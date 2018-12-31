package
{
   import flash.utils.ByteArray;
   
   public class _nm1047
   {
       
      
      public var _po1323:int;
      
      public var _jl1344:int;
      
      public var loaded:Boolean;
      
      public var flags:int;
      
      public var radius:Number;
      
      public var duration:int;
      
      public var _mx932:int;
      
      public var _mo920:int;
      
      public var _og484:int;
      
      public var id:int;
      
      public var _ly1227:int;
      
      public var _qv347:Number;
      
      public var _le375:int;
      
      public var _rr101:int;
      
      public function _nm1047(param1:ByteArray)
      {
         super();
         this.id = param1.readUnsignedShort();
         this._ly1227 = param1.readUnsignedShort();
         this.duration = param1.readInt();
         this._qv347 = param1.readFloat();
         this.flags = param1.readUnsignedInt();
         this._mo920 = param1.readUnsignedInt();
         this._po1323 = param1.readUnsignedInt();
         this._mx932 = param1.readUnsignedInt();
         this._rr101 = param1.readUnsignedInt();
         param1.position = param1.position + 24;
         this.radius = param1.readFloat();
         this._le375 = param1.readUnsignedShort();
         this._og484 = param1.readUnsignedShort();
         this.loaded = false;
      }
   }
}
