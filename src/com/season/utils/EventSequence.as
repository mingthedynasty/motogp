package com.season.utils {

  import flash.events.*;
  
  /**********************
   *
   * EventSequence
   *
   **********************/
  public class EventSequence extends EventDispatcher {

    /**********************
     * VARIABLES
     **********************/
    private var sequence:Array = [];
    private var currIndex:int = 0;

    public static const SEQUENCE_FINISH:String = "finish";

    /**********************
     * CONSTRUCTOR
     **********************/
    public function EventSequence() {
    }

    /**********************
     * PUBLIC
     **********************/
    public function initSequence(sequenceArray:Array):void {
      sequence = sequenceArray;
    }

    public function start():void {
      currIndex = 0;
      var startStep:SequenceStep= sequence[0];
      startStep.source.addEventListener(startStep.event, step);
      startStep.entry.call(startStep.source);
    }

    public function clear():void {
      sequence = [];
    }

    /**********************
     * HANDLERS
     **********************/
    private function step(e:Event):void {      
      var currStep:SequenceStep = sequence[currIndex];
      currStep.source.removeEventListener(
        currStep.event, step);

      currIndex++;
      if (currIndex < sequence.length) {
        var nextStep:SequenceStep = sequence[currIndex];        
        nextStep.source.addEventListener(nextStep.event, step);
        nextStep.entry.call(null);
      } else {
        dispatchEvent(new Event(SEQUENCE_FINISH));
      }
    }
  }
}
