# Function to test a given boole function with a given input.
#
# EXAMPLE:
# >> function = ["1-1-";"0-10";"110-"];
# >> input = "0010";
# >> boole(input,boole)
# ans = "1"
#
# >>

function output = boole(input,boole)
  variables = size(boole,2);
  terms = size(boole,1);

  if (numel(input) != variables)
    error("The quantity of input variables does not equal the quantity of function variables");
  endif


  for term = 1:terms,
    truth = 1;
    for var = 1:variables,
      boole(term,var);
      input(var);
      if (boole(term,var) == "0")
        truth = truth*not(str2num(input(var)));
      elseif (boole(term,var) == "1")
        truth = truth*str2num(input(var));
      else
        truth = truth;
      endif
    endfor
    if (truth == 1)
      output = "1";
      return;
    else
      output = "0";
    endif
  endfor

