package away3d.core.utils
{
   import away3d.core.base.Face;
   import away3d.core.base.UV;
   import away3d.core.base.Vertex;
   import away3d.materials.ITriangleMaterial;
   import flash.geom.Rectangle;
   
   public class FaceVO
   {
       
      
      public var v0:Vertex;
      
      public var generated:Boolean;
      
      public var face:Face;
      
      public var material:ITriangleMaterial;
      
      public var back:ITriangleMaterial;
      
      public var uv0:UV;
      
      public var uv1:UV;
      
      public var bitmapRect:Rectangle;
      
      public var uv2:UV;
      
      public var v1:Vertex;
      
      public var v2:Vertex;
      
      public function FaceVO()
      {
         super();
      }
      
      public function get minU() : Number
      {
         if(this.uv0.u < this.uv1.u)
         {
            if(this.uv0.u < this.uv2.u)
            {
               return this.uv0.u;
            }
            return this.uv2.u;
         }
         if(this.uv1.u < this.uv2.u)
         {
            return this.uv1.u;
         }
         return this.uv2.u;
      }
      
      public function get minV() : Number
      {
         if(this.uv0.v < this.uv1.v)
         {
            if(this.uv0.v < this.uv2.v)
            {
               return this.uv0.v;
            }
            return this.uv2.v;
         }
         if(this.uv1.v < this.uv2.v)
         {
            return this.uv1.v;
         }
         return this.uv2.v;
      }
      
      public function get maxU() : Number
      {
         if(this.uv0.u > this.uv1.u)
         {
            if(this.uv0.u > this.uv2.u)
            {
               return this.uv0.u;
            }
            return this.uv2.u;
         }
         if(this.uv1.u > this.uv2.u)
         {
            return this.uv1.u;
         }
         return this.uv2.u;
      }
      
      public function get maxV() : Number
      {
         if(this.uv0.v > this.uv1.v)
         {
            if(this.uv0.v > this.uv2.v)
            {
               return this.uv0.v;
            }
            return this.uv2.v;
         }
         if(this.uv1.v > this.uv2.v)
         {
            return this.uv1.v;
         }
         return this.uv2.v;
      }
   }
}
