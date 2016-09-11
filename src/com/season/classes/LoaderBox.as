package com.season.classes {

  import flash.display.*;
  import flash.net.*;
  import flash.events.*;
  import flash.text.*;

  import fl.transitions.*;

  import com.season.*;
  import com.season.utils.*;

  import mylibrary.utils.anim.*;

  /**********************
   *
   * Loader
   *
   **********************/
  public class LoaderBox extends TweeningSprite {

    /**********************
     * VARIABLES
     **********************/
    private var _box:Sprite = new Sprite();
    private var _spinner:MovieClip = new MovieClip();
    private var _main:MotoGP;

    /**********************
     * CONSTRUCTOR
     **********************/
    public function LoaderBox(main:MotoGP) {
      _main = main;

      //boc
      _box.graphics.beginFill(0xFFFFFF, 1);
      _box.graphics.drawRect(0, 0, 220, 140);
      _box.graphics.endFill();

      _box.graphics.lineStyle(1, 0x999999);
      _box.graphics.drawRect(0, 0, 220, 140);
      addChild(_box);

      //text
      var format:TextFormat = 
        TextFactory.createTextFormat(TextStyle.PLAIN, 0x555555);
      var loadingText:TextField = TextFactory.createText(format);
      loadingText.text = "LOADING...";

      loadingText.x = Math.round((width - loadingText.width)/2) + 5;
      loadingText.y = 110;
      _box.addChild(loadingText);

      //load spinner
      var loader:Loader = new Loader();
      _spinner.addChild(loader);
      var loadURL:URLRequest = new URLRequest("assets/loader.swf");

      loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadSpinner);
      loader.load(loadURL);

      _box.addChild(_spinner);
    }

    /**********************
     * PUBLIC
     **********************/
    public function show():void {
      alpha = 0;
      tween("alpha", 1);
      _box.visible = true;
      _main.addChild(this);
      stage.addEventListener(Event.RESIZE, onStageResize);
      onStageResize(null);
    }
    //----//
    public function hide():void {
      if (_main.contains(this)) {
        stage.removeEventListener(Event.RESIZE, onStageResize);
        var tween:Tween = tween("alpha", 0);
        tween.addEventListener(TweenEvent.MOTION_STOP, onHide);

        _box.visible = false;
        //_main.removeChild(this);
      }
    }

    private function onHide(e:Event):void {
      _main.removeChild(this);
    }

    /**********************
     * PRIVATE
     **********************/
    private function onLoadSpinner(e:Event):void {
      _spinner.width = 50;
      _spinner.height = 50;

      _spinner.x = Math.round((this.width - _spinner.width)/2);
      _spinner.y = 35;
    }
    //----//
    private function onStageResize(e:Event):void {
      graphics.clear();
      graphics.beginFill(0xDDDDDD, .3);
      graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);

      _box.x = Math.round((stage.stageWidth - _box.width)/2);
      _box.y = Math.round((stage.stageHeight - _box.width)/2);
    }
  }
}
