package com.season.components {

  import flash.events.*;
  import flash.display.*;
  import flash.text.TextField;
  import flash.text.TextFormat;

  import com.season.utils.*;

  /**********************
   *
   * SelectableButton
   *
   **********************/
  public class SelectableButton extends Sprite {

    /**********************
     * VARIABLES
     **********************/
    private var _selected:Boolean = false;

    private var _size:Number = 14;

    private var _upState:Sprite = new Sprite();
    private var _overState:Sprite = new Sprite();
    private var _selState:Sprite = new Sprite();

    private var _label:TextButton = new TextButton(TextStyle.BOLD);

    /**********************
     * CONSTRUCTOR
     **********************/
    public function SelectableButton(shape:String = "circle") {
      buttonMode = true;
      mouseChildren = false;

      //render
      if (shape == "circle") {
        renderCircle();
      } else {
        renderRectangle();
      }
      _overState.visible = false;
      _selState.visible = false;

      //label
      _label.textColor = 0x888888;
      _label.textOverColor = 0x666666;
      _label.x = 17;
      _label.y = 1;

      //children
      addChild(_upState);
      addChild(_overState);
      addChild(_selState);
      addChild(_label);

      //events
      addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
      addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
      addEventListener(MouseEvent.CLICK, onClick);

      addEventListener(MouseEvent.MOUSE_OVER, _label.onMouseOver);
      addEventListener(MouseEvent.MOUSE_OUT, _label.onMouseOut);
    }

    /**********************
     * PUBLIC
     **********************/
    public function set label(text:String):void {
      _label.text = text;
    }

    public function get label():String {
      return _label.text;
    }

    public function set selected(sel:Boolean):void {
      _selected = sel;
      _selState.visible = _selected;
      _overState.visible = _selected;

      if (_selected) {
        removeEventListener(MouseEvent.MOUSE_OVER, _label.onMouseOver);
        removeEventListener(MouseEvent.MOUSE_OUT, _label.onMouseOut);
      } else {
        addEventListener(MouseEvent.MOUSE_OVER, _label.onMouseOver);
        addEventListener(MouseEvent.MOUSE_OUT, _label.onMouseOut);

        _label.onMouseOut(null);
      }
    }
    public function get selected():Boolean {
      return _selected;
    }
    /**********************
     * PROTECTED
     **********************/

    /**********************
     * PRIVATE
     **********************/
    private function renderCircle():void {
      var radius:int = _size/2;

      //up
      _upState.graphics.beginFill(0x888888, 1);
      _upState.graphics.drawCircle(radius, radius, radius);
      _upState.graphics.beginFill(0xFFFFFF, 1);
      _upState.graphics.drawCircle(radius, radius, radius - 1);

      //over
      _overState.graphics.beginFill(0x666666, 1);
      _overState.graphics.drawCircle(radius, radius, radius);
      _overState.graphics.beginFill(0xFFFFFF, 1);
      _overState.graphics.drawCircle(radius, radius, radius - 1);

      //sel
      _selState.graphics.beginFill(0x666666, 1);
      _selState.graphics.drawCircle(radius, radius, radius - 3);
    }

    //--------//
    private function renderRectangle():void {
      //up
      _upState.graphics.beginFill(0x888888, 1);
      _upState.graphics.drawRect(0, 0, _size, _size);
      _upState.graphics.beginFill(0xFFFFFF, 1);
      _upState.graphics.drawRect(1, 1, _size - 2, _size - 2);

      //over
      _overState.graphics.beginFill(0x666666, 1);
      _overState.graphics.drawRect(0, 0, _size, _size);
      _overState.graphics.beginFill(0xFFFFFF, 1);
      _overState.graphics.drawRect(1, 1, _size - 2, _size - 2);

      //sel
      _selState.graphics.beginFill(0x666666, 1);
      _selState.graphics.drawRect(3, 3, _size - 6, _size - 6);
    }

    /**********************
     * HANDLERS
     **********************/
    private function onMouseOver(e:MouseEvent):void {
      if (!_selected) {
        _overState.visible = true;
      }
    }
    private function onMouseOut(e:MouseEvent):void {
      if (!_selected) {
        _overState.visible = false;
      }
    }
    private function onClick(e:MouseEvent):void {
      selected = !_selected;
    }

  }
}
