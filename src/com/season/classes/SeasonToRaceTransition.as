package com.season.classes {

  import flash.events.*;

  import fl.transitions.Tween;
  import fl.transitions.TweenEvent;

  import com.season.classes.season.*;
  import com.season.classes.race.*;
  import com.season.classes.race.grid.*;
  import com.season.classes.race.rideritem.*;
  import com.season.models.*;
  import com.season.classes.season.*;

  import mylibrary.utils.anim.*;

  /**********************
   *
   * SeasonToRaceTransition
   *
   **********************/
  public class SeasonToRaceTransition extends EventDispatcher {

    /**********************
     * VARIABLES
     **********************/
    private var race:Race;
    private var season:Season;

    private var sequencer:EventSequence = new EventSequence();
    private var gridFillTweenGroup:TweenGroup = new TweenGroup();
    private var finishPosGridTweenGroup:TweenGroup = new TweenGroup();

    private var finishItems:Array = [];
    private var sequenceInited:Boolean = false;

    //----//
    public static const GRID_FILL_FINISH:String = "gridFillFinish";
    public static const POSITION_GRID_FINISH:String = "positionGridFinish";

    /**********************
     * CONSTRUCTOR
     **********************/
    public function SeasonToRaceTransition(theSeason:Season, theRace:Race) {
      season = theSeason;
      race = theRace;
    }

    /**********************
     * PUBLIC
     **********************/
    public function start():void {
      race.alpha = 1;
      race.options.reset();
      initializeGrid();
      race.initialize();
      createRaceFinishItems();

      //initially position in lap view
      var riderList:Array = race.riderItemList;
      var rider:RiderItem;
      for (var i:int = 0; i < riderList.length; i++) {
        rider = riderList[i];
        rider.moveToLap(false);
        rider.moveToPosition(false);
      }

      //setup sequence
      var alphaTween:Tween = season.tween("alpha", 0);

      season.mouseChildren = false;
      season.mouseEnabled = false;
      race.mouseChildren = true;
      race.mouseEnabled = true;

      if (!sequenceInited) {
          sequenceInited = true;
          var fadeRace = new SequenceStep(alphaTween, 
                                          alphaTween.start, 
                                          TweenEvent.MOTION_FINISH);      
          var gridFill = new SequenceStep(this, 
                                          gridFillScreen, 
                                          GRID_FILL_FINISH);
          var finishGrid = new SequenceStep(this, 
                                            finishPositionGrid, 
                                            POSITION_GRID_FINISH);
          var showRace = new SequenceStep(this, 
                                          showRace, 
                                          "");

          sequencer.initSequence([fadeRace,
                                  gridFill,
                                  finishGrid,
                                  showRace]);
      }
      sequencer.start();
    }

    //--------//
    public function gridFillScreen():void {
      gridFillTweenGroup.addTween(
        race.vGrid.tween("height", race.stage.stageHeight));
      gridFillTweenGroup.addTween(
        race.vGrid.tween("y", 0));
      gridFillTweenGroup.addTween(
        race.hGrid.tween("width", race.stage.stageWidth));
      gridFillTweenGroup.addTween(
        race.hGrid.tween("x", 0));

      gridFillTweenGroup.addEventListener(EventGroup.GROUP_FINISH, 
                                          onGridFillFinish);
    }

    //--------//
    public function finishPositionGrid():void {
      var ny:int = 
        Math.round((race.stage.stageHeight - race.hGridHeight)/2);
      var nx:int = 
        Math.round((race.stage.stageWidth - race.vGridWidth)/2);

      var raceModel:RaceModel = RaceModel.getInstance();

      race.vGrid.showLaps(false);
      finishPosGridTweenGroup.addTween(race.vGrid.tween("x", nx));

      race.hGrid.showPositions();
      finishPosGridTweenGroup.addTween(race.hGrid.tween("y", ny));

      finishPosGridTweenGroup.addTween(race.riders.tween("x", nx));
      finishPosGridTweenGroup.addTween(race.riders.tween("y", ny));

      //move the race finish items to their final position
      var item:RiderItem;
      for (var i:int = 0; i < finishItems.length; i++) {
        item = finishItems[i];
        item.showTeamOrder(true);

        finishPosGridTweenGroup.addTween(item.moveToPosition());
        finishPosGridTweenGroup.addTween(item.moveToLap());

        item.setSize(15);
      }    


      finishPosGridTweenGroup.addEventListener(EventGroup.GROUP_FINISH, 
                                               onPositionGridFinish);  
    }

    //--------//
    public function showRace():void {
      race.show();
    }

    /**********************
     * PRIVATE
     **********************/
    private function initializeGrid():void {
      var seasonModel = SeasonModel.getInstance();
      var raceModel = RaceModel.getInstance();

      trace(raceModel.lapCount);
      //vGrid
      race.vGrid.changeSpacing(raceModel.lapCount,
                               RiderSeasonBar.BAR_WIDTH + RiderSeasonBar.BAR_SPACING,
                               VertRaceGrid.RACE_LAP_LINE_INFO);
      race.vGrid.height = season.gridHeight;
      race.vGrid.x = season.vGrid.x + 50;
      race.vGrid.y = Season.GRID_Y_OFFSET;

      //hGrid
      var increment:int = 2;
      var hLineCount:int = Season.MIN_POINT_TOTAL/50;
      var count:int = Math.round(hLineCount/increment);
      race.hGrid.changeSpacing(count,
                               season.gridHeight/hLineCount * increment,
                               HorzRaceGrid.RACE_POSITION_LINE_INFO);
      race.hGrid.width = season.gridWidth;
      race.hGrid.x = season.hGrid.x;
      race.hGrid.y = Season.GRID_Y_OFFSET;      
    }
    
    //--------//
    private function createRaceFinishItems():void {
      finishItems = [];

      race.riders.x = 
        Math.round((race.stage.stageHeight - race.hGridHeight)/2);
      race.riders.y = 
        Math.round((race.stage.stageWidth - race.vGridWidth)/2);

      var currRaceSquares:Array = season.getCurrRaceSquares();
      var square:RacePointSquare;
      var finishItem:RiderItem;
      var size:int;
      for (var i:int = 0; i < currRaceSquares.length; i++) {
        square = currRaceSquares[i];
        if (square) {
          size = RiderSeasonBar.BAR_WIDTH;//square.getBounds(race).width;
          finishItem = 
            race.createFinishRiderItem(RaceModel.getInstance().lapCount - 1, 
                                       square.model.riderModel.riderNum);
          if (finishItem) {
              finishItem.setRectSize(size, square.sizeHeight - 1);
              finishItem.x = square.getBounds(finishItem.parent).x + Math.round(size/2);
              finishItem.y = square.getBounds(finishItem.parent).y + Math.round(size/2);
              finishItem.showTeamOrder(false);
              finishItems.push(finishItem);
          }
        }
      }
    }


    /**********************
     * HANDLERS
     **********************/
    private function onGridFillFinish(e:Event):void {
      dispatchEvent(new Event(GRID_FILL_FINISH));
      removeEventListener(EventGroup.GROUP_FINISH, onGridFillFinish);
    }

    //--------//
    private function onPositionGridFinish(e:Event):void {
      dispatchEvent(new Event(POSITION_GRID_FINISH));
      removeEventListener(EventGroup.GROUP_FINISH, onPositionGridFinish);
    }

  }
}
