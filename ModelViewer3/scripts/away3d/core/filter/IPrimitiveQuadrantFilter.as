package away3d.core.filter
{
   import away3d.cameras.Camera3D;
   import away3d.containers.Scene3D;
   import away3d.core.clip.Clipping;
   import away3d.core.render.QuadrantRenderer;
   
   public interface IPrimitiveQuadrantFilter
   {
       
      
      function filter(param1:QuadrantRenderer, param2:Scene3D, param3:Camera3D, param4:Clipping) : void;
   }
}
