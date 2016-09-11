package com.season.classes {

  import flash.events.*;

  import com.season.classes.race.*;
  import com.season.classes.race.rideritem.*;
  import com.season.classes.race.grid.*;
  import com.season.classes.season.*;
  import com.season.models.*;

  import mylibrary.utils.anim.*;

  /**********************
   *
   * RaceToSeasonTransition
   *
   **********************/
  public class RaceToSeasonTransition {

    /**********************
     * VARIABLES
     **********************/
    private var _season:Season;
    private var _race:Race;

    private var _shiftRaceGridGroup:TweenGroup = new TweenGroup();

    /**********************
     * CONSTRUCTOR
     **********************/
    public function RaceToSeasonTransition(theSeason:Season, theRace:Race) {
      _season = theSeason;
      _race = theRace;
    }

    /**********************
     * PUBLIC
     **********************/
    public function start():void {

      var tweenGroup:TweenGroup = _race.hide();

      if (_race.currRaceView == "SPEED") {
        tweenGroup.addTween(_race.vGrid.speedLines.tween("alpha", 0));
      }
      tweenGroup.addTween(_race.vGrid.labels.tween("alpha", 0));
      tweenGroup.addTween(_race.hGrid.labels.tween("alpha", 0));


      //hgrid
      var seriesModel = SeriesModel.getInstance();
      var raceModel = RaceModel.getInstance();

      var increment:int = 4;
      var count:int = Math.round((seriesModel.scoringPlacesCount + 1)/increment);
      _race.hGrid.changeSpacing(count,
                               SeasonHorzGrid.GRID_Y_SPACING * increment,
                               HorzRaceGrid.RACE_POSITION_LINE_INFO);

      tweenGroup.addEventListener(EventGroup.GROUP_FINISH, onHideRaceFinish);

      //final items
      createRaceFinishItems();
    }

    //--------//
    private function onHideRaceFinish(e:Event):void {
      var seasonModel = SeasonModel.getInstance();
      var raceModel = RaceModel.getInstance();

      //vGrid
      _race.vGrid.addEventListener(RaceGrid.CHANGE_SPACING_FINISH, 
                                   onSeasonLinesFinish);
      _race.vGrid.changeSpacing(seasonModel.riderCount,
                                RiderSeasonBar.BAR_WIDTH + RiderSeasonBar.BAR_SPACING,
                                VertRaceGrid.RACE_LAP_LINE_INFO, true, true);
      _race.vGrid.tween("x", _season.vGrid.x + 50);
                        //Season.GRID_X_OFFSET + SeasonVertGrid.GRID_X_SPACING/2 + 3);
      _race.hGrid.tween("y", Season.GRID_Y_OFFSET);      

      moveFinishItemsToSeason();
    }

    /**********************
     * PRIVATE
     **********************/
    private function onSeasonLinesFinish(e:Event):void {
      _shiftRaceGridGroup.addTween(_race.vGrid.tween("height", _season.gridHeight));
      _shiftRaceGridGroup.addTween(_race.vGrid.tween("y", Season.GRID_Y_OFFSET));

      //hgrid
      _shiftRaceGridGroup.addTween(_race.hGrid.tween("x", _season.hGrid.x));
      _shiftRaceGridGroup.addTween(_race.hGrid.tween("width", _season.gridWidth));

      _shiftRaceGridGroup.addEventListener(EventGroup.GROUP_FINISH,
                                           onGridShiftFinish);

      _race.vGrid.removeEventListener(RaceGrid.CHANGE_SPACING_FINISH,
                                      onSeasonLinesFinish);
    }

    //--------//
    private function onGridShiftFinish(e:Event):void {
      _season.tween("alpha", 1);
      _race.tween("alpha", 0);

      _race.mouseChildren = false;
      _race.mouseEnabled = false;

      _season.mouseChildren = true;
      _season.mouseEnabled = true;

      _shiftRaceGridGroup.reset();
      _shiftRaceGridGroup.removeEventListener(EventGroup.GROUP_FINISH,
                                              onGridShiftFinish);
    }

    //--------//
    private function createRaceFinishItems():void {
      var raceModel:RaceModel = RaceModel.getInstance();
      var riderLapModels:Array = 
        raceModel.getRiderLapModelsForLap(raceModel.lapCount - 1);
      var item:RiderItem = null;
      var model:RiderLapModel = null;

      var itemCount:int = Math.min(riderLapModels.length, 
                                   SeriesModel.getInstance().scoringPlacesCount - 1);
      for (var i:int = 0; i < itemCount ; i++) {
        model = riderLapModels[i];
        item = _race.createFinishRiderItem(model.lapNumber, 
                                           model.riderModel.riderNum);
        switch (_race.currRaceView) {
        case "LAP":
          item.moveToLap(false);
          item.moveToPosition(false);
          break;
        case "GAP":
          item.moveToLap(false);
          item.moveToGap(false);
          break;
        case "SPEED":
          item.moveToSpeed(false);
          item.moveToFinalPosition(false);
          break;
        }
      }
    }

    //--------//
    private function moveFinishItemsToSeason():void {
      var finalRaceItems:Array = _race.finalRiders;
      var finalSeasonItems:Array = _season.getCurrRaceSquares();
      var raceItem:RiderItem;
      var seasonItem:RacePointSquare; 
      var nx:int;
      var ny:int;
      
      trace(finalRaceItems.length);
      for (var i:int = 0; i < finalRaceItems.length; i++) {
        raceItem = finalRaceItems[i];
        for (var j:int = 0; j < finalSeasonItems.length; j++) {                
          seasonItem = finalSeasonItems[j];
          if (raceItem.model.riderModel.riderNum == 
              seasonItem.model.riderModel.riderNum) {
            nx = seasonItem.getBounds(raceItem.parent).x + 
              Math.round(seasonItem.width/2);
            ny = seasonItem.getBounds(raceItem.parent).y + 
              Math.round(seasonItem.width/2);

            raceItem.tween("x", nx);
            raceItem.tween("y", ny);
            raceItem.setRectSize(seasonItem.width, seasonItem.sizeHeight - 1);
            raceItem.showTeamOrder(false);
            continue;
          }
        }
      }
    }

  }
}
