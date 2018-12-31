package
{
   import flash.utils.ByteArray;
   
   public final class _vc586
   {
      
      public static var _jy241:Number = 0.01745329252;
      
      public static var _pp433:Number = 0.001;
       
      
      public var w:Number;
      
      public var x:Number;
      
      public var y:Number;
      
      public var z:Number;
      
      public function _vc586(param1:Number = 0.0, param2:Number = 0.0, param3:Number = 0.0, param4:Number = 1.0)
      {
         super();
         this.x = param1;
         this.y = param2;
         this.z = param3;
         this.w = param4;
      }
      
      public static function _wg1203(param1:ByteArray) : _vc586
      {
         var _loc2_:int = param1.readShort();
         var _loc3_:int = param1.readShort();
         var _loc4_:int = param1.readShort();
         var _loc5_:int = param1.readShort();
         return new _vc586((_loc2_ < 0?_loc2_ + 32768:_loc2_ - 32767) / 32767,(_loc3_ < 0?_loc3_ + 32768:_loc3_ - 32767) / 32767,(_loc4_ < 0?_loc4_ + 32768:_loc4_ - 32767) / 32767,(_loc5_ < 0?_loc5_ + 32768:_loc5_ - 32767) / 32767);
      }
      
      public static function _bs429(param1:_gs89, param2:Number) : _vc586
      {
         var _loc3_:_gs89 = new _gs89(param1.x,param1.y,param1.z);
         _loc3_.normalize();
         param2 = param2 * _jy241 / 2;
         var _loc4_:Number = Math.sin(param2);
         return new _vc586(_loc3_.x * _loc4_,_loc3_.y * _loc4_,_loc3_.z * _loc4_,Math.cos(param2));
      }
      
      public function multiply(param1:_vc586) : _vc586
      {
         return new _vc586(this.w * param1.x + this.x * param1.w + this.y * param1.z - this.z * param1.y,this.w * param1.y + this.y * param1.w + this.z * param1.x - this.x * param1.z,this.w * param1.z + this.z * param1.w + this.x * param1.y - this.y * param1.x,this.w * param1.w - this.x * param1.x - this.y * param1.y - this.z * param1.z);
      }
      
      public function toString() : String
      {
         return "(x:" + this.x + " y:" + this.y + " z:" + this.z + " w:" + this.w + ")";
      }
      
      public function dotProduct(param1:_vc586) : Number
      {
         return this.x * param1.x + this.y * param1.y + this.z * param1.z + this.w * param1.w;
      }
      
      public function _kp1004() : _vc586
      {
         return new _vc586(-this.x,-this.y,-this.z,this.w);
      }
      
      public function _gy1092(param1:_vc586, param2:Number) : _vc586
      {
         var _loc3_:Number = 1 - param2;
         return new _vc586(this.x * _loc3_ + param1.x * param2,this.y * _loc3_ + param1.y * param2,this.z * _loc3_ + param1.z * param2,this.w * _loc3_ + param1.w * param2);
      }
      
      public function _os395() : void
      {
         this.x = 0;
         this.y = 0;
         this.z = 0;
         this.w = 1;
      }
      
      public function normalize() : void
      {
         var _loc1_:Number = this.x * this.x + this.y * this.y + this.z * this.z + this.w * this.w;
         if(Math.abs(_loc1_ - 1) > _pp433)
         {
            _loc1_ = Math.sqrt(_loc1_);
            this.x = this.x / _loc1_;
            this.y = this.y / _loc1_;
            this.z = this.z / _loc1_;
            this.w = this.w / _loc1_;
         }
      }
      
      public function copy(param1:_vc586) : void
      {
         this.x = param1.x;
         this.y = param1.y;
         this.z = param1.z;
         this.w = param1.w;
      }
      
      public function _ba183(param1:_vc586, param2:Number) : void
      {
         var _loc3_:Number = 1 - param2;
         this.x = this.x * _loc3_ + param1.x * param2;
         this.y = this.y * _loc3_ + param1.y * param2;
         this.z = this.z * _loc3_ + param1.z * param2;
         this.w = this.w * _loc3_ + param1.w * param2;
      }
      
      public function _gp666(param1:Number) : _vc586
      {
         return new _vc586(param1 * this.x,param1 * this.y,param1 * this.z,param1 * this.w);
      }
   }
}
