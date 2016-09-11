package com.season.models {


  /**********************
   * 
   * SeriesModel
   *
   **********************/
  public class SeriesModel {
    
    /**********************
     * VARIABLES      
     **********************/
    public var series:String;
    public var dataSource:String;

    public var yearList:XMLList;

    public var scoringPlaces:XMLList;
    public var scoringPlacesCount:int;


    /**********************/
    static private var instance:SeriesModel = new SeriesModel();
    private var xml:XML;


    /**********************
     * PUBLIC
     **********************/
    public static function getInstance():SeriesModel {      
      return instance;
    }
    
    /*********************/
    public function initModel(seriesXML:XML):void {
      xml = seriesXML;

      series = xml.@name;
      dataSource = xml.@datasource;

      yearList = xml.seasons.season.@year;

      scoringPlaces = xml.points.position;
      scoringPlacesCount = xml.points.@scoringplaces;
    } 

    /*********************/
    public function getPointsForPlace(place:int):int {
      return xml.points.position.(@pos == place).@points;
    }
  }
}
