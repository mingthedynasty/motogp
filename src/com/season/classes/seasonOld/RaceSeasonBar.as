package com.season.classes.season
{
    import com.season.models.SeasonRaceModel;
    import com.season.models.RiderStandingModel;
    import com.season.classes.season.RacePointSquare;
    import com.season.classes.season.RacePointSquareEvent;

    import mylibrary.utils.ObjectPool;

    import flash.display.Sprite;
    import flash.utils.*;

    /**********************************
     *
     * RaceSeasonBar
     *
     **********************************/
    public class RaceSeasonBar extends Sprite
    {

        /******************************
         * VARIABLES
         ******************************/
        private var _model    : SeasonRaceModel;
        private var _riderBar : Sprite;
        private var _overlay  : Sprite;

        private var _squares    : Array = [];
        private var _squarePool : ObjectPool;


        /******************************
         * CONSTRUCTOR
         ******************************/
        public function RaceSeasonBar (season : Season) 
        {
            _riderBar = new Sprite ();
            _riderBar.visible = false;
            addChild (_riderBar);

            _overlay = new Sprite ();
            _overlay.visible = false;
            addChild (_overlay);

            //pool
            var square = new RacePointSquare ();
            var itemClassName = getQualifiedClassName (square).split ("::").join (".");
            _squarePool = new ObjectPool (itemClassName, this);

            // listeners
            season.addEventListener (RacePointSquareEvent.OVER, onSquareOver);
            season.addEventListener (RacePointSquareEvent.OUT,  onSquareOut);
        }


        /******************************
         * GETTERS/SETTERS
         ******************************/
        public function set model (newModel : SeasonRaceModel) : void 
        {
            _model = newModel;

            if (!_model) { return; }

            _squarePool.returnAllObjects ();

            var square    : RacePointSquare;
            var standings : XML;
            var leaderPts : int = _model.standingsList.(@worldstanding=="1")[0].@pt;

            // bg highlight
            graphics.beginFill (0xFAFAFA, .7);
            graphics.lineStyle (1, 0xECECEC);
            graphics.drawRect (-5, 
                               -leaderPts * Season.POINT_SIZE_FACTOR - 7, 
                               29, 
                               leaderPts * Season.POINT_SIZE_FACTOR + 6);

            // overlay
            _overlay.graphics.beginFill (0xFFFFFF, .7);
            _overlay.graphics.drawRect (-4, 
                                        -leaderPts * Season.POINT_SIZE_FACTOR - 5, 
                                        28, 
                                        leaderPts * Season.POINT_SIZE_FACTOR + 5);


            // squares
            for (var i : int = 0; i < _model.standingsList.length (); i++) {

                standings = _model.standingsList [i];
                square = _squarePool.getObject () as RacePointSquare;

                square.model = new RiderStandingModel (standings);
                square.y = Math.round (-standings.@pt * Season.POINT_SIZE_FACTOR) - 2;
                _squares.push (square);
            }

            layerSquares ();
        }



        /******************************
         * PUBLIC
         ******************************/


        /******************************
         * PROTECTED
         ******************************/
        protected function onSquareOver (e : RacePointSquareEvent) : void
        {
            var square : RacePointSquare;

            for (var i : int = 0; i < _squares.length; i++) {
                square = _squares [i] as RacePointSquare;
                if (square.model.riderModel.riderNum == e.riderNumber) {

                    _riderBar.graphics.clear ();
                    _riderBar.graphics.beginFill (square.model.riderModel.colorTeam, .6);
                    _riderBar.graphics.drawRect (square.x - 1, square.y, 22, -square.y);
                    //_riderBar.visible = true;

                    _overlay.visible = true;

                    setChildIndex (_overlay,  numChildren - 1);
                    setChildIndex (_riderBar, numChildren - 1);
                    setChildIndex (square,    numChildren - 1);

                    return;
                }
            }
        }

        protected function onSquareOut (e : RacePointSquareEvent) : void
        {
            layerSquares ();
            _riderBar.visible = false;
            _overlay. visible = false;
 
        }


        protected function layerSquares () : void
        {
            // layering
            for (var j : int = 0; j < _squares.length; j++) {
                for (var k : int = 0; k < _squares.length; k++) {
                    if (_squares[k].model.worldPlace == j + 1) {
                        setChildIndex (_squares[k], j);
                    }
                }
            }
        }
    }
}
