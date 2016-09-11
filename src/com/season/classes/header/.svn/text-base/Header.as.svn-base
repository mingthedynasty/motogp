package com.season.classes.header {

  import flash.display.Sprite;
  import flash.text.*;
  import flash.events.*;
  import flash.geom.*;

  import com.season.*;
  import com.season.components.*;
  import com.season.data.*;
  import com.season.models.*;
  import com.season.utils.*;

  /**********************
   * 
   * Header
   *
   **********************/	
  public class Header extends Sprite {

    /**********************
     * VARIABLES
     **********************/
    private var title:TextField;
    private var changeViewButton:TextButton = 
      new TextButton(TextStyle.BOLD, TextStyle.BOLD);
    private var flipper:RaceNameFlipper = new RaceNameFlipper();

    public static const X_PADDING:int = 15;
    private static const DIVIDER_Y:int = 56;

    /**********************
     * CONSTRUCTOR
     **********************/
    public function Header() {      

      RaceChooser.getInstance().y = 28;
      flipper.x = Header.X_PADDING;
      flipper.y = 70;

      //setup title
      var format:TextFormat = 
        TextFactory.createTextFormat(TextStyle.LARGE, 0x666666);
      title = TextFactory.createText(format);

      title.x = Header.X_PADDING;
      title.y = 3;
      
      //setup change view button
      changeViewButton.text = "SHOW RACE DETAILS >>";
      changeViewButton.textColor = 0xBB0000;
      changeViewButton.textOverColor = 0xEE0000;

      changeViewButton.y = DIVIDER_Y + 10;
      
      changeViewButton.addEventListener(MouseEvent.CLICK, 
                                        onChangeViewButtonClick);
      //add children
      addChild(title);
      addChild(RaceChooser.getInstance());
      addChild(YearChooser.getInstance());
      addChild(flipper);
      addChild(changeViewButton);

      //events
      RaceChooser.getInstance().addEventListener(RaceChooser.RACE_SELECTED,
                                                 onRaceSelected);
    }

    /**********************
     * PUBLIC
     **********************/
    public function initHeader():void {
      //set title text
      var seriesModel:SeriesModel = SeriesModel.getInstance();
      title.text = seriesModel.series.toUpperCase();
      YearChooser.getInstance().initChooser();
      YearChooser.getInstance().x = title.x + title.width + 20;
      YearChooser.getInstance().y = 3;

      render();

      //events
      stage.addEventListener(Event.RESIZE, onStageResize);      
    }
    public function update():void {
      render();
    }

    /**********************
     * HANDLERS
     **********************/
    private function onStageResize(e:Event):void {
      this.render();
    }

    //----//
    private function onChangeViewButtonClick(e:MouseEvent):void {
      var motoGP:MotoGP = parent as MotoGP;
      if (motoGP.currentView == "season") {
        motoGP.transitionToRace();
        changeViewButton.text = "SHOW SEASON VIEW >>";
        RaceChooser.getInstance().removeEventListener(RaceChooser.RACE_SELECTED,
                                                      onRaceSelected);
      } else {
        motoGP.raceToTransition();
        changeViewButton.text = "SHOW RACE VIEW >>";
        RaceChooser.getInstance().addEventListener(RaceChooser.RACE_SELECTED,
                                                   onRaceSelected);
      }
    }
    //----//
    private function onRaceSelected(e:RaceEvent):void {
      changeViewButton.visible = e.model.hasData;
    }

    /**********************
     * PRIVATE
     **********************/
    private function render():void {
      graphics.clear();
      graphics.beginFill(0xFFFFFF, 1);
      graphics.drawRect(0, 0, stage.stageWidth, DIVIDER_Y);
      graphics.endFill();

      graphics.lineStyle(1, 0xCCCCCC);
      graphics.moveTo(0, DIVIDER_Y);
      graphics.lineTo(stage.stageWidth, DIVIDER_Y);
      
      var chooserBounds:Rectangle = RaceChooser.getInstance().getBounds(this);
      changeViewButton.x = 
        chooserBounds.x + chooserBounds.width - changeViewButton.width;
    }
  }

}
