package com.season.components {

  import flash.display.Sprite;

  import mylibrary.utils.anim.*;

  /**********************
   *
   * HLine
   *
   **********************/
  public class BaseLine extends TweeningSprite {

    /**********************
     * VARIABLES
     **********************/
    protected var _axis:String;
    protected var _sizeAxis:String;
    protected var _mask:Sprite = new Sprite();

    protected var _size:Number;

    protected var _currLine:Sprite;
    protected var _regLine:Sprite;
    protected var _bigLine:Sprite;
    protected var _tightLine:Sprite;


    //----//
    public static const LINE_REGULAR:String = "regular";
    public static const LINE_BIG:String = "big";
    public static const LINE_TIGHT:String = "tight";


    /**********************
     * CONSTRUCTOR
     **********************/
    public function BaseLine() {
      addChild(_mask);
      mask = _mask;

      addChild(_regLine);
      _currLine = _regLine;

      if (_bigLine) {
        _bigLine.visible = false;
        addChild(_bigLine);
      }
      if (_tightLine) {
        _tightLine.visible = false;
        addChild(_tightLine);
      }
    }

    /**********************
     * GETTER/SETTERS
     **********************/
    public function get axis():String{ 
      return _axis;
    }

    public function get sizeAxis():String{ 
      return _sizeAxis;
    }

    //--------//
    public function set lineType(type:String):void {
      
      var newLine:Sprite;
      switch(type) {
      case LINE_REGULAR:
        newLine = _regLine;
        break;
      case LINE_BIG:
        newLine = _bigLine;
        break;
      case LINE_TIGHT:
        newLine = _tightLine;
        break;        
      }      
      if (newLine) {
        _currLine.visible = false;
        newLine.visible = true;        
        _currLine = newLine;
      }
    }

    //--------//
    public function set size(ns:Number):void {
      _size = ns;

      _mask.graphics.clear();
      _mask.graphics.beginFill(0xFFFF00, 1);
      if (_axis == "x") {
        _mask.graphics.drawRect(-10, 0, 20, ns);
      } else {
        _mask.graphics.drawRect(0, -10, ns, 20);
      }
      _mask.graphics.endFill();
    }
  }
}
