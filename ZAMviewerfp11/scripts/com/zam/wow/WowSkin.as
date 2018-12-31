package com.zam.wow
{
   import flash.utils.ByteArray;
   
   public class WowSkin
   {
       
      
      public var baseTexture:String;
      
      public var furTexture:String;
      
      public var pantiesTexture:String;
      
      public var braTexture:String;
      
      public var faces:Vector.<WowFace>;
      
      public function WowSkin()
      {
         super();
      }
      
      public function read(param1:ByteArray) : void
      {
         this.baseTexture = param1.readUTF();
         this.furTexture = param1.readUTF();
         this.pantiesTexture = param1.readUTF();
         this.braTexture = param1.readUTF();
      }
      
      public function readFaces(param1:ByteArray) : void
      {
         var _loc2_:int = param1.readInt();
         this.faces = new Vector.<WowFace>(_loc2_);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.faces[_loc3_] = new WowFace();
            this.faces[_loc3_].read(param1);
            _loc3_++;
         }
      }
   }
}
