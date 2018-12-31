package
{
   import flash.utils.ByteArray;
   
   public final class _gs89
   {
      
      public static var _ac437:Number = 0.001;
       
      
      public var x:Number;
      
      public var y:Number;
      
      public var z:Number;
      
      public function _gs89(param1:Number = 0, param2:Number = 0, param3:Number = 0)
      {
         super();
         this.x = param1;
         this.y = param2;
         this.z = param3;
      }
      
      public static function _wg1203(param1:ByteArray) : _gs89
      {
         return new _gs89(param1.readFloat(),param1.readFloat(),param1.readFloat());
      }
      
      public static function clone(param1:_gs89) : _gs89
      {
         return new _gs89(param1.x,param1.y,param1.z);
      }
      
      public function _tv1198(param1:_kp1215) : void
      {
      }
      
      public function add(param1:_gs89) : _gs89
      {
         return new _gs89(this.x + param1.x,this.y + param1.y,this.z + param1.z);
      }
      
      public function _ss945(param1:Number) : void
      {
         this.x = this.x * param1;
         this.y = this.y * param1;
         this.z = this.z * param1;
      }
      
      public function multiply(param1:Number) : _gs89
      {
         return new _gs89(param1 * this.x,param1 * this.y,param1 * this.z);
      }
      
      public function zero() : void
      {
         this.x = 0;
         this.y = 0;
         this.z = 0;
      }
      
      public function _gy1092(param1:_gs89, param2:Number) : _gs89
      {
         var _loc3_:Number = 1 - param2;
         return new _gs89(this.x * _loc3_ + param1.x * param2,this.y * _loc3_ + param1.y * param2,this.z * _loc3_ + param1.z * param2);
      }
      
      public function normalize() : void
      {
         var _loc1_:Number = this.x * this.x + this.y * this.y + this.z * this.z;
         if(Math.abs(_loc1_ - 1) > _ac437)
         {
            _loc1_ = Math.sqrt(_loc1_);
            this.x = this.x / _loc1_;
            this.y = this.y / _loc1_;
            this.z = this.z / _loc1_;
         }
      }
      
      public function _mw854(param1:_gs89) : void
      {
         this.x = this.x + param1.x;
         this.y = this.y + param1.y;
         this.z = this.z + param1.z;
      }
      
      public function copy(param1:_gs89) : void
      {
         this.x = param1.x;
         this.y = param1.y;
         this.z = param1.z;
      }
      
      public function magnitude() : Number
      {
         return Math.sqrt(this.x * this.x + this.y * this.y + this.z * this.z);
      }
      
      public function rotate(param1:_vc586) : _gs89
      {
         var _loc2_:_gs89 = _gs89.clone(this);
         _loc2_.normalize();
         var _loc3_:_vc586 = new _vc586(_loc2_.x,_loc2_.y,_loc2_.z,0);
         var _loc4_:_vc586 = param1._kp1004();
         var _loc5_:_vc586 = _loc3_.multiply(_loc4_);
         _loc5_ = param1.multiply(_loc3_);
         return new _gs89(_loc5_.x,_loc5_.y,_loc5_.z);
      }
      
      public function _ba183(param1:_gs89, param2:Number) : void
      {
         var _loc3_:Number = 1 - param2;
         this.x = this.x * _loc3_ + param1.x * param2;
         this.y = this.y * _loc3_ + param1.y * param2;
         this.z = this.z * _loc3_ + param1.z * param2;
      }
   }
}
