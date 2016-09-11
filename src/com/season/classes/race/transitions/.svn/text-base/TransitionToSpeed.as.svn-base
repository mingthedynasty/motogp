package com.season.classes.race.transitions {

  import flash.events.*;

  import com.season.classes.race.*;
  import com.season.models.*;

  /**********************
   *
   * TransitionToSpeed
   *
   **********************/
  public class TransitionToSpeed extends RaceTransition {

    /**********************
     * VARIABLES
     **********************/
    private var _xTransToSpeed:XTransitionToSpeed;
    private var _yTransToFinalPos:YTransitionToFinalPosition;

    /**********************
     * CONSTRUCTOR
     **********************/
    public function TransitionToSpeed(race:Race) {
      super(race);

      _xTransToSpeed = new XTransitionToSpeed(race);
      _yTransToFinalPos = new YTransitionToFinalPosition(race);

    }

    /**********************
     * PUBLIC
     **********************/
    override public function start():void {
      _yTransToFinalPos.start();
      _yTransToFinalPos.addEventListener(RaceTransition.TRANSITION_FINISH,
                                         onYTransitionFinish);
      //show lines
      var pixelVal:Number = _race.vGridWidth/RaceModel.getInstance().speedRange;            
      var speedDiff:Number = 
        RaceModel.getInstance().speedTop - RaceModel.getInstance().speedAvg;
      var avgX:int = _race.vGridWidth - (pixelVal * speedDiff);

      _race.vGrid.showSpeeds(_race.vGridWidth, avgX);
    }

    /**********************
     * HANDLERS
     **********************/
    private function onYTransitionFinish(e:Event):void {
      _xTransToSpeed.start();      
      _yTransToFinalPos.removeEventListener(RaceTransition.TRANSITION_FINISH,
                                            onYTransitionFinish);
    }
  }
}
