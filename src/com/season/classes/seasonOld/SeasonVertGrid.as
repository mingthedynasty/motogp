package com.season.classes.season {

    import com.season.components.*;
    import com.season.models.*;
    import com.season.utils.*;
    
    import flash.display.Sprite;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    
    import mylibrary.utils.*;
    import mylibrary.utils.anim.*;

    /**********************
     *
     * SeasonVertGrid
     *
     **********************/
    public class SeasonVertGrid extends Sprite {

        /**********************
         * VARIABLES
         **********************/
        public static const GRID_X_SPACING = 180;

        public var contents:TweeningSprite = new TweeningSprite();
        public var maskObj:Sprite = new Sprite();

        private var dragArea:Sprite = new Sprite();
        private var _labelPool:ObjectPool;
        private var _linePool:ObjectPool;
		
		private var _title : TextField;

        /**********************
         * CONSTRUCTOR
         **********************/
        public function SeasonVertGrid() {
            var lines:Sprite = new Sprite();
            addChild(lines);
            addChild(contents);

            //drag area
            //contents.addChild(dragArea);

            //mask
            //addChild(maskObj);
            //mask = maskObj;

            var textStyle:TextFormat = 
                TextFactory.createTextFormat(TextStyle.PLAIN, 0x999999);

            _labelPool = new TextPool(contents, textStyle);
            //events
            addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);


            //pool
            var line = new VLine();
            var itemClassName = getQualifiedClassName(line).split("::").join(".");
            _linePool = new ObjectPool(itemClassName, lines);
			
			// label
			var titleTextStyle:TextFormat = 
				TextFactory.createTextFormat(TextStyle.BOLD, 0x9D9D9D);
			_title = TextFactory.createText(titleTextStyle);
			_title.text = "RACES";
			addChild(_title);

        }


        /**********************
         * GETTERS/SETTERS
         **********************/
        override public function get width():Number {
            var season = SeasonModel.getInstance();
            return ((season.riderCount + 1) * 
                    (RiderSeasonBar.BAR_WIDTH + RiderSeasonBar.BAR_SPACING) + 
                    RiderSeasonBar.BAR_WIDTH/2) + 60;
        }

        /**********************
         * PUBLIC
         **********************/
        public function initGrid():void {
            var season = SeasonModel.getInstance();

            var lineH:int = Season.MIN_POINT_TOTAL * Season.POINT_SIZE_FACTOR;
            _labelPool.returnAllObjects();
            _linePool.returnAllObjects();

            for (var i : int = 0; i < season.raceCount; i++) {
                var vLine:VLine = _linePool.getObject() as VLine;
                vLine.size = lineH;
                vLine.x =  (i + 1) * (RiderSeasonBar.BAR_WIDTH + RiderSeasonBar.BAR_SPACING) + 
                    RiderSeasonBar.BAR_WIDTH/2;
                vLine.alpha = .4;
                vLine.lineType = BaseLine.LINE_TIGHT;
            }

            //create lines and labels
            for (var i:int = 0; i < season.riderCount; i++) {
                /*var vLine:VLine = _linePool.getObject() as VLine;
                  vLine.size = lineH;
                  vLine.x =  (i + 1) * (RiderSeasonBar.BAR_WIDTH + RiderSeasonBar.BAR_SPACING) + 
                  RiderSeasonBar.BAR_WIDTH/2;
                  vLine.alpha = .4;
                  vLine.lineType = BaseLine.LINE_TIGHT;
                */
        
                /*var nx:int = GRID_X_SPACING * i + GRID_X_SPACING/2 + 3;        
                  contents.graphics.moveTo(nx, 0);
                  contents.graphics.lineaTo(nx, lineH);

                  var text:TextField = _labelPool.getObject() as TextField;
                  text.text = String(i + 1);
                  text.x = nx - Math.round(text.width/2);
                  text.y = lineH + 5;*/
            }
        }

        //--------//
        public function resize(seasonW:int):void {
            //trace("resize", width);
            return;
            var series = SeriesModel.getInstance();
            var lineH:int = Season.MIN_POINT_TOTAL * Season.POINT_SIZE_FACTOR;

            //drag area
            dragArea.graphics.clear();
            dragArea.graphics.beginFill(0xFF0000, 0.3);
            dragArea.graphics.drawRect(0, 0, seasonW, lineH);

            //mask
            maskObj.graphics.clear();
            maskObj.graphics.beginFill(0xFFFF00);
            maskObj.graphics.drawRect(0,
                                      -RiderSeasonSummary.BACKGROUND_HEIGHT, 
                                      seasonW,
                                      lineH + 2 * RiderSeasonSummary.BACKGROUND_HEIGHT);
        }

        /**********************
         * HANDLERS
         **********************/
        private function onMouseDown(e:MouseEvent):void {
            trace("onMouseDown", getBounds(stage));
        }
    }
}
