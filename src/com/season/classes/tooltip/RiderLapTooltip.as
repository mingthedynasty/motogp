package com.season.classes.tooltip {

  import flash.display.*;
  import flash.text.*;
  import flash.geom.*;

  import com.season.utils.*;
  import com.season.classes.race.*;
  import com.season.classes.race.rideritem.*;
  import com.season.models.*;

  /**********************
   *
   * RiderLapTooltip
   *
   **********************/
  public class RiderLapTooltip extends Tooltip {

    /**********************
     * VARIABLES
     **********************/
    private var _riderNameLabel:TextField;
    private var _riderNumberLabel:TextField;
    private var _lapNumberLabel:TextField;
    private var _positionLabel:TextField;
    private var _lapTimeLabel:TextField;
    private var _topSpeedLabel:TextField;
    private var _extraLapTimeLabel:TextField;

    private var _riderNameValue:TextField;
    private var _riderNumberValue:TextField;
    private var _lapNumberValue:TextField;
    private var _positionValue:TextField;
    private var _lapTimeValue:TextField;
    private var _topSpeedValue:TextField;

    private var _teamFooter:TextField;
    private var _manufacturerFooter:TextField;
    private var _tireFooter:TextField;

    /**********************/
    static private var instance:RiderLapTooltip = new RiderLapTooltip();

    /**********************
     * CONSTRUCTOR
     **********************/
    public function RiderLapTooltip() {
      super();

      //labels
      _riderNameLabel = initLabel("RIDER");
      _riderNumberLabel = initLabel("NUMBER");
      _lapNumberLabel = initLabel("LAP");
      _positionLabel = initLabel("POSITION");
      _lapTimeLabel = initLabel("LAP TIME");
      _topSpeedValue = initLabel("TOP SPEED");
      
      _extraLapTimeLabel = TextFactory.createText(footerTextStyle);
      addChild(_extraLapTimeLabel);
      
      //values
      values.x = labels.getBounds(this).width + 10;
      _riderNameValue = initValue();
      _riderNumberValue = initValue();
      _lapNumberValue = initValue();
      _positionValue = initValue();
      _lapTimeValue = initValue();
      _topSpeedValue = initValue();

      //footer
      _teamFooter = initFooter();
      _manufacturerFooter = initFooter();
      _tireFooter = initFooter();
    }

    /**********************
     * PUBLIC
     **********************/
    public static function getInstance():RiderLapTooltip  {      
      return instance;
    }

    /**********************/
    override public function show(ref:DisplayObject):void {
      var riderItem:RiderItem = ref as RiderItem;
      var model:RiderLapModel = riderItem.model;

      //set values
      _riderNameValue.text = model.riderModel.riderName;
      _riderNumberValue.text = String(model.riderModel.riderNum);
      _lapNumberValue.text = 
        model.lapNumber == 0 ? "GRID" : String(model.lapNumber);
      _positionValue.text = String(model.pos + 1);
      _lapTimeValue.text = 
        model.lapTime == 0 ? "N/A" : model.lapTimeDisplay;
      _topSpeedValue.text = 
        model.speedTop == 0 ? "N/A" : String(model.speedTop) + " KM/H";

      if (model.isFastestLap) {
        _extraLapTimeLabel.text = "RIDER FAST LAP";
      } else {
        _extraLapTimeLabel.text = "";
      }
      //set footer info
      _teamFooter.text = 
        "TEAM: " + model.riderModel.team.toUpperCase();
      _manufacturerFooter.text = 
        "MFR: " + model.riderModel.manufacturer.toUpperCase();
      _tireFooter.text = 
        "TIRE: " + model.riderModel.tire.toUpperCase();

      layoutItems();
      super.show(ref);


      //figure out start/end pts
      var start = new Point(Math.round(width/2) - 1, 0);
      var end = new Point(Math.round(width/2) - 1, -35);
      
      var xoff = -Math.round(width/2);
      var yoff = 35  + Math.round(riderItem.size/2);

      //flip?
      if (yoff + ref.getBounds(parent).y + background.height > stage.stageHeight) {
        yoff = -background.height - yoff;
        start.y = background.height;
        end.y = background.height + 35;
      }
      
      //finish
      finishShow(xoff, yoff, start, end);
    }

  }
}
