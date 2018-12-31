package away3d.materials
{
   import away3d.containers.View3D;
   import away3d.core.base.Object3D;
   import away3d.core.draw.DrawTriangle;
   import away3d.core.utils.Cast;
   import away3d.core.utils.Init;
   import away3d.events.MaterialEvent;
   import flash.events.EventDispatcher;
   
   public class ColorMaterial extends EventDispatcher implements ITriangleMaterial
   {
       
      
      private var _color:uint;
      
      private var _alpha:Number;
      
      protected var ini:Init;
      
      private var _materialDirty:Boolean;
      
      private var _materialupdated:MaterialEvent;
      
      public function ColorMaterial(param1:* = null, param2:Object = null)
      {
         super();
         if(param1 == null)
         {
            param1 = "random";
         }
         this.color = Cast.trycolor(param1);
         this.ini = Init.parse(param2);
         this._alpha = this.ini.getNumber("alpha",1,{
            "min":0,
            "max":1
         });
      }
      
      function notifyMaterialUpdate() : void
      {
         if(!hasEventListener(MaterialEvent.MATERIAL_UPDATED))
         {
            return;
         }
         if(this._materialupdated == null)
         {
            this._materialupdated = new MaterialEvent(MaterialEvent.MATERIAL_UPDATED,this);
         }
         dispatchEvent(this._materialupdated);
      }
      
      public function set color(param1:uint) : void
      {
         if(this._color == param1)
         {
            return;
         }
         this._color = param1;
         this._materialDirty = true;
      }
      
      public function updateMaterial(param1:Object3D, param2:View3D) : void
      {
         if(this._materialDirty)
         {
            this._materialDirty = false;
            this.notifyMaterialUpdate();
         }
      }
      
      public function get alpha() : Number
      {
         return this._alpha;
      }
      
      public function get color() : uint
      {
         return this._color;
      }
      
      public function addOnMaterialUpdate(param1:Function) : void
      {
         addEventListener(MaterialEvent.MATERIAL_UPDATED,param1,false,0,true);
      }
      
      public function get visible() : Boolean
      {
         return this.alpha > 0;
      }
      
      public function removeOnMaterialUpdate(param1:Function) : void
      {
         removeEventListener(MaterialEvent.MATERIAL_UPDATED,param1,false);
      }
      
      public function set alpha(param1:Number) : void
      {
         if(this._alpha == param1)
         {
            return;
         }
         this._alpha = param1;
         this._materialDirty = true;
      }
      
      public function renderTriangle(param1:DrawTriangle) : void
      {
         param1.source.session.renderTriangleColor(this._color,this._alpha,param1.v0,param1.v1,param1.v2);
      }
   }
}
