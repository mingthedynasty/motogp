package com.season.classes.season {

  import flash.display.Sprite;
  import flash.events.*;
  import fl.transitions.Tween;
  import fl.transitions.easing.*;	

  import com.season.utils.*;
  import com.season.models.*;
  import com.season.*;

  /**********************
   *
   * RiderSummaryShowRaceTransition
   *
   **********************/
  public class RiderSummaryShowRaceTransition extends EventDispatcher {

    /**********************
     * VARIABLES
     **********************/
    private var currSquare:RacePointSquare = null;
    private var summary:RiderSeasonSummary;

    private var sequencer:EventSequence = new EventSequence();

    private var tweenSummary:TweenRiderSummary;
    private var tweenSquares:TweenRaceSquares;


    /**********************
     * CONSTRUCTOR
     **********************/
    public function RiderSummaryShowRaceTransition(seasonSum:RiderSeasonSummary,
                                                   wrapper:Sprite) {
      summary = seasonSum;

      //tweens
      tweenSummary = new TweenRiderSummary(summary);
      tweenSquares = new TweenRaceSquares(summary, wrapper);


      //set up animation sequence
      sequencer.initSequence(
        [new SequenceStep(tweenSummary, tweenSummary.start, TweenRiderSummary.TWEEN_FINISH),
        new SequenceStep(tweenSquares, tweenSquares.start, TweenRaceSquares.TWEEN_FINISH)]);

      sequencer.addEventListener(EventSequence.SEQUENCE_FINISH, onSequenceFinish);

    }

    /**********************
     * PUBLIC
     **********************/
    public function showRace(currRaceModel:SeasonRaceModel,
                             newRaceModel:SeasonRaceModel,
                             placeMatrix:Array,
                             firstTime:Boolean):void {
      var isNewer:Boolean = false;
      if (firstTime ||
          newRaceModel.raceNum > currRaceModel.raceNum) {
        isNewer = true;
      }

      //-----
      // vars
      //-----
      var squareArray:Array;
      var square:RacePointSquare;
      var squareSize:int;
      var squareModel:RiderStandingModel;

      var posHasRace:Boolean;
      var cx:int = 0;
      var cy:int;
      var yExtent:int = 0;
      var updateObj:Object = {};

      var shiftInfoArray:Array = [];
      var showInfoArray:Array = [];
      var hideInfoArray:Array = [];
      
      var currSquareModel:RiderStandingModel = null;
      currSquare = null;

      var factor:Number = SeasonModel.getInstance().sizeFactor;

      //-----
      // Let's do it
      //-----
      for (var i:int = 0; i < placeMatrix.length; i++) {
        squareArray = placeMatrix[i];
        if (!squareArray) { continue; }
        cy = 0;
        posHasRace = false;
        for (var j:int = 0; j < squareArray.length; j++) {
          square = squareArray[j];
          squareModel = square.model;
          squareSize = 
            Math.round(squareModel.racePoints/factor);
          updateObj = {square: square, x: cx};
          
          if (squareModel.raceModel.raceNum > newRaceModel.raceNum) { 
            //hide squares for races after the curr race
            if (square.visible) {
              hideInfoArray.push(updateObj);
            }
          } else {
            //set initial pos
            if (firstTime) {
              cy -= squareSize + 1;
              showInfoArray.push(updateObj);
            } else if (isNewer) {
              //separare itmes to shift and items to show from 
              //scratch
              if (square.visible) { 
                shiftInfoArray.push(updateObj);
              } else {
                showInfoArray.push(updateObj);
              }
            } else {
              //collect items to shift when showing older race
              shiftInfoArray.push(updateObj);
            }
            
            //remember if this is the current race
            if (squareModel.raceModel.raceNum == newRaceModel.raceNum) { 
              currSquareModel = squareModel;
              currSquare = square;
            }

            if (square.initialY < yExtent) { 
              yExtent = square.initialY; 
            }
            posHasRace = true;
          }
        }
        if (posHasRace) {
          cx += squareSize + 1;   
        }
      }
      
      //-----
      //if we didn't find a square in our matrix, we're out of the points
      //so access model/XML directly
      //-----
      if (!currSquareModel) {
        currSquareModel = 
          summary.model.getStandingModelByIndex(newRaceModel.raceNum);
      } 

      //-----
      //prep show summary animation
      //-----
      var seasonModel = SeasonModel.getInstance();
      var numPlaces = SeriesModel.getInstance().scoringPlacesCount;
      var yPlace = currSquareModel.racePlace;
      if (yPlace > numPlaces) {
        yPlace = numPlaces + 1;
      }
      
      var nx:int = (currSquareModel.worldPlace - 1) * 
        SeasonVertGrid.GRID_X_SPACING + 8;
      var ny:int = (yPlace - 1) * SeasonHorzGrid.GRID_Y_SPACING - 
        Math.round(RiderSeasonSummary.BACKGROUND_HEIGHT/2);      

      tweenSummary.prepare(firstTime, nx, ny);

      //-----
      //prep show race squares
      //-----
      var wrapperW:int = cx - 1;
      var wrapperH:int = -yExtent + 10;

      var wrapperX:int = Math.round((RiderSeasonSummary.BACKGROUND_WIDTH - wrapperW)/2);
      var wrapperY:int =        
        Math.round((RiderSeasonSummary.BACKGROUND_HEIGHT - wrapperH)/2 +
                   wrapperH);

      tweenSquares.prepare(isNewer, 
                           currSquareModel,
                           wrapperX, wrapperY,
                           shiftInfoArray, 
                           showInfoArray,
                           hideInfoArray);


      //-----
      //Transition
      //-----
      sequencer.start();
    }

    /**********************
     * HANDLERS
     **********************/
    private function onSequenceFinish(e:Event):void {
      summary.showIndicator(currSquare);
    }
  }
}
