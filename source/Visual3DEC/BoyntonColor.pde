class BoyntonColor {
  
  color[] boyonton;
  int index;
  
  BoyntonColor(int ind) {
    // Define the list
    boyonton = new color[9];
    boyonton[0] = color(0, 0, 255);      //Blue
    boyonton[1] = color(255, 0, 0);      //Red
    boyonton[2] = color(0, 255, 0);      //Green
    boyonton[3] = color(255, 255, 0);    //Yellow
    boyonton[4] = color(255, 0, 255);    //Magenta
    boyonton[5] = color(255, 128, 128);  //Pink
    boyonton[6] = color(128, 128, 128);  //Gray
    boyonton[7] = color(128, 0, 0);      //Brown
    boyonton[8] = color(255, 128, 0);    //Orange
    
    index = ind % 8;
  }
  
  color getcolor() {
    return boyonton[index];
  }
  
}
