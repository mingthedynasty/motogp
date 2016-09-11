package com.season.classes.header {

  import flash.display.Sprite;
  import flash.text.TextField;
  import flash.text.TextFormat;
  import flash.text.*;

  import com.season.*;
  import com.season.utils.*;

  /**********************
   * 
   * RaceInfoPropValue
   *
   **********************/	
  public class RaceInfoPropValue extends Sprite {

  /**********************
   * VARIABLES
   **********************/	
    private var valueText:TextField;


  /**********************
   * CONSTRUCTOR
   **********************/	
    public function RaceInfoPropValue(prop:String) {
      var propFormat:TextFormat = 
        TextFactory.createTextFormat(TextStyle.PLAIN, 0xAAAAAA);
      var propText:TextField = TextFactory.createText(propFormat);
      propText.text = prop;


      var valueFormat:TextFormat = 
        TextFactory.createTextFormat(TextStyle.BOLD, 0x888888);
      valueText = TextFactory.createText(valueFormat);
      valueText.x = propText.width + 2;

      //add children
      addChild(propText);
      addChild(valueText);
    }

  /**********************
   * PUBLIC
   **********************/	
    public function updateValue(value:String) {
      valueText.text = value;
    }
  }
}
