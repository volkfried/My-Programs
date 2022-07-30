# Takes a cartesian coordinate in the form of x+iy and outputs the polar
# coordinate in the form of [radius, degrees].

function output = vpol(input)
  output = [abs(input), rad2deg(angle(input))];

