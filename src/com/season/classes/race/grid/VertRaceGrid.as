package com.season.classes.race.grid {

  import flash.display.*;
  import flash.events.*;
  import flash.text.*;

  import com.season.components.*;
  import com.season.models.*;
  import com.season.classes.race.*;
  import com.season.classes.race.transitions.*;
  import com.season.utils.*;

  import mylibrary.utils.anim.*;

  /**********************
   *
   * VertRaceGrid
   *
   **********************/
  public class VertRaceGrid extends RaceGrid {

    /**********************
     * VARIABLES
     **********************/
    private var _lapLine:BaseLine;
    private var _lapLabelBox:Sprite = new Sprite();
    private var _lapLabelText:TextField = new TextField();

    private var _speedLines:TweeningSprite = new TweeningSprite();
    private var _speedLow:VLine = new VLine();
    private var _speedTop:VLine = new VLine();
    private var _speedAvg:VLine = new VLine();

    private var _labelSpeedLow:TextField;
    private var _labelSpeedTop:TextField;
    private var _labelSpeedAvg:TextField;

    private var _tweenGroup:TweenGroup = new TweenGroup();

    //----//
    public static const RACE_LAP_LINE_INFO:Object = 
      {interval         : 5,
       primaryType      : BaseLine.LINE_REGULAR,
       primaryAlpha     : .4,
       secondaryType    : BaseLine.LINE_BIG,
       secondaryAlpha   : .2};


    /**********************
     * CONSTRUCTOR
     **********************/
    public function VertRaceGrid(race:Race) {

      var format:TextFormat = 
        TextFactory.createTextFormat(TextStyle.BOLD, 0xAAAAAA);

      super(RaceGrid.GRID_VERT, format, race);      

      _speedLow.lineType = BaseLine.LINE_REGULAR;
      _speedLow.alpha = .5;
      _speedLines.addChild(_speedLow);

      _speedTop.lineType = BaseLine.LINE_REGULAR;
      _speedLines.addChild(_speedTop);

      _speedAvg.lineType = BaseLine.LINE_BIG;
      _speedAvg.alpha = .4;
      _speedLines.addChild(_speedAvg);

      _labelSpeedLow = initLabel();
      _labelSpeedTop = initLabel();
      _labelSpeedAvg = initLabel();

      _speedLines.alpha = 0;
      _speedAvg.alpha = 0;

      var lapFormat:TextFormat = 
        TextFactory.createTextFormat(TextStyle.PLAIN, 0x999999);        
      _lapLabelText = TextFactory.createText(lapFormat);
      _lapLabelText.text = "LAP";
      _lapLabelBox.visible = false;
      _lapLabelBox.addChild(_lapLabelText);
      _lapLabelBox.mouseEnabled = false;
      _lapLabelBox.mouseChildren = false;

      addChild(_lapLabelBox);
      addChild(_speedLines);
    }

    /**********************
     * PUBLIC
     **********************/
    public function get speedLines():TweeningSprite {
      return _speedLines;
    }

    //--------//
    public function showLaps(animate:Boolean = true):void {
      changeSpacing(RaceModel.getInstance().lapCount, 
                    Race.GRID_X_SPACING, 
                    RACE_LAP_LINE_INFO,
                    animate);
      _speedLines.tween("alpha", 0);
      _labels.tween("alpha", 0);
    }

    //--------//
    public function showSpeeds(w:int, avg:int, tween:Boolean = false):void {
      changeSpacing(0, 0, null); 

      if (tween) {
        _tweenGroup.addTween(_speedAvg.tween("x", avg));
        _tweenGroup.addTween(_speedTop.tween("x", w));
        _tweenGroup.addEventListener(EventGroup.GROUP_FINISH, showSpeedLabels);
        
        _labels.alpha = 0;
      } else {
        _speedAvg.x = avg;
        _speedTop.x = w;
      }

      _speedLines.alpha = 1;
    }

    //--------//
    public function finishShowSpeeds():void {
      _speedAvg.tween("alpha", .4);
      showSpeedLabels();
    }

    //--------//
    public function hideSpeeds():void {
      _speedAvg.alpha = 0;
      _labels.alpha = 0;
    }

    //--------//
    public function showLapLabel(lap:int, show:Boolean):void {
      if (show) {
        var line:BaseLine;
        for (var i:int = 0; i < pool.getActiveObjectCount(); i++) {
          line = pool.getActiveObjectAt(i) as BaseLine;
          if (line.x == lap * Race.GRID_X_SPACING) {
            break;
          }
        }
        if (line) {
          line.lineType = BaseLine.LINE_TIGHT;
          line.alpha = 1;
          _lapLine = line;

          renderLabel(lap);
        }
      } else if (_lapLine) {
        var interval:int = RACE_LAP_LINE_INFO.interval;
        _lapLine.lineType = 
          lap%interval ? RACE_LAP_LINE_INFO.primaryType : RACE_LAP_LINE_INFO.secondaryType;
        _lapLine.alpha = 
          lap%interval ? RACE_LAP_LINE_INFO.primaryAlpha :
          RACE_LAP_LINE_INFO.secondaryAlpha;

        _lapLabelBox.visible = false;
      }
    }

    /**********************
     * PROTECTED
     **********************/
    override protected function updateLineSizes(newSize:Number):void {
      super.updateLineSizes(newSize);

      _speedAvg.size = newSize;
      _speedTop.size = newSize;
      _speedLow.size = newSize;

      _labelSpeedLow.y = _race.hGrid.y - 15;
      _labelSpeedTop.y = _race.hGrid.y - 15;      
      _labelSpeedAvg.y = _race.hGrid.y - 15;
    }

    /**********************
     * PRIVATE
     **********************/
    private function initLabel():TextField {
      var label:TextField = _labelPool.getObject() as TextField;
      label.rotation = 270;
      label.y = 400;
      return label;
    }

    //--------//
    private function showSpeedLabels(e:Event = null):void {
      _labelSpeedLow.text = String(RaceModel.getInstance().speedLow);
      _labelSpeedLow.x = -12;
      _labelSpeedLow.y = _race.hGrid.y - 15;

      _labelSpeedTop.text = String(RaceModel.getInstance().speedTop);
      _labelSpeedTop.x = _speedTop.x - 12;
      _labelSpeedTop.y = _race.hGrid.y - 15;

      _labelSpeedAvg.text = String(RaceModel.getInstance().speedAvg);
      _labelSpeedAvg.x = _speedAvg.x - 12;
      _labelSpeedAvg.y = _race.hGrid.y - 15;

      _labels.tween("alpha", 1);
    }
    
    //--------//
    private function renderLabel(lap:int):void {
      setChildIndex(_lapLabelBox, numChildren - 1);

      if (lap == 0) {
        _lapLabelText.text = "GRID";
      } else if (lap + 1 == RaceModel.getInstance().lapCount) {
        _lapLabelText.text = "FINAL";
      } else {
        _lapLabelText.text = "LAP " + Number(lap);
      }

      _lapLabelBox.graphics.clear();
      _lapLabelBox.graphics.beginFill(0x888888, 1);
      _lapLabelBox.graphics.drawRect(-3, -1, 
                                     _lapLabelText.width + 6, 
                                     _lapLabelText.height + 2);

      _lapLabelBox.graphics.beginFill(0xFFFFFF, 1);
      _lapLabelBox.graphics.drawRect(-2, 0, 
                                     _lapLabelText.width + 4, 
                                     _lapLabelText.height);


      _lapLabelBox.x = Math.round(_lapLine.x - _lapLabelText.width/2);
      _lapLabelBox.y = _race.hGrid.y - (FinalLapOutline.LINE_HEIGHT + 
                                        FinalLapOutline.PADDING + 
                                        _lapLabelBox.height) + 2;
      _lapLabelBox.visible = true;
    }

  }
}
