package com.season.components {

  import flash.display.Sprite;
  import flash.events.*;
  import flash.geom.*;
  import flash.text.*;

  import com.season.utils.*;

  import mylibrary.utils.*;

  /**********************
   *
   * StatsSlider
   *
   **********************/
  public class StatsSlider extends SizingSprite {

    /**********************
     * VARIABLES
     **********************/
    private var _thumb:Sprite = new Sprite();

    private var _minimum:Number = 0;
    private var _maximum:Number = 100;
    private var _value:Number = 50;
    private var _tooltip:Sprite = new Sprite();
    private var _tooltipText:TextField;

    public static const VALUE_CHANGE:String = "valueChange";

    /**********************
     * CONSTRUCTOR
     **********************/
    public function StatsSlider() {
      //thumb
      _thumb.graphics.beginFill(0xFFFFFF, 1);
      _thumb.graphics.drawRect(-2.5, 0, 5, 12);
      _thumb.graphics.endFill();

      _thumb.graphics.lineStyle(1, 0x676767);
      _thumb.graphics.drawRect(-2.5, 0, 5, 12);
      _thumb.y = -4;
      _thumb.buttonMode = true;

      addChild(_thumb);

      //tooltip
      var style:TextFormat = 
        TextFactory.createTextFormat(TextStyle.PLAIN, 0x555555);
      _tooltipText = TextFactory.createText(style);
      _tooltipText.text = "MING";
      _tooltip.y = -23;
      _tooltip.visible = false;
      _tooltip.addChild(_tooltipText);
      addChild(_tooltip);

      _thumb.addEventListener(MouseEvent.MOUSE_DOWN, startThumbDrag);
    }

    /**********************
     * GETTERS/SETTERS
     **********************/
    public function set minimum(min:Number):void {
      _minimum = min;
      if (_value < _minimum) {
        value = _minimum;
      } else {
        update();
      }
    }
    public function get minimum():Number {
      return _minimum;
    }

    public function set maximum(max:Number):void {
      _maximum = max;
      if (_value > _maximum) { 
        value = _maximum;
      } else {
        update();
      }
    }
    public function get maximum():Number {
      return _maximum;
    }

    public function set value(val:Number):void {
      if (val > _maximum) { val = _maximum; }
      if (val < _minimum) { val = _minimum; }
      _value = Math.round(val);
      update();
      dispatchEvent(new Event(VALUE_CHANGE));
    }
    public function get value():Number {
      return _value;
    }

    /**********************
     * PUBLIC
     **********************/
    override public function setSize(nw:Number, nh:Number):void {
      super.setSize(nw, nh);
      update();
    }


    /**********************
     * PRIVATE
     **********************/
    private function update():void {
      var pixVal:Number = width/(_maximum - _minimum);
      _thumb.x = pixVal * (_value - _minimum);
      
      graphics.clear();
      graphics.beginFill(0xCCCCCC, 1);
      graphics.drawRect(0, 0, _thumb.x, 4);
      graphics.endFill();

      graphics.lineStyle(1, 0x7E7E7E);
      graphics.drawRect(0, 0, width, 4);
    }

    /**********************
     * HANDLERS
     **********************/
    private function startThumbDrag(e:Event):void {
      var rect:Rectangle = new Rectangle(0, -5, width, 1);
      trace(rect);
      _thumb.startDrag(true, rect);

      updateTooltip();
      _tooltip.visible = true;

      stage.addEventListener(MouseEvent.MOUSE_UP, stopThumbDrag);
      stage.addEventListener(MouseEvent.MOUSE_MOVE, updateThumb);
    }

    private function stopThumbDrag(e:Event):void {
      _thumb.stopDrag();
      _tooltip.visible = false;
      stage.removeEventListener(MouseEvent.MOUSE_MOVE, updateThumb);
    }

    private function updateThumb(e:Event):void {
      var pixVal:Number = (_maximum - _minimum)/width;
      var newVal:Number = _thumb.x * pixVal + _minimum;
      if (_value != newVal) {  
        value = newVal; 
        updateTooltip();
      }
    }

    private function updateTooltip():void {
      _tooltipText.text = String(_value);

      var w:Number = Math.round(_tooltipText.width + 4);
      _tooltip.graphics.clear();
      _tooltip.graphics.beginFill(0xF3F3F3, .9);
      _tooltip.graphics.drawRect(-2, -1, 
                                 w, _tooltipText.height + 2);
      _tooltip.graphics.endFill();
      _tooltip.graphics.lineStyle(1, 0x666666);
      _tooltip.graphics.drawRect(-2, -1,
                                 w, _tooltipText.height + 2);

      _tooltip.x = _thumb.x - Math.round(w/2) + 2;
    }
  }
}
