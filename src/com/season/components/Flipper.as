package com.season.components {

  import flash.display.*;
  import flash.text.*;
  import fl.transitions.Tween;
  import fl.transitions.easing.*;	


  /**********************
   *
   * Flipper
   *
   **********************/
  public class Flipper extends Sprite {

    /**********************
     * VARIABLES
     **********************/
    private var dispObj1:DisplayObject;
    private var dispObj2:DisplayObject;

    protected var maskObj:Sprite = new Sprite();

    protected var clipHeight:int = 10;

    private var tween1:Tween;
    private var tween2:Tween;
    private var tweenMask:Tween;

    protected var isFirst:Boolean = true;


    /**********************
     * CONSTRUCTOR
     **********************/
    public function Flipper(obj1:DisplayObject, obj2:DisplayObject,
                            clipH:int = 20) {
      clipHeight = clipH;

      //container
      var container:Sprite = new Sprite();

      //objs
      dispObj1 = obj1;      
      dispObj2 = obj2;
      dispObj2.y = clipHeight + 30;

      container.addChild(dispObj1);
      container.addChild(dispObj2);

      //mask
      maskObj.graphics.beginFill(0xFFFF00);
      maskObj.graphics.drawRect(0, 0, 100, clipHeight);
      container.addChild(maskObj);
      container.mask = maskObj;

      addChild(container);

      //tweens
      tween1 = new Tween(dispObj1, "y", Regular.easeInOut, 
                         0, -(clipHeight + 30), .4, true);
      tween1.stop();
      tween2 = new Tween(dispObj2, "y", Regular.easeInOut, 
                         clipHeight + 30, 0, .4, true);
      tween2.stop();
      tweenMask = new Tween(maskObj, "width", Regular.easeInOut, 
                            0, 0, .4, true);
      tweenMask.stop();

    }

    /**********************
     * PUBLIC
     **********************/
    public function flip(info:* = null):void {
      if (isFirst) { 
        changeContents(dispObj1, info);
        dispObj1.y = Math.round((clipHeight - dispObj1.height)/2);
        isFirst = false;
      } else {
        changeContents(dispObj2, info);
        doFlip();
      }            
    }

    /**********************
     * PROTECTED
     **********************/
    protected function doFlip():void {
      tween1.obj = dispObj1;
      tween2.obj = dispObj2;

      tween1.begin = Math.round((clipHeight - dispObj1.height)/2);
      tween1.start();

      tween2.finish = Math.round((clipHeight - dispObj2.height)/2);
      tween2.start();
      
      var temp = dispObj1;
      dispObj1 = dispObj2;
      dispObj2 = temp;
    }

    /********/
    protected function changeContents(obj:DisplayObject, info:*):void {
      if (isFirst) {
        maskObj.width = obj.width;
      } else {
        tweenMask.begin = maskObj.width;
        tweenMask.finish = obj.width;
        tweenMask.start();
      }
    }
  }
}
