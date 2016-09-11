package com.season.classes.tooltip {

  import flash.display.*;
  import flash.geom.*;
  import flash.text.*;

  import com.season.utils.*;

  /**********************
   *
   * Tooltip
   *
   **********************/
  public class Tooltip extends Sprite {

    /**********************
     * VARIABLES
     **********************/
    protected var refView:DisplayObject;

    protected var contents:Sprite = new Sprite();
    protected var labels:Sprite = new Sprite();
    protected var values:Sprite = new Sprite();
    protected var background:Sprite = new Sprite();
    protected var footer:Sprite = new Sprite();
    protected var lines:Sprite = new Sprite();

    protected var labelTextStyle:TextFormat;
    protected var valueTextStyle:TextFormat;
    protected var footerTextStyle:TextFormat;

    protected var xBuffer:int = 19;
    protected var yBuffer:int = 15;

    /**********************
     * CONSTRUCTOR
     **********************/
    public function Tooltip() {
      visible = false;

      addChild(background);
      addChild(lines);
      addChild(footer);

      addChild(contents);
      contents.addChild(labels);
      contents.addChild(values);

      contents.x = xBuffer;
      contents.y = yBuffer;

      labelTextStyle = 
        TextFactory.createTextFormat(TextStyle.PLAIN, 0x555555);
      valueTextStyle = 
        TextFactory.createTextFormat(TextStyle.BOLD, 0x444444);
      footerTextStyle = 
        TextFactory.createTextFormat(TextStyle.PLAIN, 0xAAAAAA);

      mouseEnabled = false;
      mouseChildren = false;
    }

    /**********************
     * PUBLIC
     **********************/
    public function show(ref:DisplayObject):void {
      background.graphics.clear();

      var w = contents.width + 2 * xBuffer;// + labels.x;
      var h = contents.height + 2 * yBuffer;
      if (footer.numChildren && footer.visible) {
        h = contents.height + (1.5 * yBuffer) + footer.height;
        footer.x = w - footer.width;
        footer.y = h - footer.height;
      }

      //background
      background.graphics.beginFill(0xF3F3F3, .9);
      background.graphics.drawRect(0, 0, w, h);
      background.graphics.endFill();

      //border
      background.graphics.lineStyle(1, 0x666666);
      background.graphics.drawRect(0, 0, w, h);

      refView = ref;
      visible = true;
    }

    //--------//
    public function hide():void {
      visible = false;
    }

    /**********************
     * PROTECTED
     **********************/
    protected function initLabel(label:String):TextField {
      var field = TextFactory.createText(labelTextStyle);
      labels.addChild(field);
      field.text = label;
      return field;
    }

    //--------//
    protected function initValue(w:int = 0):TextField {
      var field;
      if (w > 0) {
        field = TextFactory.createText(valueTextStyle, true);
        field.width = w;
      } else {
        field = TextFactory.createText(valueTextStyle);
      }
      values.addChild(field);
      return field;
    }

    //--------//
    protected function initFooter():TextField {
      var field = TextFactory.createText(footerTextStyle);
      footer.addChild(field);
      return field;
    }

    //--------//
    protected function finishShow(xoff:int, yoff:int, 
                                  linestart:Point, lineend:Point) {      
      var globalPt = refView.localToGlobal(new Point(0, 0));
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

    //--------//
    protected function renderLines(linestart:Point, lineend:Point):void {
      lines.graphics.clear();

      //dot
      lines.graphics.beginFill(0x666666, 1);
      lines.graphics.drawCircle(lineend.x, lineend.y, 3);
      lines.graphics.endFill();

      //lines
      lines.graphics.lineStyle(1, 0x666666);
      lines.graphics.moveTo(linestart.x, linestart.y);
      lines.graphics.lineTo(lineend.x, linestart.y);
      lines.graphics.lineTo(lineend.x, lineend.y);

    }

    //--------//
    protected function layoutItems():void {
      var ny:int = 0;

      //layout main area
      for (var i:int = 0; i < values.numChildren; i++) {
        var value:DisplayObject = values.getChildAt(i);
        var label:DisplayObject = labels.getChildAt(i);

        value.y = ny;
        label.y = ny;

        ny += value.height + 1;
      }

      //layout footer
      ny = 0;
      var text:DisplayObject;
      var maxWidth:Number = 0;
      for (i = 0; i < footer.numChildren; i++) {
        text = footer.getChildAt(i);
        if (text.width > maxWidth) { maxWidth = text.width }
      }
      for (i = 0; i < footer.numChildren; i++) {
        text = footer.getChildAt(i);
        text.x = maxWidth - text.width;
        text.y = ny;
        ny += text.height -4;
      }
    }
  }
}
