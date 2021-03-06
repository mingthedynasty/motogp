package com.season.models {


    /**********************
     * 
     * SeasonModel
     *
     **********************/
    public class SeasonModel {
    
        /**********************
         * VARIABLES      
         **********************/
        public var year:String;

        public var raceList:XMLList;
        public var raceCount:int;

        public var riderList:XMLList;
        public var riderCount:int;
    
        public var sizeFactor:Number = 1;

        public var hasTires:Boolean = true;


        /**********************/
        static private var instance:SeasonModel = new SeasonModel();
        private var xml:XML;


        /**********************
         * PUBLIC
         **********************/
        public static function getInstance():SeasonModel  {      
            return instance;
        }
    
        /*********************/
        public function initModel(seasonXML:XML):void {
            xml = seasonXML;

            year = xml.@year;

            raceList = xml.races.race;
            raceCount = xml.races.race.length();

            riderList = xml.teams.team.rider;
            riderCount = xml.teams.team.rider.length();

            sizeFactor = xml.@sizefactor;

            hasTires = xml.tires.toString() != "";
        } 

        /*********************/
        public function getStandingsListForRider(num:int):XMLList {
            return xml.standings.rider.(@number == num).race;
        }


        /*********************/
        public function getRiderModelByNumber(num:int):RiderModel {
            var xml = XML(riderList.(@num == num));
            return new RiderModel(xml);
        }

        /*********************/
        public function getRaceModelByIndex(index:int):SeasonRaceModel {

            return new SeasonRaceModel(raceList[index],
                                       xml.standings.rider.race.(childIndex()==index));
        }

        /*********************/
        public function getCurrLeaderPoints():Number 
        {
            var lastIndex : Number = xml.standings.rider[0].race.length() - 1;
            xml.standings.rider.race.(childIndex()==lastIndex).(@worldstanding==1);

            return xml.standings.rider.race.(childIndex()==lastIndex).(@worldstanding==1).@pt;
        }

    }
}
