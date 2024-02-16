function output = ServiceTime()
  pkg load io;
  pkg load statistics;
  store = "PAP056," # Modify this line with correct store number; EX: "PAP001,", "PAP002,", "PAP003,",... etc. Do not truncate the comma!

  # Opens the Service Duration report file, and assigns it the file ID FID
  disp("Opening 'Service Duration.txt'.");
  FID = fopen("Service Duration.txt", "r");

  disp("Parsing file contents. This may take a while.");
  for c = 1:6,          # Skips the first few lines, which are useless headers.
    str = fgetl(FID);
  endfor

  line = 1;             # Initializes the line count variable

  while(ischar(str))    # While there are still lines left to examine in the
                        # file, continues to examine them.

    # Checks to see if lines are formating lines, and skips them if they are.
    if((str(1:5) == "Page,") || (str(1:10) == "Site Name,") || (str(1:12) == "Service Date") || (str(1:7) == store) || (str(1:11) == "Total AVG:,"))
      str = fgetl(FID);
    elseif(ischar(str)) # Having confirmed it is not a formatting line, if the
                        # line exists, log their contents.

      for col = 1:5,    # Logs the contents of the line into the matrix raw.
        raw{line,col} = strsplit(str,","){col};
      endfor

      line = line+1;    # Advances to the next useful line
      str = fgetl(FID);
      str = fgetl(FID);
    endif

  endwhile
  disp("Finished parsing file.");

  disp("Closing 'Service Duration.txt'.");
  fclose(FID);


  # Sorts the raw data by customer, so each customer has all of their data
  # listed in order. This is important for code efficiency, later on.
  disp("Sorting information by service customer.");
  raw = sortrows(raw, [1,3]);

  # Finds each unique customer and each of their service types in raw, and
  # creates an individual line item for them in the table duration.
  disp("Identifying unique customers and services.");
  customers = 1;
  newcustrow = 1;
  tablerows = size(raw,1);
  duration{1,1} = raw{1,1};
  duration{1,2} = raw{1,3};
  for row = 1:tablerows,
    if(not(strcmp(strcat(raw{row,1},raw{row,3}), strcat(raw{newcustrow,1},raw{newcustrow,3}))))
      newcustrow = row;
      customers = customers + 1;
      duration{customers,1} = raw{row,1};
      duration{customers,2} = raw{row,3};
    endif
  endfor


  # Populates duration table with customer information
  disp("Aggregating service times. This may take a while.");


  skiptoline = 1; # Used later to avoid rereading the same lines.
  # For each customer, every line of raw is scanned for corresponding data
  for durcheck = 1:customers,
    found = false;
    samplesize = 0;
    sample = [];
    for rawcheck = skiptoline:tablerows,
      if(and(strcmp(strcat(duration{durcheck,1},duration{durcheck,2}), strcat(raw{rawcheck,1},raw{rawcheck,3})),str2num(raw{rawcheck,5})>0))
      #if(and(strcmp(duration{durcheck,1}, raw{rawcheck}),str2num(raw{rawcheck,5})>0))
        samplesize = samplesize + 1;
        sample(samplesize) = str2num(raw{rawcheck,5});
        found = true;

      elseif(found == true)    # If the customer was previously found, and the
                               # line being examined is not for the customer,
                               # then all of that customer's data has already
                               # been found, so the loop for that particular
                               # customer can be exited early.

        skiptoline = rawcheck; # Marks prior lines as read, so they don't have
        break;                 # to be read again.

      endif
    endfor

    # Once raw has been scanned for any information related to that customer,
    # this information is then compiled.
    if(not(isempty(sample)))




     # If the sample size is greater than 1, performs statistical analysis on
     # the data. Else, it sets it to NaN/0.
     samplesize = numel(sample);
     sample = sort(sample);
     if(samplesize > 1)

        # Determines the +/- value for the median
        Upper = ceil(0.5*samplesize + 1.96*sqrt(0.5*samplesize*(1-0.5)));
        Lower = ceil(0.5*samplesize - 1.96*sqrt(0.5*samplesize*(1-0.5)));
        if(Lower < 1)
          Lower = 1;
        endif
        if(Upper > samplesize)
          Upper = samplesize;
        endif

        # Determines confidence interval for the average.
        width=(tinv((1-(1-0.95)/2),(numel(sample)-1)))*std(sample)/sqrt(numel(sample));
        M=mean(sample);
        confmean=[M-width, M+width];

        duration{durcheck, 3} = sample(Lower);                # Lower confidence of median
        duration{durcheck, 4} = round(median(sample));        # Median
        duration{durcheck, 5} = sample(Upper);                # Upper confidence of median
        duration{durcheck, 6} = floor(confmean(1));           # Low mean
        duration{durcheck, 7} = round(M);                     # Mean
        duration{durcheck, 8} = ceil(confmean(2));            # High Mean
        duration{durcheck, 9} = round(std(sample));           # STDEV

      else
        duration{durcheck, 3} = NaN;
        duration{durcheck, 4} = round(median(sample));
        duration{durcheck, 5} = NaN;
        duration{durcheck, 6} = NaN;
        duration{durcheck, 7} = round(mean(sample));
        duration{durcheck, 8} = NaN;
        duration{durcheck, 9} = NaN;
      endif
      duration{durcheck, 10} = samplesize;

    endif
  endfor


  duration = sortrows(duration, 1);
  duration = ["Name","Service","Low Median","Median","High Median","Low Mean","Mean","High Mean", "STDEV","Sample Size"; duration];
  xlswrite("duration.xlsx", duration);
  output = duration;
end
