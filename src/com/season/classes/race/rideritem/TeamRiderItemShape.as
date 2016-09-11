package com.season.classes.race.rideritem {

  import flash.display.Shape;
  import flash.events.*;

  import com.season.classes.race.*;

  /**********************
   * 
   * TeamRiderItemShape
   *
   **********************/
  public class TeamRiderItemShape extends RiderItemShape {

    /**********************
     * VARIABLES      
     **********************/
    private var dot:Shape = null;

    private var _sizeW:int = RiderItem.RIDER_ITEM_SIZE;
    private var _sizeH:int = RiderItem.RIDER_ITEM_SIZE;

    /**********************
     * CONSTRUCTOR
     **********************/
    public function TeamRiderItemShape(theRace:Race) {
      super(theRace);
      dot = new Shape();
    }

    /**********************
     * PUBLIC
     **********************/
    public function showDot(show:Boolean):void {
      dot.visible = show;
    }

    override public function set size(newsize:int):void {
      _sizeW = newsize;
      _sizeH = newsize;

      _size = newsize;
      render();
    }

    override public function setRectSize(nw:int, nh:int):void {
      _sizeW = nw;
      _sizeH = nh;
      _size = nw;
      render();
    }


    /**********************
     * PROTECTED
     **********************/
    override protected function render():void {
      var half:int = Math.round(_size/2);

      var off = _size/2 - half;


      //hilite
      hilite.graphics.clear();
      hilite.graphics.beginFill(_hiliteColor, 1.0);
      hilite.graphics.drawRect(-(half + 3), -(half + 3), _size + 6, _size + 6);
      hilite.graphics.endFill();
      hilite.graphics.beginFill(0xFFFFFF, 1.0);
      hilite.graphics.drawRect(-(half + 1), -(half + 1), _size + 2, _size + 2);
      hilite.graphics.endFill();
      
      hilite.visible = false;
      addChild(hilite);

      //background
      bg.graphics.clear();
      bg.graphics.beginFill(_color, 1);
      bg.graphics.drawRect(-half, -half, _sizeW, _sizeH);
      bg.graphics.endFill();
      addChild(bg);

      //dot
      dot.graphics.clear();
      dot.graphics.beginFill(0xFFFFFF, 1);
      dot.graphics.drawCircle(off, off, 
                              _size < 14 ? Math.max (_size/2 - 4, 2) : 3);
      dot.graphics.endFill();
      addChild(dot);
      
    }
  }
}
