package com.zam
{
   import flash.geom.Vector3D;
   
   public class VectorUtil
   {
       
      
      public function VectorUtil()
      {
         super();
      }
      
      public static function subtract(param1:Vector3D, param2:Vector3D, param3:Vector3D) : Vector3D
      {
         param3.x = param1.x - param2.x;
         param3.y = param1.y - param2.y;
         param3.z = param1.z - param2.z;
         param3.w = 0;
         return param3;
      }
      
      public static function crossProduct(param1:Vector3D, param2:Vector3D, param3:Vector3D) : Vector3D
      {
         param3.x = param1.y * param2.z - param1.z * param2.y;
         param3.y = param1.z * param2.x - param1.x * param2.z;
         param3.z = param1.x * param2.y - param1.y * param2.x;
         param3.w = 0;
         return param3;
      }
      
      public static function scaleBy(param1:Vector3D, param2:Number, param3:Vector3D) : Vector3D
      {
         param3.x = param1.x * param2;
         param3.y = param1.y * param2;
         param3.z = param1.z * param2;
         param3.w = param1.w;
         return param3;
      }
      
      public static function interpolate(param1:Vector3D, param2:Vector3D, param3:Number, param4:Vector3D) : Vector3D
      {
         param4.x = param1.x + (param2.x - param1.x) * param3;
         param4.y = param1.y + (param2.y - param1.y) * param3;
         param4.z = param1.z + (param2.z - param1.z) * param3;
         param4.w = param1.w;
         return param4;
      }
   }
}
