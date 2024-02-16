function output = poolAreaTable()
  pkg load io;
  table = [];
  for area = 100:50:1100
    for perimeter = 40:5:140
      if (perimeter < 2*pi*sqrt(area/pi))
        table(perimeter/5 - 7,area/50 - 1) = NaN;
        continue
      endif
      W = sqrt(area/2);
      L = 2*W;
      table(perimeter/5 - 7,area/50 - 1) = round(poolArea(L,W,perimeter))
    endfor
  endfor

  output = table;
  xlswrite("POOL_AREA.xlsx", table);
