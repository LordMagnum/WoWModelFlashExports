package
{
   import flash.utils.ByteArray;
   
   public class _jk827
   {
       
      
      public var offset:int;
      
      public var length:int;
      
      public function _jk827(param1:ByteArray)
      {
         super();
         this.length = param1.readInt();
         this.offset = param1.readInt();
      }
      
      public function toString() : String
      {
         return "(" + this.offset + ", " + this.length + ")";
      }
   }
}
