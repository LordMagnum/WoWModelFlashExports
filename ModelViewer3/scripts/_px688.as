package
{
   import away3d.core.utils.Cast;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class _px688 extends _bx752
   {
      
      public static var _wv810:int = 6;
      
      public static var _fh162:Class = _px688__fh162;
       
      
      public var _un503:Number = 0;
      
      public var _fm521:Boolean = false;
      
      public var listener:Object;
      
      public var _bu1230:Number = 0;
      
      public var _lj555:Boolean = false;
      
      public var _de803:Bitmap;
      
      public function _px688(param1:Boolean, param2:int, param3:int)
      {
         super(param1,param2,param3);
         this._de803 = new Bitmap(Cast.bitmap(_fh162));
         addChild(this._de803);
         this.update(0,0);
         addEventListener(MouseEvent.MOUSE_DOWN,this._vm699);
         addEventListener(MouseEvent.MOUSE_MOVE,this._ig1048);
      }
      
      public function _vm699(param1:Event) : void
      {
         this._sl11(mouseX,mouseY);
      }
      
      public function update(param1:Number, param2:Number) : void
      {
         this._un503 = param1;
         this._bu1230 = param2;
         this._ve1303();
      }
      
      public function _ay708(param1:Object) : void
      {
         this.listener = param1;
      }
      
      public function _ig1048(param1:MouseEvent) : void
      {
         if(param1.buttonDown && !this._fm521)
         {
            this._sl11(mouseX,mouseY);
         }
      }
      
      public function _ve1303() : void
      {
         var _loc1_:Number = (this._bu1230 + 1) / 2;
         var _loc2_:Number = (this._un503 + 1) / 2;
         this._de803.x = _wv810 + _loc2_ * (width - 2 * _wv810 - this._de803.width);
         this._de803.y = _wv810 + _loc1_ * (height - 2 * _wv810 - this._de803.height);
      }
      
      public function _sl11(param1:int, param2:int) : void
      {
         this._un503 = 2 * param1 / width - 1;
         this._bu1230 = 2 * param2 / height - 1;
         var _loc3_:int = this._de803.width / 2;
         var _loc4_:int = this._de803.height / 2;
         var _loc5_:int = Math.max(_wv810 + _loc3_,Math.min(width - _wv810 - _loc3_,param1));
         var _loc6_:int = Math.max(_wv810 + _loc4_,Math.min(height - _wv810 - _loc4_,param2));
         this._un503 = 2 * (_loc5_ - _wv810 - _loc3_) / (width - 2 * _wv810 - 2 * _loc3_) - 1;
         this._bu1230 = 2 * (_loc6_ - _wv810 - _loc4_) / (height - 2 * _wv810 - 2 * _loc4_) - 1;
         this._ve1303();
         if(this.listener)
         {
            this.listener._sl11(this._un503,this._bu1230);
         }
      }
   }
}
