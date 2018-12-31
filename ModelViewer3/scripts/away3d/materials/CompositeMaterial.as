package away3d.materials
{
   import away3d.containers.View3D;
   import away3d.core.base.Object3D;
   import away3d.core.draw.DrawTriangle;
   import away3d.core.render.AbstractRenderSession;
   import away3d.core.utils.FaceMaterialVO;
   import away3d.core.utils.Init;
   import away3d.events.MaterialEvent;
   import flash.display.BlendMode;
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class CompositeMaterial extends EventDispatcher implements ITriangleMaterial, ILayerMaterial
   {
       
      
      private var _green:Number;
      
      private var _material:ILayerMaterial;
      
      var _spriteDictionary:Dictionary;
      
      public var blendMode:String;
      
      protected var materials:Array;
      
      private var _blue:Number;
      
      var _source:Object3D;
      
      var _colorTransformDirty:Boolean;
      
      private var _red:Number;
      
      var _session:AbstractRenderSession;
      
      var _alpha:Number;
      
      var _color:uint;
      
      var _sprite:Sprite;
      
      var _colorTransform:ColorTransform;
      
      protected var ini:Init;
      
      private var _defaultColorTransform:ColorTransform;
      
      public function CompositeMaterial(param1:Object = null)
      {
         this._colorTransform = new ColorTransform();
         this._spriteDictionary = new Dictionary(true);
         this._defaultColorTransform = new ColorTransform();
         super();
         this.ini = Init.parse(param1);
         this.materials = this.ini.getArray("materials");
         this.blendMode = this.ini.getString("blendMode",BlendMode.NORMAL);
         this.alpha = this.ini.getNumber("alpha",1,{
            "min":0,
            "max":1
         });
         this.color = this.ini.getColor("color",16777215);
         for each(this._material in this.materials)
         {
            this._material.addOnMaterialUpdate(this.onMaterialUpdate);
         }
         this._colorTransformDirty = true;
      }
      
      public function get visible() : Boolean
      {
         return true;
      }
      
      private function onMaterialUpdate(param1:MaterialEvent) : void
      {
         dispatchEvent(param1);
      }
      
      public function updateMaterial(param1:Object3D, param2:View3D) : void
      {
         this.clearSpriteDictionary();
         if(this._colorTransformDirty)
         {
            this.setColorTransform();
         }
         for each(this._material in this.materials)
         {
            this._material.updateMaterial(param1,param2);
         }
      }
      
      private function clearSpriteDictionary() : void
      {
         for each(this._sprite in this._spriteDictionary)
         {
            this._sprite.graphics.clear();
         }
      }
      
      public function set alpha(param1:Number) : void
      {
         if(param1 > 1)
         {
            param1 = 1;
         }
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(this._alpha == param1)
         {
            return;
         }
         this._alpha = param1;
         this._colorTransformDirty = true;
      }
      
      public function renderTriangle(param1:DrawTriangle) : void
      {
         this._source = param1.source;
         this._session = this._source.session;
         var _loc2_:int = 0;
         this._sprite = this._session.layer as Sprite;
         if(!this._sprite || this._colorTransform || this.blendMode != BlendMode.NORMAL)
         {
            this._sprite = this._session.getSprite(this,_loc2_++);
            this._sprite.blendMode = this.blendMode;
         }
         if(this._colorTransform)
         {
            this._sprite.transform.colorTransform = this._colorTransform;
         }
         else
         {
            this._sprite.transform.colorTransform = this._defaultColorTransform;
         }
         for each(this._material in this.materials)
         {
            _loc2_ = this._material.renderLayer(param1,this._sprite,_loc2_);
         }
      }
      
      public function removeOnMaterialUpdate(param1:Function) : void
      {
         removeEventListener(MaterialEvent.MATERIAL_UPDATED,param1,false);
      }
      
      public function set color(param1:uint) : void
      {
         if(this._color == param1)
         {
            return;
         }
         this._color = param1;
         this._red = ((this._color & 16711680) >> 16) / 255;
         this._green = ((this._color & 65280) >> 8) / 255;
         this._blue = (this._color & 255) / 255;
         this._colorTransformDirty = true;
      }
      
      protected function setColorTransform() : void
      {
         this._colorTransformDirty = false;
         if(this._alpha == 1 && this._color == 16777215)
         {
            this._colorTransform = null;
            return;
         }
         if(!this._colorTransform)
         {
            this._colorTransform = new ColorTransform();
         }
         this._colorTransform.redMultiplier = this._red;
         this._colorTransform.greenMultiplier = this._green;
         this._colorTransform.blueMultiplier = this._blue;
         this._colorTransform.alphaMultiplier = this._alpha;
      }
      
      public function removeMaterial(param1:ILayerMaterial) : void
      {
         var _loc2_:int = this.materials.indexOf(param1);
         if(_loc2_ == -1)
         {
            return;
         }
         param1.removeOnMaterialUpdate(this.onMaterialUpdate);
         this.materials.splice(_loc2_,1);
      }
      
      public function get alpha() : Number
      {
         return this._alpha;
      }
      
      public function renderLayer(param1:DrawTriangle, param2:Sprite, param3:int) : int
      {
         if(!this._colorTransform && this.blendMode == BlendMode.NORMAL)
         {
            this._sprite = param2;
         }
         else
         {
            this._source = param1.source;
            this._session = this._source.session;
            this._sprite = this._session.getSprite(this,param3++,param2);
            this._sprite.blendMode = this.blendMode;
            if(this._colorTransform)
            {
               this._sprite.transform.colorTransform = this._colorTransform;
            }
            else
            {
               this._sprite.transform.colorTransform = this._defaultColorTransform;
            }
         }
         for each(this._material in this.materials)
         {
            param3 = this._material.renderLayer(param1,this._sprite,param3);
         }
         return param3;
      }
      
      public function get color() : uint
      {
         return this._color;
      }
      
      public function addMaterial(param1:ILayerMaterial) : void
      {
         param1.addOnMaterialUpdate(this.onMaterialUpdate);
         this.materials.push(param1);
      }
      
      public function renderBitmapLayer(param1:DrawTriangle, param2:Rectangle, param3:FaceMaterialVO) : FaceMaterialVO
      {
         throw new Error("Not implemented");
      }
      
      public function addOnMaterialUpdate(param1:Function) : void
      {
         addEventListener(MaterialEvent.MATERIAL_UPDATED,param1,false,0,true);
      }
   }
}
