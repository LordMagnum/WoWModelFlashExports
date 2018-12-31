package com.zam.lol
{
   import flash.geom.Vector3D;
   import flash.utils.ByteArray;
   
   public class Vertex
   {
       
      
      public var position:Vector3D;
      
      public var normal:Vector3D;
      
      public var u:Number;
      
      public var v:Number;
      
      public var bones:Vector.<int>;
      
      public var weights:Vector.<Number>;
      
      public function Vertex()
      {
         super();
         this.bones = Vector.<int>([-1,-1,-1,-1]);
         this.weights = Vector.<Number>([0,0,0,0]);
      }
      
      public function read(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         this.position = Util.readVector3D(param1);
         this.position.w = 1;
         this.normal = Util.readVector3D(param1);
         this.normal.w = 0;
         this.u = param1.readFloat();
         this.v = param1.readFloat();
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            this.bones[_loc2_] = param1.readUnsignedByte();
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            this.weights[_loc2_] = param1.readFloat();
            _loc2_++;
         }
      }
   }
}
