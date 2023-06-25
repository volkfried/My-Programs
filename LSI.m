# Function to estimate the Langlier Saturation Index (LSI) based on the pH,
# Total Alkalinity, Calcium Hardness, Stabilizer, TDS, and temperature
# (Fahrenheit). If the temperature is missing, it is assumed to be 75F. If the
# TDS is missing, it is assumed to be 1000ppm. Method used based on
# Dr. Robert W. Lowry's work "Pool Chemistry for Residential Pools"
# (ISBN 9781694504982), pages 81-82. Outputs tested for #accuracy against
# sensible chemical levels.
#
# Pool chemistry should be maintained by a licensed profesional, in compliance
# with all applicable laws and regulations.
#
# USE:
# If tds or temp are not available, substitute NaN for the value.
#
# output = LSI(ph, alkalinity, calcium, stabilizer, tds, temp)
# >> output = HOCL(11.5,7.5,100)
# output = 0.066240
# >>

function LSI = LSI(PH, TA, CAL, CYA, TDS, F)

  # Assume the values of TDS and temperature if they're missing.
  if (isnan(TDS) || TDS == 0)
    TDS = 1000;
  endif
  if (isnan(F))
    F = 75;
  endif

  CA = TA - CYA*(0.009572*PH^2 - 0.2526);
  K = (F - 32)*5/9 + 273.15;
  A = (log10(TDS) - 1)/10;
  B = 34.55 - 13.12*log10(K);
  C = log10(CAL) - 0.4;
  D = log10(CA);
  pHs = (9.3 + A + B) - (C + D);
  LSI = PH - pHs;
