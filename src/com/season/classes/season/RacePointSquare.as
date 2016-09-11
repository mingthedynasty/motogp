package com.season.classes.season {

  import caurina.transitions.Tweener;
  
  import com.season.*;
  import com.season.classes.tooltip.*;
  import com.season.models.*;
  import com.season.utils.*;
  
  import fl.transitions.Tween;
  import fl.transitions.easing.*;
  
  import flash.display.Sprite;
  import flash.events.*;
  
  import mylibrary.utils.*;

  /**********************
   *
   * RacePointSquare
   *
   **********************/
  public class RacePointSquare extends SizingSprite {

    /**********************
     * VARIABLES
     **********************/
    private var _model:RiderStandingModel;
	private var _season : Season;
	
    private var initY:int = 0;

    private var ptSize:int;
    private var tweenX:Tween;
    private var tweenY:Tween;
    private var tweenW:Tween;
    private var tweenH:Tween;

    private var tweenGroupHide:TweenGroup = new TweenGroup();

    //--------


    /**********************
     * CONSTRUCTOR
     **********************/
    public function RacePointSquare( season : Season ) {
      buttonMode = true;
      mouseChildren = false;

	  _season = season;
	  
      //tweens
      /*tweenX = new Tween(this, "x", Regular.easeInOut, 0, 0, .4, true);
      tweenX.stop();
      tweenY = new Tween(this, "y", Regular.easeInOut, 0, 0, .4, true);      
      tweenY.stop();
      tweenW = new Tween(this, "width", Regular.easeInOut, 0, 0, .4, true);
      tweenW.stop();  
      tweenH = new Tween(this, "height", Regular.easeInOut, 0, 0, .4, true);
      tweenH.stop(); */ 

      //events
      addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
      addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
    }


    /**********************
     * SETTERS/GETTERS
     **********************/
    public function set model(newModel:RiderStandingModel):void {
      _model = newModel;

      //init vars
      ptSize = Math.round(_model.racePoints * _season.hGrid.scaleFactor );//Season.POINT_SIZE_FACTOR);

	  //draw
	  graphics.clear();
	  if (_model.racePoints) {
		  graphics.beginFill(0x777777, 1);
		  graphics.drawRect(-1, -1, 22, ptSize + 2);
		  
		  //graphics.beginFill(_model.riderModel.colorTeam, .5);
		  //graphics.drawRect(-1, -1, 22, ptSize + 2);//20, ptSize - 1);
		  
		  graphics.beginFill(_model.riderModel.colorTeam, 1);
		  graphics.drawRect(0, 0, 20, ptSize);//20, ptSize - 1);
	  } else {
		  graphics.beginFill(0x777777, 1);
		  graphics.drawRect(-1, -1, 22, 1 + 2);
		  
		  graphics.beginFill(0xFFFFFF, 1);
		  graphics.drawRect(0, 0, 20, 1);//20, ptSize - 1);
		  
		  graphics.beginFill(_model.riderModel.colorTeam, 1);
		  var dotCount : int = 20/2;
		  for (var i : int = 0; i < dotCount; i++) {
			  graphics.drawRect (i * 2 + 1, 0, 1, 1);
		  }
	  }
	  graphics.endFill();
	  
	  /*
      //draw
      graphics.clear();
      graphics.beginFill(_model.riderModel.colorTeam, 1);
      graphics.drawRect(0, 0, 20, ptSize - 1);
      graphics.endFill();
	  */
    }

    public function get model():RiderStandingModel {
      return _model;
    }

    public function set initialY(ny:int):void {
      initY = ny;
    }
    public function get initialY():int {
      return initY;
    }
    public function get sizeHeight():int {
      return ptSize;
    }

    override public function setSize(w:Number, h:Number):void {
      super.setSize(w, h);
      //draw
      graphics.clear();
      graphics.beginFill(_model.riderModel.colorTeam, 1);
      graphics.drawRect(0, 0, w, h - 1);
      graphics.endFill();
    }

    /**********************
     * PUBLIC
     **********************/
    public function showSquare():void {
      if (width == RiderSeasonBar.BAR_WIDTH) {
        return;
      }
      var half = Math.round(ptSize/2);
      width = 0;
      x = RiderSeasonBar.BAR_WIDTH/2;
      y = initialY + half;

      Tweener.addTween(this,
        {width: RiderSeasonBar.BAR_WIDTH, height: ptSize, x: 0, y: initY, 
        time: .5, transition: "easeInOutCubic"});
    }

    public function hideSquare(callback:Function):void {
      var half = Math.round(ptSize/2);

      Tweener.addTween(this,
      {width: 0, height: 0, x: RiderSeasonBar.BAR_WIDTH/2, y: initY + half, 
                time: .5, transition: "easeInOutCubic", onComplete: callback});
    }

    /**********************/
    public function shift(nx:int):Tween {
      return tweenX;
      tweenX.begin = x;
      tweenX.finish = nx;
      tweenX.start();
      return tweenX;
    }

    /**********************/
    public function show(nx:int):Tween { 

      if (width == RiderSeasonBar.BAR_WIDTH) {
        return tweenY;
      }
      //return tweenY;
      var half = Math.round(ptSize/2);
      width = 0;
      x = nx + half;
      y = initY + half;

      tweenW.begin = width;
      tweenW.finish = RiderSeasonBar.BAR_WIDTH;
      tweenW.start();

      tweenH.begin = width;
      tweenH.finish = ptSize;
      tweenH.start();

      tweenX.begin = x;
      tweenX.finish = nx;
      tweenX.start();

      tweenY.begin = y;
      tweenY.finish = initY;
      tweenY.start();

      visible = true;

      return tweenY;
    }

    /**********************/
    public function hide():Tween {

      var half = Math.round(ptSize/2);

      tweenGroupHide.addTween(tweenW);
      tweenGroupHide.addTween(tweenH);
      tweenGroupHide.addTween(tweenX);
      tweenGroupHide.addTween(tweenY);

      tweenGroupHide.addEventListener(EventGroup.GROUP_FINISH, onHideFinish);

      //do tweens
      tweenW.begin = width;
      tweenW.finish = 0;
      tweenW.start();

      tweenH.begin = height;
      tweenH.finish = 0;
      tweenH.start();
      
      tweenX.begin = x;
      tweenX.finish = 10;//x + half;
      tweenX.start();

      tweenY.begin = y;
      tweenY.finish = y + half;
      tweenY.start();
      
      return tweenY;
    }

    /**********************
     * HANDLERS
     **********************/
    private function onHideFinish(e:Event) {
      visible = false;
    }

    /**********************/
    private function onMouseOver(e:MouseEvent):void {
      RiderRaceTooltip.getInstance().show(this);
	  dispatchEvent (new RacePointSquareEvent (RacePointSquareEvent.OVER, 
		  _model.riderModel.riderNum));
    }
    private function onMouseOut(e:MouseEvent):void {
      RiderRaceTooltip.getInstance().hide();
	  dispatchEvent (new RacePointSquareEvent (RacePointSquareEvent.OUT, 
		  _model.riderModel.riderNum));
    }
  }
}
