package com.race.data {

  import flash.events.*;

  /**********************
   * 
   * DataEvent
   *
   **********************/
  public class DataEvent extends Event {
    
    
    /**********************
     * VARIABLES      
     **********************/
    private var xml:XML;

    /**********************
     * CONSTRUCTOR
     **********************/
    public function DataEvent(type:String, xmlData:XML, bubbles:Boolean = false, cancelable:Boolean = false) {
      super(type, bubbles, cancelable);
      xml = xmlData;
    }     
  }
}
