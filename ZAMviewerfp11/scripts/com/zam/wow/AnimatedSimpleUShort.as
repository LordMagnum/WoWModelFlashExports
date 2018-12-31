package com.zam.wow
{
   import flash.utils.ByteArray;
   
   public class AnimatedSimpleUShort
   {
       
      
      public var _times:Vector.<int>;
      
      public var _data:Vector.<int>;
      
      public function AnimatedSimpleUShort()
      {
         super();
      }
      
      public function getValue(param1:int, param2:int = 0) : int
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Number = NaN;
         if(this._data.length > 1 && this._times.length > 1)
         {
            _loc3_ = this._times[this._times.length - 1];
            if(_loc3_ > 0 && param1 > _loc3_)
            {
               param1 = param1 % _loc3_;
            }
            _loc4_ = 0;
            _loc5_ = 0;
            while(_loc5_ < this._times.length - 1)
            {
               if(param1 >= this._times[_loc5_] && param1 < this._times[_loc5_ + 1])
               {
                  _loc4_ = _loc5_;
                  break;
               }
               _loc5_++;
            }
            _loc6_ = this._times[_loc4_];
            _loc7_ = this._times[_loc4_ + 1];
            _loc8_ = 0;
            if(_loc6_ != _loc7_)
            {
               _loc8_ = (param1 - _loc6_) / (_loc7_ - _loc6_);
            }
            return this._data[_loc4_] + (this._data[_loc4_ + 1] - this._data[_loc4_]) * _loc8_;
         }
         if(this._data.length > 0)
         {
            return this._data[0];
         }
         return param2;
      }
      
      public function read(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = param1.readInt();
         this._times = new Vector.<int>(_loc3_);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this._times[_loc2_] = param1.readInt();
            _loc2_++;
         }
         _loc3_ = param1.readInt();
         this._data = new Vector.<int>(_loc3_);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this._data[_loc2_] = param1.readUnsignedShort();
            _loc2_++;
         }
      }
   }
}
