package
{
   import flash.utils.ByteArray;
   
   public class _le493
   {
       
      
      public var blendMode:int;
      
      public var flags:int;
      
      public function _le493(param1:ByteArray)
      {
         super();
         this.flags = param1.readUnsignedShort();
         this.blendMode = param1.readUnsignedShort();
      }
      
      public function _lf10() : Boolean
      {
         return (this.flags & _md341._ox933) != 0;
      }
   }
}
