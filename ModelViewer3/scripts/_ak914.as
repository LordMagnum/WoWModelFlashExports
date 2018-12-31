package
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class _ak914 extends Sprite
   {
       
      
      public var _gp625:Array = null;
      
      public var timer:int = 0;
      
      public var _xc213:int = 0;
      
      public var _lx874:Bitmap;
      
      public function _ak914(param1:Array, param2:int)
      {
         super();
         this._gp625 = param1;
         this._xc213 = param2;
         this.update(0);
      }
      
      public function update(param1:int) : void
      {
         if(!this._gp625)
         {
            return;
         }
         this.timer = this.timer + param1;
         this.timer = this.timer % (this._gp625.length * this._xc213);
         var _loc2_:Bitmap = this._gp625[int(this.timer / this._xc213)];
         if(_loc2_ != this._lx874)
         {
            if(this._lx874 && contains(this._lx874))
            {
               removeChild(this._lx874);
            }
            addChild(_loc2_);
            this._lx874 = _loc2_;
         }
      }
   }
}
