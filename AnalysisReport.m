# Function to analyze the Water Analysis Report.
#
# Function reads "Water Analysis.txt" and determines the average chemistry for
# each customer based on the recorded readings. Function then estimates the
# concentration of hypochlorous acid based on these readings, and sorts the
# pools from low to high based on this concentration.

function output = AnalysisReport()
  pkg load io;
  pkg load statistics;
  store = "PAP056," # Modify this line with correct store number; EX: "PAP001,", "PAP002,", "PAP003,",... etc. Do not truncate the comma!

  # Opens the Water Analysis report file, and assigns it the file ID FID
  disp("Opening 'Water Analysis.txt'.");
  FID = fopen("Water Analysis.txt", "r");

  disp("Parsing file contents. This may take a while.");

  str = fgetl(FID);     # Skips the first line and initializes str as a variable
  line = 1;             # Initializes the line count variable
  labels{1} = "";       # Initializes labels list

  while(ischar(str))    # While there are still lines left to examine in the
                        # file, continues to examine them.

    # Checks to see if lines are formating lines, and skips them if they are.
    if((str(1:5) == "Page,") || (str(1:10) == "Site Name,") || (str(1:7) == store))
      str = fgetl(FID);
    elseif(ischar(str)) # Having confirmed it is not a formatting line, if the
                        # line exists, log their contents.

      # Logs the contents of the line into the matrix raw.
      columns = 1;
      for col = 1:numel(strsplit (str, ","))
        raw{line,col} = strsplit(str,","){col};
        columns = columns + 1;
      endfor
      str = fgetl(FID);
      for col = 1:numel(strsplit (str, ","))

        # Identifies what the label for the data point is.
        string = strsplit(str,","){col};
        label_length = strfind(string,"-") - 1;
        label = string(1:label_length);
        # Identifies what the data point value is.
        datum = str2num(string((strfind(string,"-") + 2):numel(string)));

        if (strcmp(labels{1},""))  # If no labels have been identified yet,
          labels{1} = label;       # log this label as the first,
          raw{line,6} = datum;     # then log the datum point at the location of the label

        else                                              # Else, since other labels have been identified already,
          if (isincluded(label,labels))                   # if this label has already been found,
            raw{line,5+isincluded(label,labels)} = datum; # log the datum point at this index.
          else                                            # Else, since it must be a new label,
            QTY = numel(labels)+1;                        # there is one more label,
            labels{QTY} = label;                          # and it is stored.
            raw{line,5+QTY} = datum;
          endif
        endif


      endfor

      line = line+1;    # Advances to the next useful line
      str = fgetl(FID);
    endif

  endwhile
  disp("Finished parsing file.");
  disp("Closing 'Water Analysis.txt'.");
  fclose(FID);

  # Identifies the index location (which column) the following labels are in,
  # so that they can be used later to calculate HOCl concentration.
  CHLOR = 2 + find(strcmp(labels, "FREE CHLORINE BROMINE "));
  PH = 2 + find(strcmp(labels, "PH "));
  STAB = 2 + find(strcmp(labels, "STABILIZER "));

  disp("Sorting information by service customer.");
  raw = sortrows(raw, [1,2]);

  # Finds each unique customer and each of their technicians in raw, and
  # creates an individual line item for them in the table water.
  disp("Identifying unique customers.");
  customers = 1;
  newcustrow = 1;
  tablerows = size(raw,1);
  water{1,1} = raw{1,1};
  water{1,2} = raw{1,2};
  for row = 1:tablerows,
    if(not(strcmp(raw{row,1}, raw{newcustrow,1})))
      newcustrow = row;
      customers = customers + 1;
      water{customers,1} = raw{row,1};
      water{customers,2} = raw{row,2};
    elseif(not(strcmp(raw{row,2}, raw{newcustrow,2})))
        water{customers,2} = cstrcat(raw{newcustrow,2},", ",raw{row,2});
    endif
  endfor

  xlswrite("raw.xlsx", raw);

  # Populates water table with aggregated test results
  disp("Aggregating water test results. This may take a while.");

  skiptoline = 1;
  for customer = 1:customers                          # For every customer,
    aggregate = [];                                       # Clear our aggregated data.
    samplesize = 0;                                       # Set sample size to zero.
    for rawcheck = skiptoline:tablerows               # check every row in raw,
      if (strcmp(water{customer,1},raw{rawcheck,1}))  # and if the customer listed in the row being examined in raw is the same,
        samplesize = samplesize + 1;                  # then increase the sample size, and
        for datum = 1:QTY                             # for each label, scan for data
          if(isempty(raw{rawcheck,5+datum}))
            raw{rawcheck,5+datum} = NaN;
          endif
          aggregate(samplesize,datum) = raw{rawcheck,5+datum};
        endfor
      else                                            # Else, since this means a new customer is being examined,
        for datum = 1:QTY                             # for each label, scan for data
          water{customer,2+datum} = round(nanmean(aggregate,1)(datum)*10)/10;
        endfor
        skiptoline = rawcheck;                        # update the starting line, and
        break;                                        # exit the loop early.
      endif
    endfor
  endfor

  for customer = 1:customers
    water{customer,3+QTY} = round(HOCL(water{customer,CHLOR}, water{customer,PH}, water{customer,STAB})*1000)/1000;
  endfor

  #header = ["CUSTOMER","TECHNICIAN(S)", labels, "HOCL CONCENTRATION"];
  header = ["CUSTOMER","TECHNICIAN(S)","HOCL CONCENTRATION", labels];
  water = [water(:,1:2) water(:,3+QTY) water(:,3:(2+QTY))];
  water = sortrows(water,3);
  water = [header; water];
  xlswrite("water.xlsx", water);
  output = water;
