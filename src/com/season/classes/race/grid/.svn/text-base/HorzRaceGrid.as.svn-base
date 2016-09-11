package com.season.classes.race.grid {

  import flash.text.*;
  import flash.events.*;

  import com.season.components.*;
  import com.season.models.*;
  import com.season.classes.race.*;
  import com.season.classes.race.transitions.*;
  import com.season.utils.*;

  import mylibrary.utils.anim.*;

  /**********************
   *
   * HorzRaceGrid
   *
   **********************/
  public class HorzRaceGrid extends RaceGrid {

    /**********************
     * VARIABLES
     **********************/
    //----//
    public static const RACE_POSITION_LINE_INFO:Object = 
      {primaryType      : BaseLine.LINE_REGULAR,
       primaryAlpha     : .4};

    public static const RACE_GAP_LINE_INFO:Object = 
      {primaryType      : BaseLine.LINE_REGULAR,
       primaryAlpha     : .4};

    /**********************
     * CONSTRUCTOR
     **********************/
    public function HorzRaceGrid(race:Race) {
      var format:TextFormat = 
        TextFactory.createTextFormat(TextStyle.PLAIN, 0xDDDDDD);

      super(RaceGrid.GRID_HORZ, format, race);
    }

    /**********************
     * PUBLIC
     **********************/
    public function showPositions(isTransToRace:Boolean = false) {
      var lineCount:int = Math.ceil(RaceModel.getInstance().gridSize/4);
      changeSpacing(lineCount, 
                    4 * Race.GRID_Y_SPACING,
                    RACE_POSITION_LINE_INFO); 

      if (isTransToRace) {
        for (var i:int = lineCount; i < _labelPool.getActiveObjectCount(); i ++) {
          _labelPool.returnObject(_labelPool.getActiveObjectAt(i));
        }
      } else {
        _labels.alpha = 0;
        _labelPool.returnAllObjects();
      }

      addEventListener(RaceGrid.CHANGE_SPACING_FINISH, showLapLabels);
    }

    //--------//
    public function showGaps(tween:Boolean = true) {
      var increment:Number = calcGapInterval();
      var gapLength:Number = _race.options.gapLength;
      changeSpacing(gapLength/increment + 1, 
                    Race.RACE_GAP_HEIGHT_RANGE/(gapLength/increment),
                    RACE_GAP_LINE_INFO, true, !tween);

      /*changeSpacing(Race.RACE_GAP_TIME_RANGE/5 + 1, 
                    Race.RACE_GAP_HEIGHT_RANGE/(5 - 1),
                    RACE_GAP_LINE_INFO);*/

      _labelPool.returnAllObjects();

      if (tween) {
        _labels.alpha = 0;
        addEventListener(RaceGrid.CHANGE_SPACING_FINISH, showGapLabels);
      } else {
        showGapLabels(null);
      }
    }

    /**********************
     * PRIVATE
     **********************/
    private function showLapLabels(e:Event):void {
      removeEventListener(RaceGrid.CHANGE_SPACING_FINISH, showLapLabels);

      _labelPool.returnAllObjects();
      var label:TextField;
      for (var i:int = 0; i < RaceModel.getInstance().gridSize; i = i + 4) {
        label = _labelPool.getObject() as TextField;
        if (i == 0) {
          label.text = "LEADER";
        } else {
          label.text = String(i + 1) + "TH";
        }
        label.x = 5;
        label.y = i * Race.GRID_Y_SPACING - label.height + 2;
      }
      _labels.tween("alpha", 1);
    }

    //--------//
    private function showGapLabels(e:Event):void {
      removeEventListener(RaceGrid.CHANGE_SPACING_FINISH, showGapLabels);

      /*var spacing:int = Race.RACE_GAP_HEIGHT_RANGE/(5 - 1);
      for (var i:int = 0; i < RaceModel.getInstance().gridSize; i++) {
        label = _labelPool.getObject() as TextField;
        label.text = (i * 5) + " SEC";
        label.x = 5;
        label.y = i * spacing - label.height + 2;
        } */

      var label:TextField;
      var increment:Number = calcGapInterval();
      var gapLength:Number = _race.options.gapLength;

      var spacing:int = Race.RACE_GAP_HEIGHT_RANGE/(gapLength/increment);
      for (var i:int = 0; i < Math.floor(gapLength/increment) + 1; i++) {
        label = _labelPool.getObject() as TextField;
        label.text = (i * increment) + " SEC";
        label.x = 5;
        label.y = i * spacing - label.height + 2;
        } 
      _labels.tween("alpha", 1);
    }

    //--------//
    private function calcGapInterval():Number {
      var increment:Number = 5;
      var gapLength:Number = _race.options.gapLength;

      if (gapLength <= 5) {
        increment = 1;
      } else if (gapLength < 10) {
        increment = 2;
      } else if (gapLength < 30) {
        increment = 5;
      } else if (gapLength < 60) {
        increment = 10;
      } else if (gapLength < 100) {
        increment = 20;
      } else if (gapLength < 150) {
        increment = 25;
      } else {
        increment = 50;
      }
      return increment;
    }
  }
}
