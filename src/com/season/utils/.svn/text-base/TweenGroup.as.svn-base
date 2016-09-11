package com.season.utils {

  import fl.transitions.Tween;
  import fl.transitions.TweenEvent;
  import fl.transitions.easing.*;
  import flash.events.*;

  /**********************
   *
   * TweenGroup
   *
   **********************/
  public class TweenGroup extends EventGroup {


    /**********************
     * PUBLIC
     **********************/
    public function addTween(tween:Tween):void {
      addEvent(tween, TweenEvent.MOTION_FINISH);
    }
  }
}
