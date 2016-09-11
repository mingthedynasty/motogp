package com.season.components {

  import flash.events.*;

  /**********************
   *
   * StatsRadioGroup
   *
   **********************/
  public class StatsRadioGroup extends EventDispatcher {

    /**********************
     * VARIABLES
     **********************/
    private var _buttonArray:Array = [];
    private var _selection:SelectableButton;

    public static const SELECTION_CHANGE:String = "selectionChange";


    /**********************
     * PUBLIC
     **********************/
    public function registerButton(button:SelectableButton):void {
      _buttonArray.push(button);
      button.addEventListener(MouseEvent.CLICK, onSelectionChange);
    }

    public function set selection(button:SelectableButton) {
      _selection = button;
      for (var i:int = 0; i < _buttonArray.length; i++) {
        var curr:SelectableButton = _buttonArray[i] as SelectableButton;
        curr.selected = (curr == button);
      }
      dispatchEvent(new Event(SELECTION_CHANGE));
    }

    public function get selection():SelectableButton {
      return _selection;
    }

    /**********************
     * HANDLERS
     **********************/
    private function onSelectionChange(e:Event):void {
      selection = e.target as SelectableButton;      
    }

  }
}
