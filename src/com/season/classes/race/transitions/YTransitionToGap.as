package com.season.classes.race.transitions {

  import flash.events.*;

  import fl.transitions.Tween;


  import com.season.classes.race.*;
  import com.season.classes.race.rideritem.*;

  import mylibrary.utils.anim.*;

  /**********************
   *
   * YTransitionToGap
   *
   **********************/
  public class YTransitionToGap extends RaceTransition {

    /**********************
     * VARIABLES
     **********************/
    private var _tweenGroup:TweenGroup = new TweenGroup();


    /**********************
     * CONSTRUCTOR
     **********************/
    public function YTransitionToGap(race:Race) {
      super(race);
      _tweenGroup.addEventListener(EventGroup.GROUP_FINISH, onTweenFinish);
    }

    /**********************
     * PUBLIC
     **********************/
    override public function start():void {
      //change to gap spacing
      _race.hGrid.showGaps(true);

      //fade podium outline
      _tweenGroup.addTween(_race.podiumOutline.tween("alpha", 0));
      
      //stetch final lap outline
      _race.finalLapOutline.update(Race.RACE_GAP_HEIGHT_RANGE, 
                                   _race.finalLapOutline.alpha == 1);
      _tweenGroup.addTween(_race.finalLapOutline.tween("alpha", 1));

      positionItems(true);
    }
    
    public function updateGap():void {
      positionItems(false);
      _race.hGrid.showGaps(false);
    }

    /**********************
     * HANDLER
     **********************/
    private function onTweenFinish(e:Event):void {
      dispatchEvent(new Event(TRANSITION_FINISH));
    }

    private function positionItems(tween:Boolean):void {
      //move rider items
      var riderList:Array = _race.riderItemList;
      var rider:RiderItem;
      for (var i:int = 0; i < riderList.length; i++) {
        rider = riderList[i];
        if (rider.model.gap > _race.options.gapLength) {//Race.RACE_GAP_TIME_RANGE) {
          if (rider.alpha == 1) {
            if (tween) {
                _tweenGroup.addTween(rider.tween("alpha", 0));
            } else { rider.alpha = 0; }
          }
        } else {
          if (rider.alpha == 0) {
            rider.moveToPosition(false);
            rider.moveToGap(false);
            if (tween) {
                _tweenGroup.addTween(rider.tween("alpha", 1));
            } else { rider.alpha = 1; }
          } else {
            var t:Tween = rider.moveToGap(tween);
            if (t) {
              _tweenGroup.addTween(rider.moveToGap(t));
            }
          }
        }
      }

    }
  }
}
