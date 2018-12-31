package
{
   import away3d.core.utils.Cast;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class _tu1192 extends Sprite
   {
      
      public static var _jw959:BitmapData = Cast.bitmap(_fj784);
      
      public static var _be518:Class = _tu1192__be518;
      
      public static var _mv1233:Class = _tu1192__mv1233;
      
      public static var _nt890:BitmapData = Cast.bitmap(_be518);
      
      public static var _cp714:Class = _tu1192__cp714;
      
      public static var _ls801:BitmapData = Cast.bitmap(_pc1108);
      
      public static var _gg104:Class = _tu1192__gg104;
      
      public static var _uv734:BitmapData = Cast.bitmap(_ma328);
      
      public static var _dq31:BitmapData = Cast.bitmap(_cp714);
      
      public static var _vk1179:BitmapData = Cast.bitmap(_mv1233);
      
      public static var _mf735:Class = _tu1192__mf735;
      
      public static var _xl351:BitmapData = Cast.bitmap(_gg104);
      
      public static var _ma328:Class = _tu1192__ma328;
      
      public static var _tv1034:Class = _tu1192__tv1034;
      
      public static var _fj784:Class = _tu1192__fj784;
      
      public static var _bu1352:BitmapData = Cast.bitmap(_tv1034);
      
      public static var _pc1108:Class = _tu1192__pc1108;
      
      public static var _to778:BitmapData = Cast.bitmap(_mf735);
       
      
      public var text:String;
      
      public var _gt412:SimpleButton;
      
      public var textField:TextField;
      
      public function _tu1192(param1:int = 0, param2:String = null)
      {
         var _loc8_:TextField = null;
         var _loc9_:TextField = null;
         super();
         var _loc3_:int = _vk1179.width + _uv734.width;
         var _loc4_:int = (param1 - _loc3_ + _dq31.width - 1) / _dq31.width;
         _loc3_ = _loc3_ + _dq31.width * _loc4_;
         var _loc5_:Bitmap = new Bitmap(_hp718(_vk1179,_dq31,_uv734,_loc4_));
         var _loc6_:Bitmap = new Bitmap(_hp718(_nt890,_xl351,_ls801,_loc4_));
         var _loc7_:Bitmap = new Bitmap(_hp718(_to778,_bu1352,_jw959,_loc4_));
         this._gt412 = new SimpleButton(_loc5_,_loc6_,_loc7_,_loc5_);
         addChild(this._gt412);
         this.buttonMode = false;
         if(param2)
         {
            _loc8_ = new TextField();
            _loc8_.width = this._gt412.width;
            _loc8_.text = param2;
            _loc8_.selectable = false;
            _loc8_.setTextFormat(new TextFormat("calibri",16,16771584,false,false,false,null,null,"center"));
            _loc8_.height = _loc8_.textHeight + 8;
            _loc8_.y = (this._gt412.height - _loc8_.height) / 2;
            _loc9_ = new TextField();
            _loc9_.width = this._gt412.width;
            _loc9_.text = param2;
            _loc9_.selectable = false;
            _loc9_.setTextFormat(new TextFormat("calibri",16,0,false,false,false,null,null,"center"));
            _loc9_.height = _loc8_.height;
            _loc9_.x = _loc8_.x + 1;
            _loc9_.y = _loc8_.y + 1;
            addChild(_loc9_);
            addChild(_loc8_);
         }
      }
      
      public static function _up1270(param1:int, param2:String) : SimpleButton
      {
         var _loc3_:int = _vk1179.width + _uv734.width;
         var _loc4_:int = (param1 - _loc3_ + _dq31.width - 1) / _dq31.width;
         _loc3_ = _loc3_ + _dq31.width * _loc4_;
         var _loc5_:Sprite = new Sprite();
         var _loc6_:Sprite = new Sprite();
         var _loc7_:Sprite = new Sprite();
         var _loc8_:BitmapData = _hp718(_vk1179,_dq31,_uv734,_loc4_);
         _loc5_.graphics.beginBitmapFill(_loc8_);
         _loc5_.graphics.drawRect(0,0,_loc8_.width,_loc8_.height);
         _loc5_.graphics.endFill();
         _loc8_ = _hp718(_nt890,_xl351,_ls801,_loc4_);
         _loc6_.graphics.beginBitmapFill(_loc8_);
         _loc6_.graphics.drawRect(0,0,_loc8_.width,_loc8_.height);
         _loc6_.graphics.endFill();
         _loc8_ = _hp718(_to778,_bu1352,_jw959,_loc4_);
         _loc7_.graphics.beginBitmapFill(_loc8_);
         _loc7_.graphics.drawRect(0,0,_loc8_.width,_loc8_.height);
         _loc7_.graphics.endFill();
         var _loc9_:TextFormat = new TextFormat("calibri",16,16771584,false,false,false,null,null,"center");
         var _loc10_:TextFormat = new TextFormat("calibri",16,0,false,false,false,null,null,"center");
         var _loc11_:TextField = new TextField();
         _loc11_.width = param1;
         _loc11_.text = param2;
         _loc11_.selectable = false;
         _loc11_.setTextFormat(_loc9_);
         _loc11_.height = _loc11_.textHeight + 8;
         _loc11_.y = (_loc5_.height - _loc11_.height) / 2;
         var _loc12_:TextField = new TextField();
         _loc12_.width = param1;
         _loc12_.text = param2;
         _loc12_.selectable = false;
         _loc12_.setTextFormat(_loc10_);
         _loc12_.height = _loc11_.height;
         _loc12_.x = _loc11_.x + 1;
         _loc12_.y = _loc11_.y + 1;
         var _loc13_:TextField = new TextField();
         _loc13_.width = param1;
         _loc13_.text = param2;
         _loc13_.selectable = false;
         _loc13_.setTextFormat(_loc9_);
         _loc13_.height = _loc13_.textHeight + 8;
         _loc13_.y = (_loc5_.height - _loc13_.height) / 2;
         var _loc14_:TextField = new TextField();
         _loc14_.width = param1;
         _loc14_.text = param2;
         _loc14_.selectable = false;
         _loc14_.setTextFormat(_loc9_);
         _loc14_.height = _loc14_.textHeight + 8;
         _loc14_.y = (_loc5_.height - _loc14_.height) / 2;
         _loc5_.addChild(_loc12_);
         _loc5_.addChild(_loc11_);
         _loc6_.addChild(_loc13_);
         _loc7_.addChild(_loc14_);
         var _loc15_:SimpleButton = new SimpleButton(_loc5_,_loc6_,_loc7_,_loc5_);
         return _loc15_;
      }
      
      public static function _vl82(param1:BitmapData, param2:BitmapData, param3:BitmapData, param4:int) : Sprite
      {
         var _loc5_:Sprite = new Sprite();
         var _loc6_:Graphics = _loc5_.graphics;
         var _loc7_:int = 0;
         _loc6_.beginBitmapFill(param1);
         _loc6_.drawRect(_loc7_,0,param1.width,param1.height);
         _loc6_.endFill();
         _loc7_ = _loc7_ + param1.width;
         var _loc8_:int = 0;
         while(_loc8_ < param4)
         {
            _loc6_.beginBitmapFill(param2);
            _loc6_.drawRect(_loc7_,0,param2.width,param2.height);
            _loc7_ = _loc7_ + param2.width;
            _loc6_.endFill();
            _loc8_++;
         }
         _loc6_.beginBitmapFill(param3,new Matrix(1,0,0,1,_loc7_ + 1,0));
         _loc6_.drawRect(_loc7_,0,param3.width,param3.height);
         _loc6_.endFill();
         return _loc5_;
      }
      
      public static function _hp718(param1:BitmapData, param2:BitmapData, param3:BitmapData, param4:int) : BitmapData
      {
         var _loc5_:BitmapData = new BitmapData(param1.width + param2.width * param4 + param3.width,param1.height,true,0);
         var _loc6_:int = 0;
         _loc5_.draw(param1);
         _loc6_ = _loc6_ + param1.width;
         var _loc7_:int = 0;
         while(_loc7_ < param4)
         {
            _loc5_.draw(param2,new Matrix(1,0,0,1,_loc6_,0));
            _loc6_ = _loc6_ + param2.width;
            _loc7_++;
         }
         _loc5_.draw(param3,new Matrix(1,0,0,1,_loc6_,0));
         return _loc5_;
      }
      
      public static function _bo745(param1:SimpleButton, param2:String) : Sprite
      {
         var _loc3_:Sprite = new Sprite();
         var _loc4_:TextField = new TextField();
         _loc4_.width = param1.width;
         _loc4_.text = param2;
         _loc4_.selectable = false;
         _loc4_.setTextFormat(new TextFormat("calibri",16,16771584,false,false,false,null,null,"center"));
         _loc4_.height = _loc4_.textHeight + 8;
         _loc4_.y = (param1.height - _loc4_.height) / 2;
         var _loc5_:TextField = new TextField();
         _loc5_.width = param1.width;
         _loc5_.text = param2;
         _loc5_.selectable = false;
         _loc5_.setTextFormat(new TextFormat("calibri",16,0,false,false,false,null,null,"center"));
         _loc5_.height = _loc4_.height;
         _loc5_.x = _loc4_.x + 1;
         _loc5_.y = _loc4_.y + 1;
         _loc3_.addChild(param1);
         _loc3_.addChild(_loc5_);
         _loc3_.addChild(_loc4_);
         return _loc3_;
      }
   }
}
