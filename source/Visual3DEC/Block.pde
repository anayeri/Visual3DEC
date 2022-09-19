class Block {
  
  PVector inivert[][];
  PVector iniUBound;
  PVector iniLBound;
  PVector curvert[][];
  int vcount;
  PVector centroid[];
  String name;
  int id;
  boolean visible;
  color colour;
  boolean wireframe = false;
  Region region;
  
  Block(int blockid, ArrayList verticesa, ArrayList verticesb) {
    if (verticesb.size() != verticesa.size()) {
      // this is a problem but it would have been noticed during
      // analysis runs. no error checking is implimented for now!
    } else {
      // get the total number of vertices
      vcount = verticesa.size() + verticesb.size();
      
      // initialize the list of vertices
      inivert = new PVector[2][(vcount / 2) + 1];
      curvert = new PVector[2][(vcount / 2) + 1];
      
      // extract the vertices
      for (int i = 0; i < (vcount / 2); i++) {
        inivert[0][i] = (PVector) verticesa.get(i);
        inivert[1][i] = (PVector) verticesb.get(i);
      }
      
      // add the first vertices to the end to close block
      inivert[0][vcount / 2] = (PVector) verticesa.get(0);
      inivert[1][vcount / 2] = (PVector) verticesb.get(0);
      
      // assign the initial vertices to the current  vertices
      for (int i = 0; i <= (vcount / 2); i++) {
        curvert[0][i] = (PVector) inivert[0][i].get();
        curvert[1][i] = (PVector) inivert[1][i].get();
      }
      
      // assign properties
      id = blockid;
      visible = true;
      iniUBound = getUBound();
      iniLBound = getLBound();
      colour = new BoyntonColor(blockid - 1).getcolor();
    }
  }
  
  // draw block to the screen
  void display() {
    if (visible == true) {
      // add a setting for colour by region and colour override
      fill(colour);
      noStroke();
      
      // draw the sides
      beginShape(TRIANGLE_STRIP);
      for (int j = 0; j <= (vcount / 2); j++) {
        vertex( curvert[0][j].x, curvert[0][j].y, curvert[0][j].z);
        vertex( curvert[1][j].x, curvert[1][j].y, curvert[1][j].z);
      }
      endShape();
      
      // draw the caps      
      for (int i = 0; i < 2; i++) {
        beginShape(TRIANGLES);
        for (int j = 1; j < (vcount / 2) - 1; j++) {
          vertex(   curvert[i][0].x,    curvert[i][0].y,   curvert[i][0].z);
          vertex(   curvert[i][j].x,    curvert[i][j].y,   curvert[i][j].z);
          vertex( curvert[i][j+1].x,  curvert[i][j+1].y, curvert[i][j+1].z);
        }
        endShape(CLOSE);
      }
      
      if (wireframe == true){
        // draw the edges
        stroke(0,0,0);
        strokeWeight(2);
        for (int j = 0; j <= (vcount / 2); j++) {
          line( curvert[0][j].x, curvert[0][j].y, curvert[0][j].z,
                curvert[1][j].x, curvert[1][j].y, curvert[1][j].z);
        }
        noStroke();
        
        // draw the caps
        noFill();
        stroke(0,0,0);
        strokeWeight(2);
        for (int i = 0; i < 2; i++) {
          beginShape();
          for (int j = 0; j <= (vcount / 2); j++) {
            vertex(curvert[i][j].x, curvert[i][j].y, curvert[i][j].z);
          }
          endShape(CLOSE);
        }
        noStroke();
      }
      
    }
  }
  
  // transform the block to a new position based on displacement of
  // three vertices
  void transform(float[][] D, float magfac) {
    
    float[][] Pc = new float[3][3];
    float[][] Qc = new float[3][3];
    float[] p_c = new float[3];
    float[] q_c = new float[3];
    
    // get the initial position of the marker vertices
    // note: this should be consistant with vertices listed in 
    // @out_blkpts FISH function.
    // currently these the markers are: 1, 0.25*vcount and 0.85*vcount
    PVector p1 = getivert(1);
    PVector p2 = getivert(int(0.25 * vcount));
    PVector p3 = getivert(int(0.85 * vcount));
    float[][] P = { {p1.x, p2.x, p3.x},
                    {p1.y, p2.y, p3.y},
                    {p1.z, p2.z, p3.z} };
    
    // scale the displacements by the magnification factor
    if (magfac != 1.0) {
      D = Mat.multiply(D, magfac);
    }
    
    // get the final position of the marker vertices
    float[][] Q = new float[3][3];
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        Q[i][j] = P[i][j] + D[i][j];
      }
    }
       
    // calculate the mean/centroid of the initial and final points
    for (int i = 0; i < 3; i++) {
      p_c[i] = (1.0/3.0) * (P[i][0] + P[i][1] + P[i][2]);
      q_c[i] = (1.0/3.0) * (Q[i][0] + Q[i][1] + Q[i][2]);
    }
    
    // find position of the initial and final points relative to the mean
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        Pc[i][j] = P[i][j] - p_c[i];
        Qc[i][j] = Q[i][j] - q_c[i];
      }
    }
    
    // calcualte the singular value decomposition
    SVD svd = new SVD(Mat.multiply(Qc, Mat.transpose(Pc)));
    float[][] U = Cast.doubleToFloat(svd.getU());
    float[][] U_t = Mat.transpose(U);
    float[][] V = Cast.doubleToFloat(svd.getV());
    float[][] V_t = Mat.transpose(V);
    
    // define the identity matrix to prevent mirroring
    float[][] I_r = Mat.identity(3);
    I_r[2][2] = Mat.det(Mat.multiply(U_t,V));
    
    // find the rotation matrix
    float[][] R = Mat.multiply(Mat.multiply(U,I_r),V_t);
    
    // find the translation vector
    float[] t = Mat.subtract(q_c,Mat.multiply(R, p_c));
    
    // find the new position of all the vertices
    for (int i = 0; i <= vcount/2; i++) {
      curvert[0][i].set(Mat.sum(Mat.multiply(R, inivert[0][i].array()),t));
      curvert[1][i].set(Mat.sum(Mat.multiply(R, inivert[1][i].array()),t));
    }
    
    // display the displaced block
    display();
    
  }
  
  // get the initial position of a block vertex
  PVector getivert(int vnum) {
    // find if the vertex is on surface "a" or "b"
    if ((float(vnum) / vcount) <= 0.5) {
      //println("a:" + id + " : " + vnum + " : " + vcount + " : " + float(vnum) / vcount);
      return inivert[0][vnum - 1];
    } else {
      //println("b:" + id + " : " + vnum + " : " + vcount + " : " + float(vnum) / vcount);
      return inivert[1][vnum - int(0.5*vcount) - 1];
    }
  }
  
  // get the current position of a block vertex
  PVector getcvert(int vnum) {
    // find if the vertex is on surface "a" or "b"
    if ((float(vnum) / vcount) <= 0.5) {
      return curvert[0][vnum - 1];
    } else {
      return curvert[1][vnum - int(0.5*vcount) - 1];
    }
  }
  
  PVector getUBound() {
    PVector pvcVertex = (PVector) curvert[0][0].get();
    float fltUBoundx = pvcVertex.x;
    float fltUBoundy = pvcVertex.y;
    float fltUBoundz = pvcVertex.z;
    
    for (int i = 0; i <= (vcount / 2); i++) {
      pvcVertex = (PVector) inivert[0][i].get();
      if (pvcVertex.x > fltUBoundx) { fltUBoundx =  pvcVertex.x; }
      if (pvcVertex.y > fltUBoundy) { fltUBoundy =  pvcVertex.y; }
      if (pvcVertex.z > fltUBoundz) { fltUBoundz =  pvcVertex.z; }
      
      pvcVertex = (PVector) inivert[1][i].get();
      if (pvcVertex.x > fltUBoundx) { fltUBoundx =  pvcVertex.x; }
      if (pvcVertex.y > fltUBoundy) { fltUBoundy =  pvcVertex.y; }
      if (pvcVertex.z > fltUBoundz) { fltUBoundz =  pvcVertex.z; }
    }
    
    return new PVector(fltUBoundx, fltUBoundy, fltUBoundz);
  }
  
  PVector getLBound() {
    PVector pvcVertex = (PVector) curvert[0][0].get();
    float fltLBoundx = pvcVertex.x;
    float fltLBoundy = pvcVertex.y;
    float fltLBoundz = pvcVertex.z;
    
    for (int i = 0; i <= (vcount / 2); i++) {
      pvcVertex = (PVector) inivert[0][i].get();
      if (pvcVertex.x < fltLBoundx) { fltLBoundx =  pvcVertex.x; }
      if (pvcVertex.y < fltLBoundy) { fltLBoundy =  pvcVertex.y; }
      if (pvcVertex.z < fltLBoundz) { fltLBoundz =  pvcVertex.z; }
      
      pvcVertex = (PVector) inivert[1][i].get();
      if (pvcVertex.x < fltLBoundx) { fltLBoundx =  pvcVertex.x; }
      if (pvcVertex.y < fltLBoundy) { fltLBoundy =  pvcVertex.y; }
      if (pvcVertex.z < fltLBoundz) { fltLBoundz =  pvcVertex.z; }
    }
    
    return new PVector(fltLBoundx, fltLBoundy, fltLBoundz);
  }
  
}
