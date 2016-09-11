package com.season.utils {

  import fl.transitions.Tween;
  import fl.transitions.TweenEvent;
  import fl.transitions.easing.*;
  import flash.events.*;

  /**********************
   *
   * EventGroup
   *
   **********************/
  public class EventGroup extends EventDispatcher{

    /**********************
     * VARIABLES
     **********************/
    public var inProgress = false;

    private var currCount:int = 0;
    private var eventArray:Array = [];

    public static const GROUP_FINISH:String = "finish";
    
    /**********************
     * CONSTRUCTOR
     **********************/
    public function EventGroup() {
    }

    /**********************
     * PUBLIC
     **********************/
    public function addEvent(dispatcher:EventDispatcher, event:String):void {
      currCount++;
      inProgress = true;
      dispatcher.addEventListener(event, checkGroupFinish);
      eventArray.push({source: dispatcher, event: event});
    }

    public function reset():void {      
      for (var i:int = 0; i < eventArray.length; i++) {
        eventArray[i].source.removeEventListener(
          eventArray[i].event, checkGroupFinish);
      }
      currCount = 0;
      inProgress = false;
    }

    /**********************
     * PRIVATE
     **********************/
    private function checkGroupFinish(e:Event):void {
      currCount--;
      if (currCount == 0) {
        reset();
        dispatchEvent(new Event(GROUP_FINISH));
      }
    }

  }
}
