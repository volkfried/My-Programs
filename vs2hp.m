function output = vs2hp(HPin,HPout)
  format short g;
  rpm = 3450*nthroot(HPin/HPout,3);
  if (rpm > 3450)
    output = nan;
  else
    output = rpm;
  endif

