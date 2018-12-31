package com.zam.wow
{
   import flash.utils.ByteArray;
   
   public class WowHairTexture
   {
       
      
      public var texture:String;
      
      public var lowerTexture:String;
      
      public var upperTexture:String;
      
      public function WowHairTexture()
      {
         super();
      }
      
      public function read(param1:ByteArray) : void
      {
         this.texture = param1.readUTF();
         this.lowerTexture = param1.readUTF();
         this.upperTexture = param1.readUTF();
      }
   }
}
