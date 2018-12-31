package com.zam.gw2
{
   import flash.utils.ByteArray;
   
   public class Material
   {
       
      
      public var type:uint;
      
      public var index:uint;
      
      public var flags:uint;
      
      public var fileId:uint;
      
      public function Material()
      {
         super();
      }
      
      public function read(param1:ByteArray) : void
      {
         this.type = param1.readUnsignedByte();
         this.index = param1.readUnsignedInt();
         this.flags = param1.readUnsignedInt();
         this.fileId = param1.readUnsignedInt();
      }
   }
}
