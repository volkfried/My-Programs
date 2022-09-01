# Determines the reactance of a capacitor in an AC circuit. Inputs
# are in standard SI units, Hertz and Farads. Output is in Ohms,
# in polar form.
#
# EXAMPLE:
# reactance = xcap(frequency, capacitance);

function output = xcap(Hz, F)
  output = vpol(-j/(2*pi*Hz*F));
