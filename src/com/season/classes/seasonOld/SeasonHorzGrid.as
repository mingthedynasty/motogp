package com.season.classes.season {

    import flash.display.Sprite;
    import flash.events.*;
    import flash.text.*;	

    import com.season.components.*;
    import com.season.models.*;
    import com.season.utils.*;
    import com.season.*;

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

        //----//
        public static const GRID_Y_SPACING = 50;
        public static const X_RIGHT_OFFSET = 50;

        private static const LABEL_X_LEFT_OFFSET = -80;


        /**********************
         * CONSTRUCTOR
         **********************/
        public function SeasonHorzGrid() {
            var seriesModel:SeriesModel = SeriesModel.getInstance();
            var factor:Number = SeasonModel.getInstance().sizeFactor;

            var textStyle:TextFormat = 
                TextFactory.createTextFormat(TextStyle.PLAIN, 0x999999);
            var topSize:int = 
                Math.round(seriesModel.scoringPlaces[0].@points/factor);

            graphics.clear();
            graphics.lineStyle(1, 0xE8E8E8);      

            var lineW:int = SeasonModel.getInstance().riderCount * 
                (RiderSeasonBar.BAR_WIDTH + RiderSeasonBar.BAR_SPACING) + 60;
            for (var i:int = 0; i < Season.MIN_POINT_TOTAL/50 + 1; i++) {
                graphics.moveTo(0, i * GRID_Y_SPACING * Season.POINT_SIZE_FACTOR);
                graphics.lineTo(lineW, i * GRID_Y_SPACING * Season.POINT_SIZE_FACTOR);

                trace (i * GRID_Y_SPACING * Season.POINT_SIZE_FACTOR);

                //label
                var text:TextField = TextFactory.createText(textStyle);
                text.text = String(Season.MIN_POINT_TOTAL - (50 * i));
                text.x = -text.width - 25;
                text.y = i * GRID_Y_SPACING * Season.POINT_SIZE_FACTOR - text.height/2;
                addChild(text);

                /*var hLine:HLine = new HLine();
                  hLine.y = i * 50 * Season.POINT_SIZE_FACTOR;
                  hLine.alpha = .4;
                  _hLineArray[i] = hLine;        
                  addChild(hLine);*/
            }
            /*
            //----
            //create squares and labels
            //----
            for (var i:int = 0; i < seriesModel.scoringPlaces.length(); i++) {
            var ny:int = GRID_Y_SPACING * i;

            //square
            var square:TweeningSprite = new TweeningSprite();
            var size:int = 
            Math.round(seriesModel.scoringPlaces[i].@points/factor);
            square.graphics.beginFill(0xDBDBDB, 1);
            square.graphics.drawRect(0, 0, 10, 10);
            square.width = size;
            square.height = size;
            square.x = LABEL_X_LEFT_OFFSET - size - 5;
            square.y = ny - Math.round(size/2);
            _squaresArray.push(square);
            addChild(square);

            //label
            var text:TextField = TextFactory.createText(textStyle);
            text.text = seriesModel.scoringPlaces[i].@pos;
            text.x = LABEL_X_LEFT_OFFSET;
            text.y = ny - Math.round(text.height/2);
            addChild(text);

            //lines
            var hLine:HLine = new HLine();
            hLine.y = ny;
            hLine.alpha = .4;
            _hLineArray[i] = hLine;        
            addChild(hLine);
            }*/

            //axis title
            var titleTextStyle:TextFormat = 
                TextFactory.createTextFormat(TextStyle.BOLD, 0x9D9D9D);
            var title:TextField = TextFactory.createText(titleTextStyle);
            title.text = "POINTS";
            addChild(title);

            var totalH:int = Season.POINT_SIZE_FACTOR * Season.MIN_POINT_TOTAL;//(seriesModel.scoringPlaces.length() - 1) * GRID_Y_SPACING
            title.x = LABEL_X_LEFT_OFFSET;
            title.y = Math.round((totalH + title.width)/2);
            title.rotation = -90;
        }


        /**********************
         * PUBLIC
         **********************/
        public function initGrid():void {

            var seriesModel:SeriesModel = SeriesModel.getInstance();
            var factor:Number = SeasonModel.getInstance().sizeFactor;

            var topSize:int = 
                Math.round(seriesModel.scoringPlaces[0].@points/factor);

            graphics.clear();
            graphics.lineStyle(1, 0xE8E8E8);      

            var lineW:int = SeasonModel.getInstance().raceCount * 
                (RiderSeasonBar.BAR_WIDTH + RiderSeasonBar.BAR_SPACING) + 60;
            for (var i:int = 0; i < Season.MIN_POINT_TOTAL/50 + 1; i++) {
                graphics.moveTo(0, i * GRID_Y_SPACING * Season.POINT_SIZE_FACTOR);
                graphics.lineTo(lineW, i * GRID_Y_SPACING * Season.POINT_SIZE_FACTOR);
            }

            /*
            //----
            //update squares
            //----
            for (var i:int = 0; i < seriesModel.scoringPlaces.length(); i++) {
            var ny:int = GRID_Y_SPACING * i;

            //square
            var square:TweeningSprite = _squaresArray[i] as TweeningSprite;
            var size:int = 
            Math.round(seriesModel.scoringPlaces[i].@points/factor);
            square.tween("width", size);
            square.tween("height", size);
            square.tween("x", LABEL_X_LEFT_OFFSET - size - 5);
            square.tween("y", ny - Math.round(size/2));
            }*/
        }

        //--------//
        public function resize(seasonW:int):void {
            graphics.clear();
            graphics.lineStyle(1, 0xE8E8E8);      

            for (var i:int = 0; i < Season.MIN_POINT_TOTAL/50 + 1; i++) {
                graphics.moveTo(0, i * GRID_Y_SPACING * Season.POINT_SIZE_FACTOR);
                graphics.lineTo(seasonW, i * GRID_Y_SPACING * Season.POINT_SIZE_FACTOR);
            }
        }
    }
}
