package com.season.models {
  
  /**********************
   *
   * RiderSeasonModel
   *
   **********************/
  public class RiderSeasonModel {

    /**********************
     * VARIABLES
     **********************/
    public var riderModel:RiderModel;
    public var scoringRacesList:XMLList;
    public var racesList:XMLList;

    /**********************
     * CONSTRUCTOR
     **********************/
    public function RiderSeasonModel(riderXML:XML) {
      var seasonModel = SeasonModel.getInstance();
      riderModel = new RiderModel(riderXML);

      racesList = 
        seasonModel.getStandingsListForRider(riderModel.riderNum);
      
      scoringRacesList = 
        racesList.(@place < SeriesModel.getInstance().scoringPlacesCount);
    }

    /**********************
     * VARIABLES
     **********************/
    public function getStandingModelByIndex(index:int):RiderStandingModel {
      var seasonModel = SeasonModel.getInstance();
      var allStandings = 
        seasonModel.getStandingsListForRider(riderModel.riderNum);   
      return new RiderStandingModel(allStandings[index]);
    }
  }

}
