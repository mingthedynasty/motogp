package com.season.classes.tooltip {

  import flash.display.*;
  import flash.text.*;
  import flash.geom.*;
  import flash.net.*;
  import flash.events.*;

  import com.season.*;
  import com.season.utils.*;
  import com.season.classes.header.*;
  import com.season.models.*;

  import mylibrary.utils.anim.*;


  /**********************
   *
   * RaceTooltip
   *
   **********************/
  public class RaceTooltip extends Tooltip {

    /**********************
     * VARIABLES
     **********************/
    private var raceLabel:TextField;
    private var locationLabel:TextField;
    private var dateLabel:TextField;

    private var raceValue:TextField;
    private var locationValue:TextField;
    private var dateValue:TextField;

    private var _hasDataFooter:TextField;

    private var loader:Loader = new Loader();
    private var image:TweeningSprite = new TweeningSprite();
    private var noImage:Sprite = new Sprite();

    /**********************/
    static private var instance:RaceTooltip = new RaceTooltip();

    private static var IMAGE_WIDTH:int = 72;
    private static var IMAGE_HEIGHT:int = 55;

    /**********************
     * CONSTRUCTOR
     **********************/
    public function RaceTooltip() {
      super();

      xBuffer = 11;
      yBuffer = 10;

      contents.x = xBuffer;
      contents.y = yBuffer;

      //labels
      labels.x = IMAGE_WIDTH + 15;
      raceLabel = initLabel("RACE");
      locationLabel = initLabel("LOCATION");
      dateLabel = initLabel("DATE");

      //values
      values.x = labels.getBounds(this).width + labels.x + 10;
      raceValue = initValue(150);
      locationValue = initValue(150);
      dateValue = initValue(150);

      //footer
      _hasDataFooter = initFooter();
      _hasDataFooter.text = "*NO DETAILED RACE DATA AVAILABLE";

      //no image
      var spinnerLoader:Loader = new Loader();
      var spinner:MovieClip = new MovieClip();
      spinner.addChild(spinnerLoader);
      noImage.addChild(spinner);
      var loadURL:URLRequest = new URLRequest("assets/loader.swf");
      spinnerLoader.load(loadURL);
      spinnerLoader.x = Math.round((IMAGE_WIDTH - 10)/2);
      spinnerLoader.y = Math.round((IMAGE_HEIGHT - 15)/2);

      noImage.graphics.beginFill(0xDDDDDD, 1);
      noImage.graphics.drawRect(1, 1, IMAGE_WIDTH, IMAGE_HEIGHT);      
      contents.addChild(noImage);

      //image
      image.x = 1;
      image.y = 2;
      image.addChild(loader);
      contents.addChild(image);

      var border:Sprite = new Sprite();
      border.graphics.lineStyle(1, 0x999999);
      border.graphics.drawRect(1, 1, IMAGE_WIDTH, IMAGE_HEIGHT);
      contents.addChild(border);

      loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, 
                                                onLoadImageError);
      loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadImage);

    }

    /**********************
     * PUBLIC
     **********************/
    public static function getInstance():RaceTooltip  {      
      return instance;
    }

    /**********************/
    override public function show(ref:DisplayObject):void {
      var button:RaceButton = ref as RaceButton;
      var model:SeasonRaceModel = button.model;

      //set values
      raceValue.text = model.raceName;
      locationValue.text = model.location;
      dateValue.text = model.date;

      footer.visible = !model.hasData;
      
      layoutItems();

      image.alpha = 0;
      var url:String = "assets/" + YearChooser.getInstance().currYear 
        + "/tracks/" + model.shortName + ".png";
      var urlReq:URLRequest = new URLRequest(url);
      loader.load(urlReq);
      super.show(ref);

      //finish it up
      var start = new Point(Math.round(width/2), 0);
      var end = new Point(Math.round(width/2), -15);
      finishShow(-Math.round((width - ref.width)/2),
                 15 + ref.height,
                 start,
                 end);
    }

    /**********************
     * PRIVATE
     **********************/
    private function onLoadImageError(e:Event):void {
      noImage.visible = true;
    }
    private function onLoadImage(e:Event):void {
      image.tween("alpha", 1, .2);
    }
  }
}
