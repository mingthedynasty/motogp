package com.season.models {

  /**********************
   * 
   * RiderLapModel
   *
   **********************/
  public class RiderLapModel {       
    
    /**********************
     * VARIABLES      
     **********************/
    public var riderModel:RiderModel;
    public var lapTime:Number;
    public var lapTimeDisplay:String;
    public var gap:Number;
    public var lapNumber:int;
    public var speedTop:Number;
    public var isFastestLap:Boolean;
    public var isRaceFastestLap:Boolean;

    public var pos:int;    
    public var finalPos: int;

    /**********************
     * CONSTRUCTOR
     **********************/
    public function RiderLapModel(xml:XML) { 
      riderModel = SeasonModel.getInstance().getRiderModelByNumber(xml.@num);      
      lapTime = xml.@laptime;
      lapTimeDisplay = String(xml.@laptimedisplay).substring(0, 6);
      gap = xml.@gap;
      lapNumber = xml.parent().childIndex();
      speedTop = xml.@topspeed;
      pos = xml.childIndex();
      finalPos = RaceModel.getInstance().getFinalPosForRider(riderModel.riderNum);

      isFastestLap = xml.@isfastest == "true";
      isRaceFastestLap = xml.@isracefastest == "true";
     }
  }
}
