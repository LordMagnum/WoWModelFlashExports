package com.zam.wow
{
   import flash.utils.ByteArray;
   
   public class WowFaceFeature
   {
       
      
      public var geoset1:int;
      
      public var geoset2:int;
      
      public var geoset3:int;
      
      public var textures:Vector.<WowFaceFeatureTexture>;
      
      public function WowFaceFeature()
      {
         super();
      }
      
      public function read(param1:ByteArray) : void
      {
         this.geoset1 = param1.readInt();
         this.geoset2 = param1.readInt();
         this.geoset3 = param1.readInt();
      }
      
      public function readTextures(param1:ByteArray) : void
      {
         var _loc2_:int = param1.readInt();
         this.textures = new Vector.<WowFaceFeatureTexture>(_loc2_);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.textures[_loc3_] = new WowFaceFeatureTexture();
            this.textures[_loc3_].read(param1);
            _loc3_++;
         }
      }
   }
}
