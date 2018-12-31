package com.zam.wow
{
   import flash.utils.ByteArray;
   
   public class WowHair
   {
       
      
      public var geoset:int;
      
      public var index:int;
      
      public var textures:Vector.<WowHairTexture>;
      
      public function WowHair()
      {
         super();
      }
      
      public function read(param1:ByteArray) : void
      {
         this.geoset = param1.readInt();
         this.index = param1.readInt();
      }
      
      public function readTextures(param1:ByteArray) : void
      {
         var _loc2_:int = param1.readInt();
         this.textures = new Vector.<WowHairTexture>(_loc2_);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.textures[_loc3_] = new WowHairTexture();
            this.textures[_loc3_].read(param1);
            _loc3_++;
         }
      }
   }
}
