package com.season.classes.season 
{

    import flash.events.*;

    /**********************
     * 
     * RacePointSquareEvent
     *
     **********************/
    public class RacePointSquareEvent extends Event {
    
        /**********************
         * VARIABLES      
         **********************/
        public var riderNumber : Number;

        //------------
        // Static
        //------------
        public static const OVER : String = "racepointsquareover";
        public static const OUT  : String = "racepointsquareout";

        /**********************
         * CONSTRUCTOR
         **********************/
        public function RacePointSquareEvent (type : String, 
                                              num  : Number)
        {
            super (type, true);
            riderNumber = num;
        }     
    }
}
