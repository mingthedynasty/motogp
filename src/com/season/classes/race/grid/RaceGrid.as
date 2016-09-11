package com.season.classes.race.grid {

  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.utils.*;
  import flash.events.*;
  import flash.text.*;

  import fl.transitions.Tween;
  import fl.transitions.easing.*;	

  import com.season.components.*;
  import com.season.utils.*;
  import com.season.classes.race.*;

  import mylibrary.utils.*;
  import mylibrary.utils.anim.*;

  /**********************
   *
   * RaceGrid
   *
   **********************/
  public class RaceGrid extends TweeningSprite {

    /**********************
     * VARIABLES
     **********************/
    protected var _race:Race;

    protected var pool:ObjectPool;
    protected var _labelPool:ObjectPool;
    private var axis:String;
    private var sizeAxis:String;

    private var lineSpacing:int;
    private var lineCount:int;
    private var lineSize:int;

    private var _size:Number = 10;

    private var tweenGroupShowMoreLines:TweenGroup = new TweenGroup();
    private var tweenGroupShowLessLines:TweenGroup = new TweenGroup();

    protected var _labels:TweeningSprite = new TweeningSprite();
    private var _tweenGroup:TweenGroup = new TweenGroup();

    private var _currLineInfo:Object = {};

    //----//
    public static const GRID_VERT:String = "vert";
    public static const GRID_HORZ:String = "horz";

    public static const CHANGE_SPACING_FINISH:String = "changeSpacingFinish";

    /**********************
     * CONSTRUCTOR
     **********************/
    public function RaceGrid(gridDir:String, labelFormat:TextFormat, race:Race) {
      _race = race;

      var className:String;
      //basic set up
      if (gridDir == GRID_VERT) {
        var vLine:RaceVLine = new RaceVLine(_race.vGrid);
        className = getQualifiedClassName(vLine).split('::').join('.');
        axis = "x"; 
        sizeAxis = "height";
      } else {
        var hLine:HLine = new HLine();
        className = getQualifiedClassName(hLine).split('::').join('.');
        axis = "y";
        sizeAxis = "width";
      }
      pool = new ObjectPool(className, this);

      _labelPool = new TextPool(_labels, labelFormat);

      addChild(_labels);
    }

    /**********************
     * PUBLIC
     **********************/
    public function changeSpacing(count:int, spacing:int, 
                                  lineInfo:Object, animate:Boolean = true,
                                  immediate:Boolean = false):void {  
      lineSpacing = spacing;
      lineCount = count;
      _currLineInfo = lineInfo;

      var line:BaseLine;
      var tween:Tween;
      var activeObjCount:int = pool.getActiveObjectCount();

      if (immediate) {
        pool.returnAllObjects();
        for (var i:int = 0; i < count; i++) {
          line = pool.getObject() as BaseLine;
          line[line.axis] = Math.round(i * spacing);
          line.alpha = 1;
          line.visible = true;
          line.size = this[sizeAxis];
        }
        dispatchEvent(new Event(CHANGE_SPACING_FINISH));
      } else {
        if (count >= activeObjCount) {
          //show more lines
          //  1) squish lines
          //  2) fade in new lines
          for (i = 0; i < activeObjCount; i++) {
            line = pool.getActiveObjectAt(i) as BaseLine;
            tween = line.tween(line.axis, Math.round(i * spacing));
            tweenGroupShowMoreLines.addTween(tween);
          }
          if (activeObjCount == 0) {
            showNewLines(animate);
          } else {
            tweenGroupShowMoreLines.addEventListener(
              EventGroup.GROUP_FINISH, onShowMoreLinesFinish);
          }
        } else {
          //show less lines
          //  1) fade out extra lines
          //  2) unsquish lines
          for (i = count; i < activeObjCount; i++) {
            line = pool.getActiveObjectAt(i) as BaseLine;
            tween = line.tween("alpha", 0);
            tweenGroupShowLessLines.addTween(tween);
          }                
          tweenGroupShowLessLines.addEventListener(
              EventGroup.GROUP_FINISH, onShowLessLinesFinish);
        }
      }
      this.updateLineTypes(lineInfo, !immediate); 
    }
    

    /**********************
     * SETTERS/GETTERS
     **********************/
    override public function set width(ns:Number):void {
      _size = ns;
      updateLineSizes(ns);
    }

    override public function set height(ns:Number):void {
      _size = ns;
      updateLineSizes(ns);
    }

    public function get labels():TweeningSprite {
      return _labels;
    }

    /**********************
     * PROTECTED
     **********************/
    protected function updateLineSizes(newSize:Number):void {
      var line:BaseLine;
      for (var i:int = 0; i < pool.getActiveObjectCount(); i++) {
        line = pool.getActiveObjectAt(i) as BaseLine;
        line.size = newSize;
      }
    }

    /**********************
     * PRIVATE
     **********************/
    private function showNewLines(doTween:Boolean):void {
      var line:BaseLine;
      //fade in the new lines
      var i:int = pool.getActiveObjectCount();

      for(i; i < lineCount; i++) {
        if (axis == "x") {
          line = pool.getObject(_race.vGrid) as BaseLine;
        } else {
          line = pool.getObject() as BaseLine;
        }
        line.size = _size;
        if (doTween) {
          line.alpha = 0;
          line.tween("alpha", 1);
        } else {
          line.alpha = 1;
        }
        line[axis] = Math.round(i * lineSpacing);
      }

      updateLineTypes(_currLineInfo, true);
      dispatchEvent(new Event(CHANGE_SPACING_FINISH));
    }

    //--------//
    private function updateLineTypes(lineInfo:Object, tween:Boolean):void {
      if (!lineInfo) { return; }
      var interval:int = lineInfo.interval;
      var line:BaseLine;
      for(var i:int = 0; i < pool.getActiveObjectCount(); i++) {
        line = pool.getActiveObjectAt(i) as BaseLine;

        if (interval) {
          line.lineType = 
            i%interval ? lineInfo.primaryType : lineInfo.secondaryType;
          line.tween("alpha",
                     i%interval ? lineInfo.primaryAlpha :
                     lineInfo.secondaryAlpha, tween ? .4 : 0);
        } else {
          line.lineType = lineInfo.primaryType;
          line.tween("alpha", lineInfo.primaryAlpha, tween ? .4 : 0);
        }
      }
    }

    /**********************
     * HANDLERS
     **********************/
    private function onShowMoreLinesFinish(e:Event):void {
      showNewLines(true);
    }

    //--------//
    private function onShowLessLinesFinish(e:Event):void {
      var line:BaseLine;
      var toPoolArray:Array = [];
      var activeObjCount:int = pool.getActiveObjectCount();
      
      var i:int = 0;

      //return extra lines to pool
      for (i = lineCount; i < activeObjCount; i++) {        
        line = pool.getActiveObjectAt(i) as BaseLine;
        toPoolArray.push(line);
      }
      
      for (i = 0; i < toPoolArray.length; i++) {
        pool.returnObject(toPoolArray[i]);
      }

      //unsquish remaining lines
      for (i = 0; i < lineCount; i++ ) {
        line = pool.getActiveObjectAt(i) as BaseLine;
        _tweenGroup.addTween(line.tween(line.axis, Math.round(i * lineSpacing)));
      }        

      _tweenGroup.addEventListener(EventGroup.GROUP_FINISH, onUnsquishLines);
      this.updateLineTypes(_currLineInfo, true);
    }

    //--------//
    private function onUnsquishLines(e:Event):void {
      _tweenGroup.removeEventListener(EventGroup.GROUP_FINISH, onUnsquishLines);
      dispatchEvent(new Event(CHANGE_SPACING_FINISH));      
    }
  }
}
