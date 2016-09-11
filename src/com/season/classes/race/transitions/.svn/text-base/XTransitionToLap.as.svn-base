package com.season.classes.race.transitions {

  import flash.events.*;

  import com.season.models.*;
  import com.season.classes.race.*;
  import com.season.classes.race.rideritem.*;

  import mylibrary.utils.anim.*;

  /**********************
   *
   * XTransitionToLap
   *
   **********************/
  public class XTransitionToLap extends RaceTransition {

    /**********************
     * VARIABLES
     **********************/
    private var _tweenGroup:TweenGroup = new TweenGroup();
    
    /**********************
     * CONSTRUCTOR
     **********************/
    public function XTransitionToLap(race:Race) {
      super(race);
      _tweenGroup.addEventListener(EventGroup.GROUP_FINISH, onTweenFinish);
    }

    /**********************
     * PUBLIC
     **********************/
    override public function start():void {            
      //move rider items
      var riderList:Array = _race.riderItemList;
      var rider:RiderItem;
      for (var i:int = 0; i < riderList.length; i++) {
        rider = riderList[i];
        _tweenGroup.addTween(rider.moveToLap());
      }
    }

    /**********************
     * HANDLERS
     **********************/
    private function onTweenFinish(e:Event):void {
      dispatchEvent(new Event(TRANSITION_FINISH));
    }
  }
}
