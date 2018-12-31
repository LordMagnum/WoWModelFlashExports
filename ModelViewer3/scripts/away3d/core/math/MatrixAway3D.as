package away3d.core.math
{
   public final class MatrixAway3D
   {
       
      
      private var xx:Number;
      
      private var xy:Number;
      
      private var xz:Number;
      
      private var _right:Number3D;
      
      private var yw:Number;
      
      private var yy:Number;
      
      private var yz:Number;
      
      private const toDEGREES:Number = 57.29577951308232;
      
      private var scos:Number;
      
      private var nCos:Number;
      
      private var zw:Number;
      
      private var _up:Number3D;
      
      private var m211:Number;
      
      private var m213:Number;
      
      private var m212:Number;
      
      private var m214:Number;
      
      private var suv:Number;
      
      private var suw:Number;
      
      private var su:Number;
      
      private var sv:Number;
      
      private var m221:Number;
      
      private var m222:Number;
      
      private var m223:Number;
      
      private var m224:Number;
      
      private var sw:Number;
      
      private var zz:Number;
      
      private var d:Number;
      
      private var w:Number;
      
      private var x:Number;
      
      private var y:Number;
      
      private var z:Number;
      
      private var svw:Number;
      
      private var m231:Number;
      
      private var m111:Number;
      
      private var m112:Number;
      
      private var _forward:Number3D;
      
      private var m114:Number;
      
      private var _position:Number3D;
      
      public var tw:Number = 1;
      
      private var m232:Number;
      
      private var m233:Number;
      
      private var m113:Number;
      
      public var swz:Number = 0;
      
      private var nSin:Number;
      
      public var swx:Number = 0;
      
      public var tx:Number = 0;
      
      public var ty:Number = 0;
      
      private var m234:Number;
      
      private var m241:Number;
      
      private var m121:Number;
      
      private var m122:Number;
      
      private var m123:Number;
      
      private var m124:Number;
      
      private var m243:Number;
      
      private var m244:Number;
      
      private var m242:Number;
      
      public var sxx:Number = 1;
      
      public var sxy:Number = 0;
      
      public var sxz:Number = 0;
      
      public var swy:Number = 0;
      
      public var tz:Number = 0;
      
      private var m131:Number;
      
      private var m132:Number;
      
      private var m133:Number;
      
      private var m134:Number;
      
      public var syx:Number = 0;
      
      public var syz:Number = 0;
      
      public var syy:Number = 1;
      
      private var m141:Number;
      
      private var m142:Number;
      
      private var m143:Number;
      
      private var m144:Number;
      
      public var szx:Number = 0;
      
      public var szz:Number = 1;
      
      public var szy:Number = 0;
      
      private var xw:Number;
      
      public function MatrixAway3D()
      {
         this._position = new Number3D();
         this._forward = new Number3D();
         this._up = new Number3D();
         this._right = new Number3D();
         super();
      }
      
      public function get det() : Number
      {
         return (this.sxx * this.syy - this.syx * this.sxy) * this.szz - (this.sxx * this.szy - this.szx * this.sxy) * this.syz + (this.syx * this.szy - this.szx * this.syy) * this.sxz;
      }
      
      public function normalize(param1:MatrixAway3D) : void
      {
         this.d = Math.sqrt(this.sxx * this.sxx + this.sxy * this.sxy + this.sxz * this.sxz);
         this.sxx = this.sxx / this.d;
         this.sxy = this.sxy / this.d;
         this.sxz = this.sxz / this.d;
         this.d = Math.sqrt(this.syx * this.syx + this.syy * this.syy + this.syz * this.syz);
         this.syx = this.syx / this.d;
         this.syy = this.syy / this.d;
         this.syz = this.syz / this.d;
         this.d = Math.sqrt(this.szx * this.szx + this.szy * this.szy + this.szz * this.szz);
         this.szx = this.szx / this.d;
         this.szy = this.szy / this.d;
         this.szz = this.szz / this.d;
      }
      
      public function get right() : Number3D
      {
         this._right.x = this.sxx;
         this._right.y = this.sxy;
         this._right.z = this.sxz;
         return this._right;
      }
      
      public function get position() : Number3D
      {
         this._position.x = this.tx;
         this._position.y = this.ty;
         this._position.z = this.tz;
         return this._position;
      }
      
      public function multiply(param1:MatrixAway3D, param2:MatrixAway3D) : void
      {
         this.m111 = param1.sxx;
         this.m211 = param2.sxx;
         this.m121 = param1.syx;
         this.m221 = param2.syx;
         this.m131 = param1.szx;
         this.m231 = param2.szx;
         this.m112 = param1.sxy;
         this.m212 = param2.sxy;
         this.m122 = param1.syy;
         this.m222 = param2.syy;
         this.m132 = param1.szy;
         this.m232 = param2.szy;
         this.m113 = param1.sxz;
         this.m213 = param2.sxz;
         this.m123 = param1.syz;
         this.m223 = param2.syz;
         this.m133 = param1.szz;
         this.m233 = param2.szz;
         this.m114 = param1.tx;
         this.m214 = param2.tx;
         this.m124 = param1.ty;
         this.m224 = param2.ty;
         this.m134 = param1.tz;
         this.m234 = param2.tz;
         this.sxx = this.m111 * this.m211 + this.m112 * this.m221 + this.m113 * this.m231;
         this.sxy = this.m111 * this.m212 + this.m112 * this.m222 + this.m113 * this.m232;
         this.sxz = this.m111 * this.m213 + this.m112 * this.m223 + this.m113 * this.m233;
         this.tx = this.m111 * this.m214 + this.m112 * this.m224 + this.m113 * this.m234 + this.m114;
         this.syx = this.m121 * this.m211 + this.m122 * this.m221 + this.m123 * this.m231;
         this.syy = this.m121 * this.m212 + this.m122 * this.m222 + this.m123 * this.m232;
         this.syz = this.m121 * this.m213 + this.m122 * this.m223 + this.m123 * this.m233;
         this.ty = this.m121 * this.m214 + this.m122 * this.m224 + this.m123 * this.m234 + this.m124;
         this.szx = this.m131 * this.m211 + this.m132 * this.m221 + this.m133 * this.m231;
         this.szy = this.m131 * this.m212 + this.m132 * this.m222 + this.m133 * this.m232;
         this.szz = this.m131 * this.m213 + this.m132 * this.m223 + this.m133 * this.m233;
         this.tz = this.m131 * this.m214 + this.m132 * this.m224 + this.m133 * this.m234 + this.m134;
      }
      
      public function inverse(param1:MatrixAway3D) : void
      {
         this.d = param1.det;
         if(Math.abs(this.d) < 0.001)
         {
            return;
         }
         this.d = 1 / this.d;
         this.m111 = param1.sxx;
         this.m121 = param1.syx;
         this.m131 = param1.szx;
         this.m112 = param1.sxy;
         this.m122 = param1.syy;
         this.m132 = param1.szy;
         this.m113 = param1.sxz;
         this.m123 = param1.syz;
         this.m133 = param1.szz;
         this.m114 = param1.tx;
         this.m124 = param1.ty;
         this.m134 = param1.tz;
         this.sxx = this.d * (this.m122 * this.m133 - this.m132 * this.m123);
         this.sxy = -this.d * (this.m112 * this.m133 - this.m132 * this.m113);
         this.sxz = this.d * (this.m112 * this.m123 - this.m122 * this.m113);
         this.tx = -this.d * (this.m112 * (this.m123 * this.m134 - this.m133 * this.m124) - this.m122 * (this.m113 * this.m134 - this.m133 * this.m114) + this.m132 * (this.m113 * this.m124 - this.m123 * this.m114));
         this.syx = -this.d * (this.m121 * this.m133 - this.m131 * this.m123);
         this.syy = this.d * (this.m111 * this.m133 - this.m131 * this.m113);
         this.syz = -this.d * (this.m111 * this.m123 - this.m121 * this.m113);
         this.ty = this.d * (this.m111 * (this.m123 * this.m134 - this.m133 * this.m124) - this.m121 * (this.m113 * this.m134 - this.m133 * this.m114) + this.m131 * (this.m113 * this.m124 - this.m123 * this.m114));
         this.szx = this.d * (this.m121 * this.m132 - this.m131 * this.m122);
         this.szy = -this.d * (this.m111 * this.m132 - this.m131 * this.m112);
         this.szz = this.d * (this.m111 * this.m122 - this.m121 * this.m112);
         this.tz = -this.d * (this.m111 * (this.m122 * this.m134 - this.m132 * this.m124) - this.m121 * (this.m112 * this.m134 - this.m132 * this.m114) + this.m131 * (this.m112 * this.m124 - this.m122 * this.m114));
      }
      
      public function set up(param1:Number3D) : void
      {
         this.syx = param1.x;
         this.syy = param1.y;
         this.syz = param1.z;
      }
      
      public function set right(param1:Number3D) : void
      {
         this.sxx = param1.x;
         this.sxy = param1.y;
         this.sxz = param1.z;
      }
      
      public function multiplyVector3x3(param1:Number3D) : void
      {
         var _loc2_:Number = param1.x;
         var _loc3_:Number = param1.y;
         var _loc4_:Number = param1.z;
         param1.x = _loc2_ * this.sxx + _loc3_ * this.sxy + _loc4_ * this.sxz;
         param1.y = _loc2_ * this.syx + _loc3_ * this.syy + _loc4_ * this.syz;
         param1.z = _loc2_ * this.szx + _loc3_ * this.szy + _loc4_ * this.szz;
      }
      
      public function multiply4x3(param1:MatrixAway3D, param2:MatrixAway3D) : void
      {
         this.m111 = param1.sxx;
         this.m211 = param2.sxx;
         this.m121 = param1.syx;
         this.m221 = param2.syx;
         this.m131 = param1.szx;
         this.m231 = param2.szx;
         this.m112 = param1.sxy;
         this.m212 = param2.sxy;
         this.m122 = param1.syy;
         this.m222 = param2.syy;
         this.m132 = param1.szy;
         this.m232 = param2.szy;
         this.m113 = param1.sxz;
         this.m213 = param2.sxz;
         this.m123 = param1.syz;
         this.m223 = param2.syz;
         this.m133 = param1.szz;
         this.m233 = param2.szz;
         this.m114 = param1.tx;
         this.m214 = param2.tx;
         this.m124 = param1.ty;
         this.m224 = param2.ty;
         this.m134 = param1.tz;
         this.m234 = param2.tz;
         this.m141 = param1.swx;
         this.m241 = param2.swx;
         this.m142 = param1.swy;
         this.m242 = param2.swy;
         this.m143 = param1.swz;
         this.m243 = param2.swz;
         this.m144 = param1.tw;
         this.m244 = param2.tw;
         this.sxx = this.m111 * this.m211 + this.m112 * this.m221 + this.m113 * this.m231;
         this.sxy = this.m111 * this.m212 + this.m112 * this.m222 + this.m113 * this.m232;
         this.sxz = this.m111 * this.m213 + this.m112 * this.m223 + this.m113 * this.m233;
         this.tx = this.m111 * this.m214 + this.m112 * this.m224 + this.m113 * this.m234 + this.m114;
         this.syx = this.m121 * this.m211 + this.m122 * this.m221 + this.m123 * this.m231;
         this.syy = this.m121 * this.m212 + this.m122 * this.m222 + this.m123 * this.m232;
         this.syz = this.m121 * this.m213 + this.m122 * this.m223 + this.m123 * this.m233;
         this.ty = this.m121 * this.m214 + this.m122 * this.m224 + this.m123 * this.m234 + this.m124;
         this.szx = this.m131 * this.m211 + this.m132 * this.m221 + this.m133 * this.m231;
         this.szy = this.m131 * this.m212 + this.m132 * this.m222 + this.m133 * this.m232;
         this.szz = this.m131 * this.m213 + this.m132 * this.m223 + this.m133 * this.m233;
         this.tz = this.m131 * this.m214 + this.m132 * this.m224 + this.m133 * this.m234 + this.m134;
         this.swx = this.m141 * this.m211 + this.m142 * this.m221 + this.m143 * this.m231;
         this.swy = this.m141 * this.m212 + this.m142 * this.m222 + this.m143 * this.m232;
         this.swz = this.m141 * this.m213 + this.m142 * this.m223 + this.m143 * this.m233;
         this.tw = this.m141 * this.m214 + this.m142 * this.m224 + this.m143 * this.m234 + this.m144;
      }
      
      public function multiply4x4(param1:MatrixAway3D, param2:MatrixAway3D) : void
      {
         this.m111 = param1.sxx;
         this.m211 = param2.sxx;
         this.m121 = param1.syx;
         this.m221 = param2.syx;
         this.m131 = param1.szx;
         this.m231 = param2.szx;
         this.m141 = param1.swx;
         this.m241 = param2.swx;
         this.m112 = param1.sxy;
         this.m212 = param2.sxy;
         this.m122 = param1.syy;
         this.m222 = param2.syy;
         this.m132 = param1.szy;
         this.m232 = param2.szy;
         this.m142 = param1.swy;
         this.m242 = param2.swy;
         this.m113 = param1.sxz;
         this.m213 = param2.sxz;
         this.m123 = param1.syz;
         this.m223 = param2.syz;
         this.m133 = param1.szz;
         this.m233 = param2.szz;
         this.m143 = param1.swz;
         this.m243 = param2.swz;
         this.m114 = param1.tx;
         this.m214 = param2.tx;
         this.m124 = param1.ty;
         this.m224 = param2.ty;
         this.m134 = param1.tz;
         this.m234 = param2.tz;
         this.m144 = param1.tw;
         this.m244 = param2.tw;
         this.sxx = this.m111 * this.m211 + this.m112 * this.m221 + this.m113 * this.m231 + this.m114 * this.m241;
         this.sxy = this.m111 * this.m212 + this.m112 * this.m222 + this.m113 * this.m232 + this.m114 * this.m242;
         this.sxz = this.m111 * this.m213 + this.m112 * this.m223 + this.m113 * this.m233 + this.m114 * this.m243;
         this.tx = this.m111 * this.m214 + this.m112 * this.m224 + this.m113 * this.m234 + this.m114 * this.m244;
         this.syx = this.m121 * this.m211 + this.m122 * this.m221 + this.m123 * this.m231 + this.m124 * this.m241;
         this.syy = this.m121 * this.m212 + this.m122 * this.m222 + this.m123 * this.m232 + this.m124 * this.m242;
         this.syz = this.m121 * this.m213 + this.m122 * this.m223 + this.m123 * this.m233 + this.m124 * this.m243;
         this.ty = this.m121 * this.m214 + this.m122 * this.m224 + this.m123 * this.m234 + this.m124 * this.m244;
         this.szx = this.m131 * this.m211 + this.m132 * this.m221 + this.m133 * this.m231 + this.m134 * this.m241;
         this.szy = this.m131 * this.m212 + this.m132 * this.m222 + this.m133 * this.m232 + this.m134 * this.m242;
         this.szz = this.m131 * this.m213 + this.m132 * this.m223 + this.m133 * this.m233 + this.m134 * this.m243;
         this.tz = this.m131 * this.m214 + this.m132 * this.m224 + this.m133 * this.m234 + this.m134 * this.m244;
         this.swx = this.m141 * this.m211 + this.m142 * this.m221 + this.m143 * this.m231 + this.m144 * this.m241;
         this.swy = this.m141 * this.m212 + this.m142 * this.m222 + this.m143 * this.m232 + this.m144 * this.m242;
         this.swz = this.m141 * this.m213 + this.m142 * this.m223 + this.m143 * this.m233 + this.m144 * this.m243;
         this.tw = this.m141 * this.m214 + this.m142 * this.m224 + this.m143 * this.m234 + this.m144 * this.m244;
      }
      
      public function scale(param1:MatrixAway3D, param2:Number, param3:Number, param4:Number) : void
      {
         this.sxx = param1.sxx * param2;
         this.syx = param1.syx * param2;
         this.szx = param1.szx * param2;
         this.sxy = param1.sxy * param3;
         this.syy = param1.syy * param3;
         this.szy = param1.szy * param3;
         this.sxz = param1.sxz * param4;
         this.syz = param1.syz * param4;
         this.szz = param1.szz * param4;
      }
      
      public function perspectiveProjectionMatrix(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc5_:Number = param1 / 2 * (Math.PI / 180);
         var _loc6_:Number = Math.tan(_loc5_);
         var _loc7_:Number = 1 / _loc6_;
         this.sxx = _loc7_ / param2;
         this.sxy = this.sxz = this.tx = 0;
         this.syy = _loc7_;
         this.syx = this.syz = this.ty = 0;
         this.szx = this.szy = 0;
         this.szz = -((param3 + param4) / (param3 - param4));
         this.tz = 2 * param4 * param3 / (param3 - param4);
         this.swx = this.swy = this.tw = 0;
         this.swz = 1;
      }
      
      public function clone(param1:MatrixAway3D) : MatrixAway3D
      {
         this.sxx = param1.sxx;
         this.sxy = param1.sxy;
         this.sxz = param1.sxz;
         this.tx = param1.tx;
         this.syx = param1.syx;
         this.syy = param1.syy;
         this.syz = param1.syz;
         this.ty = param1.ty;
         this.szx = param1.szx;
         this.szy = param1.szy;
         this.szz = param1.szz;
         this.tz = param1.tz;
         this.swx = param1.swx;
         this.swy = param1.swy;
         this.swz = param1.swz;
         this.tw = param1.tw;
         return param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "";
         _loc1_ = _loc1_ + (int(this.sxx * 1000) / 1000 + "\t\t" + int(this.sxy * 1000) / 1000 + "\t\t" + int(this.sxz * 1000) / 1000 + "\t\t" + int(this.tx * 1000) / 1000 + "\n");
         _loc1_ = _loc1_ + (int(this.syx * 1000) / 1000 + "\t\t" + int(this.syy * 1000) / 1000 + "\t\t" + int(this.syz * 1000) / 1000 + "\t\t" + int(this.ty * 1000) / 1000 + "\n");
         _loc1_ = _loc1_ + (int(this.szx * 1000) / 1000 + "\t\t" + int(this.szy * 1000) / 1000 + "\t\t" + int(this.szz * 1000) / 1000 + "\t\t" + int(this.tz * 1000) / 1000 + "\n");
         _loc1_ = _loc1_ + (int(this.swx * 1000) / 1000 + "\t\t" + int(this.swy * 1000) / 1000 + "\t\t" + int(this.swz * 1000) / 1000 + "\t\t" + int(this.tw * 1000) / 1000 + "\n");
         return _loc1_;
      }
      
      public function copy3x3(param1:MatrixAway3D) : MatrixAway3D
      {
         this.sxx = param1.sxx;
         this.sxy = param1.sxy;
         this.sxz = param1.sxz;
         this.syx = param1.syx;
         this.syy = param1.syy;
         this.syz = param1.syz;
         this.szx = param1.szx;
         this.szy = param1.szy;
         this.szz = param1.szz;
         return this;
      }
      
      public function clear() : void
      {
         this.tx = this.sxy = this.sxz = this.syz = this.ty = this.syz = this.szx = this.szy = this.tz = 0;
         this.sxx = this.syy = this.szz = 1;
      }
      
      public function scaleMatrix(param1:Number, param2:Number, param3:Number) : void
      {
         this.tx = this.sxy = this.sxz = 0;
         this.syz = this.ty = this.syz = 0;
         this.szx = this.szy = this.tz = 0;
         this.sxx = param1;
         this.syy = param2;
         this.szz = param3;
      }
      
      public function get up() : Number3D
      {
         this._up.x = this.syx;
         this._up.y = this.syy;
         this._up.z = this.syz;
         return this._up;
      }
      
      public function inverse4x4(param1:MatrixAway3D) : void
      {
         this.d = param1.det4x4;
         if(Math.abs(this.d) < 0.001)
         {
            return;
         }
         this.d = 1 / this.d;
         this.m111 = param1.sxx;
         this.m121 = param1.syx;
         this.m131 = param1.szx;
         this.m141 = param1.swx;
         this.m112 = param1.sxy;
         this.m122 = param1.syy;
         this.m132 = param1.szy;
         this.m142 = param1.swy;
         this.m113 = param1.sxz;
         this.m123 = param1.syz;
         this.m133 = param1.szz;
         this.m143 = param1.swz;
         this.m114 = param1.tx;
         this.m124 = param1.ty;
         this.m134 = param1.tz;
         this.m144 = param1.tw;
         this.sxx = this.d * (this.m122 * (this.m133 * this.m144 - this.m143 * this.m134) - this.m132 * (this.m123 * this.m144 - this.m143 * this.m124) + this.m142 * (this.m123 * this.m134 - this.m133 * this.m124));
         this.sxy = -this.d * (this.m112 * (this.m133 * this.m144 - this.m143 * this.m134) - this.m132 * (this.m113 * this.m144 - this.m143 * this.m114) + this.m142 * (this.m113 * this.m134 - this.m133 * this.m114));
         this.sxz = this.d * (this.m112 * (this.m123 * this.m144 - this.m143 * this.m124) - this.m122 * (this.m113 * this.m144 - this.m143 * this.m114) + this.m142 * (this.m113 * this.m124 - this.m123 * this.m114));
         this.tx = -this.d * (this.m112 * (this.m123 * this.m134 - this.m133 * this.m124) - this.m122 * (this.m113 * this.m134 - this.m133 * this.m114) + this.m132 * (this.m113 * this.m124 - this.m123 * this.m114));
         this.syx = -this.d * (this.m121 * (this.m133 * this.m144 - this.m143 * this.m134) - this.m131 * (this.m123 * this.m144 - this.m143 * this.m124) + this.m141 * (this.m123 * this.m134 - this.m133 * this.m124));
         this.syy = this.d * (this.m111 * (this.m133 * this.m144 - this.m143 * this.m134) - this.m131 * (this.m113 * this.m144 - this.m143 * this.m114) + this.m141 * (this.m113 * this.m134 - this.m133 * this.m114));
         this.syz = -this.d * (this.m111 * (this.m123 * this.m144 - this.m143 * this.m124) - this.m121 * (this.m113 * this.m144 - this.m143 * this.m114) + this.m141 * (this.m113 * this.m124 - this.m123 * this.m114));
         this.ty = this.d * (this.m111 * (this.m123 * this.m134 - this.m133 * this.m124) - this.m121 * (this.m113 * this.m134 - this.m133 * this.m114) + this.m131 * (this.m113 * this.m124 - this.m123 * this.m114));
         this.szx = this.d * (this.m121 * (this.m132 * this.m144 - this.m142 * this.m134) - this.m131 * (this.m122 * this.m144 - this.m142 * this.m124) + this.m141 * (this.m122 * this.m134 - this.m132 * this.m124));
         this.szy = -this.d * (this.m111 * (this.m132 * this.m144 - this.m142 * this.m134) - this.m131 * (this.m112 * this.m144 - this.m142 * this.m114) + this.m141 * (this.m112 * this.m134 - this.m132 * this.m114));
         this.szz = this.d * (this.m111 * (this.m122 * this.m144 - this.m142 * this.m124) - this.m121 * (this.m112 * this.m144 - this.m142 * this.m114) + this.m141 * (this.m112 * this.m124 - this.m122 * this.m114));
         this.tz = -this.d * (this.m111 * (this.m122 * this.m134 - this.m132 * this.m124) - this.m121 * (this.m112 * this.m134 - this.m132 * this.m114) + this.m131 * (this.m112 * this.m124 - this.m122 * this.m114));
         this.swx = -this.d * (this.m121 * (this.m132 * this.m143 - this.m142 * this.m133) - this.m131 * (this.m122 * this.m143 - this.m142 * this.m123) + this.m141 * (this.m122 * this.m133 - this.m132 * this.m123));
         this.swy = this.d * (this.m111 * (this.m132 * this.m143 - this.m142 * this.m133) - this.m131 * (this.m112 * this.m143 - this.m142 * this.m113) + this.m141 * (this.m112 * this.m133 - this.m132 * this.m113));
         this.swz = -this.d * (this.m111 * (this.m122 * this.m143 - this.m142 * this.m123) - this.m121 * (this.m112 * this.m143 - this.m142 * this.m113) + this.m141 * (this.m112 * this.m123 - this.m122 * this.m113));
         this.tw = this.d * (this.m111 * (this.m122 * this.m133 - this.m132 * this.m123) - this.m121 * (this.m112 * this.m133 - this.m132 * this.m113) + this.m131 * (this.m112 * this.m123 - this.m122 * this.m113));
      }
      
      public function multiply3x3(param1:MatrixAway3D, param2:MatrixAway3D) : void
      {
         this.m111 = param1.sxx;
         this.m211 = param2.sxx;
         this.m121 = param1.syx;
         this.m221 = param2.syx;
         this.m131 = param1.szx;
         this.m231 = param2.szx;
         this.m112 = param1.sxy;
         this.m212 = param2.sxy;
         this.m122 = param1.syy;
         this.m222 = param2.syy;
         this.m132 = param1.szy;
         this.m232 = param2.szy;
         this.m113 = param1.sxz;
         this.m213 = param2.sxz;
         this.m123 = param1.syz;
         this.m223 = param2.syz;
         this.m133 = param1.szz;
         this.m233 = param2.szz;
         this.sxx = this.m111 * this.m211 + this.m112 * this.m221 + this.m113 * this.m231;
         this.sxy = this.m111 * this.m212 + this.m112 * this.m222 + this.m113 * this.m232;
         this.sxz = this.m111 * this.m213 + this.m112 * this.m223 + this.m113 * this.m233;
         this.syx = this.m121 * this.m211 + this.m122 * this.m221 + this.m123 * this.m231;
         this.syy = this.m121 * this.m212 + this.m122 * this.m222 + this.m123 * this.m232;
         this.syz = this.m121 * this.m213 + this.m122 * this.m223 + this.m123 * this.m233;
         this.szx = this.m131 * this.m211 + this.m132 * this.m221 + this.m133 * this.m231;
         this.szy = this.m131 * this.m212 + this.m132 * this.m222 + this.m133 * this.m232;
         this.szz = this.m131 * this.m213 + this.m132 * this.m223 + this.m133 * this.m233;
         this.tx = param1.tx;
         this.ty = param1.ty;
         this.tz = param1.tz;
      }
      
      public function orthographicProjectionMatrix(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : void
      {
         this.sxx = 2 / (param2 - param1);
         this.sxy = this.sxz = 0;
         this.tx = (param2 + param1) / (param2 - param1);
         this.syy = 2 / (param4 - param3);
         this.syx = this.syz = 0;
         this.ty = (param4 + param3) / (param4 - param3);
         this.szx = this.szy = 0;
         this.szz = -2 / (param6 - param5);
         this.tz = (param6 + param5) / (param6 - param5);
         this.swx = this.swy = this.swz = 0;
         this.tw = 1;
         var _loc7_:MatrixAway3D = new MatrixAway3D();
         _loc7_.scaleMatrix(1,1,-1);
         this.multiply(_loc7_,this);
      }
      
      public function translationMatrix(param1:Number, param2:Number, param3:Number) : void
      {
         this.sxx = this.syy = this.szz = 1;
         this.sxy = this.sxz = this.syz = this.syz = this.szx = this.szy = 0;
         this.tx = param1;
         this.ty = param2;
         this.tz = param3;
      }
      
      public function quaternion2matrix(param1:Quaternion) : void
      {
         this.x = param1.x;
         this.y = param1.y;
         this.z = param1.z;
         this.w = param1.w;
         this.xx = this.x * this.x;
         this.xy = this.x * this.y;
         this.xz = this.x * this.z;
         this.xw = this.x * this.w;
         this.yy = this.y * this.y;
         this.yz = this.y * this.z;
         this.yw = this.y * this.w;
         this.zz = this.z * this.z;
         this.zw = this.z * this.w;
         this.sxx = 1 - 2 * (this.yy + this.zz);
         this.sxy = 2 * (this.xy - this.zw);
         this.sxz = 2 * (this.xz + this.yw);
         this.syx = 2 * (this.xy + this.zw);
         this.syy = 1 - 2 * (this.xx + this.zz);
         this.syz = 2 * (this.yz - this.xw);
         this.szx = 2 * (this.xz - this.yw);
         this.szy = 2 * (this.yz + this.xw);
         this.szz = 1 - 2 * (this.xx + this.yy);
      }
      
      public function get forward() : Number3D
      {
         this._forward.x = this.szx;
         this._forward.y = this.szy;
         this._forward.z = this.szz;
         return this._forward;
      }
      
      public function set forward(param1:Number3D) : void
      {
         this.szx = param1.x;
         this.szy = param1.y;
         this.szz = param1.z;
      }
      
      public function rotationMatrix(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         this.nCos = Math.cos(param4);
         this.nSin = Math.sin(param4);
         this.scos = 1 - this.nCos;
         this.suv = param1 * param2 * this.scos;
         this.svw = param2 * param3 * this.scos;
         this.suw = param1 * param3 * this.scos;
         this.sw = this.nSin * param3;
         this.sv = this.nSin * param2;
         this.su = this.nSin * param1;
         this.sxx = this.nCos + param1 * param1 * this.scos;
         this.sxy = -this.sw + this.suv;
         this.sxz = this.sv + this.suw;
         this.syx = this.sw + this.suv;
         this.syy = this.nCos + param2 * param2 * this.scos;
         this.syz = -this.su + this.svw;
         this.szx = -this.sv + this.suw;
         this.szy = this.su + this.svw;
         this.szz = this.nCos + param3 * param3 * this.scos;
      }
      
      public function compare(param1:MatrixAway3D) : Boolean
      {
         if(this.sxx != param1.sxx || this.sxy != param1.sxy || this.sxz != param1.sxz || this.tx != param1.tx || this.syx != param1.syx || this.syy != param1.syy || this.syz != param1.syz || this.ty != param1.ty || this.szx != param1.szx || this.szy != param1.szy || this.szz != param1.szz || this.tz != param1.tz)
         {
            return false;
         }
         return true;
      }
      
      public function array2matrix(param1:Array, param2:Boolean, param3:Number) : void
      {
         if(param1.length >= 12)
         {
            if(param2)
            {
               this.sxx = param1[0];
               this.sxy = -param1[1];
               this.sxz = -param1[2];
               this.tx = -param1[3] * param3;
               this.syx = -param1[4];
               this.syy = param1[5];
               this.syz = param1[6];
               this.ty = param1[7] * param3;
               this.szx = -param1[8];
               this.szy = param1[9];
               this.szz = param1[10];
               this.tz = param1[11] * param3;
            }
            else
            {
               this.sxx = param1[0];
               this.sxz = param1[1];
               this.sxy = param1[2];
               this.tx = param1[3] * param3;
               this.szx = param1[4];
               this.szz = param1[5];
               this.szy = param1[6];
               this.tz = param1[7] * param3;
               this.syx = param1[8];
               this.syz = param1[9];
               this.syy = param1[10];
               this.ty = param1[11] * param3;
            }
         }
         if(param1.length >= 16)
         {
            this.swx = param1[12];
            this.swy = param1[13];
            this.swz = param1[14];
            this.tw = param1[15];
         }
         else
         {
            this.swx = this.swy = this.swz = 0;
            this.tw = 1;
         }
      }
      
      public function get det4x4() : Number
      {
         return (this.sxx * this.syy - this.syx * this.sxy) * (this.szz * this.tw - this.swz * this.tz) - (this.sxx * this.szy - this.szx * this.sxy) * (this.syz * this.tw - this.swz * this.ty) + (this.sxx * this.swy - this.swx * this.sxy) * (this.syz * this.tz - this.szz * this.ty) + (this.syx * this.szy - this.szx * this.syy) * (this.sxz * this.tw - this.swz * this.tx) - (this.syx * this.swy - this.swx * this.syy) * (this.sxz * this.tz - this.szz * this.tx) + (this.szx * this.swy - this.swx * this.szy) * (this.sxz * this.ty - this.syz * this.tx);
      }
   }
}
