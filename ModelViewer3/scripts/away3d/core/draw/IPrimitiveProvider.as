package away3d.core.draw
{
   import away3d.core.base.Object3D;
   import away3d.core.math.MatrixAway3D;
   
   public interface IPrimitiveProvider
   {
       
      
      function primitives(param1:Object3D, param2:MatrixAway3D, param3:IPrimitiveConsumer) : void;
   }
}
