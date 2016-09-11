package com.season.classes.header {

  import flash.events.*;

  import com.season.models.*;


  /**********************
   * 
   * RaceEvent
   *
   **********************/
  public class RaceEvent extends Event {    
    
    /**********************
     * VARIABLES      
     **********************/
    public var model:SeasonRaceModel;

    /**********************
     * CONSTRUCTOR
     **********************/
    public function RaceEvent(type:String, raceModel:SeasonRaceModel, 
                              bubbles:Boolean = false, cancelable:Boolean = false) {
      super(type, bubbles, cancelable);
      model = raceModel;
    }     
  }
}
