package com.season.classes.race.transitions {

  import flash.events.*;

  import com.season.classes.race.*;

  /**********************
   *
   * TransitionToLap
   *
   **********************/
  public class TransitionToLap extends RaceTransition {

    /**********************
     * VARIABLES
     **********************/
    private var _xTransToLap:XTransitionToLap;
    private var _yTransToPosition:YTransitionToPosition;

    /**********************
     * CONSTRUCTOR
     **********************/
    public function TransitionToLap(race:Race) {
      super(race);

      _xTransToLap = new XTransitionToLap(race);
      _yTransToPosition = new YTransitionToPosition(race);

    }

    /**********************
     * PUBLIC
     **********************/
    override public function start():void {
      if (_race.currRaceView == "SPEED") {
        _race.speedBars.alpha = 0;        
        _race.vGrid.hideSpeeds();

        _xTransToLap.start();
        _xTransToLap.addEventListener(RaceTransition.TRANSITION_FINISH,
                                      onXTransitionFinish);
      } else {
        _yTransToPosition.start();
      }
    }

    /**********************
     * HANDLERS
     **********************/
    private function onXTransitionFinish(e:Event):void {
      _race.vGrid.showLaps();
      _yTransToPosition.start();      
      _xTransToLap.removeEventListener(RaceTransition.TRANSITION_FINISH,
                                       onXTransitionFinish);
    }
  }
}
