# Function to generate a table estimating monthly cost and runtime for a heat
# pump of a given specification. Calculations based on a linear degredation in
# Coefficient Of Performance (COP) with temperature, a heat loss coefficient of
# 10.4, and average Gainesville monthly temperatures. Actual results may vary.
#
# USE:
#
# T = desired pool temperature in F
# G = pool size in gallons
# P = rated power of the heat pump in kBTU
# H = the COP at 80,80,80
# L = the COP at 80,50,63
#
# heatercost(T,G,P,H,L)

function output = heatercost(temp,gallons,power,hi,low)
  pkg load io;

  monthtemp = [54,57,63,68,74,79,80,80,77,70,62,57];
  K = 110;                 # Heat Loss Coefficient
  electric_rate = 0.105;   # Electric rate $/kWhr
  avg_pool_depth = 4.5;

  table = {"MONTH","AVG TEMP (F)","COP", "POWER (kBTU/hr)", "DAILY HEAT LOSS (kBTU)", "RUN TIME (hrs)", "ENERGY USE (kWhr)", "COST ($)"};
  DaysPerMonth = 365.25/12;
  kWhrPerkBTU = 0.293071;
  Area = gallons/(7.48*avg_pool_depth);

  for month = 1:12
    DT = temp-monthtemp(month);

    table(month+1,1) = month;
    table(month+1,2) = monthtemp(month);

    COP = cop(monthtemp(month),hi,low);
    table(month+1,3) = round(10*COP)/10;

    real_output = round(power*cop(monthtemp(month),hi,low)/hi);
    table(month+1,4) = real_output;

    heat_loss = K*DT*Area/1000;
    table(month+1,5) = ceil(heat_loss);

    runtime = heat_loss/real_output;
    table(month+1,6) = ceil(runtime);

    energy_use = heat_loss*kWhrPerkBTU*DaysPerMonth/COP;
    table(month+1,7) = ceil(energy_use);

    table(month+1,8) = ceil(energy_use*electric_rate);
  endfor

  output = table;
  xlswrite("HEATER_COST.xlsx", table);
