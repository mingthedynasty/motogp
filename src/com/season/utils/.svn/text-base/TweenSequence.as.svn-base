package com.season.utils {

  import fl.transitions.Tween;
  import fl.transitions.TweenEvent;
  import flash.events.*;
  
  /**********************
   *
   * TweenSequence
   *
   **********************/
  public class TweenSequence extends EventDispatcher {

    /**********************
     * VARIABLES
     **********************/
    private var sequence:Array = [];
    private var currIndex:int = 0;

    public static const SEQUENCE_FINISH:String = "finish";

    /**********************
     * CONSTRUCTOR
     **********************/
    public function TweenSequence() {
    }

    /**********************
     * PUBLIC
     **********************/
    public function initSequence(tweenArray:Array):void {
      sequence = tweenArray;
    }

    public function start():void {
      var tween:Tween = sequence[0];
      tween.addEventListener(TweenEvent.MOTION_FINISH, step);
      tween.start();
      currIndex = 0;
    }

    /**********************
     * HANDLERS
     **********************/
    private function step(e:TweenEvent):void {      
      sequence[currIndex].removeEventListener(
        TweenEvent.MOTION_FINISH, step);

      currIndex++;
      if (currIndex < sequence.length) {
        var tween:Tween = sequence[currIndex];        
        tween.addEventListener(TweenEvent.MOTION_FINISH, step);              
        tween.start();
      } else {
        dispatchEvent(new Event(SEQUENCE_FINISH));
      }
    }
  }
}
