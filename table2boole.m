# Function takes a truth table and reduces it to the simplest possible booleon
# function using the Quine-McCluskey method.
#
# EXAMPLE:
# >> truthtable
# truthtable =
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
# >> table2boole(truthtable)
# ans =
#
# 1-1-
# 0-10
# 110-
#
# >>

function output = table2boole(input)

 # Reduces the input truth table down to only include true values.
 truecol = size(input,2);
 tablerows = size(input,1);
 tablecols = truecol;
 truetablerows = 0;
 variables = truecol-2;
 for truthtest = 1:tablerows,
   if (input(truthtest,truecol)=="1")
     truetablerows = truetablerows + 1;
     truetable(truetablerows,:)=input(truthtest,:);
   endif
 endfor

 # Repeatedly executes the qmsimplify function on the table until the output
 # is the same as the input, indicating that it cannot be further simplified.
 while (not(exist('output')))
   qmtable = qmsimplify(truetable);
   if (isequal(truetable,qmtable))
     # Removes the last three columns of the table; "=1P"
     qmtable(:,variables+4)=[]; # Yes, I know this is the ugliest
     qmtable(:,variables+3)=[]; # possible way of truncating the last
     qmtable(:,variables+2)=[]; # three columns. I'll optimize later
     qmtable(:,variables+1)=[]; # if it ever becomes a problem.
     qmtable(:,variables+1)=[]; # Otherwise, I don't care.
     output = sortrows(qmtable);
   endif
   clear('truetable');
   truetable = qmtable;
 endwhile
