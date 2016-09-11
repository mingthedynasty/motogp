package com.season.utils {

  import flash.display.DisplayObject;
  import flash.display.DisplayObjectContainer;
  import flash.text.*;

  import mylibrary.utils.*;

  /**********************
   *
   * TextPool
   *
   **********************/
  public class TextPool extends ObjectPool {

    /**********************
     * VARIABLES
     **********************/
    private var _format:TextFormat;

    /**********************
     * CONSTRUCTOR
     **********************/
    public function TextPool(cont:DisplayObjectContainer, format:TextFormat) {
      super("", cont);
      _format = format;
    }

    /**********************
     * PROTECTED
     **********************/
    override protected function createObject(args:Array):DisplayObject {
      var text:TextField = TextFactory.createText(_format);
      return text;
    }
  }
}
