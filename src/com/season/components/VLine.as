package com.season.components {

  import flash.display.Sprite;

  /**********************
   *
   * VLine
   *
   **********************/
  public class VLine extends BaseLine {


    /**********************
     * CONSTRUCTOR
     **********************/
    public function VLine() {      
      _axis = "x";
      _sizeAxis = "height";

      _regLine = new VDotLine();
      _bigLine = new VDotLineBig();
      _tightLine = new VDotLineTight();

      super();
    }
  }
}
