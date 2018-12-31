package com.zam.wow
{
   import flash.utils.ByteArray;
   
   public class WowTextureAnimation
   {
       
      
      public var translation:Vector.<AnimatedVector3D>;
      
      public var rotation:Vector.<AnimatedQuaternion>;
      
      public var scale:Vector.<AnimatedVector3D>;
      
      public function WowTextureAnimation()
      {
         super();
      }
      
      public function read(param1:ByteArray) : void
      {
         this.translation = WowUtil.readAnimatedVector3DSet(param1);
         this.rotation = WowUtil.readAnimatedQuaternionSet(param1);
         this.scale = WowUtil.readAnimatedVector3DSet(param1);
      }
   }
}
