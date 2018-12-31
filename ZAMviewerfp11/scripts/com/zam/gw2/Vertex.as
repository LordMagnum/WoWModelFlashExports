package com.zam.gw2
{
   import com.zam.ZamUtil;
   import flash.geom.Vector3D;
   import flash.utils.ByteArray;
   
   public class Vertex
   {
       
      
      public var position:Vector3D;
      
      public var normal:Vector3D;
      
      public var u:Number;
      
      public var v:Number;
      
      public var tangent:Vector3D;
      
      public var bitangent:Vector3D;
      
      public var color:uint;
      
      public function Vertex()
      {
         super();
      }
      
      public function read(param1:ByteArray, param2:Gw2Mesh) : void
      {
         this.position = ZamUtil.readVector3D(param1);
         this.position.w = 1;
         if(param2.hasNormal)
         {
            this.normal = ZamUtil.readVector3Dc(param1);
            this.normal.w = 0;
         }
         if(param2.hasUv)
         {
            this.u = param1.readFloat();
            this.v = param1.readFloat();
         }
         if(param2.hasTangent)
         {
            this.tangent = ZamUtil.readVector3Dc(param1);
            this.tangent.w = 0;
         }
         if(param2.hasBitangent)
         {
            this.bitangent = ZamUtil.readVector3Dc(param1);
            this.bitangent.w = 0;
         }
         if(param2.hasColor)
         {
            this.color = param1.readUnsignedInt();
         }
      }
   }
}
