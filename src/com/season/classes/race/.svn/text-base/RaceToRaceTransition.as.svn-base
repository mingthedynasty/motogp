package com.season.classes.race {

  import flash.events.*;
  
  import fl.transitions.Tween;
  import fl.transitions.TweenEvent;

  import com.season.classes.race.transitions.*;
  import com.season.classes.race.rideritem.*;
  import com.season.models.*;

  /**********************
   *
   * RaceToRaceTransition
   *
   **********************/
  public class RaceToRaceTransition extends RaceTransition {

    /**********************
     * CONSTRUCTOR
     **********************/
    public function RaceToRaceTransition(race:Race) {
      super(race);
    }

    /**********************
     * PUBLIC
     **********************/
    override public function start():void {
      if (_race.riders.alpha > 0) {
        var tween:Tween = _race.riders.tween("alpha", 0);
        tween.addEventListener(TweenEvent.MOTION_FINISH, onRaceFadeFinish);
      } else {
        onRaceFadeFinish(null);
      }
      _race.mouseChildren = false;
      _race.mouseEnabled = false;
    }

    /**********************
     * PRIVATE
     **********************/
    private function showLap():void {
      _race.vGrid.showLaps();
      _race.hGrid.showPositions(true);
      
      var riderList:Array = _race.riderItemList;
      var rider:RiderItem;
      for (var i:int = 0; i < riderList.length; i++) {
        rider = riderList[i];
        rider.moveToLap(false);
        rider.moveToPosition(false);
        rider.alpha = 1;
      }
    }

    //--------//
    private function showGap():void {
      _race.vGrid.showLaps();
      var prevGap:Number = _race.options.gapLength;
      _race.options.gapSlider.maximum = RaceModel.getInstance().maxGap;
      //trace("maxgap", RaceModel.getInstance().maxGap);

      if (prevGap > _race.options.gapSlider.maximum) {
        _race.hGrid.showGaps();
      }
      
      var riderList:Array = _race.riderItemList;
      var rider:RiderItem;
      for (var i:int = 0; i < riderList.length; i++) {
        rider = riderList[i];
        rider.moveToLap(false);

        if (rider.model.gap > _race.options.gapSlider.value) {//Race.RACE_GAP_TIME_RANGE) {
          rider.alpha = 0;
          rider.moveToPosition(false);
        } else {
          rider.moveToGap(false);
          rider.alpha = 1;
        }
      }
    }

    //--------//
    private function showSpeed():void {
      var pixelVal:Number = _race.vGridWidth/RaceModel.getInstance().speedRange;            
      var speedDiff:Number = 
        RaceModel.getInstance().speedTop - RaceModel.getInstance().speedAvg;
      var avgX:int = _race.vGridWidth - (pixelVal * speedDiff);

      _race.hGrid.showPositions();
      _race.vGrid.showSpeeds(_race.vGridWidth, avgX, true);

      var riderList:Array = _race.riderItemList;
      var rider:RiderItem;
      for (var i:int = 0; i < riderList.length; i++) {
        rider = riderList[i];
        rider.moveToSpeed(false);

        if (rider.model.finalPos > -1 && rider.model.speedTop > 0) {
          rider.moveToFinalPosition();
          rider.alpha = 1;
        } else {
          rider.alpha = 0;
        }
      }
    }

    /**********************
     * HANDLERS
     **********************/
    private function onRaceFadeFinish(e:Event) {
      _race.initialize();
      var nx:int = Math.round((_race.stage.stageWidth - _race.vGridWidth)/2);
      var tween:Tween = _race.vGrid.tween("x", nx);
      var ny:int = Math.round((_race.stage.stageHeight - _race.hGridHeight)/2);
      tween = _race.hGrid.tween("y", ny);
      tween.addEventListener(TweenEvent.MOTION_FINISH, onGridShiftFinish);
      _race.riders.x = nx;
      _race.riders.y = ny;

      switch(_race.currRaceView) {
      case "LAP":
        showLap();
        break;
      case "GAP":
        showGap();
        break;
      case "SPEED":
        showSpeed();
        break;
      }
    }

    //--------//
    private function onGridShiftFinish(e:Event) {
      _race.mouseChildren = true;
      _race.mouseEnabled = true;

      _race.setupMiscellany();
      _race.riders.tween("alpha", 1);
    }
  }
}
