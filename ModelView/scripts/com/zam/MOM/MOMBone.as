package com.zam.MOM
{
   import org.papervision3d.core.math.Matrix3D;
   import org.papervision3d.core.math.Number3D;
   
   public class MOMBone
   {
       
      
      public var transpivot:Number3D;
      
      public var pivot:Number3D;
      
      public var matrix:Matrix3D;
      
      public var parent:int;
      
      public function MOMBone()
      {
         super();
         this.parent = 0;
         this.pivot = this.transpivot = null;
         this.matrix = null;
      }
   }
}
