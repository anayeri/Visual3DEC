class Region {
  
  int id;
  ArrayList<Block> blocks;
  color colour;
  boolean visible;
  boolean wireframe;
  
  Region(int regid) {
    id = regid;
    blocks = new ArrayList<Block>();
    visible = true;
    colour = color(255, 255, 255);
  }
  
  void add(Block newblk) {
    blocks.add(newblk);
    newblk.region = this;
  }
  
  void colour(color regcolour) {
    colour = regcolour;
    for (int i = 0; i < blocks.size(); i++) {
      Block iblock = (Block) blocks.get(i);
      iblock.colour = regcolour;
    }
  }
  
  void visible(boolean visibility) {
    visible = visibility;
    for (int i = 0; i < blocks.size(); i++) {
      Block iblock = (Block) blocks.get(i);
      iblock.visible = visibility;
    }
  }
  
  void wireframe(boolean state) {
    wireframe = state;
    for (int i = 0; i < blocks.size(); i++) {
      Block iblock = (Block) blocks.get(i);
      iblock.wireframe = state;
    }
  }
  
}
