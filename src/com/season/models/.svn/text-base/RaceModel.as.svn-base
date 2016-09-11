package com.season.models {


  /**********************
   * 
   * RaceModel
   *
   **********************/
  public class RaceModel {   

    /**********************
     * VARIABLES      
     **********************/
    static private var instance:RaceModel = new RaceModel();
    
    private var xml:XML;

    public var lapCount:int;
    public var gridSize:int;
    public var finishSize:int;

    public var speedTop:Number;
    public var speedLow:Number;
    public var speedAvg:Number;
    public var speedRange:Number;

    public var lapSlowest:Number;
    public var lapFastest:Number;

    public var maxGap:Number;

    /**********************
     * PUBLIC
     **********************/
    public static function getInstance():RaceModel  {      
      return instance;
    }

    /*********************/
    public function initModel(raceXML:XML):void {
      xml = raceXML;

      lapCount = xml.laps.lap.length();
      gridSize = xml.laps.lap[0].rider.length();
      finishSize = xml.laps.lap[lapCount - 1].rider.length();

      //speed
      speedTop = xml.@topspeed;
      speedLow = xml.@bottomspeed;
      speedAvg = xml.@averagespeed;      
      speedRange = speedTop - speedLow;
      
      //lap times
      lapSlowest = xml.@slowestlap;
      lapFastest = xml.@fastestlap;

      //gap
      maxGap = Math.ceil(xml.@maxgap/5) * 5;
    } 

    /*********************/
    public function getFinalPosForRider(rider:int):int {
      var riderNode:XMLList = xml.summaries.summary.(@num == rider);
      var pos:int = -1;
      if (riderNode.length() > 0) {
        pos = riderNode.childIndex();
      }
      return pos;
    }

    /*********************/
    public function getRiderLapModel(lapNumber:int, 
                                     riderNumber:int):RiderLapModel {
      var lapModel:RiderLapModel = null;
      var riderNode:XML = 
        xml.laps.lap[lapNumber].rider.(@num == riderNumber)[0];
      if (riderNode) {
        lapModel = new RiderLapModel(riderNode);
      }
      return lapModel;
    }

    /*********************/
    public function getRiderLapModelsForLap(lapNumber:int):Array {
      var modelArray:Array = [];
      var riders:XMLList = xml.laps.lap[lapNumber].rider;      
      for (var i:int = 0; i < riders.length(); i++) {
        modelArray.push(new RiderLapModel(riders[i]));
      }
      return modelArray;
    }

    /*********************/
    public function getPodiumRiderLapModels():Array {
      var modelArray:Array = [];
      var riders:XMLList = xml.laps.lap[lapCount - 1].rider;
      for (var i:int = 0; i < 3; i++) {
        modelArray.push(new RiderLapModel(riders[i]));
      }
      return modelArray;
    }

    /*********************/
    public function getRiderRaceModels():Array {
      var modelArray:Array = [];
      var riders:XMLList = xml.summaries.summary;
      for (var i:int = 0; i < riders.length(); i++) {
        modelArray.push(new RiderRaceModel(riders[i]));
      }
      return modelArray;
    }
  }
}
