# Function to estimate the Coefficient Of Performance (COP) of a heat pump at a
# user-defined temperature, based on COP at 80,80,80 and COP at 80,50,63.
# Assumes a linear degredation in COP with temperature.
#
# USE:
#
# T = Temperature
# H = COP at 80,80,80
# L = COP at 80,50,63
#
# cop(T,H,L)

function output = cop(temp,hi,low)
  m=(low-hi)/(50-80);
  b=hi-m*80;
  output = m*temp+b;
