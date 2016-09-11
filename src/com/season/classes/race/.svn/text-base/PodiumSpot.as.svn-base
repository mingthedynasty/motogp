package com.season.classes.race {

  import flash.display.*;
  import flash.events.*;
  import flash.text.*;
  import flash.text.TextField;
  import flash.text.TextFormat;

  import com.season.components.*;
  import com.season.models.*;
  import com.season.utils.*;

  /**********************
   *
   * PodiumSpot
   *
   **********************/
  public class PodiumSpot extends Sprite {

    /**********************
     * VARIABLES
     **********************/
    private var _model:RiderLapModel;
    private var _riderNumberText:TextField;
    private var _race:Race;

    public static const PODIUM_SIZE:Number = 75;


    /**********************
     * CONSTRUCTOR
     **********************/
    public function PodiumSpot(race:Race) {
      _race = race;

      var format:TextFormat = 
        TextFactory.createTextFormat(TextStyle.VERDANA, 0xDDDDDD);
      format.size = 20;
      _riderNumberText = TextFactory.createText(format);
      addChild(_riderNumberText);

      //events
      _race.options.radioItemView.addEventListener(StatsRadioGroup.SELECTION_CHANGE, 
                                                   onItemViewChange);
    }

    /**********************
     * GETTERS/SETTERS
     **********************/
    public function set model(model:RiderLapModel):void {
      _model = model;
      update();
    }

    /**********************
     * PRIVATE
     **********************/
    private function update():void {
      if (!_model) { return; }
      var riderModel:RiderModel = this._model.riderModel;

      var color:uint;      
      switch(_race.options.itemView) {
      case "TEAM":
        color = riderModel.colorTeam;
        break;
      case "MANUFACTURER":
        color = riderModel.colorManufacturer;
        break;
      case "TIRE":
        color = riderModel.colorTire;
        break;
      }

      //setup text
      _riderNumberText.text = String(riderModel.riderNum);
      _riderNumberText.textColor = color;
      _riderNumberText.x = Math.round((PODIUM_SIZE - _riderNumberText.width)/2);
      _riderNumberText.y = Math.round((PODIUM_SIZE - _riderNumberText.height)/2);


      //set up shape
      var half:Number = PODIUM_SIZE/2;
      graphics.clear();

      switch (_race.options.itemView) {
      case "TEAM":
          graphics.beginFill(0xFFFFFF, 1);
          graphics.drawRect(0, 0, PODIUM_SIZE, PODIUM_SIZE);
          graphics.endFill();
          
          if (!riderModel.isTopRider) {
            graphics.beginFill(color, 1);
            graphics.drawCircle(half, half, half - 8);
            graphics.endFill();

            graphics.beginFill(0xFFFFFF, 1);
            graphics.drawCircle(half, half, half - 9);
            graphics.endFill();
          }

          graphics.lineStyle(2, color);
          graphics.drawRect(0, 0, PODIUM_SIZE, PODIUM_SIZE);
          break;

      case "MANUFACTURER":
          graphics.beginFill(color, 1);
          graphics.drawCircle(half, half, half);
          graphics.endFill();          

          graphics.beginFill(0xFFFFFF, 1);
          graphics.drawCircle(half, half, half - 2);
          graphics.endFill();          
          break;

      case "TIRE":
        var x:Number;
        var y:Number;
        var ang:Number;
        graphics.beginFill(color, 1.0);
        for (var i = 0; i < 7; i++) {
          ang = (2 * Math.PI)/6 * i;
          x = Math.cos(ang) * (half + 3) + half;
          y = Math.sin(ang) * (half + 3) + half;
          if (i == 0) { graphics.moveTo(x, y); } 
          else { graphics.lineTo(x, y); }
        }
        graphics.endFill();
        
        graphics.beginFill(0xFFFFFF, 1.0);
        for (i = 0; i < 7; i++) {
          ang = (2 * Math.PI)/6 * i;
          x = Math.cos(ang) * (half + 1) + half;
          y = Math.sin(ang) * (half + 1) + half;
          if (i == 0) { graphics.moveTo(x, y); } 
          else { graphics.lineTo(x, y); }
        }
        graphics.endFill();        
      }
    }

    /**********************
     * HANDLERS
     **********************/
    private function onItemViewChange(e:Event):void {
      update();
    }

  }
}
