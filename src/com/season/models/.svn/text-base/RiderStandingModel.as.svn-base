package com.season.models {

  /**********************
   *
   * RiderStandingModel
   *
   **********************/
  public class RiderStandingModel {

    /**********************
     * VARIABLES
     **********************/
    public var raceModel:SeasonRaceModel;
    public var riderModel:RiderModel;

    public var worldPoints:int;
    public var worldPlace:int;
    public var racePlace:int;
    public var racePoints:int = 0;

    /**********************
     * CONSTRUCTOR
     **********************/
    public function RiderStandingModel(xml:XML) {

      var season = SeasonModel.getInstance();

      var index:int = xml.childIndex();      
      raceModel =  season.getRaceModelByIndex(index);
      riderModel = season.getRiderModelByNumber(xml.parent().@number);

      racePlace = xml.@place;
      racePoints = SeriesModel.getInstance().getPointsForPlace(racePlace);
      worldPlace = xml.@worldstanding;
      worldPoints = xml.@pt;      
    }
  }
}
