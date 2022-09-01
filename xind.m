# Determines the reactance of a inductor in an AC circuit. Inputs
# are in standard SI units, Hertz and Henries. Output is in Ohms,
# in polar form.
#
# EXAMPLE:
# reactance = xind(frequency, inductance);

function output = xind(Hz, L)
  output = vpol(j*2*pi*Hz*L);
