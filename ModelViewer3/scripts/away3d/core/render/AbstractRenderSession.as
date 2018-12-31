package away3d.core.render
{
   import away3d.containers.View3D;
   import away3d.core.base.Object3D;
   import away3d.core.clip.Clipping;
   import away3d.core.draw.DrawPrimitive;
   import away3d.core.draw.DrawScaledBitmap;
   import away3d.core.draw.DrawTriangle;
   import away3d.core.draw.IPrimitiveConsumer;
   import away3d.core.draw.ScreenVertex;
   import away3d.events.Object3DEvent;
   import away3d.events.SessionEvent;
   import away3d.materials.ILayerMaterial;
   import away3d.materials.IMaterial;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.GraphicsBitmapFill;
   import flash.display.GraphicsEndFill;
   import flash.display.GraphicsTrianglePath;
   import flash.display.IGraphicsData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.utils.Dictionary;
   
   public class AbstractRenderSession extends EventDispatcher
   {
       
      
      public var filters:Array;
      
      public var consumer:IPrimitiveConsumer;
      
      private var b2:Number;
      
      var _spriteActive:Array;
      
      private var drawing:Vector.<IGraphicsData>;
      
      private var _renderer:IPrimitiveConsumer;
      
      private var path:GraphicsTrianglePath;
      
      private var triangle:DrawTriangle;
      
      private var _shapeActives:Dictionary;
      
      private var materials:Dictionary;
      
      private var c2:Number;
      
      var _renderSource:Object3D;
      
      private var _dictionary:Dictionary;
      
      private var v0x:Number;
      
      private var v0y:Number;
      
      private var _spriteLayers:Dictionary;
      
      var _shapeActive:Array;
      
      public var layer:DisplayObject;
      
      private var _consumer:IPrimitiveConsumer;
      
      private var _session:AbstractRenderSession;
      
      private var _array:Array;
      
      var _spriteStore:Array;
      
      private var v1y:Number;
      
      var _shapeStore:Array;
      
      private var a:Number;
      
      private var c:Number;
      
      private var d:Number;
      
      private var d2:Number;
      
      private var b:Number;
      
      private var m:Matrix;
      
      protected var i:int;
      
      public var primitives:Array;
      
      private var v1x:Number;
      
      private var v2x:Number;
      
      private var v2y:Number;
      
      public var alpha:Number = 1;
      
      private var fill:GraphicsBitmapFill;
      
      private var _shapeLayers:Dictionary;
      
      var _level:int = -1;
      
      var _material:IMaterial;
      
      private var _sessionupdated:SessionEvent;
      
      private var area:Number;
      
      public var priconsumers:Dictionary;
      
      private var ds:DisplayObject;
      
      private var _renderers:Dictionary;
      
      public var graphics:Graphics;
      
      private var tx:Number;
      
      private var ty:Number;
      
      public var screenZ:Number;
      
      public var sessions:Array;
      
      var _layerDirty:Boolean;
      
      var _shape:Shape;
      
      public var blendMode:String;
      
      private var _lightShapeLayer:Dictionary;
      
      private var _spriteActives:Dictionary;
      
      private var _lightShapeLayers:Dictionary;
      
      var _containers:Dictionary;
      
      private var _spriteStores:Dictionary;
      
      public var parent:AbstractRenderSession;
      
      public var updated:Boolean;
      
      private var _spriteLayer:Dictionary;
      
      private var _shapeLayer:Dictionary;
      
      private var time:int;
      
      private var end:GraphicsEndFill;
      
      var _sprite:Sprite;
      
      private var primitive:DrawPrimitive;
      
      private var _defaultColorTransform:ColorTransform;
      
      private var a2:Number;
      
      private var _shapeStores:Dictionary;
      
      private var _layerGraphics:Graphics;
      
      public function AbstractRenderSession()
      {
         this._containers = new Dictionary(true);
         this._shapeStores = new Dictionary(true);
         this._shapeActives = new Dictionary(true);
         this._spriteStores = new Dictionary(true);
         this._spriteActives = new Dictionary(true);
         this._spriteLayers = new Dictionary(true);
         this._shapeLayers = new Dictionary(true);
         this._lightShapeLayers = new Dictionary(true);
         this._defaultColorTransform = new ColorTransform();
         this.fill = new GraphicsBitmapFill();
         this.path = new GraphicsTrianglePath(new Vector.<Number>(3),null,new Vector.<Number>(3));
         this.end = new GraphicsEndFill();
         this.drawing = Vector.<IGraphicsData>([this.fill,this.path,this.end]);
         this._renderers = new Dictionary(true);
         this.m = new Matrix();
         this.priconsumers = new Dictionary(true);
         super();
      }
      
      public function addOnSessionUpdate(param1:Function) : void
      {
         addEventListener(SessionEvent.SESSION_UPDATED,param1,false,0,false);
      }
      
      public function renderFogColor(param1:Clipping, param2:int, param3:Number) : void
      {
         if(this._layerDirty)
         {
            this.createLayer();
         }
         this.graphics.lineStyle();
         this.graphics.beginFill(param2,param3);
         this.graphics.drawRect(param1.minX,param1.minY,param1.maxX - param1.minX,param1.maxY - param1.minY);
         this.graphics.endFill();
      }
      
      public function addChildSession(param1:AbstractRenderSession) : void
      {
         if(this.sessions.indexOf(param1) != -1)
         {
            return;
         }
         this.sessions.push(param1);
         param1.addOnSessionUpdate(this.onSessionUpdate);
         param1.parent = this;
      }
      
      protected function createShape(param1:Sprite) : Shape
      {
         if(this._shapeStore.length)
         {
            this._shapeActive.push(this._shape = this._shapeStore.pop());
         }
         else
         {
            this._shapeActive.push(this._shape = new Shape());
         }
         param1.addChild(this._shape);
         this._layerDirty = true;
         return this._shape;
      }
      
      public function getShapeLayer(param1:View3D) : Dictionary
      {
         if(!this._shapeLayers[param1])
         {
            return this._shapeLayers[param1] = new Dictionary(true);
         }
         return this._shapeLayers[param1];
      }
      
      function internalAddSceneSession(param1:AbstractRenderSession) : void
      {
         this.sessions = [param1];
         param1.addOnSessionUpdate(this.onSessionUpdate);
      }
      
      public function renderTriangleBitmapMask(param1:BitmapData, param2:Number, param3:Number, param4:Number, param5:ScreenVertex, param6:ScreenVertex, param7:ScreenVertex, param8:Boolean, param9:Boolean, param10:Graphics = null) : void
      {
         if(this._layerDirty)
         {
            this.createLayer();
         }
         this.a2 = (this.v1x = param6.x) - (this.v0x = param5.x);
         this.b2 = (this.v1y = param6.y) - (this.v0y = param5.y);
         this.c2 = (this.v2x = param7.x) - this.v0x;
         this.d2 = (this.v2y = param7.y) - this.v0y;
         this.m.identity();
         this.m.scale(param4,param4);
         this.m.translate(param2,param3);
         if(param10)
         {
            param10.lineStyle();
            param10.moveTo(this.v0x,this.v0y);
            param10.beginBitmapFill(param1,this.m,param9,param8 && this.v0x * (this.d2 - this.b2) - this.v1x * this.d2 + this.v2x * this.b2 > 400);
            param10.lineTo(this.v1x,this.v1y);
            param10.lineTo(this.v2x,this.v2y);
            param10.endFill();
         }
         else
         {
            this.graphics.lineStyle();
            this.graphics.moveTo(this.v0x,this.v0y);
            this.graphics.beginBitmapFill(param1,this.m,param9,param8 && this.v0x * (this.d2 - this.b2) - this.v1x * this.d2 + this.v2x * this.b2 > 400);
            this.graphics.lineTo(this.v1x,this.v1y);
            this.graphics.lineTo(this.v2x,this.v2y);
            this.graphics.endFill();
         }
      }
      
      function notifySessionUpdate() : void
      {
         if(!hasEventListener(SessionEvent.SESSION_UPDATED))
         {
            return;
         }
         if(!this._sessionupdated)
         {
            this._sessionupdated = new SessionEvent(SessionEvent.SESSION_UPDATED,this);
         }
         dispatchEvent(this._sessionupdated);
      }
      
      public function renderTriangleBitmapF10(param1:BitmapData, param2:Vector.<Number>, param3:Vector.<Number>, param4:Boolean, param5:Boolean, param6:Graphics = null) : void
      {
         if(!param6 && this._layerDirty)
         {
            this.createLayer();
         }
         this.fill.bitmapData = param1;
         this.fill.repeat = param5;
         this.fill.smooth = param4;
         this.path.vertices = param2;
         this.path.uvtData = param3;
         if(param6)
         {
            param6.lineStyle();
            param6.drawGraphicsData(this.drawing);
         }
         else
         {
            this.graphics.lineStyle();
            this.graphics.drawGraphicsData(this.drawing);
         }
      }
      
      public function clearRenderers() : void
      {
         this._renderers = new Dictionary(true);
      }
      
      public function renderTriangleColor(param1:int, param2:Number, param3:ScreenVertex, param4:ScreenVertex, param5:ScreenVertex, param6:Graphics = null) : void
      {
         if(!param6 && this._layerDirty)
         {
            this.createLayer();
         }
         if(param6)
         {
            param6.lineStyle();
            param6.moveTo(param3.x,param3.y);
            param6.beginFill(param1,param2);
            param6.lineTo(param4.x,param4.y);
            param6.lineTo(param5.x,param5.y);
            param6.endFill();
         }
         else
         {
            this.graphics.lineStyle();
            this.graphics.moveTo(param3.x,param3.y);
            this.graphics.beginFill(param1,param2);
            this.graphics.lineTo(param4.x,param4.y);
            this.graphics.lineTo(param5.x,param5.y);
            this.graphics.endFill();
         }
      }
      
      public function clear(param1:View3D) : void
      {
         this.updated = param1.updated || param1.forceUpdate || param1.scene.updatedSessions[this];
         for each(this._session in this.sessions)
         {
            this._session.clear(param1);
         }
         if(this.updated)
         {
            this._consumer = this.getConsumer(param1);
            this._spriteLayer = this.getSpriteLayer(param1);
            for each(this._array in this._spriteLayer)
            {
               this._array.length = 0;
            }
            this._shapeLayer = this.getShapeLayer(param1);
            for each(this._array in this._shapeLayer)
            {
               this._array.length = 0;
            }
            this._lightShapeLayer = this.getLightShapeLayer(param1);
            for each(this._dictionary in this._lightShapeLayer)
            {
               for each(this._array in this._dictionary)
               {
                  this._array.length = 0;
               }
            }
            this._level = -1;
            this._shapeStore = this.getShapeStore(param1);
            this._shapeActive = this.getShapeActive(param1);
            this.i = this._shapeActive.length;
            while(true)
            {
               if(!this.i--)
               {
                  break;
               }
               this._shape = this._shapeActive.pop();
               this._shape.graphics.clear();
               this._shape.filters = [];
               this._shape.blendMode = BlendMode.NORMAL;
               this._shape.transform.colorTransform = this._defaultColorTransform;
               this._shapeStore.push(this._shape);
            }
            this._spriteStore = this.getSpriteStore(param1);
            this._spriteActive = this.getSpriteActive(param1);
            this.i = this._spriteActive.length;
            while(true)
            {
               if(!this.i--)
               {
                  break;
               }
               this._sprite = this._spriteActive.pop();
               this._sprite.graphics.clear();
               this._sprite.filters = [];
               while(this._sprite.numChildren)
               {
                  this._sprite.removeChildAt(0);
               }
               this._spriteStore.push(this._sprite);
            }
            this._consumer.clear(param1);
         }
      }
      
      public function getSpriteLayer(param1:View3D) : Dictionary
      {
         if(!this._spriteLayers[param1])
         {
            return this._spriteLayers[param1] = new Dictionary(true);
         }
         return this._spriteLayers[param1];
      }
      
      protected function onSessionUpdate(param1:SessionEvent) : void
      {
         dispatchEvent(param1);
      }
      
      public function renderBitmap(param1:BitmapData, param2:ScreenVertex, param3:Boolean = false) : void
      {
         if(this._layerDirty)
         {
            this.createLayer();
         }
         this.m.identity();
         this.m.tx = param2.x - param1.width / 2;
         this.m.ty = param2.y - param1.height / 2;
         this.graphics.lineStyle();
         this.graphics.beginBitmapFill(param1,this.m,false,param3);
         this.graphics.drawRect(param2.x - param1.width / 2,param2.y - param1.height / 2,param1.width,param1.height);
         this.graphics.endFill();
      }
      
      public function getConsumer(param1:View3D) : IPrimitiveConsumer
      {
         if(this._renderers[param1])
         {
            return this._renderers[param1];
         }
         if(this._renderer)
         {
            return this._renderers[param1] = this._renderer.clone();
         }
         if(this.parent)
         {
            return this._renderers[param1] = this.parent.getConsumer(param1).clone();
         }
         return this._renderers[param1] = (param1.session.renderer as IPrimitiveConsumer).clone();
      }
      
      public function clone() : AbstractRenderSession
      {
         throw new Error("Not implemented");
      }
      
      public function removeOnSessionUpdate(param1:Function) : void
      {
         removeEventListener(SessionEvent.SESSION_UPDATED,param1,false);
      }
      
      public function addDisplayObject(param1:DisplayObject) : void
      {
         throw new Error("Not implemented");
      }
      
      public function set renderer(param1:IPrimitiveConsumer) : void
      {
         if(this._renderer == param1)
         {
            return;
         }
         this._renderer = param1;
         this.clearRenderers();
         for each(this._session in this.sessions)
         {
            this._session.clearRenderers();
         }
      }
      
      public function removeChildSession(param1:AbstractRenderSession) : void
      {
         param1.removeOnSessionUpdate(this.onSessionUpdate);
         var _loc2_:int = this.sessions.indexOf(param1);
         if(_loc2_ == -1)
         {
            return;
         }
         this.sessions.splice(_loc2_,1);
      }
      
      public function renderTriangleLineFill(param1:Number, param2:int, param3:Number, param4:int, param5:Number, param6:ScreenVertex, param7:ScreenVertex, param8:ScreenVertex) : void
      {
         if(this._layerDirty)
         {
            this.createLayer();
         }
         if(param5 > 0)
         {
            this.graphics.lineStyle(param1,param4,param5);
         }
         else
         {
            this.graphics.lineStyle();
         }
         this.graphics.moveTo(param6.x,param6.y);
         if(param3 > 0)
         {
            this.graphics.beginFill(param2,param3);
         }
         this.graphics.lineTo(param7.x,param7.y);
         this.graphics.lineTo(param8.x,param8.y);
         if(param5 > 0)
         {
            this.graphics.lineTo(param6.x,param6.y);
         }
         if(param3 > 0)
         {
            this.graphics.endFill();
         }
      }
      
      public function clearChildSessions() : void
      {
         for each(this._session in this.sessions)
         {
            this._session.removeOnSessionUpdate(this.onSessionUpdate);
         }
         this.sessions = new Array();
      }
      
      public function render(param1:View3D) : void
      {
         for each(this._session in this.sessions)
         {
            this._session.render(param1);
         }
         if(this.updated)
         {
            (this.getConsumer(param1) as IRenderer).render(param1);
         }
      }
      
      private function onObjectSessionUpdate(param1:Object3DEvent) : void
      {
         this.notifySessionUpdate();
      }
      
      function internalRemoveSceneSession(param1:AbstractRenderSession) : void
      {
         this.sessions = [];
         param1.removeOnSessionUpdate(this.onSessionUpdate);
      }
      
      public function renderTriangleBitmap(param1:BitmapData, param2:Matrix, param3:ScreenVertex, param4:ScreenVertex, param5:ScreenVertex, param6:Boolean, param7:Boolean, param8:Graphics = null) : void
      {
         if(!param8 && this._layerDirty)
         {
            this.createLayer();
         }
         this.a2 = (this.v1x = param4.x) - (this.v0x = param3.x);
         this.b2 = (this.v1y = param4.y) - (this.v0y = param3.y);
         this.c2 = (this.v2x = param5.x) - this.v0x;
         this.d2 = (this.v2y = param5.y) - this.v0y;
         this.m.a = (this.a = param2.a) * this.a2 + (this.b = param2.b) * this.c2;
         this.m.b = this.a * this.b2 + this.b * this.d2;
         this.m.c = (this.c = param2.c) * this.a2 + (this.d = param2.d) * this.c2;
         this.m.d = this.c * this.b2 + this.d * this.d2;
         this.m.tx = (this.tx = param2.tx) * this.a2 + (this.ty = param2.ty) * this.c2 + this.v0x;
         this.m.ty = this.tx * this.b2 + this.ty * this.d2 + this.v0y;
         this.area = this.v0x * (this.d2 - this.b2) - this.v1x * this.d2 + this.v2x * this.b2;
         if(this.area < 0)
         {
            this.area = -this.area;
         }
         if(param8)
         {
            param8.lineStyle();
            param8.moveTo(this.v0x,this.v0y);
            param8.beginBitmapFill(param1,this.m,param7,param6 && this.area > 400);
            param8.lineTo(this.v1x,this.v1y);
            param8.lineTo(this.v2x,this.v2y);
            param8.endFill();
         }
         else
         {
            this.graphics.lineStyle();
            this.graphics.moveTo(this.v0x,this.v0y);
            this.graphics.beginBitmapFill(param1,this.m,param7,param6 && this.area > 400);
            this.graphics.lineTo(this.v1x,this.v1y);
            this.graphics.lineTo(this.v2x,this.v2y);
            this.graphics.endFill();
         }
      }
      
      private function getSpriteActive(param1:View3D) : Array
      {
         if(!this._spriteActives[param1])
         {
            return this._spriteActives[param1] = new Array();
         }
         return this._spriteActives[param1];
      }
      
      public function getLightShapeLayer(param1:View3D) : Dictionary
      {
         if(!this._lightShapeLayers[param1])
         {
            return this._lightShapeLayers[param1] = new Dictionary(true);
         }
         return this._lightShapeLayers[param1];
      }
      
      function internalRemoveOwnSession(param1:Object3D) : void
      {
         param1.removeEventListener(Object3DEvent.SESSION_UPDATED,this.onObjectSessionUpdate);
      }
      
      private function getShapeStore(param1:View3D) : Array
      {
         if(!this._shapeStores[param1])
         {
            return this._shapeStores[param1] = new Array();
         }
         return this._shapeStores[param1];
      }
      
      public function get renderer() : IPrimitiveConsumer
      {
         return this._renderer;
      }
      
      public function getContainer(param1:View3D) : DisplayObject
      {
         throw new Error("Not implemented");
      }
      
      public function renderLine(param1:ScreenVertex, param2:ScreenVertex, param3:Number, param4:uint, param5:Number) : void
      {
         if(this._layerDirty)
         {
            this.createLayer();
         }
         this.graphics.lineStyle(param3,param4,param5);
         this.graphics.moveTo(param1.x,param1.y);
         this.graphics.lineTo(param2.x,param2.y);
      }
      
      private function getShapeActive(param1:View3D) : Array
      {
         if(!this._shapeActives[param1])
         {
            return this._shapeActives[param1] = new Array();
         }
         return this._shapeActives[param1];
      }
      
      public function getSprite(param1:ILayerMaterial, param2:int, param3:Sprite = null) : Sprite
      {
         if(!(this._array = this._spriteLayer[param1]))
         {
            this._array = this._spriteLayer[param1] = new Array();
         }
         if(!param2 && param1 != this._material)
         {
            this._level = -1;
            this._material = param1;
         }
         if(this._level >= param2 && this._array.length)
         {
            this._sprite = this._array[0];
         }
         else
         {
            this._level = param2;
            this._array.unshift(this._sprite = this.createSprite(param3));
         }
         return this._sprite;
      }
      
      public function renderTriangleLine(param1:Number, param2:int, param3:Number, param4:ScreenVertex, param5:ScreenVertex, param6:ScreenVertex) : void
      {
         if(this._layerDirty)
         {
            this.createLayer();
         }
         this.graphics.lineStyle(param1,param2,param3);
         this.graphics.moveTo(this.v0x = param4.x,this.v0y = param4.y);
         this.graphics.lineTo(param5.x,param5.y);
         this.graphics.lineTo(param6.x,param6.y);
         this.graphics.lineTo(this.v0x,this.v0y);
      }
      
      public function renderScaledBitmap(param1:DrawScaledBitmap, param2:BitmapData, param3:Matrix, param4:Boolean = false) : void
      {
         if(this._layerDirty)
         {
            this.createLayer();
         }
         this.graphics.lineStyle();
         if(param1.rotation != 0)
         {
            this.graphics.beginBitmapFill(param2,param3,false,param4);
            this.graphics.moveTo(param1.topleft.x,param1.topleft.y);
            this.graphics.lineTo(param1.topright.x,param1.topright.y);
            this.graphics.lineTo(param1.bottomright.x,param1.bottomright.y);
            this.graphics.lineTo(param1.bottomleft.x,param1.bottomleft.y);
            this.graphics.lineTo(param1.topleft.x,param1.topleft.y);
            this.graphics.endFill();
         }
         else
         {
            this.graphics.beginBitmapFill(param2,param3,false,param4);
            this.graphics.drawRect(param1.minX,param1.minY,param1.maxX - param1.minX,param1.maxY - param1.minY);
            this.graphics.endFill();
         }
      }
      
      public function getTotalFaces(param1:View3D) : int
      {
         var _loc2_:int = this.getConsumer(param1).list().length;
         for each(this._session in this.sessions)
         {
            _loc2_ = _loc2_ + this._session.getTotalFaces(param1);
         }
         return _loc2_;
      }
      
      protected function createSprite(param1:Sprite = null) : Sprite
      {
         throw new Error("Not implemented");
      }
      
      private function getSpriteStore(param1:View3D) : Array
      {
         if(!this._spriteStores[param1])
         {
            return this._spriteStores[param1] = new Array();
         }
         return this._spriteStores[param1];
      }
      
      protected function createLayer() : void
      {
         throw new Error("Not implemented");
      }
      
      public function getShape(param1:ILayerMaterial, param2:int, param3:Sprite) : Shape
      {
         if(!(this._array = this._shapeLayer[param1]))
         {
            this._array = this._shapeLayer[param1] = new Array();
         }
         if(this._level >= param2 && this._array.length)
         {
            this._shape = this._array[0];
         }
         else
         {
            this._level = param2;
            this._array.unshift(this._shape = this.createShape(param3));
         }
         return this._shape;
      }
      
      function internalAddOwnSession(param1:Object3D) : void
      {
         param1.addEventListener(Object3DEvent.SESSION_UPDATED,this.onObjectSessionUpdate);
      }
   }
}
