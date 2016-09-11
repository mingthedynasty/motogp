package com.season.classes.header {

  import flash.display.*;
  import fl.transitions.Tween;
  import fl.transitions.TweenEvent;
  import fl.transitions.easing.*;
  import flash.events.*;	

  import com.season.*;
  import com.season.components.*;
  import com.season.models.*;
  import com.season.classes.tooltip.*;


  /**********************
   *
   * RaceNameFlipper
   *
   **********************/
  public class RaceNameFlipper extends Flipper{

    /**********************
     * VARIABLES
     **********************/
    private var outline:Sprite = new Sprite();
    private var outlineTween:Tween;


    /**********************
     * CONSTRUCTOR
     **********************/
    public function RaceNameFlipper() {
      addChild(outline);

      super(new RaceInfo(), new RaceInfo());
      mouseChildren = false;

      outline.graphics.beginFill(0xCCCCCC, 1);      
      outline.graphics.drawRect(0, 0, 2000, clipHeight + 6);
      outline.graphics.endFill();
      outline.graphics.beginFill(0xFFFFFF, 1);      
      outline.graphics.drawRect(1, 1, 1998, clipHeight + 4);
      outline.graphics.endFill();
      outline.y = -3;
      
      //tween
      outlineTween = new Tween(outline, "x", Regular.easeInOut,
                               0, 0, .4, true);
      outlineTween.stop();

      //events
      RaceChooser.getInstance().addEventListener(
        RaceChooser.RACE_SELECTED, onRaceSelected);
      addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
      addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
    }

    /**********************
     * PROTECTED
     **********************/
    override protected function changeContents(obj:DisplayObject, info:*):void {
      var raceInfo:RaceInfo = obj as RaceInfo;
      var raceModel:SeasonRaceModel = info as SeasonRaceModel; 
      if (raceInfo && raceModel) {
        raceInfo.update(raceModel);
      }

      if (isFirst) {
        outline.x = obj.width - outline.width + 10;
      } else {
        outlineTween.begin = outline.x;
        outlineTween.finish = obj.width - outline.width + 10;
        outlineTween.start();
      }

      super.changeContents(obj, info);
    }

    /**********************
     * HANDLERS
     **********************/
    private function onRaceSelected(e:RaceEvent):void {
      flip(e.model);
    }
    private function onMouseOver(e:MouseEvent):void {
      if ((root as MotoGP).currentView == "race") {
        RaceInfoTooltip.getInstance().show(this);
      }
    }
    private function onMouseOut(e:MouseEvent):void {
      RaceInfoTooltip.getInstance().hide();
    }
  }
}
