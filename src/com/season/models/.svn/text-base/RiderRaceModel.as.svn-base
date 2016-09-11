package com.season.models {

  /**********************
   *
   * RiderRaceModel
   *
   **********************/
  public class RiderRaceModel {

    /**********************
     * VARIABLES
     **********************/
    public var riderModel:RiderModel;

    public var speedTop:Number;
    public var speedLow:Number;
    public var speedAvg:Number;

    public var speedRange:Number;

    /**********************
     * CONSTRUCTOR
     **********************/
    public function RiderRaceModel(xml:XML) {
      riderModel = SeasonModel.getInstance().getRiderModelByNumber(xml.@num);

      speedTop = xml.@topspeed;
      speedLow = xml.@lowspeed;
      speedAvg = xml.@avgspeed;

      speedRange = speedTop - speedLow;
    }
  }
}
