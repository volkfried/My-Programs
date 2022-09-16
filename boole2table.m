# Function takes a boolean function stored in a matrix in a particular format
# and generates a truth table for it.
#
# Boolean Function:
#
# boole = ["1-1-"; "0-10"; "110-"];
#
# ABCD
# 1-1-
# 0-10
# 110-
#
# = A(B+B')C(D+D') + A'(B+B')CD' + ABC'(D+D')
# = AC + A'CD' + ABC'
#
# EXAMPLE:
# >> boole
# boole =
#
# 1-1-
# 0-10
# 110-
#
# >> boole2table(boole)
# ans =
#
# 0000=0
# 0001=0
# 0010=1
# 0011=0
# 0100=0
# 0101=0
# 0110=1
# 0111=0
# 1000=0
# 1001=0
# 1010=1
# 1011=1
# 1100=1
# 1101=1
# 1110=1
# 1111=1
#
# >>

function output = boole2table(input)
  variables = size(input,2);      # Number of variables in the boole function
  terms = size(input,1);          # Number of terms in the boole function

  tests = binvargen(variables);   # All possible inputs to test the boole
                                  # function against.

  for testeval = 1:size(tests,1),       # Tests every input against the boole
                                        # function
    for vars = 1:variables,
      table(testeval,vars) = tests(testeval,vars);
    endfor
    table(testeval,variables+1)="=";    # Adds "=" to the end of the input

                                        # Checks if boole function is true with
                                        # current testeval

    table(testeval,variables+2) = boole(tests(testeval,:),input);

  endfor

  output = table;
