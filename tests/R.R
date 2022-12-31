#' Classify any file into text file or binary file
#'
#' @param path File path.
#' @param n The (maximal) number of bytes to read.
#'
#' @return Logical. `TRUE` if text, `FALSE` if binary.
is_text_file <- function(path, n = file.info(path)$size) {
  bytecode <- readBin(path, what = "raw", n = n)

  if (length(bytecode) == 0L) return(FALSE)

  allow <- as.raw(c(9, 10, 13, 32:255))
  block <- as.raw(c(0:6, 14:31))

  cond1 <- any(bytecode %in% allow)
  cond2 <- !any(bytecode %in% block)

  cond1 && cond2
}

for (i in unique(exts)) {
  if (i != "") {
    idx <- which(exts == i)
    val <- df[idx, "is_text"]
    if (length(unique(val)) > 1L) {
      flag[idx[val == as.logical(names(which.min(table(val))))]] <- TRUE
    }
  }
}
