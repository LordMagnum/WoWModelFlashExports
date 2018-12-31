package com.zam.wow
{
   import flash.utils.ByteArray;
   
   public class AnimatedUShort
   {
       
      
      public var _type:int;
      
      public var _times:Vector.<int>;
      
      public var _data:Vector.<int>;
      
      public var _used:Boolean;
      
      public function AnimatedUShort()
      {
         super();
      }
      
      public static function isUsed(param1:Vector.<AnimatedUShort>, param2:int) : Boolean
      {
         if(param1.length == 0)
         {
            return false;
         }
         if(param2 >= param1.length)
         {
            param2 = 0;
         }
         return param1[param2]._used;
      }
      
      public static function getValueFrom(param1:Vector.<AnimatedUShort>, param2:int, param3:int) : int
      {
         if(param1.length == 0)
         {
            return 0;
         }
         if(param2 >= param1.length)
         {
            param2 = 0;
         }
         return param1[param2].getValue(param3);
      }
      
      public function getValue(param1:int, param2:int = 0) : int
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Number = NaN;
         if(this._type != 0 || this._data.length > 1)
         {
            if(this._times.length > 1)
            {
               _loc3_ = this._times[this._times.length - 1];
               if(_loc3_ > 0 && param1 > _loc3_)
               {
                  param1 = param1 % _loc3_;
               }
               _loc6_ = 0;
               _loc7_ = 0;
               while(_loc7_ < this._times.length - 1)
               {
                  if(param1 >= this._times[_loc7_] && param1 < this._times[_loc7_ + 1])
                  {
                     _loc6_ = _loc7_;
                     break;
                  }
                  _loc7_++;
               }
               _loc4_ = this._times[_loc6_];
               _loc5_ = this._times[_loc6_ + 1];
               _loc8_ = 0;
               if(_loc4_ != _loc5_)
               {
                  _loc8_ = (param1 - _loc4_) / (_loc5_ - _loc4_);
               }
               if(this._type == 1)
               {
                  return this._data[_loc6_] + (this._data[_loc6_ + 1] - this._data[_loc6_]) * _loc8_;
               }
               return this._data[_loc6_];
            }
            if(this._data.length > 0)
            {
               return this._data[0];
            }
            return param2;
         }
         if(this._data.length == 0)
         {
            return param2;
         }
         return this._data[0];
      }
      
      public function read(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         this._used = param1.readBoolean();
         var _loc3_:int = param1.readInt();
         this._times = new Vector.<int>(_loc3_);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this._times[_loc2_] = param1.readInt();
            _loc2_++;
         }
         this._type = param1.readInt();
         _loc3_ = param1.readInt();
         this._data = new Vector.<int>(_loc3_);
         if(this._type == 2)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               param1.position = param1.position + 2;
               this._data[_loc2_] = param1.readUnsignedShort();
               _loc2_++;
            }
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               this._data[_loc2_] = param1.readUnsignedShort();
               _loc2_++;
            }
         }
      }
   }
}
