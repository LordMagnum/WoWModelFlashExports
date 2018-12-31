package com.zam.wow
{
   import flash.geom.Vector3D;
   import flash.utils.ByteArray;
   
   public class WowAttachment
   {
       
      
      public var _slot:int;
      
      public var _bone:int;
      
      public var _position:Vector3D;
      
      public function WowAttachment()
      {
         super();
      }
      
      public function read(param1:ByteArray) : void
      {
         this._slot = param1.readShort();
         this._bone = param1.readShort();
         this._position = WowUtil.readVector3D(param1);
      }
   }
}
