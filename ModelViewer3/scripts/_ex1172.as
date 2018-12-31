package
{
   import flash.utils.ByteArray;
   
   public class _ex1172
   {
      
      private static var _ju782:_vc586 = new _vc586();
      
      private static var _ya1132:_kp1215 = new _kp1215();
      
      private static var _xe185:_gs89 = new _gs89();
      
      private static var _gk554:_gs89 = new _gs89();
      
      private static var _gg321:_gs89 = new _gs89();
      
      public static var _tl295:Number = 1;
      
      private static var _nk1373:_vc586 = new _vc586();
      
      private static var _nl33:_vc586 = new _vc586();
       
      
      public var _eh190:Array = null;
      
      public var flags:int;
      
      public var _hi242:_gs89;
      
      public var _bf499:int;
      
      public var _mc222:int;
      
      public var _wx54:int;
      
      public var _we360:int;
      
      public var _rj455:Array = null;
      
      public var _yl910:_gs89;
      
      public var _xg1300:Array;
      
      public var _vo1320:int;
      
      public var _ia850:_kp1215;
      
      public var _lk959:Array;
      
      public var _sl1117:Boolean;
      
      public var _nf1406:Array;
      
      public var _qp408:Array;
      
      public var _fe863:Array = null;
      
      public var _mb870:_gs89;
      
      public var _qg444:Array = null;
      
      public var _jl938:_kp1215;
      
      public var _lu1230:Array = null;
      
      public var _co574:Array;
      
      public var _ta825:Array;
      
      public var _bi835:Array = null;
      
      public var _jq951:int;
      
      public function _ex1172(param1:ByteArray)
      {
         var _loc2_:int = 0;
         this._jl938 = new _kp1215();
         super();
         this._wx54 = param1.readInt();
         this.flags = param1.readInt();
         this._we360 = param1.readShort();
         param1.position = param1.position + 6;
         var _loc3_:_ap392 = new _ap392(param1);
         var _loc4_:_ap392 = new _ap392(param1);
         var _loc5_:_ap392 = new _ap392(param1);
         this._yl910 = _gs89._wg1203(param1);
         this._hi242 = this._yl910.multiply(-1);
         var _loc6_:int = param1.position;
         this._jq951 = _loc3_._us904;
         this._vo1320 = _loc4_._us904;
         this._mc222 = _loc5_._us904;
         this._qp408 = _wl552._ou1381(param1,_loc3_._af843);
         this._nf1406 = _wl552._ou1381(param1,_loc3_._rb697);
         this._co574 = _wl552._ou1381(param1,_loc4_._af843);
         this._xg1300 = _wl552._ou1381(param1,_loc4_._rb697);
         this._lk959 = _wl552._ou1381(param1,_loc5_._af843);
         this._ta825 = _wl552._ou1381(param1,_loc5_._rb697);
         if(_loc3_._af843.length > 0 && _loc3_._af843.offset > 0 && _loc3_._af843.length == _loc3_._rb697.length)
         {
            this._fe863 = [];
            this._lu1230 = [];
         }
         if(_loc4_._af843.length > 0 && _loc4_._af843.offset > 0 && _loc4_._af843.length == _loc4_._rb697.length)
         {
            this._eh190 = [];
            this._qg444 = [];
         }
         if(_loc5_._af843.length > 0 && _loc5_._af843.offset > 0 && _loc5_._af843.length == _loc5_._rb697.length)
         {
            this._rj455 = [];
            this._bi835 = [];
         }
         param1.position = _loc6_;
         this._bf499 = -1;
      }
      
      public function setScale(param1:_gs89, param2:int, param3:int) : Boolean
      {
         var _loc7_:int = 0;
         var _loc8_:_gs89 = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         if(param2 >= this._rj455.length)
         {
            if(this._rj455[0] && this._rj455[0][0])
            {
               param1.copy(this._rj455[0][0]);
               return true;
            }
            return false;
         }
         var _loc4_:Array = this._rj455[param2];
         var _loc5_:Array = this._bi835[param2];
         if(_loc4_ == null || _loc4_.length == 0)
         {
            return false;
         }
         if(param3 == 0)
         {
            param1.copy(_loc4_[0]);
            return true;
         }
         var _loc6_:int = 1;
         while(_loc6_ < _loc4_.length)
         {
            _loc7_ = _loc5_[_loc6_];
            if(param3 <= _loc7_)
            {
               _loc8_ = _loc4_[_loc6_ - 1];
               param1.copy(_loc4_[_loc6_]);
               _loc9_ = _loc7_ - param3;
               _loc10_ = _loc7_ - _loc5_[_loc6_ - 1];
               param1._ba183(_loc8_,_loc9_ / _loc10_);
               return true;
            }
            _loc6_++;
         }
         param1.copy(_loc4_[0]);
         return true;
      }
      
      public function _yh865(param1:int, param2:int) : _gs89
      {
         var _loc6_:int = 0;
         var _loc7_:_gs89 = null;
         var _loc8_:_gs89 = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         if(param1 >= this._rj455.length)
         {
            return this._rj455[0][0];
         }
         var _loc3_:Array = this._rj455[param1];
         var _loc4_:Array = this._bi835[param1];
         if(_loc3_ == null || _loc3_.length == 0)
         {
            return null;
         }
         if(param2 == 0)
         {
            return this._rj455[param1][0];
         }
         var _loc5_:int = 1;
         while(_loc5_ < _loc3_.length)
         {
            _loc6_ = _loc4_[_loc5_];
            if(param2 <= _loc6_)
            {
               _loc7_ = _loc3_[_loc5_ - 1];
               _loc8_ = _loc3_[_loc5_];
               _loc9_ = _loc6_ - param2;
               _loc10_ = _loc6_ - _loc4_[_loc5_ - 1];
               return _loc8_._gy1092(_loc7_,_loc9_ / _loc10_);
            }
            _loc5_++;
         }
         return this._rj455[param1][0];
      }
      
      public function setRotation(param1:_vc586, param2:int, param3:int) : Boolean
      {
         var _loc7_:int = 0;
         var _loc8_:_vc586 = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         if(param2 >= this._eh190.length)
         {
            if(this._eh190[0] && this._eh190[0][0])
            {
               param1.copy(this._eh190[0][0]);
               return true;
            }
            return false;
         }
         var _loc4_:Array = this._eh190[param2];
         var _loc5_:Array = this._qg444[param2];
         if(_loc4_ == null || _loc4_.length == 0)
         {
            return false;
         }
         if(param3 == 0)
         {
            param1.copy(_loc4_[0]);
            return true;
         }
         var _loc6_:int = 1;
         while(_loc6_ < _loc4_.length)
         {
            _loc7_ = _loc5_[_loc6_];
            if(param3 <= _loc7_)
            {
               _loc8_ = _loc4_[_loc6_ - 1];
               param1.copy(_loc4_[_loc6_]);
               _loc9_ = _loc7_ - param3;
               _loc10_ = _loc7_ - _loc5_[_loc6_ - 1];
               param1._ba183(_loc8_,_loc9_ / _loc10_);
               return true;
            }
            _loc6_++;
         }
         param1.copy(_loc4_[0]);
         return true;
      }
      
      public function _ml1282(param1:int, param2:int) : _gs89
      {
         var _loc6_:int = 0;
         var _loc7_:_gs89 = null;
         var _loc8_:_gs89 = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         if(param1 >= this._fe863.length)
         {
            return this._fe863[0][0];
         }
         var _loc3_:Array = this._fe863[param1];
         var _loc4_:Array = this._lu1230[param1];
         if(_loc3_ == null || _loc3_.length == 0)
         {
            return null;
         }
         if(param2 == 0)
         {
            return this._fe863[param1][0];
         }
         var _loc5_:int = 1;
         while(_loc5_ < _loc3_.length)
         {
            _loc6_ = _loc4_[_loc5_];
            if(param2 <= _loc6_)
            {
               _loc7_ = _loc3_[_loc5_ - 1];
               _loc8_ = _loc3_[_loc5_];
               _loc9_ = _loc6_ - param2;
               _loc10_ = _loc6_ - _loc4_[_loc5_ - 1];
               return _loc8_._gy1092(_loc7_,_loc9_ / _loc10_);
            }
            _loc5_++;
         }
         return this._fe863[param1][0];
      }
      
      public function _la487(param1:int, param2:ByteArray) : void
      {
         var _loc3_:int = param2.position;
         if(param1 < this._qp408.length)
         {
            this._fe863[param1] = _wl552._wl42(param2,this._qp408[param1]);
            this._lu1230[param1] = _wl552._pr536(param2,this._nf1406[param1]);
         }
         if(param1 < this._co574.length)
         {
            this._eh190[param1] = _wl552._ds1196(param2,this._co574[param1]);
            this._qg444[param1] = _wl552._pr536(param2,this._xg1300[param1]);
         }
         if(param1 < this._lk959.length)
         {
            this._rj455[param1] = _wl552._wl42(param2,this._lk959[param1]);
            this._bi835[param1] = _wl552._pr536(param2,this._ta825[param1]);
         }
         param2.position = _loc3_;
      }
      
      public function reset() : void
      {
         this._sl1117 = false;
      }
      
      public function animate(param1:Vector.<_ex1172>, param2:int, param3:int, param4:_kp1215, param5:int = -1, param6:int = 0, param7:int = 0, param8:Boolean = true) : void
      {
         var _loc14_:Boolean = false;
         var _loc15_:Boolean = false;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         if(this._sl1117)
         {
            return;
         }
         var _loc9_:_ex1172 = this._we360 >= 0?param1[this._we360]:null;
         var _loc10_:* = this._fe863 != null;
         var _loc11_:* = this._eh190 != null;
         var _loc12_:* = this._rj455 != null;
         if(this._bf499 >= 0)
         {
            param2 = this._bf499;
            param5 = -1;
            param6 = -1;
            param7 = 0;
         }
         var _loc13_:Number = 0;
         if(param5 >= 0)
         {
            _loc16_ = param6;
            _loc17_ = param7;
            if(_loc17_ != 0)
            {
               _loc13_ = _loc16_ / _loc17_;
            }
         }
         if(_loc9_ != null)
         {
            _loc9_.animate(param1,param2,param3,param4);
            _ya1132.copy(_loc9_._jl938);
         }
         else if(param4 != null)
         {
            _ya1132.copy(param4);
         }
         _ya1132.translate(this._yl910);
         if((this.flags & (_md341._dn974 | _md341._aq1392)) != 0 && (_loc10_ || _loc11_ || _loc12_))
         {
            if(_loc10_)
            {
               _loc14_ = this._tk72(_gk554,param2,param3);
               _loc15_ = false;
               if(param5 >= 0)
               {
                  _loc15_ = this._tk72(_xe185,param5,0);
               }
               if(_loc14_ || _loc15_)
               {
                  if(!_loc14_)
                  {
                     _gk554.zero();
                  }
                  if(!_loc15_)
                  {
                     _xe185.zero();
                  }
                  if(param5 >= 0)
                  {
                     _gk554._ba183(_xe185,_loc13_);
                  }
                  _ya1132.translate(_gk554);
               }
            }
            if(_loc11_)
            {
               _loc14_ = this.setRotation(_nk1373,param2,param3);
               _loc15_ = false;
               if(param5 >= 0)
               {
                  _loc15_ = this.setRotation(_ju782,param5,0);
               }
               if(_loc14_ || _loc15_)
               {
                  if(!_loc14_)
                  {
                     _nk1373._os395();
                  }
                  if(!_loc15_)
                  {
                     _ju782._os395();
                  }
                  if(param5 >= 0)
                  {
                     _nk1373._ba183(_ju782,_loc13_);
                  }
                  _ya1132.rotate(_nk1373);
               }
            }
            if(_loc12_)
            {
               _loc14_ = this.setScale(_gk554,param2,param3);
               _loc15_ = false;
               if(param5 >= 0)
               {
                  _loc15_ = this.setScale(_xe185,param5,0);
               }
               if(_loc14_ || _loc15_)
               {
                  if(!_loc14_)
                  {
                     _gk554.x = 1;
                     _gk554.y = 1;
                     _gk554.z = 1;
                  }
                  if(!_loc15_)
                  {
                     _xe185.x = 1;
                     _xe185.y = 1;
                     _xe185.z = 1;
                  }
                  if(param5 >= 0)
                  {
                     _gk554._ba183(_xe185,_loc13_);
                  }
                  _ya1132.scale(_gk554);
               }
            }
         }
         if((this.flags & _md341._ci388) != 0)
         {
            _ya1132._vq676 = _tl295;
            _ya1132._vt375 = 0;
            _ya1132._xp440 = 0;
            _ya1132._vg435 = -_tl295;
            _ya1132._aw971 = 0;
            _ya1132._lr388 = 0;
            _ya1132._qf1306 = 0;
            _ya1132._lr1285 = 0;
            _ya1132._oc1338 = _tl295;
            _ya1132._sm762 = 0;
            _ya1132._dn700 = 0;
            _ya1132._ho535 = 0;
         }
         _ya1132.translate(this._hi242);
         this._jl938.copy(_ya1132);
         this._sl1117 = true;
      }
      
      public function _tk72(param1:_gs89, param2:int, param3:int) : Boolean
      {
         var _loc7_:int = 0;
         var _loc8_:_gs89 = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         if(param2 >= this._fe863.length)
         {
            if(this._fe863[0] && this._fe863[0][0])
            {
               param1.copy(this._fe863[0][0]);
               return true;
            }
            return false;
         }
         var _loc4_:Array = this._fe863[param2];
         var _loc5_:Array = this._lu1230[param2];
         if(_loc4_ == null || _loc4_.length == 0)
         {
            return false;
         }
         if(param3 == 0)
         {
            param1.copy(this._fe863[param2][0]);
            return true;
         }
         var _loc6_:int = 1;
         while(_loc6_ < _loc4_.length)
         {
            _loc7_ = _loc5_[_loc6_];
            if(param3 <= _loc7_)
            {
               _loc8_ = _loc4_[_loc6_ - 1];
               param1.copy(_loc4_[_loc6_]);
               _loc9_ = _loc7_ - param3;
               _loc10_ = _loc7_ - _loc5_[_loc6_ - 1];
               param1._ba183(_loc8_,_loc9_ / _loc10_);
               return true;
            }
            _loc6_++;
         }
         param1.copy(this._fe863[param2][0]);
         return true;
      }
      
      public function getRotation(param1:int, param2:int) : _vc586
      {
         var _loc6_:int = 0;
         var _loc7_:_vc586 = null;
         var _loc8_:_vc586 = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         if(param1 >= this._eh190.length)
         {
            return this._eh190[0][0];
         }
         var _loc3_:Array = this._eh190[param1];
         var _loc4_:Array = this._qg444[param1];
         if(_loc3_ == null || _loc3_.length == 0)
         {
            return null;
         }
         if(param2 == 0)
         {
            return _loc3_[0];
         }
         var _loc5_:int = 1;
         while(_loc5_ < _loc3_.length)
         {
            _loc6_ = _loc4_[_loc5_];
            if(param2 <= _loc6_)
            {
               _loc7_ = _loc3_[_loc5_ - 1];
               _loc8_ = _loc3_[_loc5_];
               _loc9_ = _loc6_ - param2;
               _loc10_ = _loc6_ - _loc4_[_loc5_ - 1];
               return _loc8_._gy1092(_loc7_,_loc9_ / _loc10_);
            }
            _loc5_++;
         }
         return this._eh190[param1][0];
      }
   }
}
