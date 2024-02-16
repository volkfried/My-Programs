function output = runavg(data, dates, halflife)
  table = [data, dates];

  for c = 1:rows(table)
    if (isnan(table(c,1)))
      table(c,:) = [];
    endif
  endfor

  maximum = max(table(:,2));
  sum = 0;
  weight = 0;
  sumweight = 0;

  for c = 1:rows(table)
    weight = 0.5^((maximum - table(c,2))/halflife);
    table(c,1) = table(c,1)*weight;
    sumweight = sumweight + weight;
    sum = sum + table(c,1);
  endfor

  output = sum/sumweight;
