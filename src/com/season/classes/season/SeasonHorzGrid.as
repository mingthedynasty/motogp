package com.season.classes.season {

    import com.season.*;
    import com.season.components.*;
    import com.season.models.*;
    import com.season.utils.*;
    
    import flash.display.Sprite;
    import flash.events.*;
    import flash.text.*;
    
    import mylibrary.utils.*;
    import mylibrary.utils.anim.*;

    /**********************
     *
     * SeasonHorzGrid
     *
     **********************/
    public class SeasonHorzGrid extends Sprite {

        /**********************
         * VARIABLES
         **********************/
        private var _hLineArray:Array = [];
        private var _squaresArray:Array = [];
        private var _labelPool:ObjectPool;
        private var _title:TextField;
		private var _scaleFactor:Number;
		
		
        //----//
        public static const GRID_Y_SPACING = 80;
        public static const X_RIGHT_OFFSET = 50;

        private static const LABEL_X_LEFT_OFFSET = -70;

        public static const TARGET_HEIGHT : Number = 600;

        /**********************
         * CONSTRUCTOR
         **********************/
        public function SeasonHorzGrid() 
        {
            var textStyle:TextFormat = 
                TextFactory.createTextFormat(TextStyle.PLAIN, 0x999999);

            _labelPool = new TextPool( this, textStyle);


            var titleTextStyle:TextFormat = 
                TextFactory.createTextFormat(TextStyle.BOLD, 0x9D9D9D);
            _title = TextFactory.createText(titleTextStyle);
            _title.text = "POINTS";
            addChild(_title);
        }

		/**********************
		 * GETTERS/SETTERS
		 **********************/
		public function get scaleFactor() : Number 
		{
			return _scaleFactor;
		}

        /**********************
         * PUBLIC
         **********************/
        public function initGrid():void 
        {
        }

        //--------//
        public function resize( seasonW : int ) : void 
        {

            // Calc spacing, increment, etc
            var topPoints : Number = SeasonModel.getInstance().getCurrLeaderPoints();
            var increment : Number = 10;
            var rangeMax  : Number = 10;

            if ( topPoints <= 25 ) {
                increment = 5;
            } else if ( topPoints <= 50 ) {
                increment = 10;
            } else if ( topPoints <= 100 ) {
                increment = 25;
            } else {
                increment = 50;
            }

            rangeMax = Math.ceil( topPoints/increment ) * increment;

            // Prep
            _labelPool.returnAllObjects;

            graphics.clear();
            graphics.lineStyle(1, 0xE8E8E8);      

            var lineW:int = SeasonModel.getInstance().raceCount * 
                (RiderSeasonBar.BAR_WIDTH + RiderSeasonBar.BAR_SPACING) + 60;

            var count   : Number = rangeMax/increment;
            var spacing : Number = TARGET_HEIGHT/count;
            trace ( rangeMax, increment, spacing, count );

            for (var i:int = 0; i < count + 1; i++) {

                graphics.moveTo( 0,     i * spacing );
                graphics.lineTo( lineW, i * spacing );


                //label
                var text:TextField = _labelPool.getObject() as TextField;
                text.text = String( (count - i ) * increment );
                text.x    = -text.width - 15;
                text.y    = i * spacing - text.height/2;
            }

            // Axis label
            _title.x = LABEL_X_LEFT_OFFSET;
            _title.y = ( TARGET_HEIGHT + _title.width ) * .5;
            _title.rotation = -90;
			

			_scaleFactor = TARGET_HEIGHT/rangeMax;
			
			trace( "scale", TARGET_HEIGHT, rangeMax, _scaleFactor );
        }

    }
}
