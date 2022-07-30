# Takes a polar coordinate in the form of [radius, degrees] and outputs
# the polar coordinate in the form of x+iy.

function output = vcart(input)
  output = input(1)*cosd(input(2)) + j*input(1)*sind(input(2));

