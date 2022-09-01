# Determined the confidence interval of the standard deviation for any
# datasample x, for a given confidence level c.
#
# [lower_bound, upper_bound] = confs(data, confidence);

function output = confs(x,c)
  pkg load statistics;
  output=std(x)*sqrt((numel(x) - 1) ./ chi2inv([c, 1-c],(numel(x) - 1)).^2);
