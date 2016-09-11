package com.season.classes.race {

  import flash.display.Sprite;
  import flash.display.Shape;
  import flash.events.*;
  import flash.text.*;

  import caurina.transitions.Tweener;

  import com.season.*;
  import com.season.components.*;
  import com.season.models.*;
  import com.season.utils.*;

  import mylibrary.utils.anim.*;
  import mylibrary.utils.*;


  /**********************
   *
   * RaceOptions
   *
   **********************/
  public class RaceOptions extends SizingSprite {

    /**********************
     * VARIABLES
     **********************/
    private var _radioItemView:StatsRadioGroup;
    private var _radioRaceView:StatsRadioGroup;
    private var _boxLapTime:SelectableButton;

    private var _itemView:Sprite = new Sprite();
    private var _raceView:Sprite = new Sprite();

    private var _lapButton:SelectableButton;
    private var _speedButton:SelectableButton;
    private var _teamButton:SelectableButton;
    private var _tireButton:SelectableButton;

    private var _slider:StatsSlider;
    private var _sliderMask:Shape = new Shape();

    private var _startWidth:Number;

    /**********************
     * CONSTRUCTOR
     **********************/
    public function RaceOptions() {

      var format:TextFormat = 
        TextFactory.createTextFormat(TextStyle.PLAIN, 0xAAAAAA);

      //race view
      var label:TextField = TextFactory.createText(format);
      label.text = "RACE VIEW";
      _raceView.addChild(label);

      _radioRaceView = new StatsRadioGroup();
      _lapButton = 
        setupRadioButton("LAP", "circle", _radioRaceView, _raceView);
      var gapButton:SelectableButton = 
        setupRadioButton("GAP", "circle", _radioRaceView, _raceView);
      _speedButton = setupRadioButton("SPEED", "circle", _radioRaceView, _raceView);
      _radioRaceView.selection = _lapButton;

      _raceView.x = 20;
      _raceView.y = Math.round((30 - _raceView.getBounds(this).height)/2);
      addChild(_raceView);


      _sliderMask.x = gapButton.x + gapButton.width;
      _sliderMask.y = -100;
      _raceView.addChild(_sliderMask);
    
      _slider = new StatsSlider();
      _slider.width = 80;
      _slider.value = 30;
      _slider.minimum = 5;
      _slider.x = gapButton.x + gapButton.width + 12;
      _slider.y = 5;
      _slider.mask = _sliderMask;
  
      _raceView.addChild(_slider);

      _radioRaceView.addEventListener(StatsRadioGroup.SELECTION_CHANGE, 
                                      onRaceViewChange);


      //item view
      label = TextFactory.createText(format);
      label.text = "RIDER VIEW";
      _itemView.addChild(label);

      _radioItemView = new StatsRadioGroup();
      _teamButton = 
        setupRadioButton("TEAM", "circle", _radioItemView, _itemView);
      setupRadioButton("MANUFACTURER", "circle", _radioItemView, _itemView);
      _tireButton = setupRadioButton("TIRE", "circle", _radioItemView, _itemView);
      _radioItemView.selection = _teamButton;

      _itemView.x = getBounds(this).width + 50;
      _itemView.y = Math.round((30 - _itemView.getBounds(this).height)/2);
      addChild(_itemView);


      //laptime
      _boxLapTime = new SelectableButton("rect");
      _boxLapTime.x = getBounds(this).width + 60;
      _boxLapTime.label = "SHOW LAP TIMES";
      _boxLapTime.y = Math.round((30 - _boxLapTime.height)/2);
      addChild(_boxLapTime);

      setSize(getBounds(this).width + 30, getBounds(this).height);
      _startWidth = width;

      addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
    }

    /**********************
     * PUBLIC
     **********************/
    public function get radioItemView():StatsRadioGroup {
      return _radioItemView;
    }
    public function get boxLapTime():SelectableButton {
      return _boxLapTime;
    }
    public function get radioRaceView():StatsRadioGroup {
      return _radioRaceView;
    }
    public function get gapSlider():StatsSlider {
      return _slider;
    }

    //----//
    public function get itemView():String {
      return _radioItemView.selection.label;
    }
    public function get showLapTime():Boolean {
      return _boxLapTime.selected;
    }
    public function get raceView():String{
      return _radioRaceView.selection.label;
    }
    public function get gapLength():Number {
      return _slider.value;
    }

    //----//
    public function reset():void {
      _boxLapTime.selected = false;
      _radioItemView.selection = _teamButton;
      _radioRaceView.selection = _lapButton;
    }


    //----//
    override public function setSize(nw:Number, nh:Number):void {
      super.setSize(nw, nh);

      //position
      _boxLapTime.x = nw - 20 - _boxLapTime.width;
      _itemView.x = _boxLapTime.x - _itemView.width - 40;

      _speedButton.x = _itemView.x - 60 - _speedButton.width;

      //mask
      if (_sliderMask && _startWidth) {
        var sw:Number = nw - _startWidth + 10;
        _sliderMask.graphics.clear();
        _sliderMask.graphics.beginFill(0xFFFF00, 1);
        _sliderMask.graphics.drawRect(0, 0, sw, 140);
        _sliderMask.graphics.endFill();
        _sliderMask.graphics.beginFill(0xFFFF00, 1);
        _sliderMask.graphics.drawRect(-100, 0, sw + 200, 100);
      }
      
      //background
      graphics.clear();
      graphics.beginFill(0xCCCCCC, 1);
      graphics.drawRect(0, 0, nw, 40);
      graphics.beginFill(0xFFFFFF, 1);
      graphics.drawRect(0, 1, nw - 1, 40);
      graphics.endFill();

      graphics.lineStyle(1, 0xCCCCCC);
      graphics.moveTo(_itemView.x - 20, 0);
      graphics.lineTo(_itemView.x - 20, 40);

      graphics.lineStyle(1, 0xCCCCCC);
      graphics.moveTo(_boxLapTime.x - 20 , 0);
      graphics.lineTo(_boxLapTime.x - 20, 40);

    }

    /**********************
     * PRIVATE
     **********************/
    private function setupRadioButton(label:String, 
                                      shape:String,
                                      group:StatsRadioGroup, 
                                      owner:Sprite):SelectableButton {
      
      var radio:SelectableButton = new SelectableButton(shape);
      group.registerButton(radio);
      radio.label = label;
      radio.x = owner.getBounds(this).width + 20;

      owner.addChild(radio);

      return radio;
    }

    private function onRaceViewChange(e:Event):void {
      var group:StatsRadioGroup = e.target as StatsRadioGroup;
      var sel:SelectableButton = group.selection;      
      
      if (sel.label == "GAP") {
        Tweener.addTween(this, 
          {width: _startWidth + 90, time: .3, transition: "easeInOutQuad"});
      } else {
        Tweener.addTween(this, 
          {width : _startWidth, time: .3, transition: "easeInOutQuad"});
      }
    }
    
    private function onSeasonChange(e:Event):void {
      var hasTires:Boolean = SeasonModel.getInstance().hasTires;

      if (!hasTires && _tireButton.selected) {
        _radioItemView.selection = _teamButton;
      }
      _tireButton.alpha = hasTires ? 1 : .3;
      _tireButton.mouseEnabled = hasTires;

      
    }
    
    private function onAddToStage(e:Event):void {
      root.addEventListener(MotoGP.SEASON_CHANGE, onSeasonChange);
      onSeasonChange(null);
    }
  }
}
