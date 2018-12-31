package away3d.core.clip
{
   import away3d.containers.View3D;
   import away3d.core.base.Object3D;
   import away3d.core.draw.DrawPrimitive;
   import away3d.core.utils.CameraVarsStore;
   import away3d.core.utils.FaceVO;
   import away3d.core.utils.Init;
   import away3d.events.ClippingEvent;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.display.StageAlign;
   import flash.display.StageScaleMode;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   
   public class Clipping extends EventDispatcher
   {
       
      
      private var _view:View3D;
      
      private var _maX:Number;
      
      private var _stageHeight:Number;
      
      private var _stageWidth:Number;
      
      private var _maY:Number;
      
      private var _minY:Number;
      
      private var _minZ:Number;
      
      private var _minX:Number;
      
      var _cameraVarsStore:CameraVarsStore;
      
      private var _clippingClone:Clipping;
      
      private var _zeroPoint:Point;
      
      private var _maxX:Number;
      
      private var _maxY:Number;
      
      private var _maxZ:Number;
      
      protected var ini:Init;
      
      private var _globalPoint:Point;
      
      var _objectCulling:Boolean;
      
      private var _clippingupdated:ClippingEvent;
      
      private var _miX:Number;
      
      private var _miY:Number;
      
      private var _stage:Stage;
      
      public function Clipping(param1:Object = null)
      {
         this._zeroPoint = new Point(0,0);
         super();
         this.ini = Init.parse(param1) as Init;
         this.minX = this.ini.getNumber("minX",-Infinity);
         this.minY = this.ini.getNumber("minY",-Infinity);
         this.minZ = this.ini.getNumber("minZ",-Infinity);
         this.maxX = this.ini.getNumber("maxX",Infinity);
         this.maxY = this.ini.getNumber("maxY",Infinity);
         this.maxZ = this.ini.getNumber("maxZ",Infinity);
      }
      
      public function set minZ(param1:Number) : void
      {
         if(this._minZ == param1)
         {
            return;
         }
         this._minZ = param1;
         this.notifyClippingUpdate();
      }
      
      public function checkFace(param1:FaceVO, param2:Object3D, param3:Array) : void
      {
         param3.push(param1);
      }
      
      public function set minY(param1:Number) : void
      {
         if(this._minY == param1)
         {
            return;
         }
         this._minY = param1;
         this.notifyClippingUpdate();
      }
      
      public function screen(param1:Sprite, param2:Number, param3:Number) : Clipping
      {
         if(!this._clippingClone)
         {
            this._clippingClone = this.clone();
            this._clippingClone.addOnClippingUpdate(this.onScreenUpdate);
         }
         this._stage = param1.stage;
         if(this._stage.scaleMode == StageScaleMode.NO_SCALE)
         {
            this._stageWidth = this._stage.stageWidth;
            this._stageHeight = this._stage.stageHeight;
         }
         else if(this._stage.scaleMode == StageScaleMode.EXACT_FIT)
         {
            this._stageWidth = param2;
            this._stageHeight = param3;
         }
         else if(this._stage.scaleMode == StageScaleMode.SHOW_ALL)
         {
            if(this._stage.stageWidth / param2 < this._stage.stageHeight / param3)
            {
               this._stageWidth = param2;
               this._stageHeight = this._stage.stageHeight * this._stageWidth / this._stage.stageWidth;
            }
            else
            {
               this._stageHeight = param3;
               this._stageWidth = this._stage.stageWidth * this._stageHeight / this._stage.stageHeight;
            }
         }
         else if(this._stage.scaleMode == StageScaleMode.NO_BORDER)
         {
            if(this._stage.stageWidth / param2 > this._stage.stageHeight / param3)
            {
               this._stageWidth = param2;
               this._stageHeight = this._stage.stageHeight * this._stageWidth / this._stage.stageWidth;
            }
            else
            {
               this._stageHeight = param3;
               this._stageWidth = this._stage.stageWidth * this._stageHeight / this._stage.stageHeight;
            }
         }
         switch(this._stage.align)
         {
            case StageAlign.TOP_LEFT:
               this._zeroPoint.x = 0;
               this._zeroPoint.y = 0;
               this._globalPoint = param1.globalToLocal(this._zeroPoint);
               this._maX = (this._miX = this._globalPoint.x) + this._stageWidth;
               this._maY = (this._miY = this._globalPoint.y) + this._stageHeight;
               break;
            case StageAlign.TOP_RIGHT:
               this._zeroPoint.x = param2;
               this._zeroPoint.y = 0;
               this._globalPoint = param1.globalToLocal(this._zeroPoint);
               this._miX = (this._maX = this._globalPoint.x) - this._stageWidth;
               this._maY = (this._miY = this._globalPoint.y) + this._stageHeight;
               break;
            case StageAlign.BOTTOM_LEFT:
               this._zeroPoint.x = 0;
               this._zeroPoint.y = param3;
               this._globalPoint = param1.globalToLocal(this._zeroPoint);
               this._maX = (this._miX = this._globalPoint.x) + this._stageWidth;
               this._miY = (this._maY = this._globalPoint.y) - this._stageHeight;
               break;
            case StageAlign.BOTTOM_RIGHT:
               this._zeroPoint.x = param2;
               this._zeroPoint.y = param3;
               this._globalPoint = param1.globalToLocal(this._zeroPoint);
               this._miX = (this._maX = this._globalPoint.x) - this._stageWidth;
               this._miY = (this._maY = this._globalPoint.y) - this._stageHeight;
               break;
            case StageAlign.TOP:
               this._zeroPoint.x = param2 / 2;
               this._zeroPoint.y = 0;
               this._globalPoint = param1.globalToLocal(this._zeroPoint);
               this._miX = this._globalPoint.x - this._stageWidth / 2;
               this._maX = this._globalPoint.x + this._stageWidth / 2;
               this._maY = (this._miY = this._globalPoint.y) + this._stageHeight;
               break;
            case StageAlign.BOTTOM:
               this._zeroPoint.x = param2 / 2;
               this._zeroPoint.y = param3;
               this._globalPoint = param1.globalToLocal(this._zeroPoint);
               this._miX = this._globalPoint.x - this._stageWidth / 2;
               this._maX = this._globalPoint.x + this._stageWidth / 2;
               this._miY = (this._maY = this._globalPoint.y) - this._stageHeight;
               break;
            case StageAlign.LEFT:
               this._zeroPoint.x = 0;
               this._zeroPoint.y = param3 / 2;
               this._globalPoint = param1.globalToLocal(this._zeroPoint);
               this._maX = (this._miX = this._globalPoint.x) + this._stageWidth;
               this._miY = this._globalPoint.y - this._stageHeight / 2;
               this._maY = this._globalPoint.y + this._stageHeight / 2;
               break;
            case StageAlign.RIGHT:
               this._zeroPoint.x = param2;
               this._zeroPoint.y = param3 / 2;
               this._globalPoint = param1.globalToLocal(this._zeroPoint);
               this._miX = (this._maX = this._globalPoint.x) - this._stageWidth;
               this._miY = this._globalPoint.y - this._stageHeight / 2;
               this._maY = this._globalPoint.y + this._stageHeight / 2;
               break;
            default:
               this._zeroPoint.x = param2 / 2;
               this._zeroPoint.y = param3 / 2;
               this._globalPoint = param1.globalToLocal(this._zeroPoint);
               this._miX = this._globalPoint.x - this._stageWidth / 2;
               this._maX = this._globalPoint.x + this._stageWidth / 2;
               this._miY = this._globalPoint.y - this._stageHeight / 2;
               this._maY = this._globalPoint.y + this._stageHeight / 2;
         }
         if(this.minX == -Infinity)
         {
            this._clippingClone.minX = this._miX;
         }
         else
         {
            this._clippingClone.minX = this._minX;
         }
         if(this.maxX == Infinity)
         {
            this._clippingClone.maxX = this._maX;
         }
         else
         {
            this._clippingClone.maxX = this._maxX;
         }
         if(this.minY == -Infinity)
         {
            this._clippingClone.minY = this._miY;
         }
         else
         {
            this._clippingClone.minY = this._minY;
         }
         if(this.maxY == Infinity)
         {
            this._clippingClone.maxY = this._maY;
         }
         else
         {
            this._clippingClone.maxY = this._maxY;
         }
         this._clippingClone.minZ = this._minZ;
         this._clippingClone.maxZ = this._maxZ;
         this._clippingClone.objectCulling = this._objectCulling;
         return this._clippingClone;
      }
      
      public function set minX(param1:Number) : void
      {
         if(this._minX == param1)
         {
            return;
         }
         this._minX = param1;
         this.notifyClippingUpdate();
      }
      
      public function removeOnClippingUpdate(param1:Function) : void
      {
         removeEventListener(ClippingEvent.CLIPPING_UPDATED,param1,false);
      }
      
      public function get view() : View3D
      {
         return this._view;
      }
      
      public function addOnClippingUpdate(param1:Function) : void
      {
         addEventListener(ClippingEvent.CLIPPING_UPDATED,param1,false,0,false);
      }
      
      override public function toString() : String
      {
         return "{minX:" + this.minX + " maxX:" + this.maxX + " minY:" + this.minY + " maxY:" + this.maxY + " minZ:" + this.minZ + " maxZ:" + this.maxZ + "}";
      }
      
      public function checkPrimitive(param1:DrawPrimitive) : Boolean
      {
         return true;
      }
      
      public function get minX() : Number
      {
         return this._minX;
      }
      
      public function get minY() : Number
      {
         return this._minY;
      }
      
      public function get minZ() : Number
      {
         return this._minZ;
      }
      
      public function set view(param1:View3D) : void
      {
         this._view = param1;
         this._cameraVarsStore = this.view.cameraVarsStore;
      }
      
      private function onScreenUpdate(param1:ClippingEvent) : void
      {
         dispatchEvent(param1);
      }
      
      public function clone(param1:Clipping = null) : Clipping
      {
         var _loc2_:Clipping = param1 || new Clipping();
         _loc2_.minX = this.minX;
         _loc2_.minY = this.minY;
         _loc2_.minZ = this.minZ;
         _loc2_.maxX = this.maxX;
         _loc2_.maxY = this.maxY;
         _loc2_.maxZ = this.maxZ;
         _loc2_.objectCulling = this.objectCulling;
         _loc2_._cameraVarsStore = this._cameraVarsStore;
         return _loc2_;
      }
      
      private function notifyClippingUpdate() : void
      {
         if(!hasEventListener(ClippingEvent.CLIPPING_UPDATED))
         {
            return;
         }
         if(this._clippingupdated == null)
         {
            this._clippingupdated = new ClippingEvent(ClippingEvent.CLIPPING_UPDATED,this);
         }
         dispatchEvent(this._clippingupdated);
      }
      
      public function set maxX(param1:Number) : void
      {
         if(this._maxX == param1)
         {
            return;
         }
         this._maxX = param1;
         this.notifyClippingUpdate();
      }
      
      public function set objectCulling(param1:Boolean) : void
      {
         this._objectCulling = param1;
      }
      
      public function set maxY(param1:Number) : void
      {
         if(this._maxY == param1)
         {
            return;
         }
         this._maxY = param1;
         this.notifyClippingUpdate();
      }
      
      public function set maxZ(param1:Number) : void
      {
         if(this._maxZ == param1)
         {
            return;
         }
         this._maxZ = param1;
         this.notifyClippingUpdate();
      }
      
      public function get objectCulling() : Boolean
      {
         return this._objectCulling;
      }
      
      public function rect(param1:Number, param2:Number, param3:Number, param4:Number) : Boolean
      {
         if(this.maxX < param1)
         {
            return false;
         }
         if(this.minX > param3)
         {
            return false;
         }
         if(this.maxY < param2)
         {
            return false;
         }
         if(this.minY > param4)
         {
            return false;
         }
         return true;
      }
      
      public function get maxY() : Number
      {
         return this._maxY;
      }
      
      public function get maxZ() : Number
      {
         return this._maxZ;
      }
      
      public function get maxX() : Number
      {
         return this._maxX;
      }
   }
}
