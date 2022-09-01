# Converts a two's complement binary number into a decimal number.
#
# EXAMPLE:
# bin2dec2c(binary)
# >> bin2dec2c("111000101000")
# ans = -472

function output = bin2dec2c(input)
  if (input(1)=="0")
    output = bin2dec(input);
  elseif (input(1)=="1")
    N = numel(input);
    input = dec2bin(bin2dec(input)-1,N);
    for count = 1:N,
      if (input(count)=="1")
        input(count)="0";
      elseif (input(count)=="0")
        input(count)="1";
      endif
    endfor
    output = -bin2dec(input);
  endif

