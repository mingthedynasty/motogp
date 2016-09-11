package com.season.classes.race {

  import flash.display.*;
  import flash.events.*;
  import flash.display.Sprite;

  import com.season.models.*;
  import com.season.components.*;
  import com.season.classes.race.rideritem.*;

  /**********************
   *
   * RiderSpeedBar
   *
   **********************/
  public class RiderSpeedBar extends Sprite {

    /**********************
     * VARIABLES
     **********************/
    private var _model:RiderRaceModel;
    private var _race:Race;

    private var _rangeW:int;
    private var _rangeH:int;
    private var _avgX:int;

    private static const BUFFER_STANDARD:int = 2;
    private static const BUFFER_LARGE:int = 6;

    /**********************
     * CONSTRUCTOR
     **********************/
    public function RiderSpeedBar(race:Race) {
      _race = race;

      _race.options.radioItemView.addEventListener(StatsRadioGroup.SELECTION_CHANGE, 
                                                   onItemViewChange);
      _race.options.boxLapTime.addEventListener(MouseEvent.CLICK, onShowLapTime);
    }

    /**********************
     * SETTERS/GETTERS
     **********************/
    public function get model():RiderRaceModel {
      return _model;
    }
    public function set model(model:RiderRaceModel):void {
      _model = model;
      update();
    }

    /**********************
     * PUBLIC
     **********************/
    public function update() {
      if (!visible || !_model) { return; }

      var raceModel = RaceModel.getInstance();
      var buffer = _race.options.showLapTime ? BUFFER_LARGE :BUFFER_STANDARD;
      var speedPixelVal = _race.vGridWidth/raceModel.speedRange;                
      
      
      //set y
      var finalPos:int = raceModel.getFinalPosForRider(_model.riderModel.riderNum);
      y = finalPos * Race.GRID_Y_SPACING - 
        (Math.ceil(RiderItem.RIDER_ITEM_SIZE/2) + buffer + 1);
      
      //set x
      var xmin:int = (_model.speedLow - raceModel.speedLow) * speedPixelVal;
      x = Math.round(xmin) - 
        (Math.ceil(RiderItem.RIDER_ITEM_SIZE/2) + buffer + 2);
      
      //figure out info for drawing
      _rangeW = Math.round(_model.speedRange * speedPixelVal) + 
        RiderItem.RIDER_ITEM_SIZE + 1 + 2 * (buffer + 1);
      _rangeH = RiderItem.RIDER_ITEM_SIZE + 2 * buffer + 1;
      _avgX = Math.round((_model.speedAvg - raceModel.speedLow) * 
                         speedPixelVal - 1 - x);

      render();
    }

    /**********************
     * PRIVATE
     **********************/
    private function render():void {
      if (!_model) { return; }

      var color:uint;      
      switch(_race.options.itemView) {
      case "TEAM":
        color = _model.riderModel.colorTeam;
        break;
      case "MANUFACTURER":
        color = _model.riderModel.colorManufacturer;
        break;
      case "TIRE":
        color = _model.riderModel.colorTire;
        break;
      }

      graphics.clear();
      graphics.beginFill(color, 1);
      graphics.drawRect(_avgX - 1, -4, 2, _rangeH + 9);
      graphics.endFill();

      graphics.lineStyle(1, color, .4, true, 
                         LineScaleMode.NORMAL, null, 
                         JointStyle.MITER );
      graphics.drawRect(0, 0, _rangeW, _rangeH);
    }

    /**********************
     * HANDLERS
     **********************/
    private function onItemViewChange(e:Event):void {
      render();
    }
    private function onShowLapTime(e:Event):void {
      update();
    }
  }
}
