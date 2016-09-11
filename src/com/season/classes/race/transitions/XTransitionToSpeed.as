package com.season.classes.race.transitions {

  import flash.events.*;

  import fl.transitions.Tween;
  import fl.transitions.TweenEvent;

  import com.season.models.*;
  import com.season.classes.race.*;
  import com.season.classes.race.rideritem.*;

  import mylibrary.utils.anim.*;

  /**********************
   *
   * XTransitionToSpeed
   *
   **********************/
  public class XTransitionToSpeed extends RaceTransition {

    /**********************
     * VARIABLES
     **********************/
    private var _tweenGroup:TweenGroup = new TweenGroup();

    /**********************
     * CONSTRUCTOR
     **********************/
    public function XTransitionToSpeed(race:Race) {
      super(race);
      _tweenGroup.addEventListener(EventGroup.GROUP_FINISH, onTweenFinish);
    }

    /**********************
     * PUBLIC
     **********************/
    override public function start():void {
      //fade final lap outline
      _tweenGroup.addTween(_race.finalLapOutline.tween("alpha", 0));

      //move rider items
      var riderList:Array = _race.riderItemList;
      var rider:RiderItem;
      var pixelVal:Number = _race.vGridWidth/RaceModel.getInstance().speedRange;      
      for (var i:int = 0; i < riderList.length; i++) {
        rider = riderList[i];
        _tweenGroup.addTween(rider.moveToSpeed());
      }
    }

    /**********************
     * HANDLER
     **********************/
    private function onTweenFinish(e:Event):void {
      //fade in speed bars
      var tween:Tween = _race.speedBars.tween("alpha", 1);
      tween.addEventListener(TweenEvent.MOTION_FINISH, onShowBarsFinish);
      
      //finish showing the grid
      _race.vGrid.finishShowSpeeds();
    }

    //----//
    private function onShowBarsFinish(e:TweenEvent):void {
      dispatchEvent(new Event(TRANSITION_FINISH));
    }
  }
}
