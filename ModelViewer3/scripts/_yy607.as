package
{
   import flash.utils.ByteArray;
   
   public class _yy607
   {
       
      
      public var flags:int;
      
      public var _ta834:int;
      
      public var _ak886:int;
      
      public var _nj594:int;
      
      public var _jo928:int;
      
      public var _ph973:int;
      
      public var _fp1093:int;
      
      public var priority:int;
      
      public var shader:int;
      
      public var _nx1273:int;
      
      public var _iv1023:int;
      
      public var _va606:int;
      
      public var _qi1054:int;
      
      public function _yy607(param1:ByteArray)
      {
         super();
         this.flags = param1.readUnsignedByte();
         this.priority = param1.readByte();
         this.shader = param1.readUnsignedShort();
         this._va606 = param1.readUnsignedShort();
         this._fp1093 = param1.readUnsignedShort();
         this._nx1273 = param1.readUnsignedShort();
         this._jo928 = param1.readUnsignedShort();
         this._ta834 = param1.readUnsignedShort();
         this._nj594 = param1.readUnsignedShort();
         this._qi1054 = param1.readUnsignedShort();
         this._ph973 = param1.readUnsignedShort();
         this._ak886 = param1.readUnsignedShort();
         this._iv1023 = param1.readUnsignedShort();
      }
      
      public function copy(param1:_yy607) : void
      {
         this.flags = param1.flags;
         this.priority = param1.priority;
         this.shader = param1.shader;
         this._va606 = param1._va606;
         this._fp1093 = param1._fp1093;
         this._nx1273 = param1._nx1273;
         this._jo928 = param1._jo928;
         this._ta834 = param1._ta834;
         this._nj594 = param1._nj594;
         this._qi1054 = param1._qi1054;
         this._ph973 = param1._ph973;
         this._ak886 = param1._ak886;
         this._iv1023 = param1._iv1023;
      }
   }
}
