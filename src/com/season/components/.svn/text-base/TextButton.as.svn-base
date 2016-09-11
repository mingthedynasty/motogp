package com.season.components {

  import flash.display.*;
  import flash.text.*;
  import flash.text.TextField;
  import flash.text.TextFormat;
  import flash.events.*;

  import com.season.utils.*;

  /**********************
   *
   * TextButton
   *
   **********************/
  public class TextButton extends Sprite {

    /**********************
     * VARIABLES
     **********************/
    protected var colorUp:uint = 0x999999;
    protected var colorOver:uint = 0x333333;
    protected var textStr:String;

    protected var textField:TextField;
    protected var textFormatUp:TextFormat;
    protected var textFormatOver:TextFormat;


    /**********************
     * CONSTRUCTOR
     **********************/
    public function TextButton(upStyle:String = TextStyle.PLAIN,
                               overStyle:String = TextStyle.BOLD) {
      buttonMode = true;
      mouseChildren = false;

      textFormatUp = 
        TextFactory.createTextFormat(upStyle, colorUp);
      textFormatOver = 
        TextFactory.createTextFormat(overStyle, colorOver);

      textField = TextFactory.createText(textFormatUp);      
      addChild(textField);

      //events
      addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
      addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
    }

    /**********************
     * SETTERS/GETTERS
     **********************/
    public function set text(str:String):void { 
      textField.text = str;
      textStr = str;
    }
    public function get text():String {
      return textStr;
    }
    /**********************/
    public function set textColor(color:uint):void {   
      textFormatUp.color = color;
      textField.setTextFormat(textFormatUp);
      colorUp = color;
    }
    public function get textColor():uint {
      return colorUp;
    }

    /**********************/
    public function set textOverColor(color:uint):void {      
      textFormatOver.color = color;
      colorOver = color;
    }
    public function get textOverColor():uint {
      return colorOver;
    }

    /**********************
     * HANDLERS
     **********************/
    public function onMouseOver(e:MouseEvent):void {
      textField.defaultTextFormat = textFormatOver;
      textField.setTextFormat(textFormatOver);
    }

    public function onMouseOut(e:MouseEvent):void {
      textField.defaultTextFormat = textFormatUp;
      textField.setTextFormat(textFormatUp);
    }

  }
}
