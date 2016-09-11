package com.season.components {

  import flash.display.Sprite;
  import flash.display.DisplayObject;

  /**********************
   *
   * Scroller
   *
   **********************/
  public class Scroller extends Sprite {

    /**********************
     * VARIABLES
     **********************/
    private var clipper:Sprite = new Sprite();
    private var target:DisplayObject;

    private var scrollRight:ScrollArrow;
    private var scrollLeft:ScrollArrow;

    /**********************
     * CONSTRUCTOR
     **********************/
    public function Scroller(contents:DisplayObject) {
      target = contents;
      addChild(clipper);
      target.mask = clipper;

      //scroll arrows
      scrollLeft = new ScrollArrow(ScrollArrow.SCROLL_LEFT, this, contents);
      scrollRight = new ScrollArrow(ScrollArrow.SCROLL_RIGHT, this, contents);

      scrollLeft.x = -(scrollRight.width + 5);
      addChild(scrollLeft);
      addChild(scrollRight);
      
    }

    /**********************
     * PUBLIC
     **********************/
    public function resize(w:int, h:int):void {
      clipper.graphics.clear();
      clipper.graphics.beginFill(0x0000FF, .3);
      clipper.graphics.drawRect(0, 0, w, h);

      scrollLeft.updateScrollLimit(w);
      scrollRight.updateScrollLimit(w);

      scrollLeft.y = Math.round((h - scrollLeft.height)/2);
      scrollRight.y = Math.round((h - scrollRight.height)/2);
      scrollRight.x = w + 5;
    }

    /**********************/
    public function shift(nx:int):void  {
      target.x = nx;
      scrollLeft.checkScrollable();
      scrollRight.checkScrollable();
    }
  }
}
