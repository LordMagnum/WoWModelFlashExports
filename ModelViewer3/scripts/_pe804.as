package
{
   import away3d.core.utils.Cast;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class _pe804 extends Sprite
   {
      
      private static var _xk1184:Bitmap = new Bitmap(_iy193);
      
      private static var _mx1132:BitmapData = Cast.bitmap(_ps162);
      
      private static var _gr730:BitmapData = new BitmapData(_jy976.width,_jy976.height,true,0);
      
      public static var _ps162:Class = _pe804__ps162;
      
      private static var _wd13:Bitmap = new Bitmap(Cast.bitmap(_em191));
      
      private static var _fx97:Bitmap = new Bitmap(_gr730);
      
      private static var _dj456:Bitmap = new Bitmap(_tp789);
      
      public static var _ea742:Class = _pe804__ea742;
      
      public static var _wm1207:Class = _pe804__wm1207;
      
      private static var _iy193:BitmapData = Cast.bitmap(_wm1207);
      
      public static var _em191:Class = _pe804__em191;
      
      private static var _mk449:Bitmap = new Bitmap(Cast.bitmap(_ea742));
      
      public static var _go872:Class = _pe804__go872;
      
      private static var _do998:Bitmap = new Bitmap(_cn603);
      
      private static var _cn603:BitmapData = Cast.bitmap(_ib382);
      
      private static var _jy976:BitmapData = Cast.bitmap(_ea742);
      
      public static var _ib382:Class = _pe804__ib382;
      
      private static var _tp789:BitmapData = Cast.bitmap(_go872);
       
      
      public var _lv1393:Number;
      
      public var _lw1278:Number = 0.0;
      
      private var textField:TextField;
      
      private var _vx373:BitmapData;
      
      private var _ah979:Number;
      
      public function _pe804(param1:String = "Loading...")
      {
         super();
         this._lv1393 = 0;
         addChild(_do998);
         this._vx373 = new BitmapData(_jy976.width,_jy976.height,true,0);
         this._vx373.draw(_mx1132);
         _fx97 = new Bitmap(this._vx373);
         addChild(_fx97);
         _fx97.x = 15;
         _fx97.y = 15;
         addChild(_xk1184);
         _xk1184.x = 15;
         _xk1184.y = 15;
         _xk1184.visible = false;
         addChild(_dj456);
         _dj456.y = 10;
         _dj456.blendMode = BlendMode.ADD;
         _dj456.visible = false;
         addChild(_wd13);
         _wd13.visible = false;
         _wd13.alpha = 0;
         var _loc2_:TextField = new TextField();
         _loc2_.text = param1;
         _loc2_.textColor = 16777215;
         _loc2_.x = (_cn603.width - _loc2_.textWidth) / 2;
         _loc2_.y = (_cn603.height - _loc2_.textHeight) / 2 - 2;
         _loc2_.selectable = false;
         var _loc3_:TextField = new TextField();
         _loc3_.text = param1;
         _loc3_.textColor = 0;
         _loc3_.x = (_cn603.width - _loc2_.textWidth) / 2 + 1;
         _loc3_.y = (_cn603.height - _loc2_.textHeight) / 2 - 1;
         _loc3_.selectable = false;
         addChild(_loc3_);
         addChild(_loc2_);
      }
      
      public function _dg1098() : int
      {
         return _cn603.width;
      }
      
      public function _ta1349() : int
      {
         return _cn603.height;
      }
      
      public function _hy986(param1:int, param2:int) : void
      {
         this.x = param1 - width / 2;
         this.y = param2 - height / 2;
      }
      
      public function _ki798(param1:Number, param2:int) : Boolean
      {
         this._lw1278 = Math.max(this._lw1278,param1);
         if(param1 >= 1)
         {
            this._lw1278 = 1.2;
         }
         this._lv1393 = Math.min(this._lw1278,this._lv1393 + Math.min(80,param2) / 500);
         this._vx373.draw(_jy976,null,null,null,new Rectangle(0,0,_jy976.width * this._lv1393,_mx1132.height));
         _dj456.x = Math.min(1,this._lv1393) * _jy976.width;
         if(this._lv1393 >= 0.05)
         {
            _dj456.visible = true;
            _dj456.alpha = Math.min(1,(this._lv1393 - 0.05) * 20);
         }
         if(this._lv1393 >= 0.9)
         {
            _wd13.visible = true;
            _wd13.alpha = Math.min(1,(this._lv1393 - 0.9) * 10);
            _xk1184.visible = true;
            _xk1184.alpha = Math.min(1,(this._lv1393 - 0.9) * 10);
            _fx97.alpha = Math.max(0,(1 - this._lv1393) * 10);
            _dj456.alpha = Math.max(0,(1 - this._lv1393) * 10);
         }
         if(this._lv1393 >= 1)
         {
            alpha = Math.max(0,(1.2 - this._lv1393) * 5);
         }
         return this._lv1393 >= 1.2;
      }
   }
}
