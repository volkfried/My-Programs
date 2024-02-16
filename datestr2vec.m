function output = datestr2vec(input)
  output = [str2num(strsplit(input,"/"){3}),str2num(strsplit(input,"/"){2}),str2num(strsplit(input,"/"){1})]
