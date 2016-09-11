package com.season.components {

  import flash.events.*;
  import flash.display.*;

  import com.season.utils.*;

  /**********************
   *
   * ScrollArrows
   *
   **********************/
  public class ScrollArrow extends TextButton {

    /**********************
     * VARIABLES
     **********************/
    public static const SCROLL_LEFT:String = "left";
    public static const SCROLL_RIGHT:String = "right";

    private var direction:String = SCROLL_LEFT;
    private var scroller:Scroller;
    private var target:DisplayObject;

    private var scrollLimit:int = 0;
    private var downCount:int = 0;
    
    private var wrapperWidth:int = 0;

    /**********************
     * CONSTRUCTOR
     **********************/
    public function ScrollArrow(dir:String, 
                                scroll:Scroller,
                                targetObj:DisplayObject = null) {
      super(TextStyle.LARGE, TextStyle.LARGE);

      target = targetObj;
      scroller = scroll;

      //text
      direction = dir;
      if (dir == SCROLL_LEFT) {
        text = "<<";        
      } else {
        text = ">>";
      }

      textColor = 0xAAAAAA;
      textOverColor = 0x666666;

      //events
      addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
      addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
    }

    /**********************
     * PUBLIC
     **********************/
    public function updateScrollLimit(clipW:int):void {
      wrapperWidth = clipW;

      if (direction == SCROLL_RIGHT) {
        scrollLimit = clipW - (target.width + 10);//(target.getBounds(this).width + 10);

        if (target.x < scrollLimit && scrollLimit < 0) {
          scroller.shift(scrollLimit);
        }
      }
      checkScrollable();
    }

    /**********************/
    public function checkScrollable():void {
      var scrollable:Boolean = true;
      if (direction == SCROLL_LEFT) {
        scrollable = target.x < scrollLimit;
      } else {
        scrollable = this.target.x > scrollLimit;
      }
      visible = scrollable;
      if (!visible) {
        downCount = 0;
        removeEventListener(Event.ENTER_FRAME, onEnterFrame);
      }
    }

    /**********************
     * PRIVATE
     **********************/
    private function scroll():void {
      var increment:int = Math.floor(downCount/3) * 2 + 10;      
      var nx:int = target.x;

      if (direction == SCROLL_LEFT) {
        nx += increment;
        if (nx > scrollLimit) { nx = scrollLimit; }
      } else {
        nx -= increment;
        if (nx < scrollLimit) { nx = scrollLimit; }
      }
      scroller.shift(nx);
      checkScrollable();

      downCount++;
    }

    
    /**********************/
    
    /**********************
     * HANDLERS
     **********************/
    private function onMouseDown(e:MouseEvent):void {
      addEventListener(Event.ENTER_FRAME, onEnterFrame);
    }

    private function onMouseUp(e:MouseEvent):void {
      downCount = 0;
      removeEventListener(Event.ENTER_FRAME, onEnterFrame);
    }

    private function onEnterFrame(e:Event):void {
      scroll();
    }

  }
}
