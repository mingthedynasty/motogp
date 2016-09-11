package com.season.classes.race.rideritem {

  import flash.display.Shape;
  import flash.events.*;

  import com.season.classes.race.*;

  /**********************
   * 
   * TireRiderItemShape
   *
   **********************/
  public class TireRiderItemShape extends RiderItemShape {


    /**********************
     * CONSTRUCTOR
     **********************/
    public function TireRiderItemShape(theRace:Race) {
      super(theRace);
    }

    /**********************
     * METHODS
     **********************/
    override protected function render():void {
      var half = _size/2;
      var x:Number;
      var y:Number;
      var ang:Number;

      //hilite
      hilite.graphics.clear();
      hilite.graphics.beginFill(_hiliteColor, 1.0);
      for (var i = 0; i < 7; i++) {
        ang = (2 * Math.PI)/6 * i;
        x = Math.cos(ang) * (half + 3);
        y = Math.sin(ang) * (half + 3);
        if (i == 0) { hilite.graphics.moveTo(x, y); } 
        else { hilite.graphics.lineTo(x, y); }
      }
      hilite.graphics.endFill();

      hilite.graphics.beginFill(0xFFFFFF, 1.0);
      for (i = 0; i < 7; i++) {
        ang = (2 * Math.PI)/6 * i;
        x = Math.cos(ang) * (half + 1);
        y = Math.sin(ang) * (half + 1);
        if (i == 0) { hilite.graphics.moveTo(x, y); } 
        else { hilite.graphics.lineTo(x, y); }
      }
      hilite.graphics.endFill();

      hilite.visible = false;
      addChild(hilite);

      //background
      bg.graphics.clear();
      bg.graphics.beginFill(_color, 1.0);
      for (i = 0; i < 6; i++) {
        ang = (2 * Math.PI)/6 * i;
        x = Math.cos(ang) * half;
        y = Math.sin(ang) * half;
        if (i == 0) { bg.graphics.moveTo(x, y); } 
        else { bg.graphics.lineTo(x, y); }
      }
      bg.graphics.endFill();
      addChild(bg);
    }
  }
}
