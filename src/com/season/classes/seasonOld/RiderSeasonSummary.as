package com.season.classes.season {

  import flash.display.Sprite;
  import flash.text.*;
  import flash.events.*;
  import flash.utils.*;

  import fl.transitions.Tween;
  import fl.transitions.easing.*;	

  
  import com.season.*;
  import com.season.classes.header.*;
  import com.season.classes.tooltip.*;
  import com.season.models.*;
  import com.season.utils.*;

  import mylibrary.utils.anim.*;
  import mylibrary.utils.*;


  /**********************
   *
   * RiderSeasonSummary
   *
   **********************/
  public class RiderSeasonSummary extends TweeningSprite {

    /**********************
     * VARIABLES
     **********************/
    private var _model:RiderSeasonModel;
    private var placeMatrix:Array = [];

    private var currRaceModel:SeasonRaceModel;
    private var currSquare:RacePointSquare;

    private var nameText:TextField = TextFactory.createText();
    private var numText:TextField = TextFactory.createText();

    private var squaresWrapper:Sprite = new Sprite();
    private var flipper:SeasonPointsFlipper = new SeasonPointsFlipper();
    private var indicator:Sprite = new Sprite();

    private var transition:RiderSummaryShowRaceTransition;

    private var tweenIndicator:Tween;

    private var _squarePool:ObjectPool;

    /********/
    public static const BACKGROUND_HEIGHT:int = 170;
    public static const BACKGROUND_WIDTH:int = 170;

    /**********************
     * CONSTRUCTOR
     **********************/
    public function RiderSeasonSummary() {

      transition = new RiderSummaryShowRaceTransition(this, squaresWrapper);

      numText.x = 2;
      numText.y = 2;
      addChild(numText);

      nameText.text = "TEMP";
      nameText.y = 2;
      addChild(nameText);

      //points flipper
      flipper.x = BACKGROUND_WIDTH - 28 - 2;
      flipper.y = BACKGROUND_HEIGHT - 15 - 3;
      addChild(flipper);

      //wrapper
      squaresWrapper.x = Math.round(BACKGROUND_WIDTH/2);
      squaresWrapper.y = Math.round(BACKGROUND_HEIGHT/2);
      addChild(squaresWrapper);

      var maskObj:Sprite = new Sprite();
      var maskY:int = nameText.y + nameText.height + 2;
      maskObj.graphics.beginFill(0xFFFF00, .2);
      maskObj.graphics.drawRect(0, 
                                maskY,
                                BACKGROUND_WIDTH,
                                BACKGROUND_HEIGHT - maskY);
      addChild(maskObj);
      squaresWrapper.mask = maskObj;

      //indicator
      squaresWrapper.addChild(indicator);

      tweenIndicator = 
        new Tween(indicator, "alpha", Regular.easeInOut, 0, 1, .4, true);
      tweenIndicator.stop();

      //events
      RaceChooser.getInstance().addEventListener(
        RaceChooser.RACE_SELECTED, onRaceSelected);
      nameText.addEventListener(MouseEvent.MOUSE_OVER, onNameOver);
      nameText.addEventListener(MouseEvent.MOUSE_OUT, onNameOut);


      //pool
      var square = new RacePointSquare();
      var itemClassName = getQualifiedClassName(square).split("::").join(".");
      _squarePool = new ObjectPool(itemClassName, squaresWrapper);

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

      graphics.clear();
      var color:uint = _model.riderModel.colorTeam;

      //outline
      graphics.beginFill(0xFFFFFF, 1.0);
      graphics.drawRect(0, 0, BACKGROUND_WIDTH, BACKGROUND_HEIGHT);
      graphics.endFill();

      graphics.lineStyle(1, color, .3);
      graphics.drawRect(0, 0, BACKGROUND_WIDTH, BACKGROUND_HEIGHT);
      
      //ticks
      graphics.lineStyle(1, color);
      graphics.moveTo(BACKGROUND_WIDTH/2, -2);
      graphics.lineTo(BACKGROUND_WIDTH/2, 3);

      graphics.moveTo(BACKGROUND_WIDTH - 2, BACKGROUND_HEIGHT/2);
      graphics.lineTo(BACKGROUND_WIDTH + 3, BACKGROUND_HEIGHT/2);

      graphics.moveTo(BACKGROUND_WIDTH/2, BACKGROUND_HEIGHT - 2);
      graphics.lineTo(BACKGROUND_WIDTH/2, BACKGROUND_HEIGHT + 3);

      graphics.moveTo(-2, BACKGROUND_WIDTH/2);
      graphics.lineTo(3, BACKGROUND_WIDTH/2);
      

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
      squaresWrapper.setChildIndex(indicator, squaresWrapper.numChildren - 1);
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
    public function showIndicator(square:RacePointSquare):void {
      currSquare = square;
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
      placeMatrix = [];

      var races:XMLList = model.scoringRacesList;

      var square:RacePointSquare;
      for (var i = 0; i < races.length(); i++) {
        square = _squarePool.getObject() as RacePointSquare;
        square.model = new RiderStandingModel(races[i]);
        addPointSquareToMatrix(square);
        square.visible = false;
      }

      //now that we have all of our squares created show them
      var newRaceModel = RaceChooser.getInstance().currRaceModel;
      transition.showRace(currRaceModel, newRaceModel,
                          placeMatrix, true);
      
      currRaceModel = newRaceModel;
      //this.squares.squareswrapper.indicator.bringToFront();
    }

    /**********************/
    private function addPointSquareToMatrix(square:RacePointSquare):void {

      //put square in our place matrix
      var place = square.model.racePlace;
      var squareArr = placeMatrix[place];
      
      if (!squareArr) {
        placeMatrix[place] = [];
        squareArr = placeMatrix[place];
      }
      squareArr.push(square);

      //figure out initial y
      var factor:Number = SeasonModel.getInstance().sizeFactor;
      square.initialY = 
        -(squareArr.length * 
          Math.round((square.model.racePoints/factor + 1)));
      square.y = square.initialY;
      square.x = place * 20;
    }

    /**********************
     * HANDLERS
     **********************/    
    private function onRaceSelected(e:RaceEvent):void {
      if (!_model) { return; }
      transition.showRace(currRaceModel, e.model, placeMatrix, false);
      indicator.alpha = 0;
      currRaceModel = e.model;
    }

    private function onNameOver(e:Event):void {
      RiderTooltip.getInstance().show(nameText);
    }
    private function onNameOut(e:Event):void {
      RiderTooltip.getInstance().hide();
    }
  }
}
