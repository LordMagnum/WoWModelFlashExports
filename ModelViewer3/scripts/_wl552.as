package
{
   import flash.utils.ByteArray;
   
   public class _wl552
   {
       
      
      public function _wl552()
      {
         super();
      }
      
      public static function _yj684(param1:ByteArray, param2:_jk827, param3:_hg665) : Array
      {
         var _loc4_:int = 0;
         var _loc5_:int = param2.length;
         var _loc6_:Array = [];
         param1.position = param2.offset;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc6_[_loc4_] = new _kp594(param1,param3);
            _loc4_++;
         }
         return _loc6_;
      }
      
      public static function _cg1012(param1:ByteArray, param2:_jk827) : Array
      {
         var _loc3_:int = 0;
         var _loc6_:_iq662 = null;
         var _loc4_:int = param2.length;
         var _loc5_:Array = [];
         param1.position = param2.offset;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc6_ = new _iq662(param1);
            _loc5_[_loc3_] = _loc6_;
            _loc3_++;
         }
         return _loc5_;
      }
      
      public static function _gh1379(param1:ByteArray, param2:_jk827) : Array
      {
         var _loc3_:int = 0;
         var _loc4_:int = param2.length;
         var _loc5_:Array = [];
         param1.position = param2.offset;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_[_loc3_] = new _le493(param1);
            _loc3_++;
         }
         return _loc5_;
      }
      
      public static function _cl1313(param1:ByteArray, param2:_jk827) : Array
      {
         var _loc3_:int = 0;
         var _loc4_:int = param2.length;
         var _loc5_:Array = [];
         param1.position = param2.offset;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_[_loc3_] = new _pg792(param1);
            _loc3_++;
         }
         return _loc5_;
      }
      
      public static function _py1327(param1:ByteArray, param2:int) : Array
      {
         var _loc3_:int = 0;
         var _loc4_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < param2)
         {
            _loc4_[_loc3_] = param1.readFloat();
            _loc3_++;
         }
         return _loc4_;
      }
      
      public static function _lv815(param1:int) : String
      {
         if(param1 < 0 || param1 > 10000)
         {
            return "0000";
         }
         var _loc2_:* = "";
         if(param1 < 1000)
         {
            _loc2_ = _loc2_ + "0";
         }
         if(param1 < 100)
         {
            _loc2_ = _loc2_ + "0";
         }
         if(param1 < 10)
         {
            _loc2_ = _loc2_ + "0";
         }
         return _loc2_ + param1;
      }
      
      public static function _eb595(param1:ByteArray, param2:_jk827) : Array
      {
         var _loc3_:int = 0;
         var _loc4_:int = param2.length;
         var _loc5_:Array = [];
         param1.position = param2.offset;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_[_loc3_] = new _nx958(param1);
            _loc3_++;
         }
         return _loc5_;
      }
      
      public static function _pr536(param1:ByteArray, param2:_jk827) : Array
      {
         var _loc3_:int = 0;
         var _loc4_:int = param2.length;
         var _loc5_:Array = [];
         if(_loc4_ == 0)
         {
            return _loc5_;
         }
         param1.position = param2.offset;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_[_loc3_] = param1.readInt();
            _loc3_++;
         }
         return _loc5_;
      }
      
      public static function _ss923(param1:int, param2:Array, param3:Array) : _vc586
      {
         var _loc5_:int = 0;
         var _loc6_:_vc586 = null;
         var _loc7_:_vc586 = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         if(!param2 || !param3 || param2.length == 0 || param3.length == 0)
         {
            return null;
         }
         var _loc4_:int = 0;
         while(_loc4_ < param2.length)
         {
            _loc5_ = param3[_loc4_];
            if(param1 <= _loc5_)
            {
               _loc6_ = param2[_loc4_ - 1];
               _loc7_ = param2[_loc4_];
               _loc8_ = _loc5_ - param1;
               _loc9_ = _loc5_ - param3[_loc4_ - 1];
               return _loc7_._gy1092(_loc6_,_loc8_ / _loc9_);
            }
            _loc4_++;
         }
         return param2[param2.length - 1];
      }
      
      public static function _ok1365(param1:ByteArray, param2:int) : Array
      {
         var _loc3_:int = 0;
         var _loc4_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < param2)
         {
            _loc4_[_loc3_] = param1.readUnsignedByte();
            _loc3_++;
         }
         return _loc4_;
      }
      
      public static function _ih1386(param1:ByteArray, param2:_ap392, param3:Array, param4:Array) : void
      {
         var _loc5_:int = 0;
         var _loc6_:Array = null;
         var _loc7_:Array = null;
         if(param2._af843.length > 0)
         {
            _loc6_ = _wl552._ou1381(param1,param2._af843);
            _loc7_ = _wl552._ou1381(param1,param2._rb697);
            _loc5_ = 0;
            while(_loc5_ < _loc6_.length)
            {
               param3[_loc5_] = _wl552._ds1196(param1,_loc6_[_loc5_]);
               _loc5_++;
            }
            _loc5_ = 0;
            while(_loc5_ < _loc7_.length)
            {
               param4[_loc5_] = _wl552._pr536(param1,_loc7_[_loc5_]);
               _loc5_++;
            }
         }
      }
      
      public static function _ou1381(param1:ByteArray, param2:_jk827) : Array
      {
         var _loc3_:int = 0;
         var _loc4_:int = param2.length;
         var _loc5_:Array = [];
         param1.position = param2.offset;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_[_loc3_] = new _jk827(param1);
            _loc3_++;
         }
         return _loc5_;
      }
      
      public static function _ds135(param1:ByteArray, param2:_jk827) : Array
      {
         var _loc3_:int = 0;
         var _loc4_:int = param2.length;
         var _loc5_:Array = [];
         param1.position = param2.offset;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_[_loc3_] = new _nm1047(param1);
            _loc3_++;
         }
         return _loc5_;
      }
      
      public static function _pf456(param1:ByteArray, param2:_jk827) : Vector.<_ex1172>
      {
         var _loc3_:int = 0;
         var _loc4_:int = param2.length;
         var _loc5_:Vector.<_ex1172> = new Vector.<_ex1172>();
         _loc5_.length = _loc4_;
         _loc5_.fixed = true;
         param1.position = param2.offset;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_[_loc3_] = new _ex1172(param1);
            _loc3_++;
         }
         return _loc5_;
      }
      
      public static function _ds1196(param1:ByteArray, param2:_jk827) : Array
      {
         var _loc3_:int = 0;
         var _loc4_:int = param2.length;
         var _loc5_:Array = [];
         if(_loc4_ == 0)
         {
            return _loc5_;
         }
         param1.position = param2.offset;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_[_loc3_] = _vc586._wg1203(param1);
            _loc3_++;
         }
         return _loc5_;
      }
      
      public static function _ec191(param1:ByteArray, param2:_jk827) : Array
      {
         var _loc3_:int = 0;
         var _loc6_:_rn1037 = null;
         var _loc4_:int = param2.length;
         var _loc5_:Array = [];
         param1.position = param2.offset;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc6_ = new _rn1037(param1);
            _loc5_[_loc3_] = _loc6_;
            _loc3_++;
         }
         return _loc5_;
      }
      
      public static function _pr1196(param1:int, param2:Array, param3:Array) : _gs89
      {
         var _loc5_:int = 0;
         var _loc6_:_gs89 = null;
         var _loc7_:_gs89 = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         if(!param2 || !param3 || param2.length == 0 || param3.length == 0)
         {
            return null;
         }
         param1 = param1 % param3[param3.length - 1];
         var _loc4_:int = 0;
         while(_loc4_ < param2.length)
         {
            _loc5_ = param3[_loc4_];
            if(param1 < _loc5_)
            {
               _loc6_ = param2[_loc4_ - 1];
               _loc7_ = param2[_loc4_];
               _loc8_ = _loc5_ - param1;
               _loc9_ = _loc5_ - param3[_loc4_ - 1];
               _loc10_ = _loc8_ / _loc9_;
               return _loc7_._gy1092(_loc6_,_loc10_);
            }
            _loc4_++;
         }
         return param2[param2.length - 1];
      }
      
      public static function _ni1117(param1:int, param2:Array, param3:Array) : Number
      {
         var _loc5_:int = 0;
         if(!param2 || !param3 || param2.length == 0 || param3.length == 0)
         {
            return 32767;
         }
         var _loc4_:int = 0;
         while(_loc4_ < param2.length)
         {
            _loc5_ = param3[_loc4_];
            if(param1 <= _loc5_)
            {
               return param2[_loc4_];
            }
            _loc4_++;
         }
         return param2[param2.length - 1];
      }
      
      public static function _nw119(param1:ByteArray, param2:_jk827) : Array
      {
         var _loc3_:int = 0;
         var _loc4_:int = param2.length;
         var _loc5_:Array = [];
         param1.position = param2.offset;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_[_loc3_] = param1.readUnsignedShort();
            _loc3_++;
         }
         return _loc5_;
      }
      
      public static function _wl42(param1:ByteArray, param2:_jk827) : Array
      {
         var _loc3_:int = 0;
         var _loc4_:int = param2.length;
         var _loc5_:Array = [];
         if(_loc4_ == 0)
         {
            return _loc5_;
         }
         param1.position = param2.offset;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_[_loc3_] = _gs89._wg1203(param1);
            _loc3_++;
         }
         return _loc5_;
      }
      
      public static function _ij663(param1:ByteArray, param2:_jk827) : Array
      {
         var _loc3_:int = 0;
         var _loc6_:_yy607 = null;
         var _loc4_:int = param2.length;
         var _loc5_:Array = [];
         param1.position = param2.offset;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc6_ = new _yy607(param1);
            _loc5_[_loc3_] = _loc6_;
            _loc3_++;
         }
         return _loc5_;
      }
      
      public static function _fy1311(param1:ByteArray, param2:_jk827) : Array
      {
         var _loc3_:int = 0;
         var _loc4_:int = param2.length;
         var _loc5_:Array = [];
         param1.position = param2.offset;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_[_loc3_] = new _du1292(param1);
            _loc3_++;
         }
         return _loc5_;
      }
      
      public static function _xv388(param1:ByteArray, param2:_jk827) : Array
      {
         var _loc3_:int = 0;
         var _loc4_:int = param2.length;
         var _loc5_:Array = [];
         if(_loc4_ == 0)
         {
            return _loc5_;
         }
         param1.position = param2.offset;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_[_loc3_] = param1.readShort();
            _loc3_++;
         }
         return _loc5_;
      }
      
      public static function _rs277(param1:int) : String
      {
         if(param1 < 0 || param1 > 100)
         {
            return "00";
         }
         var _loc2_:* = "";
         if(param1 < 10)
         {
            _loc2_ = _loc2_ + "0";
         }
         return _loc2_ + param1;
      }
      
      public static function _he10(param1:int) : String
      {
         switch(param1)
         {
            case 0:
               return "OPAQUE";
            case 1:
               return "MOD";
            case 2:
               return "DECAL";
            case 3:
               return "ADD";
            case 4:
               return "MOD2X";
            case 5:
               return "FADE";
            case 6:
               return "MOD2X_NA";
            case 7:
               return "ADD_NA";
            case 8:
               return "ENVMAP";
            default:
               return "UNDEFINED";
         }
      }
      
      public static function _ja279(param1:ByteArray, param2:_ap392, param3:Array, param4:Array) : void
      {
         var _loc5_:int = 0;
         var _loc6_:Array = null;
         var _loc7_:Array = null;
         if(param2._af843.length > 0)
         {
            _loc6_ = _wl552._ou1381(param1,param2._af843);
            _loc7_ = _wl552._ou1381(param1,param2._rb697);
            _loc5_ = 0;
            while(_loc5_ < _loc6_.length)
            {
               param3[_loc5_] = _wl552._wl42(param1,_loc6_[_loc5_]);
               _loc5_++;
            }
            _loc5_ = 0;
            while(_loc5_ < _loc7_.length)
            {
               param4[_loc5_] = _wl552._pr536(param1,_loc7_[_loc5_]);
               _loc5_++;
            }
         }
      }
   }
}
