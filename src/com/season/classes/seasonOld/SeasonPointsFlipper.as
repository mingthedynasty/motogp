package com.season.classes.season {

  import flash.display.*;
  import flash.events.*;
  import flash.text.*;	

  import com.season.components.*;
  import com.season.utils.*;
  import com.season.classes.header.*;

  /**********************
   *
   * SeasonPointsFlipper
   *
   **********************/
  public class SeasonPointsFlipper extends Flipper{

    /**********************
     * VARIABLES
     **********************/
    private var outline:Sprite = new Sprite();
    private var text1:TextField = TextFactory.createText();
    private var text2:TextField = TextFactory.createText();

    private static const FLIPPER_WIDTH = 28;

    /**********************
     * CONSTRUCTOR
     **********************/
    public function SeasonPointsFlipper() {
      super(text1, text2, 14);

      maskObj.width = FLIPPER_WIDTH;

      //outline
      outline.y = 0;
      outline.x = -1;
      addChild(outline);
    }

    /**********************
     * GETTERS/SETTERS
     **********************/
    public function set color(c:uint):void {
      //text
      var textStyle:TextFormat = 
        TextFactory.createTextFormat(TextStyle.BOLD, c);
      text1.defaultTextFormat = textStyle;
      text2.defaultTextFormat = textStyle;

      //outline
      outline.graphics.clear();
      outline.graphics.lineStyle(1, c);
      outline.graphics.drawRect(0, 0, FLIPPER_WIDTH, 15);      
    }

    /**********************
     * PROTECTED
     **********************/
    override protected function changeContents(obj:DisplayObject, info:*):void {
      var text:TextField = obj as TextField;
      text.text = String(info as int);
      text.x = Math.round((FLIPPER_WIDTH - text.width)/2);
    }
  }
}
