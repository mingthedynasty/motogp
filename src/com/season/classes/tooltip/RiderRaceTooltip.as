package com.season.classes.tooltip {

  import flash.display.*;
  import flash.text.*;
  import flash.geom.*;

  import com.season.utils.*;
  import com.season.classes.season.*;
  import com.season.models.*;

  /**********************
   *
   * RiderRaceTooltip
   *
   **********************/
  public class RiderRaceTooltip extends Tooltip {

    /**********************
     * VARIABLES
     **********************/
    private var raceLabel:TextField;
    private var positionLabel:TextField;
    private var pointsLabel:TextField;

    private var raceValue:TextField;
    private var positionValue:TextField;
    private var pointsValue:TextField;


    /**********************/
    static private var instance:RiderRaceTooltip = new RiderRaceTooltip();

    /**********************
     * CONSTRUCTOR
     **********************/
    public function RiderRaceTooltip() {
      super();

      //labels
      raceLabel = initLabel("TOTAL");
      positionLabel = initLabel("POSITION");
      //pointsLabel = initLabel("POINTS");

      //values
      values.x = labels.getBounds(this).width + 10;
      raceValue = initValue();
      positionValue = initValue();
      //pointsValue = initValue();
    }

    /**********************
     * PUBLIC
     **********************/
    public static function getInstance():RiderRaceTooltip  {      
      return instance;
    }

    /**********************/
    override public function show(ref:DisplayObject):void {
      var square:RacePointSquare = ref as RacePointSquare;
      var model:RiderStandingModel = square.model;

      //set values
      raceValue.text = String (model.worldPoints);//model.raceModel.shortName;
      positionValue.text = String(model.racePlace);
      //pointsValue.text = String(model.racePoints);

      layoutItems();
      super.show(ref);

      //figure out start/end pts
      var start = new Point(Math.round (width/2), background.height);//0, Math.round(height/2));
      var end = new Point(Math.round (width/2), background.height + 20);
      
      var xoff = -Math.round((width - 20)/2);
      var yoff = -background.height - 20;

      /*
      //flip?
      if (xoff + ref.getBounds(parent).x + background.width > stage.stageWidth) {
        xoff = -(background.width + 20);
        start.x = background.width;
        end.x = background.width + 20 + Math.round(ref.width/2);
      }
      */
      
      //finish
      finishShow(xoff, yoff, start, end);

    }

  }
}
