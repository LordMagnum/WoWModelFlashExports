package org.papervision3d.core.math.util
{
   public class GLU
   {
       
      
      public function GLU()
      {
         super();
      }
      
      public static function unProject(param1:Number, param2:Number, param3:Number, param4:Array, param5:Array, param6:Array, param7:Array) : Boolean
      {
         var _loc8_:Array = new Array(16);
         var _loc9_:Array = new Array(4);
         multMatrices(param4,param5,_loc8_);
         if(!invertMatrix(_loc8_,_loc8_))
         {
            return false;
         }
         _loc9_[0] = param1;
         _loc9_[1] = param2;
         _loc9_[2] = param3;
         _loc9_[3] = 1;
         _loc9_[0] = (_loc9_[0] - param6[0]) / param6[2];
         _loc9_[1] = (_loc9_[1] - param6[1]) / param6[3];
         _loc9_[0] = _loc9_[0] * 2 - 1;
         _loc9_[1] = _loc9_[1] * 2 - 1;
         _loc9_[2] = _loc9_[2] * 2 - 1;
         multMatrixVec(_loc8_,_loc9_,param7);
         if(param7[3] == 0)
         {
            return false;
         }
         param7[0] = param7[0] / param7[3];
         param7[1] = param7[1] / param7[3];
         param7[2] = param7[2] / param7[3];
         return true;
      }
      
      public static function scale(param1:Array, param2:Number, param3:Number, param4:Number) : void
      {
         makeIdentity(param1);
         param1[0] = param2;
         param1[5] = param3;
         param1[10] = param4;
      }
      
      public static function multMatrixVec(param1:Array, param2:Array, param3:Array) : void
      {
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < 4)
         {
            param3[_loc4_] = param2[0] * param1[int(0 * 4 + _loc4_)] + param2[1] * param1[int(1 * 4 + _loc4_)] + param2[2] * param1[int(2 * 4 + _loc4_)] + param2[3] * param1[int(3 * 4 + _loc4_)];
            _loc4_++;
         }
      }
      
      public static function invertMatrix(param1:Array, param2:Array) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Number = NaN;
         var _loc8_:Array = new Array(4);
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            _loc8_[_loc3_] = new Array(4);
            _loc4_ = 0;
            while(_loc4_ < 4)
            {
               _loc8_[_loc3_][_loc4_] = param1[_loc3_ * 4 + _loc4_];
               _loc4_++;
            }
            _loc3_++;
         }
         makeIdentity(param2);
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            _loc6_ = _loc3_;
            _loc4_ = _loc3_ + 1;
            while(_loc4_ < 4)
            {
               if(Math.abs(_loc8_[_loc4_][_loc3_]) > Math.abs(_loc8_[_loc3_][_loc3_]))
               {
                  _loc6_ = _loc4_;
               }
               _loc4_++;
            }
            if(_loc6_ != _loc3_)
            {
               _loc5_ = 0;
               while(_loc5_ < 4)
               {
                  _loc7_ = _loc8_[_loc3_][_loc5_];
                  _loc8_[_loc3_][_loc5_] = _loc8_[_loc6_][_loc5_];
                  _loc8_[_loc6_][_loc5_] = _loc7_;
                  _loc7_ = param2[_loc3_ * 4 + _loc5_];
                  param2[_loc3_ * 4 + _loc5_] = param2[_loc6_ * 4 + _loc5_];
                  param2[_loc6_ * 4 + _loc5_] = _loc7_;
                  _loc5_++;
               }
            }
            if(_loc8_[_loc3_][_loc3_] == 0)
            {
               return false;
            }
            _loc7_ = _loc8_[_loc3_][_loc3_];
            _loc5_ = 0;
            while(_loc5_ < 4)
            {
               _loc8_[_loc3_][_loc5_] = _loc8_[_loc3_][_loc5_] / _loc7_;
               param2[_loc3_ * 4 + _loc5_] = param2[_loc3_ * 4 + _loc5_] / _loc7_;
               _loc5_++;
            }
            _loc4_ = 0;
            while(_loc4_ < 4)
            {
               if(_loc4_ != _loc3_)
               {
                  _loc7_ = _loc8_[_loc4_][_loc3_];
                  _loc5_ = 0;
                  while(_loc5_ < 4)
                  {
                     _loc8_[_loc4_][_loc5_] = _loc8_[_loc4_][_loc5_] - _loc8_[_loc3_][_loc5_] * _loc7_;
                     param2[_loc4_ * 4 + _loc5_] = param2[_loc4_ * 4 + _loc5_] - param2[_loc3_ * 4 + _loc5_] * _loc7_;
                     _loc5_++;
                  }
               }
               _loc4_++;
            }
            _loc3_++;
         }
         return true;
      }
      
      public static function ortho(param1:Array, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number) : Boolean
      {
         var _loc8_:Number = (param3 + param2) / (param3 - param2);
         var _loc9_:Number = (param4 + param5) / (param4 - param5);
         var _loc10_:Number = (param7 + param6) / (param7 - param6);
         makeIdentity(param1);
         param1[0] = 2 / (param3 - param2);
         param1[5] = 2 / (param4 - param5);
         param1[10] = -2 / (param7 - param6);
         param1[12] = _loc8_;
         param1[13] = _loc9_;
         param1[14] = _loc10_;
         return true;
      }
      
      public static function multMatrices(param1:Array, param2:Array, param3:Array) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < 4)
         {
            _loc5_ = 0;
            while(_loc5_ < 4)
            {
               param3[int(_loc4_ * 4 + _loc5_)] = param1[int(_loc4_ * 4 + 0)] * param2[int(0 * 4 + _loc5_)] + param1[int(_loc4_ * 4 + 1)] * param2[int(1 * 4 + _loc5_)] + param1[int(_loc4_ * 4 + 2)] * param2[int(2 * 4 + _loc5_)] + param1[int(_loc4_ * 4 + 3)] * param2[int(3 * 4 + _loc5_)];
               _loc5_++;
            }
            _loc4_++;
         }
      }
      
      public static function perspective(param1:Array, param2:Number, param3:Number, param4:Number, param5:Number) : Boolean
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = param2 / 2 * (Math.PI / 180);
         _loc8_ = param5 - param4;
         _loc6_ = Math.sin(_loc9_);
         if(_loc8_ == 0 || _loc6_ == 0 || param3 == 0)
         {
            return false;
         }
         _loc7_ = Math.cos(_loc9_) / _loc6_;
         makeIdentity(param1);
         param1[0] = _loc7_ / param3;
         param1[5] = _loc7_;
         param1[10] = -(param5 + param4) / _loc8_;
         param1[11] = -1;
         param1[14] = -(2 * param4 * param5) / _loc8_;
         param1[15] = 0;
         return true;
      }
      
      public static function makeIdentity(param1:Array) : void
      {
         param1[0 + 4 * 0] = 1;
         param1[0 + 4 * 1] = 0;
         param1[0 + 4 * 2] = 0;
         param1[0 + 4 * 3] = 0;
         param1[1 + 4 * 0] = 0;
         param1[1 + 4 * 1] = 1;
         param1[1 + 4 * 2] = 0;
         param1[1 + 4 * 3] = 0;
         param1[2 + 4 * 0] = 0;
         param1[2 + 4 * 1] = 0;
         param1[2 + 4 * 2] = 1;
         param1[2 + 4 * 3] = 0;
         param1[3 + 4 * 0] = 0;
         param1[3 + 4 * 1] = 0;
         param1[3 + 4 * 2] = 0;
         param1[3 + 4 * 3] = 1;
      }
   }
}
