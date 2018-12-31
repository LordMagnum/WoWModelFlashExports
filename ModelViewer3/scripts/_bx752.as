package
{
   import away3d.core.utils.Cast;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class _bx752 extends Sprite
   {
      
      public static var _rm439:BitmapData = Cast.bitmap(_yt192);
      
      public static var _dq440:Class = _bx752__dq440;
      
      public static var _bh191:BitmapData = Cast.bitmap(_dq440);
      
      public static var _yt192:Class = _bx752__yt192;
      
      public static var _ur70:BitmapData = Cast.bitmap(_mc492);
      
      public static var _wt950:Class = _bx752__wt950;
      
      public static var _ym483:Class = _bx752__ym483;
      
      public static var _cj1069:Class = _bx752__cj1069;
      
      public static var _mc63:Class = _bx752__mc63;
      
      public static var _ec156:BitmapData = Cast.bitmap(_ps1281);
      
      public static var _xq97:BitmapData = Cast.bitmap(_jq1005);
      
      public static var _qx688:BitmapData = Cast.bitmap(_ew851);
      
      public static var _pj1220:Class = _bx752__pj1220;
      
      public static var _cn826:BitmapData = Cast.bitmap(_cj1069);
      
      public static var _kl604:Class = _bx752__kl604;
      
      public static var _qm1056:Class = _bx752__qm1056;
      
      public static var _jd683:BitmapData = Cast.bitmap(_qm1056);
      
      public static var _hl1148:BitmapData = Cast.bitmap(_pj1220);
      
      public static var _jq1005:Class = _bx752__jq1005;
      
      public static var _uh1261:BitmapData = Cast.bitmap(_gn963);
      
      public static var _eh531:Class = _bx752__eh531;
      
      public static var _jd210:BitmapData = Cast.bitmap(_ym483);
      
      public static var _vk488:BitmapData = Cast.bitmap(_kw1361);
      
      public static var _qc289:BitmapData = Cast.bitmap(_wt950);
      
      public static var _ew851:Class = _bx752__ew851;
      
      public static var _uy979:BitmapData = Cast.bitmap(_eh531);
      
      public static var _sk607:BitmapData = Cast.bitmap(_mc63);
      
      public static var _kw1361:Class = _bx752__kw1361;
      
      public static var _ia948:BitmapData = Cast.bitmap(_kl604);
      
      public static var _gn963:Class = _bx752__gn963;
      
      public static var _mc492:Class = _bx752__mc492;
      
      public static var _ps1281:Class = _bx752__ps1281;
       
      
      public function _bx752(param1:Boolean, param2:int, param3:int)
      {
         super();
         var _loc4_:BitmapData = _sg576(param1,param2,param3);
         graphics.beginBitmapFill(_loc4_);
         graphics.drawRect(0,0,_loc4_.width,_loc4_.height);
         graphics.endFill();
      }
      
      public static function _sg576(param1:Boolean, param2:int, param3:int) : BitmapData
      {
         var _loc4_:BitmapData = null;
         var _loc5_:BitmapData = null;
         var _loc6_:BitmapData = null;
         var _loc7_:BitmapData = null;
         var _loc8_:BitmapData = null;
         var _loc9_:BitmapData = null;
         var _loc10_:BitmapData = null;
         var _loc11_:BitmapData = null;
         var _loc17_:int = 0;
         if(param1)
         {
            _loc4_ = _qx688;
            _loc5_ = _ec156;
            _loc6_ = _ia948;
            _loc7_ = _rm439;
            _loc8_ = _uh1261;
            _loc9_ = _uy979;
            _loc10_ = _bh191;
            _loc11_ = _cn826;
         }
         else
         {
            _loc4_ = _xq97;
            _loc5_ = _qc289;
            _loc6_ = _jd683;
            _loc7_ = _sk607;
            _loc8_ = _vk488;
            _loc9_ = _hl1148;
            _loc10_ = _jd210;
            _loc11_ = _ur70;
         }
         var _loc12_:int = int(_loc4_.width);
         var _loc13_:int = int(_loc4_.height);
         param2 = _loc12_ * Math.ceil(param2 / _loc12_);
         param3 = _loc13_ * Math.ceil(param3 / _loc13_);
         var _loc14_:int = int(Math.max(0,param2 / _loc12_));
         var _loc15_:int = int(Math.max(0,param3 / _loc13_));
         var _loc16_:BitmapData = new BitmapData(param2,param3,true,0);
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         _loc16_.draw(_loc4_);
         _loc18_ = _loc12_;
         _loc17_ = 0;
         while(_loc17_ < _loc14_ - 2)
         {
            _loc16_.draw(_loc5_,new Matrix(1,0,0,1,_loc18_,_loc19_));
            _loc18_ = _loc18_ + _loc12_;
            _loc17_++;
         }
         _loc16_.draw(_loc6_,new Matrix(1,0,0,1,_loc18_,_loc19_));
         _loc18_ = 0;
         _loc19_ = _loc13_;
         _loc17_ = 0;
         while(_loc17_ < _loc15_ - 2)
         {
            _loc16_.draw(_loc7_,new Matrix(1,0,0,1,_loc18_,_loc19_));
            _loc19_ = _loc19_ + _loc13_;
            _loc17_++;
         }
         _loc16_.fillRect(new Rectangle(_loc12_,_loc13_,_loc12_ * (_loc14_ - 2),_loc13_ * (_loc15_ - 2)),3003121664);
         _loc18_ = _loc12_ * (_loc14_ - 1);
         _loc19_ = _loc13_;
         _loc17_ = 0;
         while(_loc17_ < _loc15_ - 2)
         {
            _loc16_.draw(_loc8_,new Matrix(1,0,0,1,_loc18_,_loc19_));
            _loc19_ = _loc19_ + _loc13_;
            _loc17_++;
         }
         _loc18_ = 0;
         _loc19_ = _loc13_ * (_loc15_ - 1);
         _loc16_.draw(_loc9_,new Matrix(1,0,0,1,_loc18_,_loc19_));
         _loc18_ = _loc12_;
         _loc17_ = 0;
         while(_loc17_ < _loc14_ - 2)
         {
            _loc16_.draw(_loc10_,new Matrix(1,0,0,1,_loc18_,_loc19_));
            _loc18_ = _loc18_ + _loc12_;
            _loc17_++;
         }
         _loc16_.draw(_loc11_,new Matrix(1,0,0,1,_loc18_,_loc19_));
         return _loc16_;
      }
   }
}
