package away3d.core.render
{
   import away3d.containers.View3D;
   import away3d.core.clip.Clipping;
   import away3d.events.SessionEvent;
   import §away3d:arcane§._containers;
   import §away3d:arcane§._layerDirty;
   import §away3d:arcane§._level;
   import §away3d:arcane§._shape;
   import §away3d:arcane§._shapeActive;
   import §away3d:arcane§._shapeStore;
   import §away3d:arcane§._sprite;
   import §away3d:arcane§._spriteActive;
   import §away3d:arcane§._spriteStore;
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class SpriteRenderSession extends AbstractRenderSession
   {
       
      
      private var _container:Sprite;
      
      public var cacheAsBitmap:Boolean;
      
      private var _clip:Clipping;
      
      public function SpriteRenderSession()
      {
         super();
      }
      
      override protected function onSessionUpdate(param1:SessionEvent) : void
      {
         super.onSessionUpdate(param1);
         this.cacheAsBitmap = false;
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
            this._container.addChild(_sprite);
         }
         _layerDirty = true;
         return _sprite;
      }
      
      override public function addDisplayObject(param1:DisplayObject) : void
      {
         this._container.addChild(param1);
         param1.visible = true;
         layer = null;
         _level = -1;
         _layerDirty = true;
      }
      
      override public function getContainer(param1:View3D) : DisplayObject
      {
         if(!_containers[param1])
         {
            return _containers[param1] = new Sprite();
         }
         return _containers[param1];
      }
      
      override public function clear(param1:View3D) : void
      {
         super.clear(param1);
         this._container = this.getContainer(param1) as Sprite;
         if(updated)
         {
            layer = this._container;
            graphics = this._container.graphics;
            if(this == param1.session)
            {
               this._clip = param1.screenClipping;
               this._container.scrollRect = new Rectangle(this._clip.minX - 1,this._clip.minY - 1,this._clip.maxX - this._clip.minX + 2,this._clip.maxY - this._clip.minY + 2);
               this._container.x = this._clip.minX - 1;
               this._container.y = this._clip.minY - 1;
            }
            this._container.cacheAsBitmap = false;
            graphics.clear();
            while(this._container.numChildren)
            {
               this._container.removeChildAt(0);
            }
         }
         else
         {
            this._container.cacheAsBitmap = this.cacheAsBitmap;
         }
         if(filters && filters.length || this._container.filters && this._container.filters.length)
         {
            this._container.filters = filters;
         }
         this._container.alpha = alpha;
         this._container.blendMode = blendMode || BlendMode.NORMAL;
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
         this._container.addChild(_shape);
         _layerDirty = false;
         _level = -1;
      }
      
      override public function clone() : AbstractRenderSession
      {
         return new SpriteRenderSession();
      }
   }
}
