# Takes any number of vectors as an input, in either the cartesian
# form of x+i*y or the polar form of [radius, degrees], and
# multiplies the vectors. The output is always in polar form.
#
# EXAMPLES:
# vectMULT([173.2,0], [17.32,-30]) = [2999.824, -30]
# vectMULT([173.2,0], 15 - i*8.66) = [2999.824, -30]
# vectMULT(173.2 + i0, [17.32,-30]) = [2999.824, -30]
# vectMULT(173.2 + i0, 15 - i*8.66) = [2999.824, -30]

function output = vmult(varargin)
  N = numel(varargin);
  output = 1;

  for count = 1:N,
    if (numel(varargin{count})==2)
      varargin{count} = vcart(varargin{count});
    endif
    output = output*varargin{count};
  endfor

  output = vpol(output);

