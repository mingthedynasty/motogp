package com.season.utils {


  import flash.text.*;

  /**********************
   * 
   * TextFactory
   *
   **********************/
  public class TextFactory {

    /**********************
     * PUBLIC
     **********************/
    public static function createText(format:TextFormat = null,
                                      multiline:Boolean = false):TextField {
      var text:TextField = new TextField();
      if (multiline) {
        text.multiline = true;
        text.wordWrap = true;
      } 

      text.autoSize = TextFieldAutoSize.LEFT;
      text.selectable = false;
      text.embedFonts = true;
      if (format != null) {
          text.defaultTextFormat = format;
      }
      return text;
    }

    /**********************/
    public static function createTextFormat(style:String, 
                                           color:uint):TextFormat {
      var format:TextFormat = new TextFormat();
      var fontName:String = "";
      switch(style) {
      case TextStyle.PLAIN:
        fontName = AssetManager.plainFont.fontName;
        break;
      case TextStyle.BOLD:
        fontName = AssetManager.boldFont.fontName;
        break;
      case TextStyle.LARGE:
        fontName = AssetManager.largeFont.fontName;
        break;
      case TextStyle.VERDANA:
        fontName = AssetManager.verdanaFont.fontName;
        break;
      }

      format.font = fontName;
      format.size = 8;
      format.color = color;

      return format;
    }
  }
}
