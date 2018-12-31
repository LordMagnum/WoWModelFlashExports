package
{
   public final class _kp1215
   {
      
      private static var _qr1179:Number;
      
      private static var _ft231:_kp1215 = new _kp1215();
      
      private static var _yg453:Number;
      
      private static var _ch396:Number;
      
      private static var _mm1104:Number;
      
      private static var _oj253:Number;
      
      private static var _be900:Number;
      
      private static var _jt638:Number;
      
      private static var _ai1099:Number;
      
      private static var _gn838:Number;
      
      private static var _ht383:Number;
      
      private static var _qk568:Number;
      
      private static var _ts1119:Number;
      
      private static var _px1172:Number;
      
      private static var _up1109:Number;
      
      private static var _kx1304:Number;
      
      private static var _rm473:Number;
       
      
      public var _rv1142:Number;
      
      public var _lr1285:Number;
      
      public var _le716:Number;
      
      public var _vg435:Number;
      
      public var _vt375:Number;
      
      public var _sm762:Number;
      
      public var _aw971:Number;
      
      public var _qf1306:Number;
      
      public var _lr388:Number;
      
      public var _xh513:Number;
      
      public var _ho535:Number;
      
      public var _dn700:Number;
      
      public var _dv1018:Number;
      
      public var _xp440:Number;
      
      public var _oc1338:Number;
      
      public var _vq676:Number;
      
      public function _kp1215(param1:Number = 1.0, param2:Number = 0.0, param3:Number = 0.0, param4:Number = 0.0, param5:Number = 0.0, param6:Number = 1.0, param7:Number = 0.0, param8:Number = 0.0, param9:Number = 0.0, param10:Number = 0.0, param11:Number = 1.0, param12:Number = 0.0, param13:Number = 0.0, param14:Number = 0.0, param15:Number = 0.0, param16:Number = 1.0)
      {
         super();
         this._vq676 = param1;
         this._vt375 = param2;
         this._xp440 = param3;
         this._sm762 = param4;
         this._vg435 = param5;
         this._aw971 = param6;
         this._lr388 = param7;
         this._dn700 = param8;
         this._qf1306 = param9;
         this._lr1285 = param10;
         this._oc1338 = param11;
         this._ho535 = param12;
         this._dv1018 = param13;
         this._xh513 = param14;
         this._rv1142 = param15;
         this._le716 = param16;
      }
      
      public static function translationMatrix(param1:Number, param2:Number, param3:Number) : _kp1215
      {
         return new _kp1215(1,0,0,0,0,1,0,0,0,0,1,0,param1,param2,param3,1);
      }
      
      public static function _ol1182(param1:_gs89) : _kp1215
      {
         return translationMatrix(param1.x,param1.y,param1.z);
      }
      
      public static function rotationMatrix(param1:_vc586) : _kp1215
      {
         var _loc2_:Number = param1.x * param1.x;
         var _loc3_:Number = param1.y * param1.y;
         var _loc4_:Number = param1.z * param1.z;
         var _loc5_:Number = param1.x * param1.y;
         var _loc6_:Number = param1.x * param1.z;
         var _loc7_:Number = param1.y * param1.z;
         var _loc8_:Number = param1.w * param1.x;
         var _loc9_:Number = param1.w * param1.y;
         var _loc10_:Number = param1.w * param1.z;
         return new _kp1215(1 - 2 * (_loc3_ + _loc4_),2 * (_loc5_ + _loc10_),2 * (_loc6_ - _loc9_),0,2 * (_loc5_ - _loc10_),1 - 2 * (_loc2_ + _loc4_),2 * (_loc7_ + _loc8_),0,2 * (_loc6_ + _loc9_),2 * (_loc7_ - _loc8_),1 - 2 * (_loc2_ + _loc3_),0,0,0,0,1);
      }
      
      public static function scaleMatrix(param1:Number, param2:Number, param3:Number) : _kp1215
      {
         return new _kp1215(param1,0,0,0,0,param2,0,0,0,0,param3,0,0,0,0,1);
      }
      
      public static function _fl668(param1:_gs89) : _kp1215
      {
         return scaleMatrix(param1.x,param1.y,param1.z);
      }
      
      public static function identity() : _kp1215
      {
         return new _kp1215(1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1);
      }
      
      public static function clone(param1:_kp1215) : _kp1215
      {
         return new _kp1215(param1._vq676,param1._vt375,param1._xp440,param1._sm762,param1._vt375,param1._aw971,param1._lr1285,param1._xh513,param1._xp440,param1._lr388,param1._oc1338,param1._rv1142,param1._sm762,param1._dn700,param1._ho535,param1._le716);
      }
      
      public function _dy302(param1:_kp1215) : void
      {
         _gn838 = param1._vq676;
         _ch396 = param1._vt375;
         _oj253 = param1._xp440;
         _be900 = param1._sm762;
         _px1172 = param1._vg435;
         _kx1304 = param1._aw971;
         _rm473 = param1._lr388;
         _ht383 = param1._dn700;
         _qk568 = param1._qf1306;
         _qr1179 = param1._lr1285;
         _yg453 = param1._oc1338;
         _up1109 = param1._ho535;
         _ts1119 = param1._dv1018;
         _mm1104 = param1._xh513;
         _jt638 = param1._rv1142;
         _ai1099 = param1._le716;
         param1._vq676 = this._vq676 * _gn838 + this._vg435 * _ch396 + this._qf1306 * _oj253 + this._dv1018 * _be900;
         param1._vt375 = this._vt375 * _gn838 + this._aw971 * _ch396 + this._lr1285 * _oj253 + this._xh513 * _be900;
         param1._xp440 = this._xp440 * _gn838 + this._lr388 * _ch396 + this._oc1338 * _oj253 + this._rv1142 * _be900;
         param1._sm762 = this._sm762 * _gn838 + this._dn700 * _ch396 + this._ho535 * _oj253 + this._le716 * _be900;
         param1._vg435 = this._vq676 * _px1172 + this._vg435 * _kx1304 + this._qf1306 * _rm473 + this._dv1018 * _ht383;
         param1._aw971 = this._vt375 * _px1172 + this._aw971 * _kx1304 + this._lr1285 * _rm473 + this._xh513 * _ht383;
         param1._lr388 = this._xp440 * _px1172 + this._lr388 * _kx1304 + this._oc1338 * _rm473 + this._rv1142 * _ht383;
         param1._dn700 = this._sm762 * _px1172 + this._dn700 * _kx1304 + this._ho535 * _rm473 + this._le716 * _ht383;
         param1._qf1306 = this._vq676 * _qk568 + this._vg435 * _qr1179 + this._qf1306 * _yg453 + this._dv1018 * _up1109;
         param1._lr1285 = this._vt375 * _qk568 + this._aw971 * _qr1179 + this._lr1285 * _yg453 + this._xh513 * _up1109;
         param1._oc1338 = this._xp440 * _qk568 + this._lr388 * _qr1179 + this._oc1338 * _yg453 + this._rv1142 * _up1109;
         param1._ho535 = this._sm762 * _qk568 + this._dn700 * _qr1179 + this._ho535 * _yg453 + this._le716 * _up1109;
         param1._dv1018 = this._vq676 * _ts1119 + this._vg435 * _mm1104 + this._qf1306 * _jt638 + this._dv1018 * _ai1099;
         param1._xh513 = this._vt375 * _ts1119 + this._aw971 * _mm1104 + this._lr1285 * _jt638 + this._xh513 * _ai1099;
         param1._rv1142 = this._xp440 * _ts1119 + this._lr388 * _mm1104 + this._oc1338 * _jt638 + this._rv1142 * _ai1099;
         param1._le716 = this._sm762 * _ts1119 + this._dn700 * _mm1104 + this._ho535 * _jt638 + this._le716 * _ai1099;
      }
      
      public function scale(param1:_gs89) : void
      {
         this._vq676 = this._vq676 * param1.x;
         this._vt375 = this._vt375 * param1.x;
         this._xp440 = this._xp440 * param1.x;
         this._sm762 = this._sm762 * param1.x;
         this._vg435 = this._vg435 * param1.y;
         this._aw971 = this._aw971 * param1.y;
         this._lr388 = this._lr388 * param1.y;
         this._dn700 = this._dn700 * param1.y;
         this._qf1306 = this._qf1306 * param1.z;
         this._lr1285 = this._lr1285 * param1.z;
         this._oc1338 = this._oc1338 * param1.z;
         this._ho535 = this._ho535 * param1.z;
      }
      
      public function translate(param1:_gs89) : void
      {
         this._dv1018 = this._dv1018 + (this._vq676 * param1.x + this._vg435 * param1.y + this._qf1306 * param1.z);
         this._xh513 = this._xh513 + (this._vt375 * param1.x + this._aw971 * param1.y + this._lr1285 * param1.z);
         this._rv1142 = this._rv1142 + (this._xp440 * param1.x + this._lr388 * param1.y + this._oc1338 * param1.z);
         this._le716 = this._le716 + (this._sm762 * param1.x + this._dn700 * param1.y + this._ho535 * param1.z);
      }
      
      public function _is1337(param1:_kp1215, param2:_kp1215) : void
      {
         param2._vq676 = this._vq676 * param1._vq676 + this._vg435 * param1._vt375 + this._qf1306 * param1._xp440 + this._dv1018 * param1._sm762;
         param2._vt375 = this._vt375 * param1._vq676 + this._aw971 * param1._vt375 + this._lr1285 * param1._xp440 + this._xh513 * param1._sm762;
         param2._xp440 = this._xp440 * param1._vq676 + this._lr388 * param1._vt375 + this._oc1338 * param1._xp440 + this._rv1142 * param1._sm762;
         param2._sm762 = this._sm762 * param1._vq676 + this._dn700 * param1._vt375 + this._ho535 * param1._xp440 + this._le716 * param1._sm762;
         param2._vg435 = this._vq676 * param1._vg435 + this._vg435 * param1._aw971 + this._qf1306 * param1._lr388 + this._dv1018 * param1._dn700;
         param2._aw971 = this._vt375 * param1._vg435 + this._aw971 * param1._aw971 + this._lr1285 * param1._lr388 + this._xh513 * param1._dn700;
         param2._lr388 = this._xp440 * param1._vg435 + this._lr388 * param1._aw971 + this._oc1338 * param1._lr388 + this._rv1142 * param1._dn700;
         param2._dn700 = this._sm762 * param1._vg435 + this._dn700 * param1._aw971 + this._ho535 * param1._lr388 + this._le716 * param1._dn700;
         param2._qf1306 = this._vq676 * param1._qf1306 + this._vg435 * param1._lr1285 + this._qf1306 * param1._oc1338 + this._dv1018 * param1._ho535;
         param2._lr1285 = this._vt375 * param1._qf1306 + this._aw971 * param1._lr1285 + this._lr1285 * param1._oc1338 + this._xh513 * param1._ho535;
         param2._oc1338 = this._xp440 * param1._qf1306 + this._lr388 * param1._lr1285 + this._oc1338 * param1._oc1338 + this._rv1142 * param1._ho535;
         param2._ho535 = this._sm762 * param1._qf1306 + this._dn700 * param1._lr1285 + this._ho535 * param1._oc1338 + this._le716 * param1._ho535;
         param2._dv1018 = this._vq676 * param1._dv1018 + this._vg435 * param1._xh513 + this._qf1306 * param1._rv1142 + this._dv1018 * param1._le716;
         param2._xh513 = this._vt375 * param1._dv1018 + this._aw971 * param1._xh513 + this._lr1285 * param1._rv1142 + this._xh513 * param1._le716;
         param2._rv1142 = this._xp440 * param1._dv1018 + this._lr388 * param1._xh513 + this._oc1338 * param1._rv1142 + this._rv1142 * param1._le716;
         param2._le716 = this._sm762 * param1._dv1018 + this._dn700 * param1._xh513 + this._ho535 * param1._rv1142 + this._le716 * param1._le716;
      }
      
      public function _sw1222(param1:_gs89) : void
      {
         this._vq676 = 1;
         this._vt375 = 0;
         this._xp440 = 0;
         this._sm762 = 0;
         this._vg435 = 0;
         this._aw971 = 1;
         this._lr388 = 0;
         this._dn700 = 0;
         this._qf1306 = 0;
         this._lr1285 = 0;
         this._oc1338 = 1;
         this._ho535 = 0;
         this._dv1018 = param1.x;
         this._xh513 = param1.y;
         this._rv1142 = param1.z;
         this._le716 = 1;
      }
      
      public function _cw1193(param1:_gs89) : _gs89
      {
         return new _gs89(this._vq676 * param1.x + this._vg435 * param1.y + this._qf1306 * param1.z + this._dv1018,this._vt375 * param1.x + this._aw971 * param1.y + this._lr1285 * param1.z + this._xh513,this._xp440 * param1.x + this._lr388 * param1.y + this._oc1338 * param1.z + this._rv1142);
      }
      
      public function copy(param1:_kp1215) : void
      {
         this._vq676 = param1._vq676;
         this._vt375 = param1._vt375;
         this._xp440 = param1._xp440;
         this._sm762 = param1._sm762;
         this._vg435 = param1._vg435;
         this._aw971 = param1._aw971;
         this._lr388 = param1._lr388;
         this._dn700 = param1._dn700;
         this._qf1306 = param1._qf1306;
         this._lr1285 = param1._lr1285;
         this._oc1338 = param1._oc1338;
         this._ho535 = param1._ho535;
         this._dv1018 = param1._dv1018;
         this._xh513 = param1._xh513;
         this._rv1142 = param1._rv1142;
         this._le716 = param1._le716;
      }
      
      public function _rj153(param1:_gs89, param2:_gs89, param3:Number) : void
      {
         param2.x = param2.x + param3 * (this._vq676 * param1.x + this._vg435 * param1.y + this._qf1306 * param1.z + this._dv1018);
         param2.y = param2.y + param3 * (this._vt375 * param1.x + this._aw971 * param1.y + this._lr1285 * param1.z + this._xh513);
         param2.z = param2.z + param3 * (this._xp440 * param1.x + this._lr388 * param1.y + this._oc1338 * param1.z + this._rv1142);
      }
      
      public function _km648() : void
      {
         this._vq676 = 1;
         this._vt375 = 0;
         this._xp440 = 0;
         this._sm762 = 0;
         this._vg435 = 0;
         this._aw971 = 1;
         this._lr388 = 0;
         this._dn700 = 0;
         this._qf1306 = 0;
         this._lr1285 = 0;
         this._oc1338 = 1;
         this._ho535 = 0;
         this._dv1018 = 0;
         this._xh513 = 0;
         this._rv1142 = 0;
         this._le716 = 1;
      }
      
      public function _ss945(param1:_kp1215) : void
      {
         _gn838 = this._vq676;
         _ch396 = this._vt375;
         _oj253 = this._xp440;
         _be900 = this._sm762;
         _px1172 = this._vg435;
         _kx1304 = this._aw971;
         _rm473 = this._lr388;
         _ht383 = this._dn700;
         _qk568 = this._qf1306;
         _qr1179 = this._lr1285;
         _yg453 = this._oc1338;
         _up1109 = this._ho535;
         _ts1119 = this._dv1018;
         _mm1104 = this._xh513;
         _jt638 = this._rv1142;
         _ai1099 = this._le716;
         this._vq676 = _gn838 * param1._vq676 + _px1172 * param1._vt375 + _qk568 * param1._xp440 + _ts1119 * param1._sm762;
         this._vt375 = _ch396 * param1._vq676 + _kx1304 * param1._vt375 + _qr1179 * param1._xp440 + _mm1104 * param1._sm762;
         this._xp440 = _oj253 * param1._vq676 + _rm473 * param1._vt375 + _yg453 * param1._xp440 + _jt638 * param1._sm762;
         this._sm762 = _be900 * param1._vq676 + _ht383 * param1._vt375 + _up1109 * param1._xp440 + _ai1099 * param1._sm762;
         this._vg435 = _gn838 * param1._vg435 + _px1172 * param1._aw971 + _qk568 * param1._lr388 + _ts1119 * param1._dn700;
         this._aw971 = _ch396 * param1._vg435 + _kx1304 * param1._aw971 + _qr1179 * param1._lr388 + _mm1104 * param1._dn700;
         this._lr388 = _oj253 * param1._vg435 + _rm473 * param1._aw971 + _yg453 * param1._lr388 + _jt638 * param1._dn700;
         this._dn700 = _be900 * param1._vg435 + _ht383 * param1._aw971 + _up1109 * param1._lr388 + _ai1099 * param1._dn700;
         this._qf1306 = _gn838 * param1._qf1306 + _px1172 * param1._lr1285 + _qk568 * param1._oc1338 + _ts1119 * param1._ho535;
         this._lr1285 = _ch396 * param1._qf1306 + _kx1304 * param1._lr1285 + _qr1179 * param1._oc1338 + _mm1104 * param1._ho535;
         this._oc1338 = _oj253 * param1._qf1306 + _rm473 * param1._lr1285 + _yg453 * param1._oc1338 + _jt638 * param1._ho535;
         this._ho535 = _be900 * param1._qf1306 + _ht383 * param1._lr1285 + _up1109 * param1._oc1338 + _ai1099 * param1._ho535;
         this._dv1018 = _gn838 * param1._dv1018 + _px1172 * param1._xh513 + _qk568 * param1._rv1142 + _ts1119 * param1._le716;
         this._xh513 = _ch396 * param1._dv1018 + _kx1304 * param1._xh513 + _qr1179 * param1._rv1142 + _mm1104 * param1._le716;
         this._rv1142 = _oj253 * param1._dv1018 + _rm473 * param1._xh513 + _yg453 * param1._rv1142 + _jt638 * param1._le716;
         this._le716 = _be900 * param1._dv1018 + _ht383 * param1._xh513 + _up1109 * param1._rv1142 + _ai1099 * param1._le716;
      }
      
      public function _lk240(param1:_gs89, param2:_gs89) : void
      {
         param2.x = param2.x + (this._vq676 * param1.x + this._vg435 * param1.y + this._qf1306 * param1.z + this._dv1018);
         param2.x = param2.x + (this._vq676 * param1.x + this._vg435 * param1.y + this._qf1306 * param1.z + this._dv1018);
         param2.y = param2.y + (this._vt375 * param1.x + this._aw971 * param1.y + this._lr1285 * param1.z + this._xh513);
         param2.z = param2.z + (this._xp440 * param1.x + this._lr388 * param1.y + this._oc1338 * param1.z + this._rv1142);
      }
      
      public function multiply(param1:_kp1215) : _kp1215
      {
         return new _kp1215(this._vq676 * param1._vq676 + this._vg435 * param1._vt375 + this._qf1306 * param1._xp440 + this._dv1018 * param1._sm762,this._vt375 * param1._vq676 + this._aw971 * param1._vt375 + this._lr1285 * param1._xp440 + this._xh513 * param1._sm762,this._xp440 * param1._vq676 + this._lr388 * param1._vt375 + this._oc1338 * param1._xp440 + this._rv1142 * param1._sm762,this._sm762 * param1._vq676 + this._dn700 * param1._vt375 + this._ho535 * param1._xp440 + this._le716 * param1._sm762,this._vq676 * param1._vg435 + this._vg435 * param1._aw971 + this._qf1306 * param1._lr388 + this._dv1018 * param1._dn700,this._vt375 * param1._vg435 + this._aw971 * param1._aw971 + this._lr1285 * param1._lr388 + this._xh513 * param1._dn700,this._xp440 * param1._vg435 + this._lr388 * param1._aw971 + this._oc1338 * param1._lr388 + this._rv1142 * param1._dn700,this._sm762 * param1._vg435 + this._dn700 * param1._aw971 + this._ho535 * param1._lr388 + this._le716 * param1._dn700,this._vq676 * param1._qf1306 + this._vg435 * param1._lr1285 + this._qf1306 * param1._oc1338 + this._dv1018 * param1._ho535,this._vt375 * param1._qf1306 + this._aw971 * param1._lr1285 + this._lr1285 * param1._oc1338 + this._xh513 * param1._ho535,this._xp440 * param1._qf1306 + this._lr388 * param1._lr1285 + this._oc1338 * param1._oc1338 + this._rv1142 * param1._ho535,this._sm762 * param1._qf1306 + this._dn700 * param1._lr1285 + this._ho535 * param1._oc1338 + this._le716 * param1._ho535,this._vq676 * param1._dv1018 + this._vg435 * param1._xh513 + this._qf1306 * param1._rv1142 + this._dv1018 * param1._le716,this._vt375 * param1._dv1018 + this._aw971 * param1._xh513 + this._lr1285 * param1._rv1142 + this._xh513 * param1._le716,this._xp440 * param1._dv1018 + this._lr388 * param1._xh513 + this._oc1338 * param1._rv1142 + this._rv1142 * param1._le716,this._sm762 * param1._dv1018 + this._dn700 * param1._xh513 + this._ho535 * param1._rv1142 + this._le716 * param1._le716);
      }
      
      public function _ch1061(param1:_kp1215) : void
      {
         _gn838 = this._vq676;
         _ch396 = this._vt375;
         _oj253 = this._xp440;
         _be900 = this._sm762;
         _px1172 = this._vg435;
         _kx1304 = this._aw971;
         _rm473 = this._lr388;
         _ht383 = this._dn700;
         _qk568 = this._qf1306;
         _qr1179 = this._lr1285;
         _yg453 = this._oc1338;
         _up1109 = this._ho535;
         _ts1119 = this._dv1018;
         _mm1104 = this._xh513;
         _jt638 = this._rv1142;
         _ai1099 = this._le716;
         this._vq676 = _gn838 * param1._vq676 + _px1172 * param1._vt375 + _qk568 * param1._xp440 + _ts1119 * param1._sm762;
         this._vt375 = _ch396 * param1._vq676 + _kx1304 * param1._vt375 + _qr1179 * param1._xp440 + _mm1104 * param1._sm762;
         this._xp440 = _oj253 * param1._vq676 + _rm473 * param1._vt375 + _yg453 * param1._xp440 + _jt638 * param1._sm762;
         this._sm762 = _be900 * param1._vq676 + _ht383 * param1._vt375 + _up1109 * param1._xp440 + _ai1099 * param1._sm762;
         this._vg435 = _gn838 * param1._vg435 + _px1172 * param1._aw971 + _qk568 * param1._lr388 + _ts1119 * param1._dn700;
         this._aw971 = _ch396 * param1._vg435 + _kx1304 * param1._aw971 + _qr1179 * param1._lr388 + _mm1104 * param1._dn700;
         this._lr388 = _oj253 * param1._vg435 + _rm473 * param1._aw971 + _yg453 * param1._lr388 + _jt638 * param1._dn700;
         this._dn700 = _be900 * param1._vg435 + _ht383 * param1._aw971 + _up1109 * param1._lr388 + _ai1099 * param1._dn700;
         this._qf1306 = _gn838 * param1._qf1306 + _px1172 * param1._lr1285 + _qk568 * param1._oc1338 + _ts1119 * param1._ho535;
         this._lr1285 = _ch396 * param1._qf1306 + _kx1304 * param1._lr1285 + _qr1179 * param1._oc1338 + _mm1104 * param1._ho535;
         this._oc1338 = _oj253 * param1._qf1306 + _rm473 * param1._lr1285 + _yg453 * param1._oc1338 + _jt638 * param1._ho535;
         this._ho535 = _be900 * param1._qf1306 + _ht383 * param1._lr1285 + _up1109 * param1._oc1338 + _ai1099 * param1._ho535;
         this._dv1018 = _gn838 * param1._dv1018 + _px1172 * param1._xh513 + _qk568 * param1._rv1142 + _ts1119 * param1._le716;
         this._xh513 = _ch396 * param1._dv1018 + _kx1304 * param1._xh513 + _qr1179 * param1._rv1142 + _mm1104 * param1._le716;
         this._rv1142 = _oj253 * param1._dv1018 + _rm473 * param1._xh513 + _yg453 * param1._rv1142 + _jt638 * param1._le716;
         this._le716 = _be900 * param1._dv1018 + _ht383 * param1._xh513 + _up1109 * param1._rv1142 + _ai1099 * param1._le716;
      }
      
      public function _dx104(param1:_gs89) : void
      {
         _gn838 = param1.x;
         _ch396 = param1.y;
         param1.x = param1.x + (this._vq676 * _gn838 + this._vg435 * _ch396 + this._qf1306 * param1.z + this._dv1018);
         param1.y = param1.y + (this._vt375 * _gn838 + this._aw971 * _ch396 + this._lr1285 * param1.z + this._xh513);
         param1.z = param1.z + (this._xp440 * _gn838 + this._lr388 * _ch396 + this._oc1338 * param1.z + this._rv1142);
      }
      
      public function rotate(param1:_vc586) : void
      {
         var _loc2_:Number = param1.x * param1.x;
         var _loc3_:Number = param1.y * param1.y;
         var _loc4_:Number = param1.z * param1.z;
         var _loc5_:Number = param1.x * param1.y;
         var _loc6_:Number = param1.x * param1.z;
         var _loc7_:Number = param1.y * param1.z;
         var _loc8_:Number = param1.w * param1.x;
         var _loc9_:Number = param1.w * param1.y;
         var _loc10_:Number = param1.w * param1.z;
         var _loc11_:Number = 1 - 2 * (_loc3_ + _loc4_);
         var _loc12_:Number = 2 * (_loc5_ + _loc10_);
         var _loc13_:Number = 2 * (_loc6_ - _loc9_);
         var _loc14_:Number = 2 * (_loc5_ - _loc10_);
         var _loc15_:Number = 1 - 2 * (_loc2_ + _loc4_);
         var _loc16_:Number = 2 * (_loc7_ + _loc8_);
         var _loc17_:Number = 2 * (_loc6_ + _loc9_);
         var _loc18_:Number = 2 * (_loc7_ - _loc8_);
         var _loc19_:Number = 1 - 2 * (_loc2_ + _loc3_);
         _gn838 = this._vq676;
         _ch396 = this._vt375;
         _oj253 = this._xp440;
         _be900 = this._sm762;
         _px1172 = this._vg435;
         _kx1304 = this._aw971;
         _rm473 = this._lr388;
         _ht383 = this._dn700;
         this._vq676 = _gn838 * _loc11_ + _px1172 * _loc12_ + this._qf1306 * _loc13_;
         this._vt375 = _ch396 * _loc11_ + _kx1304 * _loc12_ + this._lr1285 * _loc13_;
         this._xp440 = _oj253 * _loc11_ + _rm473 * _loc12_ + this._oc1338 * _loc13_;
         this._sm762 = _be900 * _loc11_ + _ht383 * _loc12_ + this._ho535 * _loc13_;
         this._vg435 = _gn838 * _loc14_ + _px1172 * _loc15_ + this._qf1306 * _loc16_;
         this._aw971 = _ch396 * _loc14_ + _kx1304 * _loc15_ + this._lr1285 * _loc16_;
         this._lr388 = _oj253 * _loc14_ + _rm473 * _loc15_ + this._oc1338 * _loc16_;
         this._dn700 = _be900 * _loc14_ + _ht383 * _loc15_ + this._ho535 * _loc16_;
         this._qf1306 = _gn838 * _loc17_ + _px1172 * _loc18_ + this._qf1306 * _loc19_;
         this._lr1285 = _ch396 * _loc17_ + _kx1304 * _loc18_ + this._lr1285 * _loc19_;
         this._oc1338 = _oj253 * _loc17_ + _rm473 * _loc18_ + this._oc1338 * _loc19_;
         this._ho535 = _be900 * _loc17_ + _ht383 * _loc18_ + this._ho535 * _loc19_;
      }
      
      public function _pr1214(param1:_gs89) : void
      {
         _gn838 = param1.x;
         _ch396 = param1.y;
         param1.x = this._vq676 * _gn838 + this._vg435 * _ch396 + this._qf1306 * param1.z + this._dv1018;
         param1.y = this._vt375 * _gn838 + this._aw971 * _ch396 + this._lr1285 * param1.z + this._xh513;
         param1.z = this._xp440 * _gn838 + this._lr388 * _ch396 + this._oc1338 * param1.z + this._rv1142;
      }
   }
}
