# Determined the confidence interval of the mean for any
# datasample x, for a given confidence level c.
#
# [lower_bound, upper_bound] = confm(data, confidence);

function output = confm(x,c)
  pkg load statistics;
  width=(tinv((1-(1-c)/2),(numel(x)-1)))*std(x)/sqrt(numel(x));
  M=mean(x);
  output=[M-width, M+width];
