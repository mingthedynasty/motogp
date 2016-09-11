package com.season.classes.race {

  import com.season.models.*;

  import mylibrary.utils.anim.*;

  /**********************
   *
   * Podium
   *
   **********************/
  public class PodiumDisplay extends TweeningSprite {

    /**********************
     * VARIABLES
     **********************/
    private var _race:Race;

    private var _first:PodiumSpot;
    private var _second:PodiumSpot;
    private var _third:PodiumSpot;

    public static const SPACING:Number = 10;

    /**********************
     * CONSTRUCTOR
     **********************/
    public function PodiumDisplay(race:Race) {
      _race = race;

      _first = new PodiumSpot(_race);
      _second = new PodiumSpot(_race);
      _third = new PodiumSpot(_race);

      addChild(_first);
      addChild(_second);
      addChild(_third);

      _second.y = PodiumSpot.PODIUM_SIZE + SPACING;
      _third.y = 2 * (PodiumSpot.PODIUM_SIZE + SPACING);
    }

    /**********************
     * PUBLIC
     **********************/
    public function update():void {
      var podiumModels:Array = RaceModel.getInstance().getPodiumRiderLapModels();

      _first.model = podiumModels[0];
      _second.model = podiumModels[1];
      _third.model = podiumModels[2];
    }
  }
}
