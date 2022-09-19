// import required libraries
import papaya.*;
import remixlab.proscene.*;
import processing.opengl.*;
import processing.dxf.*;
import processing.pdf.*;
import codeanticode.gsvideo.*;

// application objects
BlockModel model;
TimeHistory analysis;
Scene scene;
GUI guiInterface;
GSMovieMaker mmkVideo;

// display parameters
boolean blnShading = true;
boolean blnWireframe = false;

// data parameters
boolean blnModelLoaded = false;
boolean blnTHLoaded = false;

// time history animation parameters
int step = 1;
boolean pause = true;
float magfac = 1.0;
float maginc = 0.25;
float magmax = 10.0;

// file output paramters
boolean blnSavePNG = false;
boolean blnSavePNGt = false;
PGraphics pgrPNG;
boolean blnSavePDF = false;
boolean blnSaveDXF = false;
boolean blnSaveVid = false;
String strSaveFile;

// file output set parameters
boolean blnSaveSet = false;
String strSetFile;
int intSetStep = 0;
int intSetStartNo = 1;
int intStartInd = 1;
float fltSetTime = 0.0;
float fltSetInt;
float fltTimeTol = 0.005;

// keyboard control prameters
boolean blnAltPress = false;

void setup() {
  size(1100, 600, OPENGL);
  noStroke();
  frameRate(30);
  
  // setup the scene rendering
  scene = new Scene(this); 
  scene.setGridIsDrawn(false);
  scene.setAxisIsDrawn(false);
  scene.disableKeyboardHandling();
  scene.camera().showEntireScene();
  
  // setup user interface objects
  guiInterface = new GUI(this);
}

void draw() {
  // setup the display settings
  if (blnShading) { lights(); }
  if (!blnSavePNGt) { background(255); }
  scale(-1, 1, 1);
  rotateZ(radians(180));
  
  // setup output system
  if (blnSaveSet) {
    intSetStep++;
    fltSetTime = intSetStep * fltSetInt;
    int inistep = step;
    for (int i = intStartInd; i < analysis.getreccount(); i++) {
      if (abs(analysis.gettime(i) - fltSetTime) <= fltTimeTol) {
        step = i;
        intStartInd = i + 1;
        switch(int(guiInterface.ddlOutImageSetFormat.getValue())) {
          case 0:
            // png output
            strSaveFile = strSetFile + "_" + intSetStep + ".png";
            blnSavePNG = true;
            break;
          case 1:
            // transparent png output
            strSaveFile = strSetFile + "_" + intSetStep + ".png";
            blnSavePNGt = true;
            break;
          case 2:
            // pdf output
            strSaveFile = strSetFile + "_" + intSetStep + ".pdf";
            blnSavePDF = true;
            break;
          case 3:
            // dxf output
            strSaveFile = strSetFile + "_" + intSetStep + ".dxf";
            blnSaveDXF = true;
            break;
        }
        guiInterface.hideAll();
        break;
      }
    }
    if (step == inistep){
      blnSaveSet = false;
      intSetStep = 0;
      intStartInd = 1;
      fltSetTime = 0.0;
    }
  }
  if (blnSavePDF) { hint(ENABLE_DEPTH_SORT); beginRaw(PDF, strSaveFile); }
  if (blnSaveDXF) { beginRaw(DXF, strSaveFile); }
  if (blnSavePNGt) { 
    pgrPNG = createGraphics(width, height, P3D);
    beginRecord(pgrPNG);
    pgrPNG.setMatrix(g.getMatrix());
    if (blnShading) { pgrPNG.lights(); }
  }
  
  // draw the appropriate model based on loaded information
  if (blnTHLoaded) {
    // re-sample time history data for real-time rendering
    int inistep = step;
    if (!pause) {
      if (step < analysis.getreccount()) {
        // find the next time step given the frame rate
        for (int i = step + 1; i < analysis.getreccount(); i++) {
          if (abs(analysis.gettime(i) - (analysis.gettime(step) + (1.0/frameRate))) <= fltTimeTol) {
            step = i;
            guiInterface.sldTimeLine.setValue(float(step));
            break;
          }
        }
        // continue animation to the end for static runs with large time steps
        if (step == inistep){
          step++;
          guiInterface.sldTimeLine.setValue(float(step));
        }
      } else {
        btnTHPlay(2);
      }
    }
    // display the time history analysis
    analysis.animate(step, magfac);
    
    // display the time and magnification information
    guiInterface.lblTHTime.setText("Time: " + nf(analysis.gettime(step),0,2));
    guiInterface.lblTHMag.setText("Mag:  " + str(magfac));
  } else if (blnModelLoaded) {
    // display the model
    model.display();
  }
  
  // close 3D output stream
  if (blnSaveDXF) { endRaw(); blnSaveDXF = false; guiInterface.showAll(); }
  
  // draw the user interface
  guiInterface.draw();
  
  // close 2D ouput streams
  if (blnSavePDF) { endRaw(); blnSavePDF = false; hint(DISABLE_DEPTH_SORT); guiInterface.showAll(); }
  if (blnSavePNG) { save(strSaveFile); blnSavePNG = false; guiInterface.showAll(); }
  if (blnSavePNGt) { endRecord(); blnSavePNGt = false; pgrPNG.save(strSaveFile); guiInterface.showAll(); }
  if (blnSaveVid) { 
    loadPixels();
    mmkVideo.addFrame(pixels);
    if (pause) { println(mmkVideo.getDroppedFrames()); blnSaveVid = false; mmkVideo.finish(); guiInterface.showAll(); }
  }
}

void keyPressed() {
  // add manual control of the time history animation
  if (key == CODED) {
    if (keyCode == RIGHT && blnTHLoaded) {
      if (step < analysis.getreccount()){
        step++;
        guiInterface.sldTimeLine.setValue(float(step));
      }
    } else if (keyCode == LEFT && blnTHLoaded) {
      if (step > 1){
        step--;
        guiInterface.sldTimeLine.setValue(float(step));
      }
    } else if (keyCode == KeyEvent.VK_ALT) {
      blnAltPress = true;
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == KeyEvent.VK_F1) {
      println("F1");
    } else if (keyCode == KeyEvent.VK_ALT) {
      blnAltPress = false;
    }
  } else if (key == 'h' && blnAltPress) {
    if (guiInterface.blnMenu) { 
      guiInterface.hideMenu();
    } else {
      guiInterface.showMenu();
    }
  } else if (key == 'H' && blnAltPress) {
    if (guiInterface.blnTimeLine) { 
      guiInterface.hideAll();
    } else {
      guiInterface.showAll();
    }
  }
}

String extractFileName(String filePathName) {
  if ( filePathName == null ) {
    return null;
  }
  int dotPos = filePathName.lastIndexOf( '.' );
  int slashPos = filePathName.lastIndexOf( '\\' );
  if ( slashPos == -1 ) {
    slashPos = filePathName.lastIndexOf( '/' );
  }
  if ( dotPos > slashPos ) {
    return filePathName.substring( slashPos > 0 ? slashPos + 1 : 0, dotPos );
  }
  
  return filePathName.substring( slashPos > 0 ? slashPos + 1 : 0 );
}
