#' Classify any file into text file or binary file
#'
#' @param path File path.
#' @param n The (maximal) number of bytes to read.
#'
#' @return Logical. `TRUE` if text, `FALSE` if binary.
#'
#' @examples
#' is_text_file(file.path(R.home("doc"), "COPYING"))
#' is_text_file(file.path(R.home("doc"), "NEWS.pdf"))
is_text_file <- function(path, n = file.info(path)$size) {
  bytecode <- readBin(path, what = "raw", n = n)

  if (length(bytecode) == 0L) return(FALSE)

  allow <- as.raw(c(9, 10, 13, 32:255))
  block <- as.raw(c(0:6, 14:31))

  cond1 <- any(bytecode %in% allow)
  cond2 <- !any(bytecode %in% block)

  cond1 && cond2
}

is_text_files <- Vectorize(is_text_file, "path")
df <- data.frame(
  file = fs::dir_ls(R.home(), type = "file", recurse = TRUE),
  is_text = NA,
  is_text_100k = NA,
  row.names = NULL,
  stringsAsFactors = FALSE
)

# Read the entire file
system.time(df$is_text <- is_text_files(df$file))

# Read the first 100 KB at maximum
system.time(df$is_text_100k <- is_text_files(df$file, n = 0.1 * 1000^2))
all.equal(df$is_text, df$is_text_100k)

df$file <- gsub(paste0("^", fs::path_norm(R.home()), "/"), "", df$file)
exts <- fs::path_ext(df$file)
df$exts <- as.factor(exts)
DT::datatable(df, filter = list(position = "top", clear = FALSE))

# Find anti-patterns: inconsistent class tag within the same extension
flag <- rep(FALSE, nrow(df))

for (i in unique(exts)) {
  if (i != "") {
    idx <- which(exts == i)
    val <- df[idx, "is_text"]
    if (length(unique(val)) > 1L) {
      flag[idx[val == as.logical(names(which.min(table(val))))]] <- TRUE
    }
  }
}

DT::datatable(df[flag, ], rownames = FALSE)
