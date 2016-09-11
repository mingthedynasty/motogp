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
  import com.season.classes.season.*;

  import mylibrary.utils.anim.*;

  /**********************
   *
   * RiderTooltip
   *
   **********************/
  public class RiderTooltip extends Tooltip {

    /**********************
     * VARIABLES
     **********************/
    private var nameLabel:TextField;
    private var numberLabel:TextField;
    private var teamLabel:TextField;
    private var countryLabel:TextField;
    private var birthLabel:TextField;

    private var nameValue:TextField;
    private var numberValue:TextField;
    private var teamValue:TextField;
    private var countryValue:TextField;
    private var birthValue:TextField;

    private var info:TextField;
    private var noImageText:TweeningSprite = new TweeningSprite();
    private var spinner:MovieClip = new MovieClip();
    private var image:TweeningSprite = new TweeningSprite();
    private var loader:Loader = new Loader();


    /**********************/
    private static var instance:RiderTooltip = new RiderTooltip();

    private static var IMAGE_WIDTH:int = 109;
    private static var IMAGE_HEIGHT:int = 82;

    /**********************
     * CONSTRUCTOR
     **********************/
    public function RiderTooltip() {
      super();

      xBuffer = 10;
      yBuffer = 12;

      //labels
      labels.x = IMAGE_WIDTH + 10;
      nameLabel = initLabel("NAME");
      numberLabel = initLabel("NUMBER");
      teamLabel = initLabel("TEAM");
      countryLabel = initLabel("NATIONALITY");
      birthLabel = initLabel("BIRTH");

      //values
      values.x = labels.getBounds(this).width + labels.x + 15;
      nameValue = initValue();
      numberValue = initValue();
      teamValue = initValue();
      countryValue = initValue();
      birthValue = initValue();


      var imageContainer:Sprite = new Sprite();
      imageContainer.x = 10;
      imageContainer.y = 10;

      addChild(imageContainer);

      //border and bg
      var border:Sprite = new Sprite();
      border.graphics.beginFill(0xDDDDDD, 1);
      border.graphics.drawRect(-1, -1, IMAGE_WIDTH, IMAGE_HEIGHT);      
      border.graphics.endFill();
      border.graphics.lineStyle(1, 0x999999);
      border.graphics.drawRect(-1, -1, IMAGE_WIDTH, IMAGE_HEIGHT);
      imageContainer.addChild(border);

      //spinner
      var spinnerLoader:Loader = new Loader();
      spinner.addChild(spinnerLoader);
      var loadURL:URLRequest = new URLRequest("assets/loader.swf");
      spinnerLoader.load(loadURL);
      spinnerLoader.x = Math.round((IMAGE_WIDTH - 13)/2);
      spinnerLoader.y = Math.round((IMAGE_HEIGHT - 13)/2);
      imageContainer.addChild(spinner);

      //no image message
      var text:TextField = TextFactory.createText(labelTextStyle);
      text.text = "NO IMAGE";
      noImageText.x = Math.round((IMAGE_WIDTH - text.width)/2);
      noImageText.y = Math.round((IMAGE_HEIGHT - text.height)/2);
      noImageText.addChild(text);
      imageContainer.addChild(noImageText);
      noImageText.alpha = 0;

      //image
      image.addChild(loader);
      imageContainer.addChild(image);

      loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, 
                                                onLoadImageError);
      loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadImage);

      //info
      info = TextFactory.createText(labelTextStyle, true);
      info.x = -10;
      info.y = IMAGE_HEIGHT + 3;
      info.text = "TEST";
      contents.addChild(info);
    }

    /**********************
     * PUBLIC
     **********************/
    public static function getInstance():RiderTooltip  {      
      return instance;
    }

    /**********************/
    override public function show(ref:DisplayObject):void {
      var summary:RiderSeasonBar = ref.parent.parent as RiderSeasonBar;
      var model:RiderSeasonModel = summary.model;

      //set values
      nameValue.text = model.riderModel.riderName.toUpperCase();
      numberValue.text = String(model.riderModel.riderNum);
      teamValue.text = model.riderModel.team.toUpperCase();
      countryValue.text = model.riderModel.country.toUpperCase();
      birthValue.text = model.riderModel.birth;
      
      layoutItems();
      
      image.alpha = 0;
      spinner.visible = true;
      noImageText.alpha = 0;

      info.width = values.x + values.width + 10;
      info.visible = model.riderModel.info != "";
      info.text = model.riderModel.info.toUpperCase();
      info.y = info.visible ? 85 : 0;
      yBuffer = info.visible ? 12 : 15;

      var year:String = YearChooser.getInstance().currYear;
      var url:String = "assets/" + year + "/riders/" + model.riderModel.riderNum + ".png";
      var urlReq:URLRequest = new URLRequest(url);
      loader.load(urlReq);

      super.show(ref);

      trace(ref.height);
      //finish it up
      var start = new Point(Math.round(width/2), 0);
      var end = new Point(Math.round(width/2), -15);
      var xoff = -Math.round((width)/2);
      var yoff = 15;
      
      var globalPt = refView.localToGlobal(new Point(refView.width/2, refView.height + 2));
      if (yoff + globalPt.y + background.height > stage.stageHeight) {
        yoff = -background.height - yoff - 37;
        start.y = background.height;
        end.y = background.height + 35;
      }

      finishShow(xoff, yoff, start, end);
    }

    /**********************
     * PROTECTED
     **********************/
    override protected function finishShow(xoff:int, yoff:int, 
                                           linestart:Point, lineend:Point) {      
      var globalPt = refView.localToGlobal(new Point(refView.width/2, refView.height + 2));
      var ox = Math.round(globalPt.x + xoff);
      var oy = Math.round(globalPt.y + yoff);
      

      //bound it
      var nx = Math.max(ox, 0);
      if (nx + width > stage.stageWidth) {
        nx = stage.stageWidth - width;
      }
      
      //set position
      x = nx;
      y = oy;
      
      //draw lines
      linestart.x += ox - nx;
      lineend.x += ox - nx;
      
      renderLines(linestart, lineend);
      visible = true;
    }


    /**********************
     * PRIVATE
     **********************/
    private function onLoadImageError(e:Event):void {
      spinner.visible = false;
      noImageText.tween("alpha", 1, .2);
    }
    private function onLoadImage(e:Event):void {
      image.tween("alpha", 1, .2);
    }

  }
}
