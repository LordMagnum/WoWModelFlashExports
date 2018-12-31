package
{
   import flash.utils.ByteArray;
   
   public class _du1292
   {
       
      
      public var _uf542:_ap392;
      
      public var _by1186:int;
      
      public var position:_gs89;
      
      public var _nq395:int;
      
      public function _du1292(param1:ByteArray)
      {
         super();
         this._by1186 = param1.readInt();
         this._nq395 = param1.readInt();
         this.position = _gs89._wg1203(param1);
         this._uf542 = new _ap392(param1);
      }
   }
}
