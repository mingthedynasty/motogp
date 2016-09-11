package com.season.components {

  /**********************
   *
   * HLine
   *
   **********************/
  public class HLine extends BaseLine {


    /**********************
     * CONSTRUCTOR
     **********************/
    public function HLine() {
      _axis = "y";
      _sizeAxis = "width";

      _regLine = new HDotLine();

      super();
    }
  }
}
