package
{
   import away3d.core.utils.Cast;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class _ap1178 extends SimpleButton
   {
      
      public static var _im996:BitmapData = Cast.bitmap(_ai387);
      
      public static var _eb1262:BitmapData = Cast.bitmap(_og411);
      
      public static var _ai387:Class = _ap1178__ai387;
      
      public static var _og411:Class = _ap1178__og411;
       
      
      private var _mu616:Boolean = false;
      
      private var _wn166:Bitmap;
      
      private var _vu1112:Bitmap;
      
      public function _ap1178()
      {
         this._wn166 = new Bitmap(_im996);
         this._vu1112 = new Bitmap(_eb1262);
         super(this._vu1112,this._vu1112,this._vu1112,this._vu1112);
         addEventListener(MouseEvent.MOUSE_DOWN,this._ot830,false,0,true);
      }
      
      public function _ot830(param1:MouseEvent) : void
      {
         this._xx1191 = !this._mu616;
      }
      
      public function set _xx1191(param1:Boolean) : void
      {
         if(this._mu616 == param1)
         {
            return;
         }
         this._mu616 = param1;
         if(param1)
         {
            upState = downState = hitTestState = overState = this._wn166;
         }
         else
         {
            upState = downState = hitTestState = overState = this._vu1112;
         }
      }
      
      public function get _xx1191() : Boolean
      {
         return this._mu616;
      }
   }
}
