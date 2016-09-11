package com.season.classes.season {

  import flash.events.*;
  import fl.transitions.Tween;
  import fl.transitions.easing.*;	

  import com.season.utils.*;

  /**********************
   *
   * TweenRiderSummary
   *
   **********************/
  public class TweenRiderSummary extends EventDispatcher {

    /**********************
     * VARIABLES
     **********************/
    private var summary:RiderSeasonSummary;

    private var tweenX:Tween;
    private var tweenY:Tween;
    private var tweenSequence:TweenSequence = new TweenSequence();

    private var firstTime:Boolean = false;
    private var targetX:int = 0;
    private var targetY:int = 0;

    /****/
    public static const TWEEN_FINISH:String = "tweenfinish";

    /**********************
     * CONSTRUCTOR
     **********************/
    public function TweenRiderSummary(theSummary:RiderSeasonSummary) {
      summary = theSummary;
      tweenX = 
        new Tween(summary, "x", Regular.easeInOut, 0, 0, .4, true);
      tweenX.stop();
      tweenY = 
        new Tween(summary, "y", Regular.easeInOut, 0, 0, .4, true);
      tweenY.stop();
    }

    /**********************
     * PUBLIC
     **********************/
    public function prepare(isFirstTime, nx, ny) {
      firstTime = isFirstTime;
      targetX = nx;
      targetY = ny;
    }

    /****/
    public function start() {
      if (firstTime) {
        summary.x = targetX;
        summary.y = targetY;

        dispatchEvent(new Event(TWEEN_FINISH));
      } else {
        tweenX.begin = summary.x;
        tweenX.finish = targetX;
        
        tweenY.begin = summary.y;
        tweenY.finish = targetY;
        
        tweenSequence.initSequence([tweenY, tweenX]);
        tweenSequence.start();
        
        tweenSequence.addEventListener(
          TweenSequence.SEQUENCE_FINISH, onTweenSequenceFinish);
      }
    }

    /**********************
     * HANDLERS
     **********************/
    private function onTweenSequenceFinish(e:Event):void {
      dispatchEvent(new Event(TWEEN_FINISH));
    }

  }
}
