package com.season.models {


    /**********************
     * 
     * SeasonRaceModel
     *
     **********************/
    public class SeasonRaceModel {

        /**********************
         * VARIABLES      
         **********************/
        private var xml:XML;

        public var raceName:String;
        public var shortName:String;
        public var date:String;
        public var location:String;
        public var raceNum:int;

        public var conditions:String;
        public var temp:int;
        public var humidity:int;
        public var length:Number;

        public var hasData:Boolean;
        public var happened:Boolean;

        public var standingsList:XMLList;

        /**********************
         * PUBLIC
         **********************/
        public function SeasonRaceModel(raceXML:XML, standingsList:XMLList = null) {
            xml = raceXML;

            raceName = xml.@name;
            shortName = xml.@short;
            date = xml.@date;
            location = xml.@location;
            raceNum = xml.childIndex();

            conditions = xml.@conditions;
            temp = xml.@temp;
            humidity = xml.@humidity;
            length = xml.@length;

            hasData = xml.@hasdata == "1";
            happened = xml.@happened == "1";

            if (standingsList) {
                this.standingsList = standingsList;
            }

        }
    }

}
