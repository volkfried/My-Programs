function output = tablecheck(input, table)
  tablerows = size(table,1);
  for rowcheck = 1:tablerows
    if (abs(table(rowcheck+1,1)-input) > abs(table(rowcheck,1)-input))
      break;
    endif
    if (rowcheck == tablerows-1)

      break;
    endif
  endfor
  output = table(rowcheck,2);

