package away3d.core.render
{
   import away3d.containers.View3D;
   import §away3d:arcane§._containers;
   import §away3d:arcane§._layerDirty;
   import §away3d:arcane§._shape;
   import §away3d:arcane§._shapeActive;
   import §away3d:arcane§._shapeStore;
   import §away3d:arcane§._sprite;
   import §away3d:arcane§._spriteActive;
   import §away3d:arcane§._spriteStore;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.utils.Dictionary;
   
   public class BitmapRenderSession extends AbstractRenderSession
   {
       
      
      private var _bitmapContainers:Dictionary;
      
      private var _container:Sprite;
      
      private var _height:int;
      
      private var _cm:Matrix;
      
      private var _scale:Number;
      
      private var layers:Array;
      
      private var _bitmapContainer:Bitmap;
      
      private var _cx:Number;
      
      private var _cy:Number;
      
      private var _width:int;
      
      private var _layer:DisplayObject;
      
      private var mActive:Array;
      
      private var mStore:Array;
      
      private var _bitmapheight:int;
      
      private var _base:BitmapData;
      
      private var _bitmapwidth:int;
      
      public function BitmapRenderSession(param1:Number = 2)
      {
         this._bitmapContainers = new Dictionary(true);
         this.mStore = new Array();
         this.mActive = new Array();
         this.layers = [];
         super();
         if(this._scale <= 0)
         {
            throw new Error("scale cannot be negative or zero");
         }
         this._scale = param1;
      }
      
      override public function clear(param1:View3D) : void
      {
         super.clear(param1);
         if(updated)
         {
            this._base = this.getBitmapData(param1);
            this._cx = this._bitmapContainer.x = param1.screenClipping.minX;
            this._cy = this._bitmapContainer.y = param1.screenClipping.minY;
            this._bitmapContainer.scaleX = this._scale;
            this._bitmapContainer.scaleY = this._scale;
            this._cm = new Matrix();
            this._cm.scale(1 / this._scale,1 / this._scale);
            this._cm.translate(-param1.screenClipping.minX / this._scale,-param1.screenClipping.minY / this._scale);
            this._base.lock();
            this._base.fillRect(this._base.rect,0);
            this.layers = [];
            _layerDirty = true;
            layer = null;
         }
         if(filters && filters.length || this._bitmapContainer.filters && this._bitmapContainer.filters.length)
         {
            this._bitmapContainer.filters = filters;
         }
         this._bitmapContainer.alpha = Number(alpha) || Number(1);
         this._bitmapContainer.blendMode = blendMode || BlendMode.NORMAL;
      }
      
      override public function addDisplayObject(param1:DisplayObject) : void
      {
         this.layers.push(param1);
         param1.visible = true;
         _layerDirty = true;
      }
      
      override protected function createSprite(param1:Sprite = null) : Sprite
      {
         if(_spriteStore.length)
         {
            _spriteActive.push(_sprite = _spriteStore.pop());
         }
         else
         {
            _spriteActive.push(_sprite = new Sprite());
         }
         if(param1)
         {
            param1.addChild(_sprite);
         }
         else
         {
            this.layers.push(_sprite);
         }
         _layerDirty = true;
         return _sprite;
      }
      
      override public function getContainer(param1:View3D) : DisplayObject
      {
         this._bitmapContainer = this.getBitmapContainer(param1);
         if(!_containers[param1])
         {
            this._container = _containers[param1] = new Sprite();
            this._container.addChild(this._bitmapContainer);
            return this._container;
         }
         return _containers[param1];
      }
      
      override public function render(param1:View3D) : void
      {
         super.render(param1);
         if(updated)
         {
            for each(this._layer in this.layers)
            {
               this._base.draw(this._layer,this._cm,this._layer.transform.colorTransform,this._layer.blendMode,this._base.rect);
            }
            this._base.unlock();
         }
      }
      
      public function getBitmapContainer(param1:View3D) : Bitmap
      {
         if(!this._bitmapContainers[param1])
         {
            return this._bitmapContainers[param1] = new Bitmap();
         }
         return this._bitmapContainers[param1];
      }
      
      override public function clone() : AbstractRenderSession
      {
         return new BitmapRenderSession(this._scale);
      }
      
      public function getBitmapData(param1:View3D) : BitmapData
      {
         this._container = this.getContainer(param1) as Sprite;
         if(!this._bitmapContainer.bitmapData)
         {
            this._bitmapwidth = int((this._width = param1.screenClipping.maxX - param1.screenClipping.minX) / this._scale);
            this._bitmapheight = int((this._height = param1.screenClipping.maxY - param1.screenClipping.minY) / this._scale);
            return this._bitmapContainer.bitmapData = new BitmapData(this._bitmapwidth,this._bitmapheight,true,0);
         }
         return this._bitmapContainer.bitmapData;
      }
      
      override protected function createLayer() : void
      {
         if(_shapeStore.length)
         {
            _shapeActive.push(_shape = _shapeStore.pop());
         }
         else
         {
            _shapeActive.push(_shape = new Shape());
         }
         layer = _shape;
         graphics = _shape.graphics;
         this.layers.push(_shape);
         _layerDirty = false;
      }
   }
}
