package com.season.classes.race {

  import flash.display.*;
  import flash.events.*;
  import flash.text.*;
  import flash.text.TextField;
  import flash.text.TextFormat;

  import fl.transitions.Tween;
  import fl.transitions.TweenEvent;

  import com.season.utils.*;
  import com.season.models.*;

  import mylibrary.utils.anim.*;

  /**********************
   *
   * FinalLapOutline
   *
   **********************/
  public class FinalLapOutline extends TweeningSprite {

    /**********************
     * VARIABLES
     **********************/
    private var _outlineBottom:TweeningSprite = new TweeningSprite();
    private var _bottomMask:TweeningSprite = new TweeningSprite();


    public static const PADDING:Number = 15;
    public static const LINE_HEIGHT:Number = 15;


    /**********************
     * CONSTRUCTOR
     **********************/
    public function FinalLapOutline() {
      //text
      var format:TextFormat = 
        TextFactory.createTextFormat(TextStyle.PLAIN, 0x888888);
      var finalText:TextField = TextFactory.createText(format);

      addChild(finalText);
      finalText.text = "FINAL";
      finalText.y = -(PADDING + LINE_HEIGHT + finalText.height);
      finalText.x = -Math.round(finalText.width/2);

      //line
      graphics.clear();
      graphics.lineStyle(1, 0x888888, 1, true, 
                         LineScaleMode.NORMAL, null, 
                         JointStyle.MITER );
      graphics.moveTo(-1, -(PADDING + LINE_HEIGHT));
      graphics.lineTo(-1, -PADDING);
      
      //top bracket
      graphics.moveTo(-PADDING, 100);
      graphics.lineTo(-PADDING, -PADDING);
      graphics.lineTo(PADDING, -PADDING);
      graphics.lineTo(PADDING, 100);

      //bottom bracket
      _outlineBottom.graphics.clear();
      _outlineBottom.graphics.lineStyle(1, 0x888888, 1, true, 
                                        LineScaleMode.NORMAL, null, 
                                        JointStyle.MITER );
      _outlineBottom.graphics.moveTo(-PADDING, 0);
      _outlineBottom.graphics.lineTo(-PADDING, 1000);
      _outlineBottom.graphics.lineTo(PADDING, 1000);
      _outlineBottom.graphics.lineTo(PADDING, 0);

      _bottomMask.graphics.beginFill(0xFF0000, 1);
      _bottomMask.graphics.drawRect(-PADDING - 10, 0, 2 * (PADDING + 10), 1000);
      _bottomMask.graphics.endFill();

      addChild(_bottomMask);
      _outlineBottom.mask = _bottomMask;

      addChild(_outlineBottom);

      mouseEnabled = false;
      mouseChildren = false;
    }

    /**********************
     * PUBLIC
     **********************/
    public function update(nh:int, tween:Boolean = false):void {
      var ny:int = nh - 1000 + PADDING;
      if (tween) {
        _outlineBottom.tween("y", ny);
      } else {
        _outlineBottom.y = ny;
      }
    }
  }
}
