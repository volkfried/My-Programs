# Takes two vectors as an input, in either the cartesian form of x+i*y
# or the polar form of [radius, degrees], and divides the vectors. The
# The output is always in polar form.
#
# EXAMPLES:
# vectDIV([173.2,0], [17.32,-30]) = [10, 30]
# vectDIV([173.2,0], 15 - i*8.66) = [10, 30]
# vectDIV(173.2 + i0, [17.32,-30]) = [10, 30]
# vectDIV(173.2 + i0, 15 - i*8.66) = [10, 30]

function output = vdiv(input1,input2)
  if (numel(input1)==1)
    input1=vpol(input1);
  endif
  if (numel(input2)==1)
    input2=vpol(input2);
  endif
  output = [input1(1)/input2(1), input1(2)-input2(2)];

