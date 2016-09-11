package com.season.classes.race.transitions {

  import flash.events.*;

  import com.season.models.*;
  import com.season.classes.race.*;
  import com.season.classes.race.rideritem.*;

  import mylibrary.utils.anim.*;

  /**********************
   *
   * YTransitionToPosition
   *
   **********************/
  public class YTransitionToPosition extends RaceTransition {

    /**********************
     * VARIABLES
     **********************/
    private var _tweenGroup:TweenGroup = new TweenGroup();
    
    /**********************
     * CONSTRUCTOR
     **********************/
    public function YTransitionToPosition(race:Race) {
      super(race);
      _tweenGroup.addEventListener(EventGroup.GROUP_FINISH, onTweenFinish);
    }

    /**********************
     * PUBLIC
     **********************/
    override public function start():void {
      //show position lines
      _race.hGrid.showPositions();

      //show podium outline
      _tweenGroup.addTween(_race.podiumOutline.tween("alpha", 1));

      //stretch final lap outline
      _race.finalLapOutline.update((RaceModel.getInstance().finishSize - 1) * 
                                   Race.GRID_Y_SPACING, 
                                   _race.finalLapOutline.alpha == 1);
      _tweenGroup.addTween(_race.finalLapOutline.tween("alpha", 1));

      //move rider items
      var riderList:Array = _race.riderItemList;
      var rider:RiderItem;
      for (var i:int = 0; i < riderList.length; i++) {
        rider = riderList[i];
        _tweenGroup.addTween(rider.moveToPosition());
        if (rider.alpha != 1) {
          _tweenGroup.addTween(rider.tween("alpha", 1));
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
