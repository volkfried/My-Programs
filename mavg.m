function output = mavg(input, weight)
  N = numel(input);
  sum = 0
  den = 0
  for step = 1:N
    sum = sum + input(step)/(weight^(step-1));
    den = den + weight^(1-step);
  endfor
  output = sum/den;

