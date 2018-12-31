package com.zam.wow
{
   import flash.utils.ByteArray;
   
   public class WowFace
   {
       
      
      public var lowerTexture:String;
      
      public var upperTexture:String;
      
      public function WowFace()
      {
         super();
      }
      
      public function read(param1:ByteArray) : void
      {
         this.lowerTexture = param1.readUTF();
         this.upperTexture = param1.readUTF();
      }
   }
}
