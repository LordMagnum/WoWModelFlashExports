package away3d.core.clip
{
   import away3d.core.base.UV;
   import away3d.core.base.Vertex;
   import away3d.core.base.VertexClassification;
   import away3d.core.draw.DrawPrimitive;
   import away3d.core.draw.DrawTriangle;
   import away3d.core.geom.Frustum;
   import away3d.core.geom.Plane3D;
   import away3d.core.render.AbstractRenderSession;
   import away3d.core.utils.FaceVO;
   
   public class RectangleClipping extends Clipping
   {
       
      
      private var _uv1:UV;
      
      private var _uv20:UV;
      
      private var _v2C:VertexClassification;
      
      private var _v1d:Number;
      
      private var _v0:Vertex;
      
      private var _v1:Vertex;
      
      private var _v1w:Number;
      
      private var _v1Classification:Plane3D;
      
      private var _v2:Vertex;
      
      private var _frustum:Frustum;
      
      private var _v2d:Number;
      
      private var _f1:FaceVO;
      
      private var tri:DrawTriangle;
      
      private var _v01:Vertex;
      
      private var _v2w:Number;
      
      private var _uv01:UV;
      
      private var _f0:FaceVO;
      
      private var _v0C:VertexClassification;
      
      private var _session:AbstractRenderSession;
      
      private var _v12:Vertex;
      
      private var _plane:Plane3D;
      
      private var _v0Classification:Plane3D;
      
      private var _v2Classification:Plane3D;
      
      private var _d:Number;
      
      private var _uv12:UV;
      
      private var _v1C:VertexClassification;
      
      private var _v0d:Number;
      
      private var _uv0:UV;
      
      private var _p:Number;
      
      private var _uv2:UV;
      
      private var _v20:Vertex;
      
      private var _v0w:Number;
      
      private var _pass:Boolean;
      
      public function RectangleClipping(param1:Object = null)
      {
         super(param1);
         objectCulling = ini.getBoolean("objectCulling",false);
      }
      
      override public function checkPrimitive(param1:DrawPrimitive) : Boolean
      {
         if(param1.maxX < minX)
         {
            return false;
         }
         if(param1.minX > maxX)
         {
            return false;
         }
         if(param1.maxY < minY)
         {
            return false;
         }
         if(param1.minY > maxY)
         {
            return false;
         }
         return true;
      }
      
      override public function clone(param1:Clipping = null) : Clipping
      {
         var _loc2_:RectangleClipping = param1 as RectangleClipping || new RectangleClipping();
         super.clone(_loc2_);
         return _loc2_;
      }
   }
}
