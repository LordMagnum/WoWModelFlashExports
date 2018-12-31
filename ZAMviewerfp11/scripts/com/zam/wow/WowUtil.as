package com.zam.wow
{
   import com.zam.Quaternion;
   import flash.geom.Vector3D;
   import flash.utils.ByteArray;
   
   public class WowUtil
   {
       
      
      public function WowUtil()
      {
         super();
      }
      
      public static function readAnimatedFloatSet(param1:ByteArray) : Vector.<AnimatedFloat>
      {
         var _loc2_:int = param1.readInt();
         var _loc3_:Vector.<AnimatedFloat> = new Vector.<AnimatedFloat>(_loc2_);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_[_loc4_] = new AnimatedFloat();
            _loc3_[_loc4_].read(param1);
            _loc4_++;
         }
         return _loc3_;
      }
      
      public static function readAnimatedQuaternionSet(param1:ByteArray) : Vector.<AnimatedQuaternion>
      {
         var _loc2_:int = param1.readInt();
         var _loc3_:Vector.<AnimatedQuaternion> = new Vector.<AnimatedQuaternion>(_loc2_);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_[_loc4_] = new AnimatedQuaternion();
            _loc3_[_loc4_].read(param1);
            _loc4_++;
         }
         return _loc3_;
      }
      
      public static function readAnimatedVector3DSet(param1:ByteArray, param2:Boolean = true) : Vector.<AnimatedVector3D>
      {
         var _loc3_:int = param1.readInt();
         var _loc4_:Vector.<AnimatedVector3D> = new Vector.<AnimatedVector3D>(_loc3_);
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_[_loc5_] = new AnimatedVector3D();
            _loc4_[_loc5_].read(param1,param2);
            _loc5_++;
         }
         return _loc4_;
      }
      
      public static function readAnimatedUShortSet(param1:ByteArray) : Vector.<AnimatedUShort>
      {
         var _loc2_:int = param1.readInt();
         var _loc3_:Vector.<AnimatedUShort> = new Vector.<AnimatedUShort>(_loc2_);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_[_loc4_] = new AnimatedUShort();
            _loc3_[_loc4_].read(param1);
            _loc4_++;
         }
         return _loc3_;
      }
      
      public static function readVector2D(param1:ByteArray) : Vector3D
      {
         var _loc2_:Number = param1.readFloat();
         var _loc3_:Number = param1.readFloat();
         return new Vector3D(_loc2_,_loc3_);
      }
      
      public static function readVector3D(param1:ByteArray, param2:Boolean = true) : Vector3D
      {
         var _loc3_:Number = param1.readFloat();
         var _loc4_:Number = param1.readFloat();
         var _loc5_:Number = param1.readFloat();
         if(param2)
         {
            return new Vector3D(_loc3_,_loc5_,_loc4_);
         }
         return new Vector3D(_loc3_,_loc4_,_loc5_);
      }
      
      public static function readQuaternion(param1:ByteArray) : Quaternion
      {
         var _loc2_:Number = param1.readFloat();
         var _loc3_:Number = param1.readFloat();
         var _loc4_:Number = param1.readFloat();
         var _loc5_:Number = param1.readFloat();
         return new Quaternion(_loc2_,_loc4_,_loc3_,_loc5_);
      }
   }
}
