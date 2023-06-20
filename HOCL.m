# Function to estimate the concentration of Hypochlorous Acid (HOCl) in ppm
# based on the Free Chlorine, pH, and Stabilizer levels. Method used based on
# Dr. Robert W. Lowry's work "Pool Chemistry for Residential Pools"
# (ISBN 9781694504982), page 77. Outputs tested for accuracy against table
# shown on page 177. Results do not perfectly match the table, or reality, but
# as Dr. Lowry states, it's only intended as an approximation.
#
# Per page 49 of the Pool & Spa Operator Handbook (ISBN 0-9845863-7-0), the
# common practice is to keep free chlorine between 2ppm and 4ppm, with some
# standards saying between 1ppm and 5ppm. Per page 53 of the same book,
# stabilizer should be kept between 30ppm and 50ppm, though some other sources
# suggest higher levels. Per page 61, the acceptable range for pH is 7.2 to 7.8.
#
# Given these numbers, the maximum permissable concentration of HOCl is 0.13ppm,
# though it's possible skin and eye irritation may develop sooner. Per page 77
# of "Pool Chemistry for Residential Pools", the minimum concentration of HOCl
# is 0.05ppm to prevent algae.
#
# Pool chemistry should be maintained by a licensed profesional, in compliance
# with all applicable laws and regulations.
#
# USE:
# output = HOCL(chlorine, ph, stabilizer)
# >> output = HOCL(11.5,7.5,100)
# output = 0.066240
# >>

function output = HOCL(chlorine, ph, stabilizer)
  if (stabilizer < 1)
    stabilizer = 1;
  endif
  FC = 0.0000012*chlorine/stabilizer;
  output = (4.38-0.52*ph)*FC*1000000;

