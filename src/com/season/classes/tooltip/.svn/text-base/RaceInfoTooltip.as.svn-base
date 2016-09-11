package com.season.classes.tooltip {

  import flash.display.*;
  import flash.text.*;
  import flash.geom.*;
  import flash.net.*;
  import flash.events.*;


  import com.season.utils.*;
  import com.season.classes.header.*;
  import com.season.models.*;
  import com.season.classes.season.*;

  /**********************
   *
   * RiderTooltip
   *
   **********************/
  public class RaceInfoTooltip extends Tooltip {

    /**********************
     * VARIABLES
     **********************/
    private var conditionsLabel:TextField;
    private var tempLabel:TextField;
    private var humidityLabel:TextField;
    private var lengthLabel:TextField;

    private var conditionsValue:TextField;
    private var tempValue:TextField;
    private var humidityValue:TextField;
    private var lengthValue:TextField;


    /**********************/
    private static var instance:RaceInfoTooltip = new RaceInfoTooltip();

    /**********************
     * CONSTRUCTOR
     **********************/
    public function RaceInfoTooltip() {
      super();

      //labels
      conditionsLabel = initLabel("CONDITIONS");
      tempLabel = initLabel("TEMP");
      humidityLabel = initLabel("HUMIDITY");
      lengthLabel = initLabel("LENGTH");

      //values
      values.x = labels.getBounds(this).width + labels.x + 15;
      conditionsValue = initValue();
      tempValue = initValue();
      humidityValue = initValue();
      lengthValue = initValue();
    }

    /**********************
     * PUBLIC
     **********************/
    public static function getInstance():RaceInfoTooltip  {      
      return instance;
    }

    /**********************/
    override public function show(ref:DisplayObject):void {

      var model:SeasonRaceModel = RaceChooser.getInstance().currRaceModel;
      
      //set values
      conditionsValue.text = model.conditions.toUpperCase();
      tempValue.text = model.temp + " C";
      humidityValue.text = model.humidity + "%";
      lengthValue.text = model.length + " KM"
      
      layoutItems();
      
      super.show(ref);

      //finish it up
      var start = new Point(Math.round(width/2), 0);
      var end = new Point(Math.round(width/2), -15);
      var bounds = ref.getBounds(root);
      finishShow(-Math.round((width - (2000 + bounds.x))/2) - 15,
                 15 + 22,
                 start,
                 end);
    }
  }
}
