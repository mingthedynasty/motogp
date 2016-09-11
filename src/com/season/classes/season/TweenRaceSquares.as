package com.season.classes.season {

  import flash.display.Sprite;
  import flash.events.*;
  import fl.transitions.Tween;
  import fl.transitions.easing.*;	


  import com.season.models.*;
  import com.season.utils.*;

  /**********************
   *
   * TweenRaceSquares
   *
   **********************/
  public class TweenRaceSquares extends EventDispatcher{

    /**********************
     * VARIABLES
     **********************/
    private var summary:RiderSeasonSummary;
    private var wrapper:Sprite;

    private var tweenWrapperX:Tween;
    private var tweenWrapperY:Tween;

    private var tweenGroupShift:TweenGroup = new TweenGroup();
    private var tweenGroupShow:TweenGroup = new TweenGroup();
    private var tweenGroupHide:TweenGroup = new TweenGroup();

    private var shiftInfoArray:Array = [];
    private var showInfoArray:Array = [];
    private var hideInfoArray:Array = [];

    private var isNewerRace:Boolean = false;
    private var currSquareModel:RiderStandingModel;

    /****/
    public static const TWEEN_FINISH:String = "tweenfinish";

    /**********************
     * CONSTRUCTOR
     **********************/
    public function TweenRaceSquares(sum:RiderSeasonSummary,
                                     squaresWrapper:Sprite) {
      summary = sum;
      wrapper = squaresWrapper;

      tweenWrapperX = 
        new Tween(wrapper, "x", Regular.easeInOut, 0, 0, .4, true);
      tweenWrapperX.stop();
      tweenWrapperY = 
        new Tween(wrapper, "y", Regular.easeInOut, 0, 0, .4, true);
      tweenWrapperY.stop();
    }

    /**********************
     * PUBLIC
     **********************/
    public function prepare(isNewer:Boolean, 
                            squareModel:RiderStandingModel,
                            wrapX:int,
                            wrapY:int,
                            shiftArray:Array, 
                            showArray:Array, 
                            hideArray:Array):void {
      isNewerRace = isNewer;
      currSquareModel = squareModel;

      tweenWrapperX.begin = wrapper.x;
      tweenWrapperX.finish = wrapX;
      tweenWrapperY.begin = wrapper.y;
      tweenWrapperY.finish = wrapY;

      shiftInfoArray = shiftArray;
      showInfoArray = showArray;
      hideInfoArray = hideArray;
    }

    /****/
    public function start():void {

      var tweenGroup:TweenGroup = null;

      //tween squares
      if (isNewerRace) {
        showSquares();
        shiftSquares();
      } else {
        hideSquares();
        shiftSquares();
      }

      //figure out what tweening group to wait for
      if (tweenGroupShift.inProgress) { 
        tweenGroup = tweenGroupShift; 
      } else if (tweenGroupShow.inProgress) { 
        tweenGroup = tweenGroupShow; 
      } else if (tweenGroupHide.inProgress) {
        tweenGroup = tweenGroupHide; 
      }

      //tween wrapper
      tweenWrapperX.start();
      tweenWrapperY.start();

      //show points
      summary.showRacePoints(currSquareModel.worldPoints);

      //show indicator when tween is done
      if (tweenGroup) {
        tweenGroup.addEventListener(EventGroup.GROUP_FINISH, 
                                    onTweenGroupFinish);
      } else {
        dispatchEvent(new Event(TWEEN_FINISH));
      }
    }

    /**********************
     * PRIVATE
     **********************/
    private function shiftSquares():void {
      processArray(shiftInfoArray, "shift", tweenGroupShift);
    }
    private function showSquares():void {
      processArray(showInfoArray, "show", tweenGroupShow);
    }
    private function hideSquares():void {
      processArray(hideInfoArray, "hide", tweenGroupHide);
    }

    /**********************/
    private function processArray(infoArray:Array, 
                                  action:String, 
                                  tweenGroup:TweenGroup):void {
      tweenGroup.reset();
      if (infoArray.length) {

        var t:Tween;
        for (var i:int = 0; i < infoArray.length; i++) {
          if (action == "hide") {
            t = infoArray[i].square[action]();
          } else {
            t = infoArray[i].square[action](infoArray[i].x);
          }
          tweenGroup.addTween(t);
        }
      }      
    }

    /**********************
     * HANDLERS
     **********************/
    private function onTweenGroupFinish(e:Event):void {
      e.target.removeEventListener(EventGroup.GROUP_FINISH, onTweenGroupFinish);
      dispatchEvent(new Event(TWEEN_FINISH));
    }
  }
}
