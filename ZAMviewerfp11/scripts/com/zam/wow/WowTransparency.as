package com.zam.wow
{
   import flash.utils.ByteArray;
   
   public class WowTransparency
   {
       
      
      public var alpha:Vector.<AnimatedUShort>;
      
      public function WowTransparency()
      {
         super();
      }
      
      public function read(param1:ByteArray) : void
      {
         this.alpha = WowUtil.readAnimatedUShortSet(param1);
      }
      
      public function used(param1:int) : Boolean
      {
         if(this.alpha.length == 0)
         {
            return false;
         }
         if(param1 < this.alpha.length)
         {
            return this.alpha[param1]._used;
         }
         return this.alpha[0]._used;
      }
      
      public function getValue(param1:int, param2:int) : Number
      {
         var _loc3_:Number = NaN;
         if(this.used(param1))
         {
            _loc3_ = AnimatedUShort.getValueFrom(this.alpha,param1,param2) / 32767;
         }
         else
         {
            _loc3_ = 1;
         }
         if(_loc3_ > 1)
         {
            _loc3_ = 1;
         }
         else if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         return _loc3_;
      }
   }
}
