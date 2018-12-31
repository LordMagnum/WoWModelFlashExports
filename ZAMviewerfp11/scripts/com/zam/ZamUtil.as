package com.zam
{
   import flash.geom.Vector3D;
   import flash.utils.ByteArray;
   
   public class ZamUtil
   {
       
      
      public function ZamUtil()
      {
         super();
      }
      
      public static function randomInt(param1:int, param2:int) : int
      {
         return param1 + Math.floor(Math.random() * (param2 - param1));
      }
      
      public static function readVector3D(param1:ByteArray, param2:Boolean = false) : Vector3D
      {
         var _loc3_:Number = param1.readFloat();
         var _loc4_:Number = param1.readFloat();
         var _loc5_:Number = param1.readFloat();
         if(param2)
         {
            return new Vector3D(_loc3_,-_loc5_,_loc4_);
         }
         return new Vector3D(_loc3_,_loc4_,_loc5_);
      }
      
      public static function readVector3Dc(param1:ByteArray, param2:Boolean = false) : Vector3D
      {
         var _loc3_:Number = param1.readUnsignedShort() / 65535 * 2 - 1;
         var _loc4_:Number = param1.readUnsignedShort() / 65535 * 2 - 1;
         var _loc5_:Number = param1.readUnsignedShort() / 65535 * 2 - 1;
         if(param2)
         {
            return new Vector3D(_loc3_,_loc5_,_loc4_);
         }
         return new Vector3D(_loc3_,_loc4_,_loc5_);
      }
   }
}
