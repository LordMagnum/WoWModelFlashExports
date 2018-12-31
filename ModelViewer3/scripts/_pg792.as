package
{
   import flash.utils.ByteArray;
   
   public class _pg792
   {
       
      
      public var _yd183:_gs89;
      
      public var _jt511:int;
      
      public var _yx150:int;
      
      public var _mv257:Number;
      
      public var _cg1081:int;
      
      public var _mf510:int;
      
      public var _ne703:int;
      
      public var id:int;
      
      public var _bu43:int;
      
      public var _yu196:int;
      
      public var _nw738:_gs89;
      
      public var _tf1408:int;
      
      public function _pg792(param1:ByteArray)
      {
         super();
         this.id = param1.readInt();
         this._jt511 = param1.readUnsignedShort();
         this._yu196 = param1.readUnsignedShort();
         this._yx150 = param1.readUnsignedShort();
         this._tf1408 = param1.readUnsignedShort();
         this._mf510 = param1.readUnsignedShort();
         this._bu43 = param1.readUnsignedShort();
         this._cg1081 = param1.readUnsignedShort();
         this._ne703 = param1.readUnsignedShort();
         this._nw738 = _gs89._wg1203(param1);
         this._yd183 = _gs89._wg1203(param1);
         this._mv257 = param1.readFloat();
      }
   }
}
