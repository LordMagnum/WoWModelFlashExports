package
{
   import away3d.core.utils.Cast;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class _pc1306 extends Sprite
   {
      
      public static var _rm1305:Class = _pc1306__rm1305;
      
      public static var _oq1095:BitmapData = Cast.bitmap(_or18);
      
      public static var _cd1215:BitmapData = Cast.bitmap(_yo64);
      
      public static var _xg457:BitmapData = Cast.bitmap(_rm1305);
      
      public static var _js1306:BitmapData = Cast.bitmap(_hb842);
      
      public static var _dm1329:BitmapData = Cast.bitmap(_re1409);
      
      public static var _wp1261:Class = _pc1306__wp1261;
      
      public static var _ck1293:BitmapData = Cast.bitmap(_qi506);
      
      public static var _jh518:BitmapData = Cast.bitmap(_wp1261);
      
      public static var _ul831:Class = _pc1306__ul831;
      
      public static var _ds593:BitmapData = Cast.bitmap(_vy1006);
      
      public static var _gh1301:BitmapData = Cast.bitmap(_pm17);
      
      public static var _or18:Class = _pc1306__or18;
      
      public static var _xl1182:BitmapData = Cast.bitmap(_ul831);
      
      public static var _aw556:BitmapData = Cast.bitmap(_bt900);
      
      public static var _mv824:Class = _pc1306__mv824;
      
      public static var _yo64:Class = _pc1306__yo64;
      
      public static var _vt1081:BitmapData = Cast.bitmap(_tr82);
      
      public static var _qd82:BitmapData = Cast.bitmap(_fy301);
      
      public static var _vf739:BitmapData = Cast.bitmap(_mv824);
      
      public static var _re1409:Class = _pc1306__re1409;
      
      public static var _fy301:Class = _pc1306__fy301;
      
      public static var _vy1006:Class = _pc1306__vy1006;
      
      public static var _pm17:Class = _pc1306__pm17;
      
      public static var _al933:BitmapData = Cast.bitmap(_eh742);
      
      public static var _dm624:Class = _pc1306__dm624;
      
      public static var _tp375:Class = _pc1306__tp375;
      
      public static var _tr82:Class = _pc1306__tr82;
      
      public static var _fu232:BitmapData = Cast.bitmap(_tp375);
      
      public static var _bt900:Class = _pc1306__bt900;
      
      public static var _fl1018:Class = _pc1306__fl1018;
      
      public static var _lh650:BitmapData = Cast.bitmap(_fl1018);
      
      public static var _ci235:BitmapData = Cast.bitmap(_dm624);
      
      public static var _qi506:Class = _pc1306__qi506;
      
      public static var _eh742:Class = _pc1306__eh742;
      
      public static var _hb842:Class = _pc1306__hb842;
       
      
      public var _rk317:int;
      
      public var _uy1018:Bitmap;
      
      public var _gn750:SimpleButton;
      
      public var textField:_ij408;
      
      public var _fq823:Bitmap;
      
      public var _wm1062:Bitmap;
      
      public var _ow322:Array;
      
      public var _jp339:Bitmap;
      
      public var _om1007:Boolean = false;
      
      public var _qa444:Bitmap;
      
      public var _bb1318:Bitmap;
      
      public var _fa1258:Bitmap;
      
      public var _lf301:SimpleButton;
      
      public var _nj1321:Object;
      
      public var _ah947:Bitmap;
      
      public function _pc1306(param1:Boolean, param2:Array, param3:Function = null)
      {
         super();
         this._nj1321 = param3;
         this._ow322 = param2;
         this._om1007 = param1;
         this._gn750 = new SimpleButton();
         this._lf301 = new SimpleButton();
         if(param1)
         {
            this._ah947 = new Bitmap(_ck1293);
            this._wm1062 = new Bitmap(_xl1182);
            this._bb1318 = new Bitmap(_jh518);
            this._qa444 = new Bitmap(_aw556);
            this._uy1018 = new Bitmap(_vf739);
            this._fq823 = new Bitmap(_qd82);
            this._fa1258 = new Bitmap(_lh650);
            this._jp339 = new Bitmap(_fu232);
            this.textField = new _ij408(new Bitmap(_gh1301),16771584,24);
         }
         else
         {
            this._ah947 = new Bitmap(_ci235);
            this._wm1062 = new Bitmap(_dm1329);
            this._bb1318 = new Bitmap(_al933);
            this._qa444 = new Bitmap(_js1306);
            this._uy1018 = new Bitmap(_xg457);
            this._fq823 = new Bitmap(_ds593);
            this._fa1258 = new Bitmap(_cd1215);
            this._jp339 = new Bitmap(_oq1095);
            this.textField = new _ij408(new Bitmap(_vt1081),16771584,12);
         }
         this._gn750.x = 0;
         this._gn750.y = 0;
         this.textField.x = this._ah947.width - 2;
         this.textField.y = 0;
         this._lf301.x = this.textField.x + this.textField.width - 2;
         this._lf301.y = 0;
         addChild(this._gn750);
         addChild(this.textField);
         addChild(this._lf301);
         this.value = 0;
         if(this._ow322 && this._ow322.length > 0)
         {
            this.textField.text = this._ow322[0];
         }
         this._gn750.addEventListener(MouseEvent.MOUSE_DOWN,this._gl734,false,0,true);
         this._lf301.addEventListener(MouseEvent.MOUSE_DOWN,this._pj756,false,0,true);
      }
      
      public function _gl734(param1:MouseEvent) : void
      {
         if(this._rk317 > 0)
         {
            this.value = this.value - 1;
            this.textField.text = this._ow322[this._rk317];
            if(this._nj1321)
            {
               this._nj1321(this._rk317);
            }
         }
      }
      
      public function set value(param1:int) : void
      {
         if(this._rk317 < 0 || this._rk317 >= this._ow322.length)
         {
            return;
         }
         if(param1 == 0)
         {
            this._gn750.overState = this._gn750.upState = this._gn750.downState = this._qa444;
         }
         else
         {
            this._gn750.upState = this._gn750.hitTestState = this._ah947;
            this._gn750.overState = this._wm1062;
            this._gn750.downState = this._bb1318;
         }
         if(param1 == this._ow322.length - 1)
         {
            this._lf301.overState = this._lf301.upState = this._lf301.downState = this._jp339;
         }
         else
         {
            this._lf301.upState = this._lf301.hitTestState = this._uy1018;
            this._lf301.overState = this._fq823;
            this._lf301.downState = this._fa1258;
         }
         this._rk317 = param1;
         this.textField.text = this._ow322[this._rk317];
      }
      
      public function _pj756(param1:MouseEvent) : void
      {
         if(this._rk317 < this._ow322.length - 1)
         {
            this.value = this.value + 1;
            this.textField.text = this._ow322[this._rk317];
            if(this._nj1321)
            {
               this._nj1321(this._rk317);
            }
         }
      }
      
      public function get value() : int
      {
         return this._rk317;
      }
   }
}
