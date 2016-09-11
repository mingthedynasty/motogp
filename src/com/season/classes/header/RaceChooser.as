package com.season.classes.header {


  import flash.display.Sprite;
  import flash.events.*;
  import flash.utils.*;

  import com.season.*;
  import com.season.models.*;

  import mylibrary.utils.*;

  /**********************
   * 
   * RaceChooser
   *
   **********************/
  public class RaceChooser extends Sprite {

    /**********************
     * VARIABLES
     **********************/
    private var selection:RaceButton = null;
    private var arrow:Sprite = new Sprite();
    private var _buttonPool:ObjectPool;

    /********/
    public static const RACE_SELECTED:String = "raceselected";

    /********/
    static private var instance:RaceChooser = new RaceChooser();


    /**********************
     * CONSTRCUTOR
     **********************/
    public function RaceChooser() {
      //arrow
      arrow.graphics.beginFill(0x999999, 1.0);
      arrow.graphics.moveTo(-4, 0);
      arrow.graphics.lineTo(4, 0);
      arrow.graphics.lineTo(0, 4);
      arrow.graphics.lineTo(-4, 0);
      arrow.graphics.endFill();
      arrow.y = -4;
      addChild(arrow);

      //pool
      var button = new RaceButton(this);
      var itemClassName = getQualifiedClassName(button).split("::").join(".");
      _buttonPool = new ObjectPool(itemClassName, this);

    }
    
    /**********************
     * HANDLERS
     **********************/
    private function onStageResize(e:Event):void {
      layoutButtons();
    }

    /**********************
     * SETTERS/GETTERS
     **********************/
    public function get currRaceModel():SeasonRaceModel {      
      return selection.model;
    }

    /**********************
     * PUBLIC
     **********************/
    public static function getInstance():RaceChooser  {      
      return instance;
    }

    /**********************/
    public function initChooser():void {
      _buttonPool.returnAllObjects();
      var currSelection:String = "";
      var currentView:String = (root as MotoGP).currentView;

      if (selection) {
        currSelection = selection.model.shortName;
      }

      var races:XMLList = SeasonModel.getInstance().raceList;
      var last:RaceButton = null;
      var same:RaceButton = null;
      for (var i = 0; i < races.length(); i++) {
        var btn:RaceButton = _buttonPool.getObject(this) as RaceButton;
        btn.model = new SeasonRaceModel(races[i]);
        if (btn.model.happened) { last = btn; }
        if (selection && currSelection == btn.model.shortName) {
          if (currentView == "season") {
            if (btn.model.happened) { same = btn; }
          } else if (btn.model.hasData) {
            same = btn;
          }
        }
        addChild(btn);
      }
      if (same) {
        trace("3", same.model.shortName);
      }
      selectRace(same ? same : last);

      stage.addEventListener(Event.RESIZE, onStageResize);
      layoutButtons();
    }

    /**********************/
    public function selectRace(raceBtn:RaceButton):void {
      if (selection) {
        selection.isSelected = false;
      } 
      selection = raceBtn;
      raceBtn.isSelected = true;
      arrow.x = Math.round(raceBtn.width/2) + raceBtn.x;

      dispatchEvent(new RaceEvent(RACE_SELECTED, raceBtn.model));
    }

    /**********************/
    public function layoutButtons():void {
      var btn;
      var raceCount = SeasonModel.getInstance().raceCount;
      var neww = Math.round((stage.stageWidth - 2 * Header.X_PADDING)/raceCount);
      neww = Math.max(neww, RaceButton.MIN_BUTTON_WIDTH); 
      for (var i = 0; i < numChildren; i++) {        
        btn = getChildAt(i) as RaceButton;
        if (!btn) { continue; }
        btn.update(Header.X_PADDING + (btn.getRaceIndex() * (neww - 1)), neww);
      }

      arrow.x = Math.round(selection.width/2) + selection.x;
    }
  }

}
