package com.season.classes.season {

  import flash.display.Sprite;
  import flash.text.*;
  import flash.events.*;
  import flash.utils.*;

  import fl.transitions.Tween;
  import fl.transitions.easing.*;	

  import caurina.transitions.Tweener;

  import com.season.*;
  import com.season.classes.header.*;
  import com.season.classes.tooltip.*;
  import com.season.models.*;
  import com.season.utils.*;

  import mylibrary.utils.anim.*;
  import mylibrary.utils.*;

  /**********************
   *
   * RiderSeasonBar
   *
   **********************/
  public class RiderSeasonBar extends TweeningSprite {


    /**********************
     * VARIABLES
     **********************/
    private var _model:RiderSeasonModel;

    private var currRaceModel:SeasonRaceModel;
    private var currSquare:RacePointSquare;

    private var prevRaceModel:SeasonRaceModel;

    private var nameNumText:Sprite = new Sprite();
    private var nameText:TextField = TextFactory.createText();
    private var numText:TextField = TextFactory.createText();

    private var flipper:SeasonPointsFlipper = new SeasonPointsFlipper();
    private var indicator:Sprite = new Sprite();

    private var transition:RiderSummaryShowRaceTransition;

    private var tweenIndicator:Tween;

    private var squares:Array = [];
    private var _squarePool:ObjectPool;

    private var moved:Boolean = false;
    //--------
    public static const BAR_WIDTH:int = 20;
    public static const BAR_SPACING:int = 50;


    /**********************
     * CONSTRUCTOR
     **********************/
    public function RiderSeasonBar() {
      
      //transition = new RiderSummaryShowRaceTransition(this, squaresWrapper);
      x= 200;
      nameNumText.addChild(numText);

      nameText.text = "TEMP";
      nameNumText.addChild(nameText);

      nameNumText.x = 5;
      nameNumText.rotation = -25;
      addChild(nameNumText);
      

      //points flipper
      flipper.y = 402;
      flipper.x = (BAR_WIDTH - flipper.width)/2;
      addChild(flipper);

      //indicator
      this.addChild(indicator);

      tweenIndicator = 
        new Tween(indicator, "alpha", Regular.easeInOut, 0, 1, .4, true);
      tweenIndicator.stop();

      //register for events
      RaceChooser.getInstance().addEventListener(
        RaceChooser.RACE_SELECTED, onRaceSelected);
      nameText.addEventListener(MouseEvent.MOUSE_OVER, onNameOver);
      nameText.addEventListener(MouseEvent.MOUSE_OUT, onNameOut);


      //pool
      var square = new RacePointSquare();
      var itemClassName = getQualifiedClassName(square).split("::").join(".");
      _squarePool = new ObjectPool(itemClassName, this);

    }

    /**********************
     * GETTER/SETTER
     **********************/
    public function get currRaceSquare():RacePointSquare {
      return currSquare;
    }

    public function set model(newModel:RiderSeasonModel):void {
      _model = newModel;

      if (!_model) { return; }

      var color:uint = _model.riderModel.colorTeam;
      //labels
      var numStyle:TextFormat = 
        TextFactory.createTextFormat(TextStyle.PLAIN, color);
      var nameStyle:TextFormat = 
        TextFactory.createTextFormat(TextStyle.BOLD, color);

      numText.defaultTextFormat = numStyle;
      numText.text = String(model.riderModel.riderNum);

      nameText.defaultTextFormat = nameStyle;
      nameText.text = _model.riderModel.riderName;
      nameText.x = numText.width + 5;

      //points flipper
      flipper.color = color;

      //init points
      createPointSquares();

      //indicator
      indicator.alpha = 0;
      setChildIndex(indicator, numChildren - 1);
    }

    public function get model():RiderSeasonModel {
      return _model;
    }

    /**********************
     * PUBLIC
     **********************/
    public function showRacePoints(points:int):void { 
      flipper.flip(points);
    }

    //--------//
    public function showIndicator():void {
      if (currSquare) {
        indicator.graphics.clear();
        indicator.graphics.lineStyle(1, 0x777777);
        indicator.graphics.drawRect(0, 
                                    0, 
                                    currSquare.width + 3, 
                                    currSquare.height + 3);

        indicator.x = currSquare.x - 2;
        indicator.y = currSquare.y - 2;

        tweenIndicator.start();
      }
    }

    /**********************
     * PRIVATE
     **********************/
    private function createPointSquares():void {
      _squarePool.returnAllObjects();

      var newRaceModel = RaceChooser.getInstance().currRaceModel;

      var races:XMLList = model.racesList;
      var square:RacePointSquare;
      var ny = 0;

      for (var i = 0; i < races.length(); i++) {
        square = _squarePool.getObject() as RacePointSquare;
        square.model = new RiderStandingModel(races[i]);
        squares.push(square);
        if (square.model.raceModel.raceNum == newRaceModel.raceNum) {
          currSquare = square;
        }
        if (square.sizeHeight > 0) {
          ny += square.sizeHeight;// + 1;
          square.visible = true;
        } else {
          square.visible = false;
        }
        square.initialY = 400 - ny;
        square.width = 0;
        if (square.model.raceModel.raceNum <= newRaceModel.raceNum) {
          square.showSquare();
        }
      }

      nameNumText.y = currSquare.initialY - 12;
      currRaceModel = newRaceModel;

      x = currSquare.model.worldPlace * (BAR_WIDTH + BAR_SPACING);
      showRacePoints(currSquare.model.worldPoints);
    }


    /**********************
     * HANDLERS
     **********************/    
    private function onRaceSelected(e:RaceEvent):void {
      if (!_model) { return; }
      moved = false;
      indicator.alpha = 0;
      var newRaceModel:SeasonRaceModel = e.model;
      currSquare = null;

      var square;

      for (var i = 0; i < squares.length; i++) {
        square = squares[i];
        if (square.model.raceModel.raceNum == newRaceModel.raceNum) {
          currSquare = square;
        }

        if (newRaceModel.raceNum < currRaceModel.raceNum) {
          if (square.model.raceModel.raceNum > newRaceModel.raceNum) {
            square.hideSquare(finishHide);
          }
        } 
      }

      if (newRaceModel.raceNum > currRaceModel.raceNum) {
        Tweener.addTween(nameNumText, {y: currSquare.initialY - 12, time: .5,
          transition: "easeInOutCubic", onComplete: finishShow});
      } 

      var t:SeasonRaceModel = currRaceModel;
      currRaceModel = newRaceModel;
      prevRaceModel = t;
    }

    private function onNameOver(e:Event):void {
      RiderTooltip.getInstance().show(nameText);
    }
    private function onNameOut(e:Event):void {
      RiderTooltip.getInstance().hide();
    }

    private function finishHide():void {
      if (moved || !currSquare) { return; }
      Tweener.addTween(nameNumText, {y: currSquare.initialY - 12, time: .5,
        transition: "easeInOutCubic"});

      Tweener.addTween(this, 
        {x: currSquare.model.worldPlace * (BAR_WIDTH + BAR_SPACING), 
         time:.5, transition:"easeInOutCubic"});
      moved = true;

      showRacePoints(currSquare.model.worldPoints);
    }

    private function finishShow():void {
      showRacePoints(currSquare.model.worldPoints);
      Tweener.addTween(this, 
        {x: currSquare.model.worldPlace * (BAR_WIDTH + BAR_SPACING), 
         time:.5, transition:"easeInOutCubic"});

      var square:RacePointSquare;
      for (var i = 0; i < squares.length; i++) {
        square = squares[i];
        if (square.model.raceModel.raceNum <= currRaceModel.raceNum) {
          square.showSquare();
        }
      }
    }
  }
}
