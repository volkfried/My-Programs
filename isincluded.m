function output = isincluded(input, table)
  rows = size(table,2);
  found = false;
  for check = 1:rows
    if (strcmp(input,table(check)))
      found = check;
      break;
    endif
  endfor
  output = found;

