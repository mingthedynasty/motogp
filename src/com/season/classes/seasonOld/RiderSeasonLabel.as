package com.season.classes.season
{
    import com.season.models.RiderStandingModel;
    import com.season.utils.*;

    import mylibrary.utils.*;

    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.text.*;

    /**********************************
     *
     * RiderSeasonLabel
     *
     **********************************/
    public class RiderSeasonLabel extends Sprite
    {

        /******************************
         * VARIABLES
         ******************************/
        private var _model : RiderStandingModel;

        private var _nameField : TextField;
        private var _numField  : TextField;


        private var _upFormatNum    : TextFormat;
        private var _upFormatName   : TextFormat;
        private var _overFormatNum  : TextFormat;
        private var _overFormatName : TextFormat;


        /******************************
         * CONSTRUCTOR
         ******************************/
        public function RiderSeasonLabel (season : Season) 
        {
            _upFormatNum  = TextFactory.createTextFormat (TextStyle.PLAIN, 0x999999);
            _upFormatName = TextFactory.createTextFormat (TextStyle.BOLD,  0x999999);
            _numField  = TextFactory.createText (_upFormatNum);
            _nameField = TextFactory.createText (_upFormatName);
            _nameField.x = 17;
            addChild (_numField);
            addChild (_nameField);

            mouseChildren = false;
            buttonMode    = true;

            // listeners
            addEventListener(MouseEvent.MOUSE_OVER, onOver);
            addEventListener(MouseEvent.MOUSE_OUT,  onOut);

            season.addEventListener (RacePointSquareEvent.OVER, onSquareOver);
            season.addEventListener (RacePointSquareEvent.OUT,  onSquareOut);
        }


        /******************************
         * GETTERS/SETTERS
         ******************************/
        public function set model (m : RiderStandingModel) : void
        {
            _model = m;

            _numField.text  = String (_model.riderModel.riderNum);
            _nameField.text = _model.riderModel.riderName;

            // click area
            graphics.beginFill (0xFF0000, 0);
            graphics.drawRect (0, 0, _nameField.x + _nameField.width, _nameField.height);

            // color
            _overFormatNum  = TextFactory.createTextFormat (TextStyle.PLAIN, _model.riderModel.colorTeam);
            _overFormatName = TextFactory.createTextFormat (TextStyle.BOLD,  _model.riderModel.colorTeam);
        }


        /******************************
         * PUBLIC
         ******************************/


        /******************************
         * PROTECTED
         ******************************/
        protected function onOver (e : MouseEvent) : void
        {
            dispatchEvent (new RacePointSquareEvent (RacePointSquareEvent.OVER,
                                                     _model.riderModel.riderNum));
            _numField.setTextFormat  (_overFormatNum);
            _nameField.setTextFormat (_overFormatName);
        }

        //------------
        protected function onOut (e : MouseEvent) : void
        {
            dispatchEvent (new RacePointSquareEvent (RacePointSquareEvent.OUT,
                                                     _model.riderModel.riderNum));
            _numField.setTextFormat  (_upFormatNum);
            _nameField.setTextFormat (_upFormatName);
        }


        //------------
        //------------
        protected function onSquareOver (e : RacePointSquareEvent) : void
        {
            if (e.riderNumber == _model.riderModel.riderNum) {
                _numField.setTextFormat  (_overFormatNum);
                _nameField.setTextFormat (_overFormatName);
            } else {
                alpha = .5;
            }
        }

        //------------
        protected function onSquareOut (e : RacePointSquareEvent) : void
        {
            _numField.setTextFormat  (_upFormatNum);
            _nameField.setTextFormat (_upFormatName);

            alpha = 1;
        }

    }
}
