# Determines the impedance of a parallel circuit with an arbitrary
# number of elements. Inputs can be in either the cartesian form of
# x+i*y or the polar form of [radius, degrees]. Output is always in
# polar form.
#
# EXAMPLE:
# impedance = xpara(A, B, C);

function output = xpara(varargin)
  N = numel(varargin);
  output = 0;
  for count = 1:N,
    if (numel(varargin{count})==2)
      varargin{count} = vcart(varargin{count});
    endif
    output = output + 1/varargin{count};
  endfor
  output = 1/output;
  output = vpol(output);

