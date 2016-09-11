package com.season.classes.race.grid {

  import flash.display.*;
  import flash.events.*;

  import com.season.classes.race.*;
  import com.season.components.*;

  /**********************
   *
   * RaceVLine
   *
   **********************/
  public class RaceVLine extends VLine {

    /**********************
     * VARIABLES
     **********************/
    private var _grid:VertRaceGrid;
    private var _hotSpot:Sprite = new Sprite();

    /**********************
     * CONSTRUCTOR
     **********************/
    public function RaceVLine(vGrid:VertRaceGrid) {
      _grid = vGrid;

      _hotSpot.graphics.beginFill(0x000000, 0);
      _hotSpot.graphics.drawRect(-Race.GRID_X_SPACING/2, 0, 
                                 Race.GRID_X_SPACING, 2000);
      addChild(_hotSpot);

      addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
      addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
    }

    /**********************
     * HANDLERS
     **********************/
    private function onMouseOver(e:MouseEvent):void {
      _grid.showLapLabel(x/Race.GRID_X_SPACING, true);
    }

    private function onMouseOut(e:MouseEvent):void {
      _grid.showLapLabel(x/Race.GRID_X_SPACING, false);
    }
  }
}
