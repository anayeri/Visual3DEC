class BlockModel {
  
  ArrayList verticesa;
  ArrayList verticesb;
  ArrayList blocks;
  HashMap regions;
  ArrayList vertices;
  PVector[] extents;
  Region blkregion;
  
  BlockModel(String modelfile) {
    BufferedReader reader;
    
    // Open the model file for reading
    reader = createReader(modelfile);
    importModel(reader);
    scene.camera().lookAt(getCentre());
    scene.camera().setSceneBoundingBox(getLBound(),getUBound());
    scene.camera().setOrientation(0,0);
    scene.camera().showEntireScene();
  }

  void importModel(BufferedReader reader) {
    // Setup the string operation control variables
    String line = "";
    boolean startpoly = false;
    boolean verta = false;
    boolean vertb = false;
    extents = new PVector[2];
    
    // Create an array of objects in the model
    blocks = new ArrayList();
    vertices = new ArrayList();
    regions = new HashMap();
    
    // Read throught the file until the end
    while (line != null) {
      try {
        line = reader.readLine();
      } catch (IOException e) {
        e.printStackTrace();
        line = null;
      }
      
      if (line != null) {
        line = trim(line);
        
        // Find polyhedron block definitions
        if ((line.length() > 3) && (line.substring(0, 4).equals("poly") == true)) {
          startpoly = true;
          int regid = int(split(line, ' ')[2]);
          if (regions.get(regid) == null) {
              regions.put(regid, new Region(regid));
              blkregion = (Region) regions.get(regid);
          } else {
              blkregion = (Region) regions.get(regid);
          }
        } else if (startpoly == true) {
          // Find the surfaces defining the polyhedron
          if (line.substring(0, 2).equals("a ") == true) {
            verticesa = new ArrayList();
            verta = true;
            vertb = false;
          } else if (line.substring(0, 2).equals("b ") == true) {
            verticesb = new ArrayList();
            verta = false;
            vertb = true;
          }
          
          if (verta == true) {
            // Read the point information
            float[] pdata = float(splitTokens(line, ", ()ab&xyz="));
            int pts = pdata.length / 3;
            
            // Store each point set inside the vertices collection
            for (int i = 0; i < pts; i++) {
              verticesa.add(new PVector(pdata[i*3], pdata[i*3 + 1], pdata[i*3 + 2]));
            }
            
            // Check for continuation (&) character at the end
            int linelen = line.length();
            if (line.substring(linelen - 1, linelen).equals("&") == false){
              verta = false;
            }
          } else if (vertb == true) {
            // Read the point information
            float[] pdata = float(splitTokens(line, ", ()ab&xyz="));
            int pts = pdata.length / 3;
            
            // Store each point set inside the vertices collection
            for (int i = 0; i < pts; i++) {
              verticesb.add(new PVector(pdata[i*3], pdata[i*3 + 1], pdata[i*3 + 2]));
            }
            
            // Check for continuation (&) character at the end
            int linelen = line.length();
            if (line.substring(linelen - 1, linelen).equals("&") == false){
              vertb = false;
              startpoly = false;
              Block newblk = new Block(blocks.size() + 1, verticesa, verticesb);
              //blocks.add(new Block(blocks.size() + 1, verticesa, verticesb));
              blocks.add(newblk);
              blkregion.add(newblk);
            }
          }
        }
      }
    }
    
  }
  
  void display() {
    for (int i = 0; i < blocks.size(); i++) {
      Block iblock = (Block) blocks.get(i);
      iblock.display();
    }
  }
  
  Block getblock(int blockid) {
    if (blockid <= blocks.size()) {
      return (Block) blocks.get(blockid - 1);
    } else {
      return null;
    }
  }
  
  int getblockcount() {
    return blocks.size();
  }
  
  Region getregion(int regid) {
    if (regions.get(regid) != null) {
      return (Region) regions.get(regid);
    } else {
      return null;
    }
  }
  
  int getregioncount() {
    return regions.size();
  }
  
  void wireframe(boolean state) {
    for (int i = 1; i < regions.size()+1; i++) {
      Region iregion = (Region) regions.get(i);
      iregion.wireframe(state);
    }
  }
  
  void colour(color blkcolour) {
    for (int i = 0; i < blocks.size(); i++) {
      Block iblock = (Block) blocks.get(i);
      iblock.colour = blkcolour;
    }
  }
  
  void colourbyID() {
    for (int i = 0; i < blocks.size(); i++) {
      Block iblock = (Block) blocks.get(i);
      iblock.colour = new BoyntonColor(iblock.id - 1).getcolor();
    }
  }
  
  void colourbyRegion() {
    for (int i = 1; i < regions.size()+1; i++) {
      Region iregion = (Region) regions.get(i);
      iregion.colour(new BoyntonColor(iregion.id - 1).getcolor());
    }
  }
  
  PVector getUBound() {
    Block iblock = (Block) blocks.get(0);
    PVector pvcUVertex = iblock.getUBound();
    float fltUBoundx = pvcUVertex.x;
    float fltUBoundy = pvcUVertex.y;
    float fltUBoundz = pvcUVertex.z;
    
    for (int i = 0; i < blocks.size(); i++) {
      iblock = (Block) blocks.get(i);
      pvcUVertex = iblock.getUBound();
      if (pvcUVertex.x > fltUBoundx) { fltUBoundx =  pvcUVertex.x; }
      if (pvcUVertex.y > fltUBoundy) { fltUBoundy =  pvcUVertex.y; }
      if (pvcUVertex.z > fltUBoundz) { fltUBoundz =  pvcUVertex.z; }
    }
    
    return new PVector(fltUBoundx, -fltUBoundy, fltUBoundz);
  }
  
  PVector getLBound() {
    Block iblock = (Block) blocks.get(0);
    PVector pvcLVertex = iblock.getLBound();
    float fltLBoundx = pvcLVertex.x;
    float fltLBoundy = pvcLVertex.y;
    float fltLBoundz = pvcLVertex.z;
    
    for (int i = 0; i < blocks.size(); i++) {
      iblock = (Block) blocks.get(i);
      pvcLVertex = iblock.getLBound();
      if (pvcLVertex.x < fltLBoundx) { fltLBoundx =  pvcLVertex.x; }
      if (pvcLVertex.y < fltLBoundy) { fltLBoundy =  pvcLVertex.y; }
      if (pvcLVertex.z < fltLBoundz) { fltLBoundz =  pvcLVertex.z; }
    }
    
    return new PVector(fltLBoundx, -fltLBoundy, fltLBoundz);
  }
  
  PVector getCentre() {
    return PVector.add(PVector.mult(PVector.sub(getLBound(), getUBound()),0.5),getUBound());    
  }
  
}
