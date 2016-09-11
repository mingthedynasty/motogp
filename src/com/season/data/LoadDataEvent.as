package com.season.data {

  import flash.events.*;

  /**********************
   * 
   * LoadDataEvent
   *
   **********************/
  public class LoadDataEvent extends Event {
    
    
    /**********************
     * VARIABLES      
     **********************/
    public var xml:XML;

    /**********************
     * CONSTRUCTOR
     **********************/
    public function LoadDataEvent(type:String, xmlData:XML, bubbles:Boolean = false, cancelable:Boolean = false) {
      super(type, bubbles, cancelable);
      xml = xmlData;
    }     
  }
}
