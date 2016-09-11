package com.season.classes.header {


  import flash.display.Sprite;
  import flash.text.*;

  import com.season.models.*;

  /**********************
   * 
   * RaceInfo
   *
   **********************/	
  public class RaceInfo extends Sprite {

    /**********************
     * VARIABLES
     **********************/
    private var raceName:RaceInfoPropValue = new RaceInfoPropValue("RACE");
    private var locName:RaceInfoPropValue = new RaceInfoPropValue("LOCATION");
    private var dateName:RaceInfoPropValue = new RaceInfoPropValue("DATE");
    
    /**********************
     * CONSTRUCTOR
     **********************/
    public function RaceInfo() {      
      addChild(raceName);
      addChild(locName);
      addChild(dateName);
    }

    /**********************
     * PUBLIC
     **********************/
    public function update(model:SeasonRaceModel):void {
      raceName.updateValue(model.raceName.toUpperCase());
      locName.updateValue(model.location.toUpperCase());
      dateName.updateValue(model.date.toUpperCase());

      locName.x = raceName.width + 20;
      dateName.x = locName.x + locName.width + 20;
    }
  }

}
