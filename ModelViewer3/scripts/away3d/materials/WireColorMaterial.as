package away3d.materials
{
   import away3d.containers.View3D;
   import away3d.core.base.Object3D;
   import away3d.core.draw.DrawTriangle;
   import away3d.core.utils.Cast;
   import away3d.core.utils.Init;
   import away3d.events.MaterialEvent;
   import flash.events.EventDispatcher;
   
   public class WireColorMaterial extends EventDispatcher implements ITriangleMaterial
   {
       
      
      public var color:int;
      
      protected var ini:Init;
      
      public var alpha:Number;
      
      public var width:Number;
      
      public var wirealpha:Number;
      
      public var wirecolor:int;
      
      public function WireColorMaterial(param1:* = null, param2:Object = null)
      {
         super();
         if(param1 == null)
         {
            param1 = "random";
         }
         this.color = Cast.trycolor(param1);
         this.ini = Init.parse(param2);
         this.alpha = this.ini.getNumber("alpha",1,{
            "min":0,
            "max":1
         });
         this.wirecolor = this.ini.getColor("wirecolor",0);
         this.width = this.ini.getNumber("width",1,{"min":0});
         this.wirealpha = this.ini.getNumber("wirealpha",1,{
            "min":0,
            "max":1
         });
      }
      
      public function get visible() : Boolean
      {
         return this.alpha > 0 || this.wirealpha > 0;
      }
      
      public function updateMaterial(param1:Object3D, param2:View3D) : void
      {
      }
      
      public function renderTriangle(param1:DrawTriangle) : void
      {
         param1.source.session.renderTriangleLineFill(this.width,this.color,this.alpha,this.wirecolor,this.wirealpha,param1.v0,param1.v1,param1.v2);
      }
      
      public function removeOnMaterialUpdate(param1:Function) : void
      {
         removeEventListener(MaterialEvent.MATERIAL_UPDATED,param1,false);
      }
      
      public function addOnMaterialUpdate(param1:Function) : void
      {
         addEventListener(MaterialEvent.MATERIAL_UPDATED,param1,false,0,true);
      }
   }
}
