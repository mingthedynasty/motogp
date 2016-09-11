package com.season.classes.header {


  import flash.display.Sprite;
  import flash.text.*;
  import flash.text.TextField;
  import flash.text.TextFormat;
  import flash.events.*;

  import com.season.models.*;
  import com.season.*;
  import com.season.utils.*;
  import com.season.classes.tooltip.*;

  /**********************
   * 
   * RaceButton
   *
   **********************/	
  public class RaceButton extends Sprite {


    /**********************
     * VARIABLES      
     **********************/
    private var _model:SeasonRaceModel;
    private var chooser:RaceChooser;

    private var text:TextField;

    private var  _isSelected:Boolean = false;
    private var _enabled:Boolean = true;

    private var plainTextFormat:TextFormat;
    private var boldTextFormat:TextFormat;


    public static const MIN_BUTTON_WIDTH:int = 40;
    private static const BUTTON_HEIGHT:int = 15;

   /**********************
     * CONSTRUCTOR
     **********************/
    public function RaceButton(raceChooser:RaceChooser) {
      buttonMode = true;
      mouseChildren = false;

      chooser = raceChooser;      

      //styles
      plainTextFormat = 
        TextFactory.createTextFormat(TextStyle.PLAIN, 0xAAAAAA);
      boldTextFormat = 
        TextFactory.createTextFormat(TextStyle.BOLD, 0x888888);

      //text
      text = TextFactory.createText(plainTextFormat);
      addChild(text);

      //events
      addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
      addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
      addEventListener(MouseEvent.CLICK, onMouseClick);

      addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
    }

   /**********************
    * SETTERS
    **********************/
    public function set model(newModel:SeasonRaceModel):void {
      _model = newModel;

      if (_model.hasData) { 
        text.text = _model.shortName;
      } else {
        text.text = _model.shortName + "*"; 
      }
      text.y = Math.round((BUTTON_HEIGHT - text.height)/2);

      var main:MotoGP = root as MotoGP;
      _enabled = !(main.currentView == "race" && !model.hasData);
    }

    public function get model():SeasonRaceModel {
      return _model;
    }


    public function set isSelected(isSel:Boolean):void {
      _isSelected = isSel;
      render(width);
      text.y = Math.round((this.height - text.height)/2);
      if(_isSelected) {
        text.setTextFormat(boldTextFormat);
        parent.setChildIndex(this, parent.numChildren - 1);
      } else {
        text.setTextFormat(plainTextFormat);
        parent.setChildIndex(this, 0);
      }
    }
    
   /**********************
    * HANDLERS
    **********************/
    private function onMouseOver(e:MouseEvent):void {
      RaceTooltip.getInstance().show(this);
      if (_isSelected || !_enabled || !model.happened) { return; }
      render(width);
      text.setTextFormat(boldTextFormat);
      text.y = Math.round((this.height - text.height)/2) - 1;
    }
    private function onMouseOut(e:MouseEvent):void {
      RaceTooltip.getInstance().hide();
      if (_isSelected || !_enabled || !model.happened) { return; }
      render(width);
      text.setTextFormat(plainTextFormat);
      text.y = Math.round((this.height - text.height)/2);
    }
    private function onMouseClick(e:MouseEvent):void {
      if (_isSelected || !_enabled || !model.happened) { return; }
      chooser.selectRace(this);
    }
    //--------//
    private function onAddToStage(e:Event):void {
      root.addEventListener(MotoGP.VIEW_CHANGE, onAppViewChange);
    }
    private function onAppViewChange(e:Event):void {
      var main:MotoGP = root as MotoGP;
      _enabled = !(main.currentView == "race" && !model.hasData);
    }
   /**********************
     * PUBLIC
     **********************/
    public function update(nx:int, nw:int) {
      x = nx;
      text.x = Math.round((nw - text.width)/2); 
      render(nw);
    }
    public function getRaceIndex():int {
      return model.raceNum;
    }

   /**********************
     * PRIVATE
     **********************/
    private function render(w:int):void {
      graphics.clear();
      graphics.beginFill(_isSelected? 0x999999 : 0xCCCCCC, 1.0);
      graphics.drawRect(0, 0, w, BUTTON_HEIGHT);
      graphics.endFill();
      graphics.beginFill(0xFFFFFF, 1.0);

      var offset:int = _isSelected ? 2 : 1;
      graphics.drawRect(offset, offset, w - 2 * offset,
                        BUTTON_HEIGHT - 2 * offset);
      graphics.endFill();
    }    
    
  }

}
