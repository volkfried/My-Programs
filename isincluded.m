function output = isincluded(string, matrix)
  found = false;
  for check = 1:numel(matrix)
    if strcmp(string, matrix{check})
      found = check;
      break;
    endif
  endfor
  output = found;

