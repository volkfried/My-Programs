# Creates a truth table out of the specified inputs for
# the given function.
#
# EXAMPLE:
# truthtable(inputs,func1)
# >> truthtable(["00";"01";"10";"11"],@and)
# ans =
#
# 00=0
# 01=0
# 10=0
# 11=1
#
# >>

function output = truthtable(input,func1)
  tests = size(input,1);
  variables = size(input,2);
  for counttest = 1:tests,
    for countvars = 1:variables,
      varargout(countvars) = str2num(input(counttest,countvars));
    endfor
    output(counttest,:) = strcat(num2str(input(counttest,:)),"=",num2str(func1(num2cell(varargout){:})));
  endfor

