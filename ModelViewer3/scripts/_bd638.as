package
{
   import flash.display.DisplayObject;
   import flash.display.SimpleButton;
   
   public class _bd638 extends SimpleButton
   {
       
      
      public var _kx183:DisplayObject;
      
      public var _pc104:DisplayObject;
      
      public var _mh1209:DisplayObject;
      
      public var _nr324:DisplayObject;
      
      public var _wq717:DisplayObject;
      
      public var _rm672:DisplayObject;
      
      public var _ee944:DisplayObject;
      
      public var _qq703:DisplayObject;
      
      public var _hd327:Boolean = false;
      
      public function _bd638(param1:DisplayObject = null, param2:DisplayObject = null, param3:DisplayObject = null, param4:DisplayObject = null, param5:DisplayObject = null, param6:DisplayObject = null, param7:DisplayObject = null, param8:DisplayObject = null)
      {
         super(param1,param2,param3,param4);
         this._qq703 = param1;
         this._rm672 = param2;
         this._ee944 = param3;
         this._kx183 = param4;
         this._nr324 = param5;
         this._pc104 = param6;
         this._mh1209 = param7;
         this._wq717 = param8;
      }
      
      public function resize(param1:Boolean = false) : void
      {
         if(param1 == this._hd327)
         {
            return;
         }
         this._hd327 = param1;
         this.reset();
      }
      
      public function reset() : void
      {
         if(this._hd327)
         {
            upState = this._nr324;
            overState = this._pc104;
            downState = this._mh1209;
            hitTestState = this._wq717;
         }
         else
         {
            upState = this._qq703;
            overState = this._rm672;
            downState = this._ee944;
            hitTestState = this._kx183;
         }
      }
   }
}
