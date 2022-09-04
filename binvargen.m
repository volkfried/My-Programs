# Generates every possible binary input for a fixed number of inputs.
#
# EXAMPLE:
# binvargen(integer)
# >> binvargen(3)
# ans = ["000","001","010","011","100","101","110","111"]

function output = binvargen(input)
  output = dec2bin(0:(2^input-1));
