package com.season.classes.race.transitions {

  import flash.events.*;

  import com.season.models.*;
  import com.season.classes.race.*;
  import com.season.classes.race.rideritem.*;

  import mylibrary.utils.anim.*;

  /**********************
   *
   * YTransitionToFinalPosition
   *
   **********************/
  public class YTransitionToFinalPosition extends RaceTransition {

    /**********************
     * VARIABLES
     **********************/
    private var _tweenGroup:TweenGroup = new TweenGroup();

    /**********************
     * CONSTRUCTOR
     **********************/
    public function YTransitionToFinalPosition(race:Race) {
      super(race);
      _tweenGroup.addEventListener(EventGroup.GROUP_FINISH, onTweenFinish);
    }

    /**********************
     * PUBLIC
     **********************/
    override public function start():void {
      //change line spacing
      _race.hGrid.showPositions();

      //show podium outline
      _tweenGroup.addTween(_race.podiumOutline.tween("alpha", 1));

      //fade final lap outline
      _tweenGroup.addTween(_race.finalLapOutline.tween("alpha", 0));

      //move rider items
      var riderList:Array = _race.riderItemList;
      var rider:RiderItem;
      for (var i:int = 0; i < riderList.length; i++) {
        rider = riderList[i];
        if (rider.model.finalPos > -1 && rider.model.speedTop > 0) {
          _tweenGroup.addTween(rider.moveToFinalPosition());
          if (rider.alpha != 1) {
            _tweenGroup.addTween(rider.tween("alpha", 1));
          }
        } else if (rider.alpha != 0) {
          _tweenGroup.addTween(rider.tween("alpha", 0));
          //_tweenGroup.addTween(rider.moveToPosition());
        }
      }
    }

    /**********************
     * HANDLER
     **********************/
    private function onTweenFinish(e:Event):void {
      dispatchEvent(new Event(TRANSITION_FINISH));
    }
  }
}
