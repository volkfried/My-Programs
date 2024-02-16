function output = pumptable()
  pkg load io;

  THP_out = [0.80,0.95,1.25,1.65,2.2];
  THP_in = [1.3,1.65,1.85,2.2,2.7,3.0,3.8,3.95];

  table = [0];

  for col = 2:(1+numel(THP_in))
    table(1,col) = THP_in(col-1);
  endfor
  for row = 2:(1+numel(THP_out))
    table(row,1) = THP_out(row-1);
  endfor

  for col = 2:(1+numel(THP_in))
    for row = 2:(1+numel(THP_out))
      table(row,col) = ceil(vs2hp(table(row,1),THP_in(col-1)));
  endfor
  endfor

  output = table;
  xlswrite("VSP_RPM.xlsx", table);
