package com.zam.lol
{
   import flash.geom.Vector3D;
   import flash.utils.ByteArray;
   
   public class Util
   {
       
      
      public function Util()
      {
         super();
      }
      
      public static function readVector3D(param1:ByteArray) : Vector3D
      {
         var _loc2_:Number = param1.readFloat();
         var _loc3_:Number = param1.readFloat();
         var _loc4_:Number = param1.readFloat();
         return new Vector3D(_loc2_,_loc3_,_loc4_);
      }
   }
}
