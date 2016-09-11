package com.season.classes.race {

  import flash.display.*;
  import flash.text.*;
  import flash.text.TextField;
  import flash.text.TextFormat;

  import com.season.utils.*;
  import com.season.models.*;

  import mylibrary.utils.anim.*;

  /**********************
   *
   * PodiumOutline
   *
   **********************/
  public class PodiumOutline extends TweeningSprite {

    /**********************
     * VARIABLES
     **********************/
    private var _outline:Sprite = new Sprite();
    private var _podiumText:TextField;
    
    private static const PADDING:Number = 13;
    private static const LINE_WIDTH:Number = 15;


    /**********************
     * CONSTRUCTOR
     **********************/
    public function PodiumOutline() {
      //text
      var format:TextFormat = 
        TextFactory.createTextFormat(TextStyle.PLAIN, 0xDDDDDD);
      _podiumText = TextFactory.createText(format);

      addChild(_podiumText);
      _podiumText.text = "PODIUM";
      _podiumText.rotation = 270;

      //outline
      addChild(_outline);

      mouseEnabled = false;
      mouseChildren = false;
    }

    /**********************
     * PUBLIC
     **********************/
    public function update():void {
      _outline.graphics.clear();

      //outline
      var contentsWidth:Number = 
        (RaceModel.getInstance().lapCount - 1) * Race.GRID_X_SPACING;
      var contentsHeight:Number = 2 * Race.GRID_Y_SPACING;

      _outline.graphics.lineStyle(1, 0xDDDDDD, 1, true, 
                                  LineScaleMode.NORMAL, null, 
                                  JointStyle.MITER );
      _outline.graphics.drawRect(-PADDING, 
                                 -PADDING, 
                                 contentsWidth + 2 * PADDING, 
                                 contentsHeight + 2 * PADDING);      

      _outline.graphics.moveTo(contentsWidth + PADDING, 
                               Math.round(contentsHeight/2));
      _outline.graphics.lineTo(contentsWidth + PADDING + LINE_WIDTH,
                               Math.round(contentsHeight/2));

      //text
      _podiumText.x = contentsWidth + PADDING + LINE_WIDTH;
      _podiumText.y = 
        Math.round((contentsHeight - _podiumText.height)/2) + _podiumText.height;

    }
  }
}
