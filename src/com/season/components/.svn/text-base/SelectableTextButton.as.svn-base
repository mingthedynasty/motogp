package com.season.components {

  import flash.display.*;
  import flash.text.*;
  import flash.text.TextField;
  import flash.text.TextFormat;
  import flash.events.*;

  import com.season.utils.*;

  /**********************
   *
   * SelectableTextButton
   *
   **********************/
  public class SelectableTextButton extends TextButton {

    /**********************
     * VARIABLES
     **********************/
    private var _selected:Boolean = false;

    /**********************
     * CONSTRUCTOR
     **********************/
    public function SelectableTextButton(upStyle:String = TextStyle.PLAIN,
                                         overStyle:String = TextStyle.BOLD) {
      super(upStyle, overStyle);
    }

    /**********************
     * GETTERS/SETTERS
     **********************/
    public function set selected(sel:Boolean):void {
      _selected = sel;
      if (_selected) {
        super.onMouseOver(null);
      } else {
        onMouseOut(null);
      }
    }

    public function get selected():Boolean {
      return _selected;
    }

    /**********************
     * HANDLERS
     **********************/
    override public function onMouseOver(e:MouseEvent):void {
      if (!_selected) {
        super.onMouseOver(e);
      }
    }

    override public function onMouseOut(e:MouseEvent):void {
      if (!_selected) {
        super.onMouseOut(e);
      }
    }
  }
}
