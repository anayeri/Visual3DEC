import controlP5.*;

class GUI {
  
  ControlP5 cp5Ctrls;
  Accordion accMenus;
  boolean blnMenu = true;
  PMatrix3D currCameraMatrix;
  PGraphics3D g3; 
  
  Group grpInputs;
  Textfield txtModelPath;
  Button btnLoadModel;
  Textfield txtTHPath;
  Button btnLoadTH;
  
  Group grpView;
  Textlabel lblProjMode;
  RadioButton rdbProj;
  Textlabel lblShading;
  CheckBox chkShading;
  Textlabel lblView;
  RadioButton rdbView;
  Textlabel lblViewLogo;
  CheckBox chkViewLogo;
  
  Group grpTH;
  Textlabel lblNoTH;
  Textlabel lblMagFac;
  Slider sldMagFac;
  Textlabel lblTHLabel;
  CheckBox chkTHLabel;
  
  Group grpModel;
  Textlabel lblWireframe;
  CheckBox chkWireframe;
  Textlabel lblModelCol;
  DropdownList ddlModelCol;
  Textlabel lblModelCCol;
  ColorPickerII cpkModelCol;
  
  Group grpRegions;
  Textlabel lblNoReg;
  Textlabel lblRegID;
  DropdownList ddlRegions;
  Textlabel lblRegCol;
  ColorPickerII cpkRegCol;
  Textlabel lblRegVis;
  CheckBox chkRegVis;
  Textlabel lblRegWire;
  CheckBox chkRegWire;
  Textlabel lblRegSetCol;
  CheckBox chkRegSetCol;
  
  Group grpBlocks;
  Textlabel lblNoBlk;
  Textlabel lblBlkID;
  DropdownList ddlBlocks;
  Textlabel lblBlkCol;
  ColorPickerII cpkBlkCol;
  Textlabel lblBlkVis;
  CheckBox chkBlkVis;
  Textlabel lblBlkWire;
  CheckBox chkBlkWire;
  
  Group grpOutput;
  Textlabel lblNoOut;
  Accordion accOutput;
  Group grpOutImage;
  Textlabel lblOutImageForamt;
  DropdownList ddlOutImageFormat;
  Textfield txtOutImagePath;
  Button btnOutImagePath;
  Button btnOutImage;
  Group grpOutImageSet;
  Textlabel lblOutImageSetForamt;
  DropdownList ddlOutImageSetFormat;
  Textfield txtOutImageSetPath;
  Button btnOutImageSetPath;
  Textfield txtOutImageSetNo;
  //Textfield txtOutImageSetStart;
  //Textfield txtOutImageSetEnd;
  Textfield txtOutImageSetInt;
  Button btnOutImageSet;
  Group grpOutVideo;
  Textfield txtOutVideoPath;
  Button btnOutVideoPath;
  //Textfield txtOutVideoStart;
  //Textfield txtOutVideoEnd;
  Button btnOutVideo;
  
  Group grpAbout;
  Textlabel lblAbout;
  String strAbout;
  PImage imgSAHCLogo;
  Button btnSAHCLink;

  Slider sldTimeLine;
  Button btnTHPlay;
  Button btnTHRev;
  Button btnTHFF;
  Textlabel lblTHFile;
  Textlabel lblTHTime;
  Textlabel lblTHMag;
  boolean blnTimeLine = true;
  
  Button btnSAHCLogo;
  boolean blnLogo = true;
  
  GUI(processing.core.PApplet appParent) {
    
    // setup the gui controllers
    cp5Ctrls = new ControlP5(appParent);
    cp5Ctrls.disableShortcuts();
    cp5Ctrls.setAutoDraw(false);
    //cp5Ctrls.setFont(createFont("Georgia",20));
    g3 = (PGraphics3D)g;
    
    // setup the accordion menu groups
    grpInputs  = cp5Ctrls.addGroup("Inputs")
                          .setBackgroundColor(color(0, 64))
                          .setBackgroundHeight(50)
                          .setLabel("Input Files");
    
    grpView    = cp5Ctrls.addGroup("View")
                         .setBackgroundColor(color(0, 64))
                         .setBackgroundHeight(100)
                         .setLabel("View Settings");
    
    grpTH      = cp5Ctrls.addGroup("TH")
                         .setBackgroundColor(color(0, 64))
                         .setBackgroundHeight(30)
                         .setLabel("Time History Settings");
    
    grpModel   = cp5Ctrls.addGroup("Model")
                         .setBackgroundColor(color(0, 64))
                         .setBackgroundHeight(110)
                         .setLabel("Model Settings");
    
    grpBlocks  = cp5Ctrls.addGroup("Blocks")
                         .setBackgroundColor(color(0, 64))
                         .setBackgroundHeight(130)
                         .setLabel("Block Settings");
    
    grpRegions = cp5Ctrls.addGroup("Regions")
                         .setBackgroundColor(color(0, 64))
                         .setBackgroundHeight(150)
                         .setLabel("Region Settings");
    
    grpOutput  = cp5Ctrls.addGroup("Output")
                         .setBackgroundColor(color(0, 64))
                         .setBackgroundHeight(160)
                         .setLabel("Output");
    
    grpAbout   = cp5Ctrls.addGroup("About")
                         .setBackgroundColor(color(0, 64))
                         .setBackgroundHeight(150)
                         .setLabel("About");
    
    // setup inputs tab components
    txtModelPath = cp5Ctrls.addTextfield("txtModelPath")
                           .setPosition(5,15)
                           .setColorCaptionLabel(0x00000000)
                           .setWidth(235)
                           .setAutoClear(false)
                           .setCaptionLabel("Model file")
                           .setGroup(grpInputs);
    txtModelPath.captionLabel().style().marginTop = -32;
        
    btnLoadModel = cp5Ctrls.addButton("btnLoadModel")
                           .setValue(0)
                           .setPosition(245,15)
                           .setSize(50,19)
                           .setCaptionLabel("Browse")
                           .setGroup(grpInputs);
    btnLoadModel.getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    
    txtTHPath    = cp5Ctrls.addTextfield("txtTHPath")
                           .setPosition(5,50)
                           .setColorCaptionLabel(0x00000000)
                           .setWidth(235)
                           .setAutoClear(false)
                           .setCaptionLabel("Time history data file")
                           .setGroup(grpInputs)
                           .hide();
    txtTHPath.captionLabel().style().marginTop = -32;
    
    btnLoadTH    = cp5Ctrls.addButton("btnLoadTH")
                           .setValue(0)
                           .setPosition(245,50)
                           .setSize(50,19)
                           .setCaptionLabel("Browse")
                           .setGroup(grpInputs)
                           .hide();
    btnLoadTH.getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    
    // setup view tab components
    lblProjMode  = cp5Ctrls.addTextlabel("lblProjMode")
                           .setColorValue(0x00000000)
                           .setWidth(30)
                           .setHeight(10)
                           .setText("PROJECTION")
                           .setFont(ControlP5.standard58)
                           .setPosition(5,9)
                           .setGroup(grpView);
    
    rdbProj      = cp5Ctrls.addRadioButton("rdbProj")
                           .setPosition(70,5)
                           .setSize(15,15)
                           .setNoneSelectedAllowed(false)
                           .setColorForeground(color(120))
                           .setColorActive(color(255))
                           .setColorLabel(color(0))
                           .setItemsPerRow(2)
                           .setSpacingColumn(60)
                           .addItem("Parallel",1)
                           .addItem("Perspective",2)
                           .activate(1)
                           .setGroup(grpView);
    
    lblShading   = cp5Ctrls.addTextlabel("lblShading")
                           .setColorValue(0x00000000)
                           .setWidth(30)
                           .setHeight(10)
                           .setText("SHADING")
                           .setFont(ControlP5.standard58)
                           .setPosition(5,29)
                           .setGroup(grpView);
    
    chkShading   = cp5Ctrls.addCheckBox("chkShading")
                           .setPosition(70, 25)
                           .setSize(15,15)
                           .setColorForeground(color(120))
                           .setColorActive(color(255))
                           .setColorLabel(color(255))
                           .setItemsPerRow(2)
                           .setSpacingColumn(30)
                           .setSpacingRow(20)
                           .addItem("Shading", 1)
                           .hideLabels()
                           .activate(0)
                           .setGroup(grpView);
    
    lblView      = cp5Ctrls.addTextlabel("lblView")
                           .setColorValue(0x00000000)
                           .setWidth(30)
                           .setHeight(10)
                           .setText("VIEW")
                           .setFont(ControlP5.standard58)
                           .setPosition(5,49)
                           .setGroup(grpView);
    
    rdbView      = cp5Ctrls.addRadioButton("rdbView")
                           .setPosition(70,45)
                           .setSize(15,15)
                           .setNoneSelectedAllowed(false)
                           .setColorForeground(color(120))
                           .setColorActive(color(255))
                           .setColorLabel(color(0))
                           .setItemsPerRow(3)
                           .setSpacingColumn(60)
                           .addItem("Top",1)
                           .addItem("Front",2)
                           .addItem("Back",3)
                           .addItem("Left",4)
                           .addItem("Right",5)
                           .addItem("Perspect",6)
                           .activate(0)
                           .setGroup(grpView);
    
    lblViewLogo  = cp5Ctrls.addTextlabel("lblViewLogo")
                           .setColorValue(0x00000000)
                           .setWidth(30)
                           .setHeight(10)
                           .setText("DISPLAY LOGO")
                           .setFont(ControlP5.standard58)
                           .setPosition(5,84)
                           .setGroup(grpView);
    
    chkViewLogo  = cp5Ctrls.addCheckBox("chkViewLogo")
                           .setPosition(70, 80)
                           .setSize(15,15)
                           .setColorForeground(color(120))
                           .setColorActive(color(255))
                           .setColorLabel(color(255))
                           .setItemsPerRow(2)
                           .setSpacingColumn(30)
                           .setSpacingRow(20)
                           .addItem("ViewLogo", 1)
                           .hideLabels()
                           .activate(0)
                           .setGroup(grpView);
    
    // setup time history tab components
    lblNoTH      = cp5Ctrls.addTextlabel("lblNoTH")
                           .setColorValue(0x00000000)
                           .setWidth(50)
                           .setHeight(10)
                           .setText("TIME HISTORY DATA HAS NOT BEEN LOADED")
                           .setFont(ControlP5.standard58)
                           .setPosition(5,9)
                           .setGroup(grpTH);
    
    lblMagFac    = cp5Ctrls.addTextlabel("lblMagFac")
                           .setColorValue(0x00000000)
                           .setWidth(30)
                           .setHeight(10)
                           .setText("MAG FACTOR")
                           .setFont(ControlP5.standard58)
                           .setPosition(5,9)
                           .setGroup(grpTH)
                           .hide();
    
    sldMagFac   = cp5Ctrls.addSlider("magfac")
                          .setPosition(70,5)
                          .setSize(225,15)
                          .setRange(1, magmax)
                          .setValue(1)
                          .setNumberOfTickMarks(round((magmax-1.0)/maginc)+1)
                          .setCaptionLabel("")
                          .setGroup(grpTH)
                          .hide();
    
    lblTHLabel   = cp5Ctrls.addTextlabel("lblTHLabel")
                           .setColorValue(0x00000000)
                           .setWidth(30)
                           .setHeight(10)
                           .setText("LABELS")
                           .setFont(ControlP5.standard58)
                           .setPosition(5,39)
                           .setGroup(grpTH)
                           .hide();
    
    chkTHLabel   = cp5Ctrls.addCheckBox("chkTHLabel")
                           .setPosition(70, 35)
                           .setSize(15,15)
                           .setColorForeground(color(120))
                           .setColorActive(color(255))
                           .setColorLabel(color(0))
                           .setItemsPerRow(3)
                           .setSpacingColumn(30)
                           .setSpacingRow(20)
                           .addItem("File", 1)
                           .addItem("Time", 2)
                           .addItem("Mag Factor", 3)
                           .activateAll()
                           .setGroup(grpTH)
                           .hide();
    
    // setup model tab components
    lblWireframe = cp5Ctrls.addTextlabel("lblWireframe")
                           .setColorValue(0x00000000)
                           .setWidth(30)
                           .setHeight(10)
                           .setText("WIREFRAME")
                           .setFont(ControlP5.standard58)
                           .setPosition(5,9)
                           .setGroup(grpModel);
    
    chkWireframe = cp5Ctrls.addCheckBox("chkWireframe")
                           .setPosition(70, 5)
                           .setSize(15,15)
                           .setColorForeground(color(120))
                           .setColorActive(color(255))
                           .setColorLabel(color(255))
                           .setItemsPerRow(2)
                           .setSpacingColumn(30)
                           .setSpacingRow(20)
                           .addItem("Wireframe", 1)
                           .hideLabels()
                           .setGroup(grpModel);
    
    lblModelCCol = cp5Ctrls.addTextlabel("lblModelCCol")
                           .setColorValue(0x00000000)
                           .setWidth(30)
                           .setHeight(10)
                           .setText("COLOUR")
                           .setFont(ControlP5.standard58)
                           .setPosition(5,45)
                           .setGroup(grpModel)
                           .hide();
    
    cpkModelCol = new ColorPickerII(cp5Ctrls,"cpkModelCol");
    cpkModelCol.setPosition(70,45)
               .setWidth(225)
               .setHeight(5)
               .setColorValue(color(255, 255, 255))
               .setGroup(grpModel)
               .hide();
    cpkModelCol.setItemSize(225, 10);
    
    lblModelCol  = cp5Ctrls.addTextlabel("lblModelCol")
                           .setColorValue(0x00000000)
                           .setWidth(30)
                           .setHeight(10)
                           .setText("COLOUR BY")
                           .setFont(ControlP5.standard58)
                           .setPosition(5,29)
                           .setGroup(grpModel);    
    
    String[] strColModes = {"Block ID", "Region ID", "Uniform"};
    ddlModelCol  = cp5Ctrls.addDropdownList("ddlModelCol")
                           .setPosition(70,40)
                           .setBarHeight(15)
                           .setItemHeight(15)
                           .addItems(strColModes)
                           .setGroup(grpModel);
    ddlModelCol.captionLabel().style().marginTop = 3;
    ddlModelCol.setIndex(0);
    
    // setup region tab components
    lblRegCol    = cp5Ctrls.addTextlabel("lblRegCol")
                           .setColorValue(0x00000000)
                           .setWidth(30)
                           .setHeight(10)
                           .setText("COLOUR")
                           .setFont(ControlP5.standard58)
                           .setPosition(5,89)
                           .setGroup(grpRegions)
                           .hide();
    
    cpkRegCol = new ColorPickerII(cp5Ctrls,"cpkRegCol");
    cpkRegCol.setPosition(70,85)
             .setWidth(225)
             .setHeight(5)
             .setColorValue(color(255, 255, 255))
             .setGroup(grpRegions)
             .hide();
    cpkRegCol.setItemSize(225, 10);
    
    lblNoReg     = cp5Ctrls.addTextlabel("lblNoReg")
                           .setColorValue(0x00000000)
                           .setWidth(50)
                           .setHeight(10)
                           .setText("MODEL HAS NOT BEEN LOADED")
                           .setFont(ControlP5.standard58)
                           .setPosition(5,9)
                           .setGroup(grpRegions);
    
    lblRegID     = cp5Ctrls.addTextlabel("lblRegID")
                           .setColorValue(0x00000000)
                           .setWidth(30)
                           .setHeight(10)
                           .setText("REGION ID")
                           .setFont(ControlP5.standard58)
                           .setPosition(5,9)
                           .setGroup(grpRegions)
                           .hide();
    
    lblRegVis    = cp5Ctrls.addTextlabel("lblRegVis")
                           .setColorValue(0x00000000)
                           .setWidth(30)
                           .setHeight(10)
                           .setText("VISIBILITY")
                           .setFont(ControlP5.standard58)
                           .setPosition(5,29)
                           .setGroup(grpRegions)
                           .hide();
    
    chkRegVis    = cp5Ctrls.addCheckBox("chkRegVis")
                           .setPosition(70, 25)
                           .setSize(15,15)
                           .setColorForeground(color(120))
                           .setColorActive(color(255))
                           .setColorLabel(color(255))
                           .setItemsPerRow(2)
                           .setSpacingColumn(30)
                           .setSpacingRow(20)
                           .addItem("RegVis", 1)
                           .hideLabels()
                           .setGroup(grpRegions)
                           .hide();
    
    lblRegWire   = cp5Ctrls.addTextlabel("lblRegWire")
                           .setColorValue(0x00000000)
                           .setWidth(30)
                           .setHeight(10)
                           .setText("WIREFRAME")
                           .setFont(ControlP5.standard58)
                           .setPosition(5,49)
                           .setGroup(grpRegions)
                           .hide();
    
    chkRegWire   = cp5Ctrls.addCheckBox("chkRegWire")
                           .setPosition(70, 45)
                           .setSize(15,15)
                           .setColorForeground(color(120))
                           .setColorActive(color(255))
                           .setColorLabel(color(255))
                           .setItemsPerRow(2)
                           .setSpacingColumn(30)
                           .setSpacingRow(20)
                           .addItem("RegWire", 1)
                           .hideLabels()
                           .setGroup(grpRegions)
                           .hide();
    
    lblRegSetCol = cp5Ctrls.addTextlabel("lblRegSetCol")
                           .setColorValue(0x00000000)
                           .setWidth(30)
                           .setHeight(10)
                           .setText("CHANGE COL")
                           .setFont(ControlP5.standard58)
                           .setPosition(5,69)
                           .setGroup(grpRegions)
                           .hide();
    
    chkRegSetCol = cp5Ctrls.addCheckBox("chkRegSetCol")
                           .setPosition(70, 65)
                           .setSize(15,15)
                           .setColorForeground(color(120))
                           .setColorActive(color(255))
                           .setColorLabel(color(255))
                           .setItemsPerRow(2)
                           .setSpacingColumn(30)
                           .setSpacingRow(20)
                           .addItem("RegSetCol", 1)
                           .hideLabels()
                           .setGroup(grpRegions)
                           .hide();
    
    // setup blocks tab components
    lblBlkCol    = cp5Ctrls.addTextlabel("lblBlkCol")
                           .setColorValue(0x00000000)
                           .setWidth(30)
                           .setHeight(10)
                           .setText("COLOUR")
                           .setFont(ControlP5.standard58)
                           .setPosition(5,69)
                           .setGroup(grpBlocks)
                           .hide();
    
    cpkBlkCol = new ColorPickerII(cp5Ctrls,"cpkBlkCol");
    cpkBlkCol.setPosition(70,65)
             .setWidth(225)
             .setHeight(5)
             .setColorValue(color(255, 255, 255))
             .setGroup(grpBlocks)
             .hide();
    cpkBlkCol.setItemSize(225, 10);
    
    lblNoBlk     = cp5Ctrls.addTextlabel("lblNoBlk")
                           .setColorValue(0x00000000)
                           .setWidth(50)
                           .setHeight(10)
                           .setText("MODEL HAS NOT BEEN LOADED")
                           .setFont(ControlP5.standard58)
                           .setPosition(5,9)
                           .setGroup(grpBlocks);
    
    lblBlkID     = cp5Ctrls.addTextlabel("lblBlkID")
                           .setColorValue(0x00000000)
                           .setWidth(30)
                           .setHeight(10)
                           .setText("BLOCK ID")
                           .setFont(ControlP5.standard58)
                           .setPosition(5,9)
                           .setGroup(grpBlocks)
                           .hide();
    
    lblBlkVis    = cp5Ctrls.addTextlabel("lblBlkVis")
                           .setColorValue(0x00000000)
                           .setWidth(30)
                           .setHeight(10)
                           .setText("VISIBILITY")
                           .setFont(ControlP5.standard58)
                           .setPosition(5,29)
                           .setGroup(grpBlocks)
                           .hide();
    
    chkBlkVis    = cp5Ctrls.addCheckBox("chkBlkVis")
                           .setPosition(70, 25)
                           .setSize(15,15)
                           .setColorForeground(color(120))
                           .setColorActive(color(255))
                           .setColorLabel(color(255))
                           .setItemsPerRow(2)
                           .setSpacingColumn(30)
                           .setSpacingRow(20)
                           .addItem("BlkVis", 1)
                           .hideLabels()
                           .setGroup(grpBlocks)
                           .hide();
    
    lblBlkWire   = cp5Ctrls.addTextlabel("lblBlkWire")
                           .setColorValue(0x00000000)
                           .setWidth(30)
                           .setHeight(10)
                           .setText("WIREFRAME")
                           .setFont(ControlP5.standard58)
                           .setPosition(5,49)
                           .setGroup(grpBlocks)
                           .hide();
    
    chkBlkWire   = cp5Ctrls.addCheckBox("chkBlkWire")
                           .setPosition(70, 45)
                           .setSize(15,15)
                           .setColorForeground(color(120))
                           .setColorActive(color(255))
                           .setColorLabel(color(255))
                           .setItemsPerRow(2)
                           .setSpacingColumn(30)
                           .setSpacingRow(20)
                           .addItem("BlkWire", 1)
                           .hideLabels()
                           .setGroup(grpBlocks)
                           .hide();
    
    // setup output tab components
    lblNoOut     = cp5Ctrls.addTextlabel("lblNoOut")
                           .setColorValue(0x00000000)
                           .setWidth(50)
                           .setHeight(10)
                           .setText("MODEL HAS NOT BEEN LOADED")
                           .setFont(ControlP5.standard58)
                           .setPosition(5,9)
                           .setGroup(grpOutput);
    
    grpOutImage  = cp5Ctrls.addGroup("grpOutImage")
                           .setBackgroundColor(color(0, 64))
                           .setBackgroundHeight(50)
                           .setLabel("Output Image");
    
    grpOutImageSet = cp5Ctrls.addGroup("grpOutImageSet")
                           .setBackgroundColor(color(0, 64))
                           .setBackgroundHeight(115)
                           .setLabel("Output Image Set")
                           .hide();
    
    grpOutVideo  = cp5Ctrls.addGroup("grpOutVideo")
                           .setBackgroundColor(color(0, 64))
                           .setBackgroundHeight(50)
                           .setLabel("Output Video")
                           .hide();
    
    accOutput    = cp5Ctrls.addAccordion("accOutput")
                           .setPosition(5,5)
                           .setWidth(290)
                           .addItem(grpOutImage)
                           .addItem(grpOutImageSet)
                           .addItem(grpOutVideo)
                           .setGroup(grpOutput)
                           .hide();
    
    // setup output image sub-tab components
    
    txtOutImagePath = cp5Ctrls.addTextfield("txtOutImagePath")
                           .setPosition(5,35)
                           .setWidth(220)
                           .setAutoClear(false)
                           .setCaptionLabel("File Path")
                           .setGroup(grpOutImage);
    txtOutImagePath.captionLabel().style().marginTop = -32;
    
    btnOutImagePath = cp5Ctrls.addButton("btnOutImagePath")
                           .setValue(0)
                           .setPosition(230,35)
                           .setSize(50,19)
                           .setCaptionLabel("Browse")
                           .setGroup(grpOutImage);
    btnOutImagePath.getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    
    btnOutImage  = cp5Ctrls.addButton("btnOutImage")
                           .setValue(0)
                           .setPosition(120,60)
                           .setSize(50,19)
                           .setCaptionLabel("Output")
                           .setGroup(grpOutImage);
    btnOutImage.getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    
    lblOutImageForamt = cp5Ctrls.addTextlabel("lblOutImageForamt")
                           .setWidth(50)
                           .setHeight(10)
                           .setText("FILE FORMAT")
                           .setFont(ControlP5.standard58)
                           .setPosition(2,9)
                           .setGroup(grpOutImage);
    
    String[] strImageFormat = {"PNG", "Transparent PNG", "PDF", "DXF"};
    ddlOutImageFormat = cp5Ctrls.addDropdownList("ddlOutImageFormat")
                           .setPosition(70,20)
                           .setBarHeight(15)
                           .setItemHeight(15)
                           .addItems(strImageFormat)
                           .setGroup(grpOutImage);
    ddlOutImageFormat.captionLabel().style().marginTop = 3;
    ddlOutImageFormat.captionLabel().set("Select Type");
    
    // setup output image set sub-tab components
    
    txtOutImageSetPath = cp5Ctrls.addTextfield("txtOutImageSetPath")
                           .setPosition(5,35)
                           .setWidth(220)
                           .setAutoClear(false)
                           .setCaptionLabel("File Path")
                           .setGroup(grpOutImageSet);
    txtOutImageSetPath.captionLabel().style().marginTop = -32;
    
    btnOutImageSetPath = cp5Ctrls.addButton("btnOutImageSetPath")
                           .setValue(0)
                           .setPosition(230,35)
                           .setSize(50,19)
                           .setCaptionLabel("Browse")
                           .setGroup(grpOutImageSet);
    btnOutImageSetPath.getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    
    txtOutImageSetNo = cp5Ctrls.addTextfield("txtOutImageSetNo")
                           .setPosition(5,65)
                           .setWidth(135)
                           .setAutoClear(false)
                           .setCaptionLabel("Start No.")
                           .setGroup(grpOutImageSet);
    txtOutImageSetNo.captionLabel().style().marginTop = -32;
    
    txtOutImageSetInt = cp5Ctrls.addTextfield("txtOutImageSetInt")
                           .setPosition(150,65)
                           .setWidth(135)
                           .setAutoClear(false)
                           .setCaptionLabel("Output Interval")
                           .setGroup(grpOutImageSet);
    txtOutImageSetInt.captionLabel().style().marginTop = -32;
    
    btnOutImageSet  = cp5Ctrls.addButton("btnOutImageSet")
                           .setValue(0)
                           .setPosition(120,90)
                           .setSize(50,19)
                           .setCaptionLabel("Output")
                           .setGroup(grpOutImageSet);
    btnOutImageSet.getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    
    lblOutImageSetForamt = cp5Ctrls.addTextlabel("lblOutImageSetForamt")
                           .setWidth(50)
                           .setHeight(10)
                           .setText("FILE FORMAT")
                           .setFont(ControlP5.standard58)
                           .setPosition(2,9)
                           .setGroup(grpOutImageSet);
    
    String[] strImageSetFormat = {"PNG", "Transparent PNG", "PDF", "DXF"};
    ddlOutImageSetFormat = cp5Ctrls.addDropdownList("ddlOutImageSetFormat")
                           .setPosition(70,20)
                           .setBarHeight(15)
                           .setItemHeight(15)
                           .addItems(strImageSetFormat)
                           .setGroup(grpOutImageSet);
    ddlOutImageSetFormat.captionLabel().style().marginTop = 3;
    ddlOutImageSetFormat.captionLabel().set("Select Type");
    
    // setup output video sub-tab components
    
    txtOutVideoPath = cp5Ctrls.addTextfield("txtOutVideoPath")
                           .setPosition(5,15)
                           .setWidth(220)
                           .setAutoClear(false)
                           .setCaptionLabel("File Path")
                           .setGroup(grpOutVideo);
    txtOutVideoPath.captionLabel().style().marginTop = -32;
    
    btnOutVideoPath = cp5Ctrls.addButton("btnOutVideoPath")
                           .setValue(0)
                           .setPosition(230,15)
                           .setSize(50,19)
                           .setCaptionLabel("Browse")
                           .setGroup(grpOutVideo);
    btnOutVideoPath.getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    
    btnOutVideo  = cp5Ctrls.addButton("btnOutVideo")
                           .setValue(0)
                           .setPosition(120,40)
                           .setSize(50,19)
                           .setCaptionLabel("Output")
                           .setGroup(grpOutVideo);
    btnOutVideo.getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    
    // setup about tab components
    strAbout = "This application was developed by Ali Nayeri at the University of Minho " +
               "as a part of the Erasmus Mundus Advanced Masters in Structural Analysis of " +
               "Monuments and Historical Constructions (MSc SAHC). The program was developed " +
               "in cooperation with National Laboratory for Civil Engineering in Lisbon (LNEC).\n\n" +
               "The program and its source-code are available for free for use by other researchers.";
    lblAbout    = cp5Ctrls.addTextlabel("lblAbout")
                          .setColorValue(0x00000000)
                          .setMultiline(true)
                          .setWidth(290)
                          .setHeight(80)
                          .setText(strAbout)
                          .setPosition(5,5)
                          .setGroup(grpAbout);
    
    btnSAHCLink = cp5Ctrls.addButton("btnSAHCLink")
                          .setPosition(29,85)
                          .setImages(loadImage("sahc_logo.png"), loadImage("sahc_logo.png"), loadImage("sahc_logo.png"))
                          .setGroup(grpAbout)
                          .updateSize();
    
    // setup the accordion menu
    accMenus    = cp5Ctrls.addAccordion("accMenus")
                          .setPosition(20,20)
                          .setWidth(300)
                          .addItem(grpInputs)
                          .addItem(grpView)
                          .addItem(grpTH)
                          .addItem(grpModel)
                          .addItem(grpRegions)
                          .addItem(grpBlocks)
                          .addItem(grpOutput)
                          .addItem(grpAbout);
    
    // setup the time line slider
    sldTimeLine = cp5Ctrls.addSlider("step")
                          .setPosition(66,height-20)
                          .setSize(width-66,20)
                          .setRange(1, 2);
    
    btnTHPlay   = cp5Ctrls.addButton("btnTHPlay")
                          .setValue(0)
                          .setPosition(22,height-20)
                          .setImages(loadImage("play0.png"), loadImage("play1.png"), loadImage("play1.png"))
                          .updateSize();
                          
    btnTHRev    = cp5Ctrls.addButton("btnTHRev")
                          .setValue(0)
                          .setPosition(0,height-20)
                          .setImages(loadImage("rev0.png"), loadImage("rev1.png"), loadImage("rev1.png"))
                          .updateSize();
    
    btnTHFF     = cp5Ctrls.addButton("btnTHFF")
                          .setValue(0)
                          .setPosition(44,height-20)
                          .setImages(loadImage("ff0.png"), loadImage("ff1.png"), loadImage("ff1.png"))
                          .updateSize();
    
    lblTHFile    = cp5Ctrls.addTextlabel("lblTHFile")
                           .setColorValue(0x00000000)
                           .setWidth(200)
                           .setHeight(10)
                           .setText("File:")
                           .setPosition(20,height-80)
                           .hide();
    lblTHFile.getValueLabel().setColorBackground(0xffffffff);
    
    lblTHTime    = cp5Ctrls.addTextlabel("lblTHTime")
                           .setColorValue(0x00000000)
                           .setWidth(200)
                           .setHeight(10)
                           .setText("Time:")
                           .setPosition(20,height-65)
                           .hide();
    lblTHTime.getValueLabel().setColorBackground(0xffffffff);
    
    lblTHMag     = cp5Ctrls.addTextlabel("lblTHMag")
                           .setColorValue(0x00000000)
                           .setWidth(200)
                           .setHeight(10)
                           .setText("Mag:")
                           .setPosition(20,height-50)
                           .hide();
    lblTHMag.getValueLabel().setColorBackground(0xffffffff);
    
    // setup the side branding logo
    btnSAHCLogo = cp5Ctrls.addButton("btnSAHCLogo")
                          .setValue(0)
                          .setPosition(width-100,height-80)
                          .setImages(loadImage("sahc_logo_small_trans2.png"), loadImage("sahc_logo_small.png"), loadImage("sahc_logo_small_trans2.png"))
                          .updateSize();
    
  }
  
  void draw() {
    // turn off shading
    noLights();
    
    // disable view manipulation on the gui components
    scene.enableMouseHandling(!cp5Ctrls.isMouseOver());
    
    // check visibilty of the menus and branding logo
    if (blnMenu) { accMenus.show(); } else { accMenus.hide(); }
    if (blnLogo) { btnSAHCLogo.show(); } else { btnSAHCLogo.hide(); }
    
    // check visibility of the time line for time history mode
    if (blnTHLoaded && blnTimeLine) { 
      //sldTimeLine.setRange(1, analysis.getreccount()); 
      sldTimeLine.show(); 
      btnTHRev.show();
      btnTHPlay.show();
      btnTHFF.show();
    } else { 
      sldTimeLine.hide();
      btnTHRev.hide();
      btnTHPlay.hide();
      btnTHFF.hide();
    }
    
    // draw the gui components
    hint(DISABLE_DEPTH_TEST);
    currCameraMatrix = new PMatrix3D(g3.modelview);
    float cameraZ = ((height/2.0) / tan(PI*60.0/360.0));
    perspective(PI/3.0, scene.camera().aspectRatio(), cameraZ/10.0, cameraZ*10.0);
    camera();
    cp5Ctrls.draw();
    g3.camera = currCameraMatrix;
    hint(ENABLE_DEPTH_TEST);
    
    // return shading
    if (blnShading) { lights(); }
  }
  
  void addRegionList() {
    lblRegID.show();
    lblNoReg.hide();
    ddlRegions   = cp5Ctrls.addDropdownList("ddlRegions")
                           .setPosition(70,20)
                           .setBarHeight(15)
                           .setItemHeight(15)
                           .setGroup(grpRegions);
    for (int i = 1; i < model.regions.size()+1; i++) {
      Region iregion = (Region) model.regions.get(i);
      ddlRegions.addItem(str(iregion.id), iregion.id);
    }
    ddlRegions.captionLabel().style().marginTop = 3;
    ddlRegions.captionLabel().set("Select Region");
  }
  
  void addBlockList() {
    lblBlkID.show();
    lblNoBlk.hide();
    ddlBlocks    = cp5Ctrls.addDropdownList("ddlBlocks")
                           .setPosition(70,20)
                           .setBarHeight(15)
                           .setItemHeight(15)
                           .setGroup(grpBlocks);
    for (int i = 0; i < model.blocks.size(); i++) {
      Block iblock = (Block) model.blocks.get(i);
      ddlBlocks.addItem(str(iblock.id), iblock.id);
    }
    ddlBlocks.captionLabel().style().marginTop = 3;
    ddlBlocks.captionLabel().set("Select Block");
  }
  
  // side menu visiblity methods
  void hideMenu() {
    blnMenu = false;
  }
  void showMenu() {
    blnMenu = true;
  }
  
  // branding logo visiblity methods
  void hideLogo() {
    blnLogo = false;
  }
  void showLogo() {
    blnLogo = true;
  }
  
  // time line control visiblity methods
  void hideTimeLine() {
    blnTimeLine = false;
  }
  void showTimeLine() {
    blnTimeLine = true;
  }
  
  // file output visiblity methods
  void hideAll() {
    blnTimeLine = false;
    blnMenu = false;
    btnSAHCLogo.setImages(loadImage("sahc_logo_small_op.png"), loadImage("sahc_logo_small_op.png"), loadImage("sahc_logo_small_op.png"));
  }
  void showAll() {
    blnTimeLine = true;
    blnMenu = true;
    btnSAHCLogo.setImages(loadImage("sahc_logo_small_trans2.png"), loadImage("sahc_logo_small.png"), loadImage("sahc_logo_small_trans2.png"));
  }
  
}

// controller events
public void btnSAHCLink(int intVal) {
  if (intVal == 0) {
    guiInterface.btnSAHCLink.setValue(1);
  } else {
    link("http://www.msc-sahc.org", "_new"); 
  }
}

public void btnSAHCLogo(int intVal) {
  if (intVal == 0) {
    guiInterface.btnSAHCLogo.setValue(1);
  } else {
    link("http://www.msc-sahc.org", "_new"); 
  }
}

public void btnLoadModel(int intVal) {
  if (intVal == 0) {
    guiInterface.btnLoadModel.setValue(1);
  } else {
    String strModelPath = selectInput("3DEC Model Geometry File (*.dat)"); 
    if (strModelPath == null && !blnModelLoaded) {
      blnModelLoaded = false;
      guiInterface.lblRegID.hide();
      guiInterface.lblNoReg.show();
      guiInterface.lblBlkID.hide();
      guiInterface.lblNoBlk.show();
    } else {
      model = new BlockModel(strModelPath);
      guiInterface.txtModelPath.setValue(strModelPath);
      blnModelLoaded = true;
      blnTHLoaded = false;
      guiInterface.txtTHPath.show();
      guiInterface.btnLoadTH.show();
      guiInterface.addRegionList();
      guiInterface.lblRegID.show();
      guiInterface.lblNoReg.hide();
      guiInterface.addBlockList();
      guiInterface.lblBlkID.show();
      guiInterface.lblNoBlk.hide();
      guiInterface.lblNoOut.hide();
      guiInterface.accOutput.show();
    }
  }
}

public void btnLoadTH(int intVal) {
  if (intVal == 0) {
    guiInterface.btnLoadTH.setValue(1);
  } else {
    String strAnalysisPath = selectInput("3DEC Analysis Output File (*_pts.out)"); 
    if (strAnalysisPath == null && !blnTHLoaded) {
      blnTHLoaded = false;
      guiInterface.lblNoTH.show();
      guiInterface.lblMagFac.hide();
      guiInterface.sldMagFac.hide();
      guiInterface.lblTHLabel.hide();
      guiInterface.chkTHLabel.hide();
    } else {
      step = 1;
      pause = true;
      analysis = new TimeHistory(strAnalysisPath, model);
      guiInterface.txtTHPath.setValue(strAnalysisPath);
      guiInterface.lblTHFile.setText("File:  " + extractFileName(strAnalysisPath));
      guiInterface.sldTimeLine.setValue(float(step));
      guiInterface.sldTimeLine.setMax(float(analysis.getreccount()));
      guiInterface.lblNoTH.hide();
      guiInterface.lblMagFac.show();
      guiInterface.sldMagFac.show();
      guiInterface.lblTHLabel.show();
      guiInterface.chkTHLabel.show();
      guiInterface.lblTHFile.show();
      guiInterface.lblTHTime.show();
      guiInterface.lblTHMag.show();
      guiInterface.grpOutImageSet.show();
      guiInterface.grpOutVideo.show();
      guiInterface.showTimeLine();
      blnTHLoaded = true;
    }
  }
}

public void btnTHPlay(int intVal) {
  if (intVal == 0) {
    guiInterface.btnTHPlay.setValue(1);
  } else {
    if (pause) {
      pause = false;
      guiInterface.hideMenu();
      guiInterface.btnTHPlay.setImages(loadImage("pause0.png"), loadImage("pause1.png"), loadImage("pause1.png"));
    } else {
      pause = true;
      guiInterface.showMenu();
      guiInterface.btnTHPlay.setImages(loadImage("play0.png"), loadImage("play1.png"), loadImage("play1.png"));
    }
  }
}

public void btnTHRev(int intVal) {
  if (intVal == 0) {
    guiInterface.btnTHRev.setValue(1);
  } else {
    step = 1;
    guiInterface.sldTimeLine.setValue(float(step));
  }
}

public void btnTHFF(int intVal) {
  if (intVal == 0) {
    guiInterface.btnTHFF.setValue(1);
  } else {
    step = analysis.getreccount();
    guiInterface.sldTimeLine.setValue(float(step));
  }
}

public void rdbProj(int intVal) {
  switch(intVal) {
    case 1:
      scene.camera().setType(Camera.Type.ORTHOGRAPHIC);
      break;
    case 2:
      scene.camera().setType(Camera.Type.PERSPECTIVE);
       break;
  }
}

public void chkShading(float[] fltVal) {
  switch(int(fltVal[0])) {
    case 1:
      blnShading = true;
      break;
    default:
      blnShading = false; 
      break;
  }
}

public void rdbView(int intVal) {
  switch(intVal) {
    case 1:
      // top view
      scene.camera().setOrientation(0,0);
      break;
    case 2:
      // front view
      scene.camera().setOrientation(0,HALF_PI);
      break;
    case 3:
      // back view
      scene.camera().setOrientation(0,0);
      scene.camera().frame().rotate(new Quaternion(scene.camera().frame().transformOf(new PVector(1,0,0)), HALF_PI));
      scene.camera().frame().rotate(new Quaternion(scene.camera().frame().transformOf(new PVector(0,1,0)), PI));
      break;
    case 4:
      // left view
      scene.camera().setOrientation(HALF_PI,-HALF_PI);
      break;
    case 5:
      // right view
      scene.camera().setOrientation(-HALF_PI,-HALF_PI);
      break;
    case 6:
      // perspective view
      scene.camera().setOrientation(new Quaternion(new PVector(-HALF_PI-QUARTER_PI, QUARTER_PI, -HALF_PI-QUARTER_PI),1));
      break;
  }
  scene.camera().showEntireScene();
}

public void chkViewLogo(float[] fltVal) {
  switch(int(fltVal[0])) {
    case 0:
      guiInterface.hideLogo();
      break;
    case 1:
      guiInterface.showLogo();
      break;
  }
}

public void chkTHLabel(float[] fltVal) {
  switch(int(fltVal[0])) {
    case 1:
      guiInterface.lblTHFile.show();
      break;
    default:
      guiInterface.lblTHFile.hide();
      break;
  }
  switch(int(fltVal[1])) {
    case 1:
      guiInterface.lblTHTime.show();
      break;
    default:
      guiInterface.lblTHTime.hide();
      break;
  }
  switch(int(fltVal[2])) {
    case 1:
      guiInterface.lblTHMag.show();
      break;
    default:
      guiInterface.lblTHMag.hide(); 
      break;
  }
}

public void chkWireframe(float[] fltVal) {
  if (blnModelLoaded) {
    switch(int(fltVal[0])) {
      case 1:
        model.wireframe(true);
        break;
      default:
        model.wireframe(false); 
        break;
    }
  }
}

public void cpkModelCol(int intCol) {
  if (blnModelLoaded) {
    model.colour(color(red(intCol),green(intCol),blue(intCol),alpha(intCol)));
  }
}

public void cpkRegCol(int intCol) {
  if (blnModelLoaded) {
    Region iregion = (Region) model.regions.get(int(guiInterface.ddlRegions.getValue()));
    iregion.colour(color(red(intCol),green(intCol),blue(intCol),alpha(intCol)));
  }
}

public void chkRegVis(float[] fltVal) {
  if (blnModelLoaded) {
    Region iregion = (Region) model.regions.get(int(guiInterface.ddlRegions.getValue()));
    switch(int(fltVal[0])) {
      case 1:
        iregion.visible(true);
        break;
      case 0:
        iregion.visible(false); 
        break;
    }
  }
}

public void chkRegWire(float[] fltVal) {
  if (blnModelLoaded) {
    Region iregion = (Region) model.regions.get(int(guiInterface.ddlRegions.getValue()));
    switch(int(fltVal[0])) {
      case 1:
        iregion.wireframe(true);
        break;
      case 0:
        iregion.wireframe(false); 
        break;
    }
  }
}

public void chkRegSetCol(float[] fltVal) {
  if (blnModelLoaded) {
    Region iregion = (Region) model.regions.get(int(guiInterface.ddlRegions.getValue()));
    switch(int(fltVal[0])) {
      case 1:
        guiInterface.lblRegCol.show();
        guiInterface.cpkRegCol.show();
        guiInterface.cpkRegCol.setColorValue(iregion.colour);
        break;
      case 0:
        guiInterface.lblRegCol.hide();
        guiInterface.cpkRegCol.hide();
        break;
    }
  }
}

public void cpkBlkCol(int intCol) {
  if (blnModelLoaded) {
    Block iblock = (Block) model.blocks.get(int(guiInterface.ddlBlocks.getValue()));
    iblock.colour = color(red(intCol),green(intCol),blue(intCol),alpha(intCol));
  }
}

public void chkBlkVis(float[] fltVal) {
  if (blnModelLoaded) {
   Block iblock = (Block) model.blocks.get(int(guiInterface.ddlBlocks.getValue()));
    switch(int(fltVal[0])) {
      case 1:
        iblock.visible = true;
        break;
      case 0:
        iblock.visible = false; 
        break;
    }
  }
}

public void chkBlkWire(float[] fltVal) {
  if (blnModelLoaded) {
    Block iblock = (Block) model.blocks.get(int(guiInterface.ddlBlocks.getValue()));
    switch(int(fltVal[0])) {
      case 1:
        iblock.wireframe = true;
        break;
      case 0:
        iblock.wireframe = false; 
        break;
    }
  }
}

public void btnOutImagePath(int intVal) {
  if (intVal == 0) {
    guiInterface.btnOutImagePath.setValue(1);
  } else {
    String strImagePath = selectOutput(); 
    if (strImagePath != null) {
      guiInterface.txtOutImagePath.setValue(strImagePath);
    }
  }
}

public void btnOutImage(int intVal) {
  if (intVal == 0) {
    guiInterface.btnOutImage.setValue(1);
  } else {
    String strImagePath = guiInterface.txtOutImagePath.getText();
    if (strImagePath != null) {
      switch(int(guiInterface.ddlOutImageFormat.getValue())) {
        case 0:
          // png output
          strSaveFile = strImagePath + ".png";
          blnSavePNG = true;
          break;
        case 1:
          // transparent png output
          strSaveFile = strImagePath + ".png";
          blnSavePNGt = true;
          break;
        case 2:
          // pdf output
          strSaveFile = strImagePath + ".pdf";
          blnSavePDF = true;
          break;
        case 3:
          // dxf output
          strSaveFile = strImagePath + ".dxf";
          blnSaveDXF = true;
          break;
      }
      guiInterface.hideAll();
    }
  }
}

public void btnOutImageSetPath(int intVal) {
  if (intVal == 0) {
    guiInterface.btnOutImageSetPath.setValue(1);
  } else {
    String strImageSetPath = selectOutput(); 
    if (strImageSetPath != null) {
      guiInterface.txtOutImageSetPath.setValue(strImageSetPath);
    }
  }
}

public void btnOutImageSet(int intVal) {
  if (intVal == 0) {
    guiInterface.btnOutImageSet.setValue(1);
  } else {
    String strImageSetPath = guiInterface.txtOutImageSetPath.getText();
    if (strImageSetPath != null) {
      strSetFile = strImageSetPath;
      fltSetInt = float(guiInterface.txtOutImageSetInt.getText());
      intSetStartNo = int(guiInterface.txtOutImageSetNo.getText());
      blnSaveSet = true;
    }
  }
}

public void btnOutVideoPath(int intVal) {
  if (intVal == 0) {
    guiInterface.btnOutVideoPath.setValue(1);
  } else {
    String strVideoPath = selectOutput(); 
    if (strVideoPath != null) {
      guiInterface.txtOutVideoPath.setValue(strVideoPath);
    }
  }
}

public void btnOutVideo(int intVal) {
  if (intVal == 0) {
    guiInterface.btnOutVideo.setValue(1);
  } else {
    String strVideoPath = guiInterface.txtOutVideoPath.getText();
    if (strVideoPath != null) {
      println(strVideoPath);
      strSaveFile = strVideoPath + ".ogg";
      blnSaveVid = true;
      step = 1;
      pause = false;
      mmkVideo = new GSMovieMaker(this, width, height, strSaveFile, 
      //                            GSMovieMaker.THEORA, GSMovieMaker.BEST, int(frameRate));
                                  GSMovieMaker.THEORA, GSMovieMaker.BEST, 6);
      mmkVideo.setQueueSize(50, 10);
      //mmkVideo.setQueueSize(0, 100);
      //mmkVideo.setQueueSize(0, 10);
      mmkVideo.start();
      guiInterface.hideAll();
    }
  }
}

public void controlEvent(ControlEvent theEvent) {
  if (theEvent.isGroup()) {
    if (theEvent.getGroup().getName() == "ddlModelCol" && blnModelLoaded) {
      switch(int(theEvent.getGroup().getValue())) {
        case 0:
          guiInterface.cpkModelCol.hide();
          guiInterface.lblModelCCol.hide();
          model.colourbyID();
          break;
        case 1:
          guiInterface.cpkModelCol.hide();
          guiInterface.lblModelCCol.hide();
          model.colourbyRegion();
          break;
        case 2:
          guiInterface.cpkModelCol.show();
          guiInterface.lblModelCCol.show();
          int intCol = guiInterface.cpkModelCol.getColorValue();
          model.colour(color(red(intCol),green(intCol),blue(intCol),alpha(intCol)));
          break;
      }
    }
    
    if (theEvent.getGroup().getName() == "ddlRegions" && blnModelLoaded) {
      if (int(theEvent.getGroup().getValue()) == 0) {
        guiInterface.lblRegSetCol.hide();
        guiInterface.chkRegSetCol.hide();
        guiInterface.lblRegCol.hide();
        guiInterface.cpkRegCol.hide();
        guiInterface.lblRegVis.hide();
        guiInterface.chkRegVis.hide();
        guiInterface.lblRegWire.hide();
        guiInterface.chkRegWire.hide();
      } else {
        Region iregion = (Region) model.regions.get(int(theEvent.getGroup().getValue()));
        guiInterface.lblRegSetCol.show();
        guiInterface.chkRegSetCol.show();
        guiInterface.chkRegSetCol.deactivateAll();
        guiInterface.lblRegCol.hide();
        guiInterface.cpkRegCol.hide();
        guiInterface.lblRegVis.show();
        guiInterface.chkRegVis.show();
        if (iregion.visible) { guiInterface.chkRegVis.activate(0); } else { guiInterface.chkRegVis.deactivateAll(); }
        guiInterface.lblRegWire.show();
        guiInterface.chkRegWire.show();
        if (iregion.wireframe) { guiInterface.chkRegWire.activate(0); } else { guiInterface.chkRegWire.deactivateAll(); }
      }
    }
    
    if (theEvent.getGroup().getName() == "ddlBlocks" && blnModelLoaded) {
      if (int(theEvent.getGroup().getValue()) == 0) {
        guiInterface.lblBlkCol.hide();
        guiInterface.cpkBlkCol.hide();
        guiInterface.lblBlkVis.hide();
        guiInterface.chkBlkVis.hide();
        guiInterface.lblBlkWire.hide();
        guiInterface.chkBlkWire.hide();
      } else {
        Block iblock = (Block) model.blocks.get(int(guiInterface.ddlBlocks.getValue()));
        guiInterface.lblBlkCol.show();
        guiInterface.cpkBlkCol.show();
        guiInterface.cpkBlkCol.setColorValue(iblock.colour);
        guiInterface.lblBlkVis.show();
        guiInterface.chkBlkVis.show();
        if (iblock.visible) { guiInterface.chkBlkVis.activate(0); } else { guiInterface.chkBlkVis.deactivateAll(); }
        guiInterface.lblBlkWire.show();
        guiInterface.chkBlkWire.show();
        if (iblock.wireframe) { guiInterface.chkBlkWire.activate(0); } else { guiInterface.chkBlkWire.deactivateAll(); }
      }
    }
  }
  
}

