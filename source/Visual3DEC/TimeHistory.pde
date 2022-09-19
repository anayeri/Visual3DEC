class TimeHistory {
  
  ArrayList trecords;
  ArrayList drecords;
  int numrecs = 0;
  int numblocks;
  BlockModel anmodel;
  
  TimeHistory(String outfile, BlockModel mdl) {
    BufferedReader reader;
    anmodel = mdl;
    numblocks = anmodel.getblockcount();
    
    // open the analysis results file for reading
    reader = createReader(outfile);
    importResults(reader);
  }
  
  void importResults(BufferedReader reader) {
    // setup the string operation control variables
    String line = "";
    float time = 0.0;
    
    // create an array of time history records
    trecords = new ArrayList();
    drecords = new ArrayList();
    
    // read throught the file until the end
    while (line != null) {
      try {
        line = reader.readLine();
      } catch (IOException e) {
        e.printStackTrace();
        line = null;
      }
      
      if (line != null) {
        line = trim(line);
        
        // read and split each line of information
        float[] recdata = float(splitTokens(line, ", ()"));
        
        if (recdata[0] != 0) {
          float rectime = recdata[0];
          ArrayList recdisp = new ArrayList();
          
          for (int i = 0; i < numblocks; i++) {
            
            int j = (9 * i) + 1;
            float[][] D = { {   recdata[j], recdata[j+3], recdata[j+6] },
                            { recdata[j+1], recdata[j+4], recdata[j+7] },
                            { recdata[j+2], recdata[j+5], recdata[j+8] }};
            recdisp.add(D);
          }
          
          trecords.add(rectime);
          drecords.add(recdisp);
          
          numrecs++;
        }
      }
    }
  }
  
  void animate(int rstep, float magfac) {
    
    // transform each block
    for (int i = 1; i <= numblocks; i++) {
      Block anblock = anmodel.getblock(i);
      anblock.transform(getdispl(rstep, i), magfac);
    }
    
  }
  
  float[][] getdispl(int rstep, int blkid) {
    ArrayList sdata = (ArrayList) drecords.get(rstep - 1);
    return (float[][]) sdata.get(blkid -1);
  }
  
  float gettime(int rstep) {
    return (Float) trecords.get(rstep - 1);
  }
  
  int getreccount() {
    return trecords.size();
  }
}
