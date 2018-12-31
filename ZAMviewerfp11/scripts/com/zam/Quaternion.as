package com.zam
{
   import flash.geom.Matrix3D;
   import flash.geom.Vector3D;
   
   public class Quaternion
   {
      
      private static var rawVec:Vector.<Number> = new Vector.<Number>(16);
      
      private static var tmpQuat:Quaternion = new Quaternion();
      
      private static var tmpQuat2:Quaternion = new Quaternion();
      
      private static var tmpVec:Vector3D = new Vector3D();
      
      private static var tmpVec2:Vector3D = new Vector3D();
      
      private static var tmpVec3:Vector3D = new Vector3D();
       
      
      public var x:Number;
      
      public var y:Number;
      
      public var z:Number;
      
      public var w:Number;
      
      public function Quaternion(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 1)
      {
         super();
         this.x = param1;
         this.y = param2;
         this.z = param3;
         this.w = param4;
      }
      
      public static function fromAxisAngle(param1:Number, param2:Number, param3:Number, param4:Number) : Quaternion
      {
         var _loc5_:Number = param4 / 180 * Math.PI;
         var _loc6_:Number = Math.sin(_loc5_ / 2);
         return new Quaternion(param1 * _loc6_,param2 * _loc6_,param3 * _loc6_,Math.cos(_loc5_ / 2));
      }
      
      public static function mul(param1:Quaternion, param2:Quaternion, param3:Quaternion) : Quaternion
      {
         param3.x = param1.x * param2.w + param1.w * param2.x + param1.z * param2.y - param1.y * param2.z;
         param3.y = param1.y * param2.w + param1.w * param2.y + param1.x * param2.z - param1.z * param2.x;
         param3.z = param1.z * param2.w + param1.w * param2.z + param1.y * param2.x - param1.x * param2.y;
         param3.w = param1.w * param2.w - param1.x * param2.x - param1.y * param2.y - param1.z * param2.z;
         return param3;
      }
      
      public static function slerp(param1:Quaternion, param2:Quaternion, param3:Number, param4:Quaternion = null) : Quaternion
      {
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         if(!param4)
         {
            param4 = new Quaternion();
         }
         var _loc5_:Number = param1.x * param2.x + param1.y * param2.y + param1.z * param2.z + param1.w * param2.w;
         var _loc6_:Number = 1;
         if(_loc5_ < 0)
         {
            _loc5_ = -_loc5_;
            _loc6_ = -1;
         }
         if(1 - _loc5_ > 0.0001)
         {
            _loc9_ = Math.acos(_loc5_);
            _loc10_ = Math.sin(_loc9_);
            _loc7_ = Math.sin((1 - param3) * _loc9_) / _loc10_;
            _loc8_ = _loc6_ * Math.sin(param3 * _loc9_) / _loc10_;
         }
         else
         {
            _loc7_ = 1 - param3;
            _loc8_ = _loc6_ * param3;
         }
         param4.x = _loc7_ * param1.x + _loc8_ * param2.x;
         param4.y = _loc7_ * param1.y + _loc8_ * param2.y;
         param4.z = _loc7_ * param1.z + _loc8_ * param2.z;
         param4.w = _loc7_ * param1.w + _loc8_ * param2.w;
         return param4;
      }
      
      public function clone() : Quaternion
      {
         return new Quaternion(this.x,this.y,this.z,this.w);
      }
      
      public function setTo(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 1) : Quaternion
      {
         this.x = param1;
         this.y = param2;
         this.z = param3;
         this.w = param4;
         return this;
      }
      
      public function copyFrom(param1:Quaternion) : Quaternion
      {
         this.x = param1.x;
         this.y = param1.y;
         this.z = param1.z;
         this.w = param1.w;
         return this;
      }
      
      public function toMatrix(param1:Matrix3D = null, param2:Vector3D = null) : Matrix3D
      {
         this.normalize();
         var _loc3_:Number = this.x * this.x;
         var _loc4_:Number = this.x * this.y;
         var _loc5_:Number = this.x * this.z;
         var _loc6_:Number = this.x * this.w;
         var _loc7_:Number = this.y * this.y;
         var _loc8_:Number = this.y * this.z;
         var _loc9_:Number = this.y * this.w;
         var _loc10_:Number = this.z * this.z;
         var _loc11_:Number = this.z * this.w;
         if(!param1)
         {
            param1 = new Matrix3D();
         }
         rawVec[0] = 1 - 2 * (_loc7_ + _loc10_);
         rawVec[1] = 2 * (_loc4_ - _loc11_);
         rawVec[2] = 2 * (_loc5_ + _loc9_);
         rawVec[4] = 2 * (_loc4_ + _loc11_);
         rawVec[5] = 1 - 2 * (_loc3_ + _loc10_);
         rawVec[6] = 2 * (_loc8_ - _loc6_);
         rawVec[8] = 2 * (_loc5_ - _loc9_);
         rawVec[9] = 2 * (_loc8_ + _loc6_);
         rawVec[10] = 1 - 2 * (_loc3_ + _loc7_);
         rawVec[3] = rawVec[7] = rawVec[11] = rawVec[12] = rawVec[13] = rawVec[14] = 0;
         rawVec[15] = 1;
         if(param2)
         {
            rawVec[3] = param2.x;
            rawVec[7] = param2.y;
            rawVec[11] = param2.z;
         }
         param1.copyRawDataFrom(rawVec);
         return param1;
      }
      
      public function add(param1:Quaternion) : Quaternion
      {
         this.x = this.x + param1.x;
         this.y = this.y + param1.y;
         this.z = this.z + param1.z;
         this.w = this.w + param1.w;
         return this;
      }
      
      public function invert() : Quaternion
      {
         var _loc2_:Number = NaN;
         var _loc1_:Number = this.x * this.x + this.y * this.y + this.z * this.z + this.w * this.w;
         if(_loc1_ == 1)
         {
            this.x = -this.x;
            this.y = -this.y;
            this.z = -this.z;
         }
         else
         {
            _loc2_ = 1;
            if(_loc1_ != 0)
            {
               _loc2_ = 1 / _loc1_;
            }
            this.x = this.x * _loc2_;
            this.y = this.y * _loc2_;
            this.z = this.z * _loc2_;
            this.w = this.w * _loc2_;
         }
         return this;
      }
      
      public function multiply(param1:Quaternion) : Quaternion
      {
         this.x = this.x * param1.w + this.w * param1.x + this.z * param1.y - this.y * param1.z;
         this.y = this.y * param1.w + this.w * param1.y + this.x * param1.z - this.z * param1.x;
         this.z = this.z * param1.w + this.w * param1.z + this.y * param1.x - this.x * param1.y;
         this.w = this.w * param1.w - this.x * param1.x - this.y * param1.y - this.z * param1.z;
         return this;
      }
      
      public function mulPoint(param1:Vector3D) : Vector3D
      {
         tmpVec.setTo(this.x,this.y,this.z);
         VectorUtil.crossProduct(tmpVec,param1,tmpVec2);
         VectorUtil.crossProduct(tmpVec,tmpVec2,tmpVec3);
         tmpVec2.scaleBy(2 * this.w);
         tmpVec3.scaleBy(2);
         param1.setTo(param1.x + tmpVec2.x + tmpVec3.x,param1.y + tmpVec2.y + tmpVec3.y,param1.z + tmpVec2.z + tmpVec3.z);
         return param1;
      }
      
      public function transformSelf(param1:Vector3D) : Vector3D
      {
         tmpQuat.copyFrom(this);
         tmpQuat.invert();
         tmpQuat2.setTo(param1.x,param1.y,param1.z,0);
         tmpQuat.multiply(tmpQuat2);
         tmpQuat.multiply(this);
         param1.setTo(tmpQuat.x,tmpQuat.y,tmpQuat.z);
         return param1;
      }
      
      public function scale(param1:Number) : Quaternion
      {
         this.x = this.x * param1;
         this.y = this.y * param1;
         this.z = this.z * param1;
         this.w = this.w * param1;
         return this;
      }
      
      public function dot(param1:Quaternion) : Number
      {
         return this.x * param1.x + this.y * param1.y + this.z * param1.z + this.w * param1.w;
      }
      
      public function normalize() : void
      {
         var _loc1_:Number = Math.sqrt(this.x * this.x + this.y * this.y + this.z * this.z + this.w * this.w);
         if(_loc1_ == 0)
         {
            this.x = this.y = this.z = 0;
            this.w = 1;
         }
         else if(_loc1_ != 1)
         {
            this.x = this.x / _loc1_;
            this.y = this.y / _loc1_;
            this.z = this.z / _loc1_;
            this.w = this.w / _loc1_;
         }
      }
      
      public function toString() : String
      {
         return "Quaternion(" + this.x + ", " + this.y + ", " + this.z + ", " + this.w + ")";
      }
   }
}
