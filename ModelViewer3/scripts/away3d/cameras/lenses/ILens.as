package away3d.cameras.lenses
{
   import away3d.containers.View3D;
   import away3d.core.base.Object3D;
   import away3d.core.base.Vertex;
   import away3d.core.draw.ScreenVertex;
   import away3d.core.geom.Frustum;
   import away3d.core.math.MatrixAway3D;
   
   public interface ILens
   {
       
      
      function getZoom() : Number;
      
      function getFOV() : Number;
      
      function project(param1:MatrixAway3D, param2:Vertex) : ScreenVertex;
      
      function getFrustum(param1:Object3D, param2:MatrixAway3D) : Frustum;
      
      function setView(param1:View3D) : void;
   }
}
