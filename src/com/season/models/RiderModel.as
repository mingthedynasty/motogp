package com.season.models {

  
  /**********************
   * 
   * RiderModel
   *
   **********************/
  public class RiderModel {       
    
    /**********************
     * VARIABLES      
     **********************/
    public var riderNum:int;
    public var riderName:String;

    public var isTopRider:Boolean;

    public var team:String;
    public var manufacturer:String;
    public var tire:String;

    public var colorTeam:uint;
    public var colorManufacturer:uint;
    public var colorTire:uint;

    public var country:String;
    public var birth:String;
    public var info:String;

    /**********************
     * CONSTRUCTOR
     **********************/
    public function RiderModel(xml:XML) {
      riderNum = xml.@num;
      riderName = (xml.@name).toUpperCase();

      isTopRider = xml.childIndex() == 0;

      team = xml.parent().@name;
      manufacturer = xml.parent().@manufacturer;
      tire = xml.@tires;
      if (tire == "") {
        tire = xml.parent().@tires;
      }

      //colors
      colorTeam = xml.parent().@color;

      var mans:XMLList = xml.parent().parent().parent().manufacturers;
      colorManufacturer = mans.manufacturer.(@name == manufacturer).@color;

      var tires:XMLList = xml.parent().parent().parent().tires;
      colorTire = tires.tire.(@name == tire).@color;

      //personal info
      country = xml.@country;
      birth = xml.@birth;
      info = xml;
    }
  }
}
