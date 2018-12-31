package com.zam.wow
{
   import com.zam.Quaternion;
   import flash.utils.ByteArray;
   
   public class AnimatedQuaternion
   {
       
      
      public var _type:int;
      
      public var _times:Vector.<int>;
      
      public var _data:Vector.<Quaternion>;
      
      public var _used:Boolean;
      
      private var tmpQuat:Quaternion;
      
      public function AnimatedQuaternion()
      {
         super();
         this.tmpQuat = new Quaternion();
      }
      
      public static function getValueFrom(param1:Vector.<AnimatedQuaternion>, param2:int, param3:int, param4:Quaternion = null) : Quaternion
      {
         if(!param4)
         {
            param4 = new Quaternion();
         }
         if(param1.length == 0)
         {
            return param4;
         }
         if(param2 >= param1.length)
         {
            param2 = 0;
         }
         return param1[param2].getValue(param3,param4);
      }
      
      public function getValue(param1:int, param2:Quaternion = null) : Quaternion
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Number = NaN;
         if(!param2)
         {
            param2 = new Quaternion();
         }
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
                  return Quaternion.slerp(this._data[_loc6_],this._data[_loc6_ + 1],_loc8_,param2);
               }
               return param2.copyFrom(this._data[_loc6_]);
            }
            if(this._data.length > 0)
            {
               return param2.copyFrom(this._data[0]);
            }
            return param2;
         }
         if(this._data.length == 0)
         {
            return param2;
         }
         return param2.copyFrom(this._data[0]);
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
         this._data = new Vector.<Quaternion>(_loc3_);
         if(this._type == 2)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               param1.position = param1.position + 16;
               this._data[_loc2_] = WowUtil.readQuaternion(param1);
               _loc2_++;
            }
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               this._data[_loc2_] = WowUtil.readQuaternion(param1);
               _loc2_++;
            }
         }
      }
   }
}
