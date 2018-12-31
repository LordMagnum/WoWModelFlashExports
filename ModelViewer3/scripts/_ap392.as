package
{
   import flash.utils.ByteArray;
   
   public class _ap392
   {
       
      
      public var _us904:int;
      
      public var _yc212:int;
      
      public var _af843:_jk827;
      
      public var _rb697:_jk827;
      
      public function _ap392(param1:ByteArray)
      {
         super();
         this._us904 = param1.readShort();
         this._yc212 = param1.readShort();
         this._rb697 = new _jk827(param1);
         this._af843 = new _jk827(param1);
      }
   }
}
