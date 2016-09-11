package com.season.classes.race.rideritem {

  import flash.display.Sprite;
  import flash.display.Shape;
  import flash.events.*;

  import fl.transitions.Tween;
  import fl.transitions.TweenEvent;
  import fl.transitions.easing.*;

  import com.season.components.*;
  import com.season.models.*;
  import com.season.classes.race.*;
  import com.season.classes.tooltip.*;

  import mylibrary.utils.anim.*;

  /**********************
   * 
   * RiderItem
   *
   **********************/
  public class RiderItem extends TweeningSprite {

    /**********************
     * VARIABLES      
     **********************/
    private var _model:RiderLapModel;
    private var bgCurr:RiderItemShape = null;

    private var bgTeam:TeamRiderItemShape = null;
    private var bgMan:ManRiderItemShape = null;
    private var bgTire:TireRiderItemShape = null;

    private var race:Race;

    private var isShowLapTime:Boolean = false;

    //----//
    public static const RIDER_ITEM_SIZE:int = 15;
    

    /**********************
     * CONSTRCUTOR
     **********************/
    public function RiderItem(theRace:Race) {
      race = theRace;

      //RiderItemShapes
      bgTeam = new TeamRiderItemShape(race);
      addChild(bgTeam);
      
      bgCurr = bgTeam;

      bgMan = new ManRiderItemShape(race);
      bgMan.visible = false;
      addChild(bgMan);
      
      bgTire = new TireRiderItemShape(race);
      bgTire.visible = false;
      addChild(bgTire);

      changeItemView(race.options.itemView);

      //Sign up for events
      race.options.radioItemView.addEventListener(StatsRadioGroup.SELECTION_CHANGE, 
                                                  onItemViewChange);
      race.options.boxLapTime.addEventListener(MouseEvent.CLICK, onShowLapTime);
      addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
      addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
      race.addEventListener(Race.RIDER_ITEM_MOUSE_OVER, onOverRider);
    }
    /**********************
     * SETTERS/GETTERS
     **********************/
    public function set model(newModel:RiderLapModel) {
      _model = newModel;

      bgTeam.color = _model.riderModel.colorTeam;
      showTeamOrder(true);
      bgMan.color = _model.riderModel.colorManufacturer;
      bgTire.color = _model.riderModel.colorTire;

      showLapTime(race.options.showLapTime);
    }    
    public function get model():RiderLapModel {
      return _model;
    }
    override public function set alpha(nalpha:Number):void {
      super.alpha = nalpha;
      //mouseChildren = nalpha > 0;
      //mouseEnabled = nalpha > 0;
    }
    /**********************
     * PUBLIC
     **********************/    
    public function get size():int {
      return bgCurr.size;
    }

    public function setSize(size:int):void {
      bgCurr.size = size;
    }
    
    public function setRectSize(nw:int, nh:int):void {
      bgCurr.setRectSize(nw, nh);
    }

    //----//
    public function showTeamOrder(show:Boolean):void {
      bgTeam.showDot(show && !_model.riderModel.isTopRider);
    }

    //----//
    public function moveToLap(doTween:Boolean = true):Tween {
      var nx:int = _model.lapNumber * Race.GRID_X_SPACING;
      //trace(nx);
      return tween("x", nx, doTween ? .4 : 0);
    }

    //----//
    public function moveToPosition(doTween:Boolean = true):Tween {
      var ny:int = _model.pos * Race.GRID_Y_SPACING;
      return tween("y", ny, doTween ? .4 : 0);
    }

    //----//
    public function moveToFinalPosition(doTween:Boolean = true):Tween {
      if (_model.finalPos < 0) { return null; }
      var ny:int = _model.finalPos * Race.GRID_Y_SPACING;
      return tween("y", ny, doTween ? .4 : 0);
    }

    //----//
    public function moveToGap(doTween:Boolean = true):Tween {
      var gapRange:Number = race.options.gapLength;
      var totalgap:Number = (gapRange - _model.gap)/gapRange;

      /*var totalgap:Number = 
        (Race.RACE_GAP_TIME_RANGE - _model.gap)/Race.RACE_GAP_TIME_RANGE;*/
      var ny:int = 
        Race.RACE_GAP_HEIGHT_RANGE - Math.round(totalgap * Race.RACE_GAP_HEIGHT_RANGE);

      return tween("y", ny, doTween ? .4 : 0);
    }

    //----//
    public function moveToSpeed(doTween:Boolean = true):Tween {
      var pixelVal:Number = race.vGridWidth/RaceModel.getInstance().speedRange;
      var speedDiff:Number = RaceModel.getInstance().speedTop - _model.speedTop;
      var nx:int = race.vGridWidth - (pixelVal * speedDiff);

      return tween("x", nx, doTween ? .4 : 0);
    }
    

    /**********************
     * PRIVATE
     **********************/
    private function showLapTime(show:Boolean):void {
      if (!_model) { return; }
      if (show && _model.lapTime != 0) {
        var fastest:Number = RaceModel.getInstance().lapFastest;
        var diff:Number = _model.lapTime - fastest;
        
        //var fac:Number = ((100 - fastest)/100);
        //var ns:Number = 26 - 
        //  (Math.round(Math.pow(diff, 1.15 + 3 * fac) * 7));

        var fac:Number = ((120 - fastest)/120);
        var ns:Number = 26 - 
          (Math.round(Math.pow(diff, 1.15 + 3 * fac) * 3.5));

        ns = Math.max(ns, 7);
        setSize(ns);

        if (_model.isRaceFastestLap) {
          bgCurr.hiliteColor = 0xBB0000;
        }

        if (_model.isFastestLap) {
          //bgCurr.hideShowHilite(true);
        }
      } else {
        setSize(RIDER_ITEM_SIZE);
        if (_model.isFastestLap) {
          //bgCurr.hideShowHilite(false);
        }
        if (_model.isRaceFastestLap) {
          bgTeam.hiliteColor = _model.riderModel.colorTeam;
          bgMan.hiliteColor = _model.riderModel.colorManufacturer;
          bgTire.hiliteColor = _model.riderModel.colorTire;
        }
      }
      isShowLapTime = show;
    }

    //----//
    public function changeItemView(view:String):void {
      var newBg:RiderItemShape;
      switch(view) {
      case "TEAM":
        newBg = bgTeam;
        break;
      case "MANUFACTURER":
        newBg = bgMan;
        break;
      case "TIRE":
        newBg = bgTire;
        break;
      }

      if (bgCurr == newBg) { return; }
      newBg.visible = true;
      bgCurr.visible = false;
      newBg.size = bgCurr.size;
      bgCurr = newBg;

      if (isShowLapTime && _model != null) {
        if (_model.isFastestLap) {
          //bgCurr.hideShowHilite(true);
        }
        if (_model.isRaceFastestLap) {
          bgCurr.hiliteColor = 0xBB0000;
          bgCurr.hideShowHilite(true);
        }
      }
    }

    /**********************
     * HANDLERS
     **********************/
    private function onItemViewChange(e:Event):void {
      var group:StatsRadioGroup = e.target as StatsRadioGroup;
      var sel:SelectableButton = group.selection;

      changeItemView(sel.label);
    }

    /*********************/
    private function onShowLapTime(e:MouseEvent):void {
      var button:SelectableButton = e.target as SelectableButton;
      showLapTime(button.selected);
    }

    /*********************/
    private function onGapChange(e:MouseEvent):void {
      
    }

    /*********************/
    private function onMouseOver(e:MouseEvent):void {
      if (alpha == 0) { return; }

      RiderLapTooltip.getInstance().show(this);
      if (race.options.raceView != "SPEED") {
        race.doOverRider(_model.riderModel.riderNum);
        //parent.setChildIndex(this, parent.numChildren - 1);
        race.vGrid.showLapLabel(model.lapNumber, true);
      }
    }
    /*********************/
    private function onMouseOut(e:MouseEvent):void {
      race.doOverRider(-1);
      race.vGrid.showLapLabel(model.lapNumber, false);
      RiderLapTooltip.getInstance().hide();
    }

    /*********************/
    private function onOverRider(e:RiderItemEvent):void {
      if (!_model) { return; }

      if (isShowLapTime && _model.isFastestLap) { 
        parent.setChildIndex(this, parent.numChildren - 1);
        return; 
      }
      var isMe:Boolean = e.riderNumber == _model.riderModel.riderNum;
      bgCurr.hideShowHilite(isMe);
      if (isMe) {
        parent.setChildIndex(this, parent.numChildren - 2);
      }
    }
  }
}
