package com.zam.MOM
{
   import org.papervision3d.core.geom.renderables.Vertex3D;
   import org.papervision3d.core.math.Number3D;
   import org.papervision3d.core.math.NumberUV;
   
   public class MOMVertex
   {
       
      
      public var uv:NumberUV;
      
      public var normal:Number3D;
      
      public var position:Vertex3D;
      
      public var weights:Vector.<int>;
      
      public var bones:Vector.<int>;
      
      public function MOMVertex()
      {
         super();
         this.position = null;
         this.normal = null;
         this.uv = null;
         this.bones = this.weights = null;
      }
   }
}
