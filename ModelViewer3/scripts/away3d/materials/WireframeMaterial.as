package away3d.materials
{
   import away3d.containers.View3D;
   import away3d.core.base.Object3D;
   import away3d.core.draw.DrawSegment;
   import away3d.core.draw.DrawTriangle;
   import away3d.core.utils.Cast;
   import away3d.core.utils.Init;
   import away3d.events.MaterialEvent;
   import flash.events.EventDispatcher;
   
   public class WireframeMaterial extends EventDispatcher implements ITriangleMaterial, ISegmentMaterial
   {
       
      
      public var color:int;
      
      protected var ini:Init;
      
      public var width:Number;
      
      public var alpha:Number;
      
      public function WireframeMaterial(param1:* = null, param2:Object = null)
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
         this.width = this.ini.getNumber("width",1,{"min":0});
      }
      
      public function renderTriangle(param1:DrawTriangle) : void
      {
         if(this.alpha <= 0)
         {
            return;
         }
         param1.source.session.renderTriangleLine(this.width,this.color,this.alpha,param1.v0,param1.v1,param1.v2);
      }
      
      public function updateMaterial(param1:Object3D, param2:View3D) : void
      {
      }
      
      public function get visible() : Boolean
      {
         return this.alpha > 0;
      }
      
      public function removeOnMaterialUpdate(param1:Function) : void
      {
         removeEventListener(MaterialEvent.MATERIAL_UPDATED,param1,false);
      }
      
      public function renderSegment(param1:DrawSegment) : void
      {
         if(this.alpha <= 0)
         {
            return;
         }
         param1.source.session.renderLine(param1.v0,param1.v1,this.width,this.color,this.alpha);
      }
      
      public function addOnMaterialUpdate(param1:Function) : void
      {
         addEventListener(MaterialEvent.MATERIAL_UPDATED,param1,false,0,true);
      }
   }
}
