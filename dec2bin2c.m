# Converts a decimal into a signed binary using two's complement
# representation.
#
# EXAMPLE:
# dec2bin2c(integer, digits)
# >> dec2bin2c(-472,12)
# ans = 111000101000
#
# EXAMPLE:
# dec2bin2c(integer)
# >> dec2bin2c(-472)
# ans = 1000101000

function output = dec2bin2c(varargin)

  input = varargin{1};

  # Sets a default quantity of digits, in case the user does not
  # specify the quantity of digits in the output.
  if (varargin{1} > 0)
    digits = numel(dec2bin(varargin{1}))+1;
  else
    digits = numel(dec2bin(-varargin{1}))+1;
  endif

  # If the user did specify the number of digits, it utilizes that
  # instead.
  if (numel(varargin)==2)
    digits = varargin{2};
  elseif (numel(varargin)>2)
    # Returns error if there are too many arguements.
    error("Too many arguements.")
  endif

  # Returns an error if the user-specified quantity of digits is
  # insufficient to contain the output.
  if (input < 0)
    if (numel(dec2bin(-input))+1 > digits)
      error("Overflow. Insufficient digits for output.");
    endif
  elseif (input > 0)
    if (numel(dec2bin(input))+1 > digits)
      error("Overflow. Insufficient digits for output.");
    endif
  endif

  # If the input is greater than or equal to 0, the built-in
  # matlab function will work.
  if (input>=0)
    output = dec2bin(input, digits);
  # If the input is less than zero, this converts it to two's
  # complement.
  elseif (input<0)
    input = -input;
    input = dec2bin(input, digits);
    N = numel(input);
    for count = 1:N,
      if (input(count)=="1")
        input(count)="0";
      elseif (input(count)=="0")
        input(count)="1";
      endif
    endfor
    output = dec2bin(bin2dec(input)+1,digits);
  endif

