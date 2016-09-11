package com.season.classes.race.rideritem {

  import flash.display.Shape;
  import flash.events.*;

  import com.season.classes.race.*;

  /**********************
   * 
   * ManRiderItemShape
   *
   **********************/
  public class ManRiderItemShape extends RiderItemShape {


    /**********************
     * CONSTRUCTOR
     **********************/
    public function ManRiderItemShape(theRace:Race) {
      super(theRace);
    }

    /**********************
     * METHODS
     **********************/
    override protected function render():void {
      var rad = _size/2;

      //hilite
      hilite.graphics.clear();
      hilite.graphics.beginFill(_hiliteColor, 1.0);
      hilite.graphics.drawCircle(0, 0, rad + 3);
      hilite.graphics.endFill();
      hilite.graphics.beginFill(0xFFFFFF, 1.0);
      hilite.graphics.drawCircle(0, 0, rad + 1);
      hilite.graphics.endFill();
      hilite.visible = false;
      addChild(hilite);

      //background
      bg.graphics.clear();
      bg.graphics.beginFill(_color, 1.0);
      bg.graphics.drawCircle(0, 0, rad);
      bg.graphics.endFill();
      addChild(bg);
    }
  }
}
