package com.season.classes.header {

  import flash.display.*;
  import flash.events.*;

  import com.season.*;
  import com.season.models.*;
  import com.season.components.*;
  import com.season.utils.*;

  /**********************
   * 
   * YearChooser
   *
   **********************/	
  public class YearChooser extends Sprite {

    public var currYear:String = "";
    private var _buttons:Array = [];
    
    //--------//
    static private var instance:YearChooser = new YearChooser();
    public static const YEAR_SELECTED:String = "yearSelected";

    /**********************
     * PUBLIC
     **********************/
    public function initChooser():void {
      var seriesModel:SeriesModel = SeriesModel.getInstance();
      var nx = 0;
      for (var i:int = 0; i < seriesModel.yearList.length(); i++) {
        var btn:SelectableTextButton = 
          new SelectableTextButton(TextStyle.LARGE, TextStyle.LARGE);
        btn.text = seriesModel.yearList[i];
        btn.textColor = 0xBBBBBB;
        btn.textOverColor = 0x666666;
        btn.x = nx;
        btn.addEventListener(MouseEvent.CLICK, onYearClick);
        addChild(btn);
        
        _buttons[i] = btn;

        if (i < seriesModel.yearList.length() - 1) {
          graphics.lineStyle(1, 0x999999);
          graphics.moveTo(nx + btn.width + 5, 4);
          graphics.lineTo(nx + btn.width + 5, btn.height - 4);
        } else {
          trace("initChooser");
          btn.selected = true;
          currYear = btn.text;
        }
        nx += btn.width + 12;

      }      
    }

    //--------//
    public static function getInstance():YearChooser {      
      return instance;
    }

    /**********************
     * PRIVATE
     **********************/
    private function onYearClick(e:Event):void {
      var btn = e.target as SelectableTextButton;
      if (btn.selected) { return; }

      currYear = btn.text;
      dispatchEvent(new Event(YEAR_SELECTED));
      for (var i:int = 0; i < _buttons.length; i++) {
        _buttons[i].selected = _buttons[i] == btn;
      }
    }
  }

}
