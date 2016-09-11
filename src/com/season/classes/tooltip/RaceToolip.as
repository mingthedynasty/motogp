package com.season.classes.tooltip {

  import flash.text.*;

  import com.season.utils.*;

  /**********************
   *
   * RaceTooltip
   *
   **********************/
  public class RaceTooltip extends Tooltip {

    /**********************
     * VARIABLES
     **********************/
    static public var test:String = "test";

    /**********************/
    static private var instance:RaceTooltip = new RaceTooltip();

    /**********************
     * CONSTRUCTOR
     **********************/
    public function RaceTooltip() {
    }

    /**********************
     * PUBLIC
     **********************/
    public static function getInstance():RaceTooltip  {      
      return instance;
    }

    /**********************/
    override public function show(ref:DisplayObject):void {
      super.show(ref);
    }

    /**********************
     * PROTECTED
     **********************/

    /**********************
     * PRIVATE
     **********************/

    /**********************
     * HANDLERS
     **********************/

  }
}
