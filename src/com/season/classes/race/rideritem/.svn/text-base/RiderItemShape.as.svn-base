package com.season.classes.race.rideritem {

  import flash.display.Sprite;
  import flash.display.Shape;
  import flash.events.*;

  import com.season.classes.race.*;

  /**********************
   * 
   * RiderItemShape
   *
   **********************/
  public class RiderItemShape extends Sprite {

    /**********************
     * VARIABLES      
     **********************/
    protected var race:Race;

    protected var bg:Shape = null;
    protected var hilite:Shape = null;

    public var _size:int = RiderItem.RIDER_ITEM_SIZE;
    public var _color:uint = 0xFF0000;
    public var _hiliteColor:uint = 0xFF0000;
    

    /**********************
     * CONSTRUCTOR
     **********************/
    public function RiderItemShape(theRace:Race) {
      race = theRace;
      buttonMode = true;
      mouseChildren = false;

      bg = new Shape();
      hilite = new Shape();

      bg.addEventListener(MouseEvent.MOUSE_OVER, doMouseOver);
      bg.addEventListener(MouseEvent.MOUSE_OUT, doMouseOut);
    }

    /**********************
     * HANDLERS
     **********************/
    protected function doMouseOver(e:MouseEvent):void {
      if (race.options.raceView != "SPEED") {
        hilite.visible = true;
      }
    }

    protected function doMouseOut(e:MouseEvent):void {
      hilite.visible = false;
    }

    /**********************
     * SETTERS
     **********************/
    public function set color(newcolor:uint):void {
      _color = newcolor;      
      _hiliteColor = newcolor;
      render();
    }
    public function set hiliteColor(newcolor: uint):void {
      _hiliteColor = newcolor;
      render();
    }

    public function set size(newsize:int):void {
      _size = newsize;
      render();
    }


    /**********************
     * GETTERS
     **********************/
    public function get size():int {
      return _size;
    }

    /**********************
     * PUBLIC
     **********************/
    public function hideShowHilite(show:Boolean):void {
      hilite.visible = show;
    }

    public function setRectSize(nw:int, nh:int):void {
      size = nw;
    }

    /**********************
     * PROTECTED
     **********************/
    protected function render():void {}
  }

}
