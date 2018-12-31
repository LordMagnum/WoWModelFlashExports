package com.zam.wow
{
   import flash.utils.ByteArray;
   
   public class WowAnimation
   {
       
      
      public var _index:int;
      
      public var _name:String;
      
      public var _duration:int;
      
      public var _flags:int;
      
      public var _translation:Vector.<AnimatedVector3D>;
      
      public var _scale:Vector.<AnimatedVector3D>;
      
      public var _rotation:Vector.<AnimatedQuaternion>;
      
      public function WowAnimation(param1:int)
      {
         super();
         this._index = param1;
      }
      
      public function read(param1:ByteArray, param2:int) : void
      {
         var _loc3_:int = 0;
         this._name = param1.readUTF();
         this._flags = param1.readInt();
         this._duration = param1.readInt();
         if(param2 > 0)
         {
            this._translation = new Vector.<AnimatedVector3D>(param2);
            this._rotation = new Vector.<AnimatedQuaternion>(param2);
            this._scale = new Vector.<AnimatedVector3D>(param2);
            _loc3_ = 0;
            while(_loc3_ < param2)
            {
               this._translation[_loc3_] = new AnimatedVector3D();
               this._rotation[_loc3_] = new AnimatedQuaternion();
               this._scale[_loc3_] = new AnimatedVector3D();
               this._translation[_loc3_].read(param1);
               this._rotation[_loc3_].read(param1);
               this._scale[_loc3_].read(param1);
               _loc3_++;
            }
         }
      }
   }
}
