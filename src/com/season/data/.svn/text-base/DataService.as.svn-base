package com.season.data {

  import flash.net.*;
  import flash.events.*;

  import com.season.*;


  /**********************
   * 
   * DataService
   *
   **********************/
  public class DataService extends EventDispatcher {

    /**********************
     * VARIABLES      
     **********************/
    static private var instance:DataService = new DataService();
    private var loader:URLLoader = new URLLoader();

    //events
    public static const DATA_LOAD_SERIES = "dataloadseries";
    public static const DATA_LOAD_SEASON = "dataloadseason";
    public static const DATA_LOAD_RACE = "dataloadrace";

    /**********************
     * HANDLERS
     **********************/
    private function onSeriesComplete(e:Event):void {
      var seriesXML:XML = XML(loader.data);
      dispatchEvent(new LoadDataEvent(DATA_LOAD_SERIES, XML(loader.data)));

      loader.removeEventListener(Event.COMPLETE, onSeriesComplete);
    }

    //--------//
    private function onSeasonComplete(e:Event):void {
      var seasonXML:XML = XML(loader.data);
      dispatchEvent(new LoadDataEvent(DATA_LOAD_SEASON, XML(loader.data)));

      loader.removeEventListener(Event.COMPLETE, onSeasonComplete);
    }
    
    //--------//
    private function onRaceComplete(e:Event):void {
      var raceXML:XML = XML(loader.data);
      dispatchEvent(new LoadDataEvent(DATA_LOAD_RACE, XML(loader.data)));

      loader.removeEventListener(Event.COMPLETE, onRaceComplete);
    }
    /**********************
     * PUBLIC
     **********************/
    public static function getInstance():DataService  {
      return instance;
    }

    //--------//
    public function loadSeries():void {
      requestData("data/series.xml", onSeriesComplete);
    }
    
    //--------//
    public function loadSeason(year:String):void {
      requestData("data/" + year + "/season.xml", onSeasonComplete);
    }
    
    //--------//
    public function loadRace(year:String, raceName:String):void {
      var url:String = "data/" + year + "/"; //"http://www.minglebee.com/gp/data/";
      requestData(url + raceName + ".xml", onRaceComplete);
    }

    /**********************
     * PRIVATE
     **********************/
    public function requestData(requestStr:String, listener:Function):void {

      var request:URLRequest = new URLRequest(requestStr);      
      loader.addEventListener(Event.COMPLETE, listener);
      try {
        loader.load(request);
      }
      catch(error:SecurityError) {
        trace("Bonk");
      }      
    }
  }
}
