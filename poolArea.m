function output = poolArea(L,W,P)
  output = L*W*(((P-ellipsePerimeter(L,W))/(2*L+2*W-ellipsePerimeter(L,W)))*(1-pi/4)+pi/4);
