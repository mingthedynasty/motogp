package com.season.classes.race.transitions {

  import flash.events.*;

  import com.season.classes.race.*;

  /**********************
   *
   * TransitionToGap
   *
   **********************/
  public class TransitionToGap extends RaceTransition {

    /**********************
     * VARIABLES
     **********************/
    private var _xTransToLap:XTransitionToLap;
    private var _yTransToGap:YTransitionToGap;

    /**********************
     * CONSTRUCTOR
     **********************/
    public function TransitionToGap(race:Race) {
      super(race);

      _xTransToLap = new XTransitionToLap(race);
      _yTransToGap = new YTransitionToGap(race);

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
        _yTransToGap.start();
      }
    }

    public function updateY():void {
      _yTransToGap.updateGap();
    }

    /**********************
     * HANDLERS
     **********************/
    private function onXTransitionFinish(e:Event):void {      
      _race.vGrid.showLaps();
      _yTransToGap.start();
      _xTransToLap.removeEventListener(RaceTransition.TRANSITION_FINISH,
                                       onXTransitionFinish);
    }
  }
}
