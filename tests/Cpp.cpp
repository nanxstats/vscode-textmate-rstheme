#include "oneclust.h"
#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
List clust(NumericVector x, int k, NumericVector w, bool sort)
{
    NumericVector x_sort;
    IntegerVector x_rank;
    NumericVector w_sort;

    int n = x.length();

    if (sort)
    {
        x_sort = clone(x).sort();
        x_rank = rank_c(x, x_sort);
        w_sort = w[order_c(x, x_sort)];
    }
    else
    {
        x_sort = clone(x);
        x_rank = seq(0L, n - 1L);
        w_sort = clone(w);
    }

    NumericMatrix p(n, k);
    NumericMatrix e(n, k);
    NumericVector e_tmp(n);

    // initialize
    for (int i = k - 1; i < n; ++i)
    {
        e(i, k - 1) = ssq_dev(slice(x_sort, i, n - 1), slice(w_sort, i, n - 1));
    }

    int tmp = 0;
    for (int j = k - 2; j >= 0; --j)
    {
        for (int i = j; i < n - (k - j - 1); ++i)
        {
            for (int u = i + 1; u < n - (k - j - 2); ++u)
            {
                e_tmp[u] = ssq_dev(slice(x_sort, i, u - 1), slice(w_sort, i, u - 1)) + e(u, j + 1);
            }
            e(i, j) = min(slice(e_tmp, i + 1, n - (k - j - 1)));
            tmp = which_min(slice(e_tmp, i + 1, n - (k - j - 1))); // index of _the first_ minimum
            p(i, j) = i + tmp;
        }
    }

    IntegerVector opt_cut(k);
    opt_cut[0] = 0L;
    for (int j = 1; j <= k - 1; ++j)
    {
        opt_cut[j] = p(opt_cut[j - 1], j - 1) + 1;
    }

    IntegerVector cluster_id(n);
    IntegerVector cluster_interval = concat(opt_cut, n - 1);
    for (int i = 0; i < k; ++i)
    {
        IntegerVector idx = seq(cluster_interval[i], cluster_interval[i + 1]);
        IntegerVector val(idx.length(), i + 1);
        cluster_id[idx] = val;
    }
    cluster_id = cluster_id[x_rank];

    List L = List::create(
        // Named("p") = p,
        // Named("e") = e,
        Named("opt_cut") = opt_cut + 1L,
        Named("cluster_id") = cluster_id);
    return L;
}