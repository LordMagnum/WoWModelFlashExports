package com.zam.lol
{
   import com.zam.MatrixUtil;
   import flash.geom.Matrix3D;
   import flash.utils.ByteArray;
   
   public class Bone
   {
       
      
      public var name:String;
      
      public var parent:int;
      
      public var index:int;
      
      public var scale:Number;
      
      public var baseMatrix:Matrix3D;
      
      public var origMatrix:Matrix3D;
      
      public var incrMatrix:Matrix3D;
      
      public var calc:Boolean;
      
      public var fixed:Boolean;
      
      protected var _mesh:LolMesh;
      
      public function Bone(param1:LolMesh, param2:int)
      {
         super();
         this._mesh = param1;
         this.index = param2;
      }
      
      public function read(param1:ByteArray, param2:uint) : void
      {
         var _loc3_:int = 0;
         this.name = param1.readUTF();
         this.name = this.name.toLowerCase();
         this.parent = param1.readInt();
         this.scale = param1.readFloat();
         var _loc4_:Vector.<Number> = new Vector.<Number>(16);
         _loc3_ = 0;
         while(_loc3_ < 16)
         {
            _loc4_[_loc3_] = param1.readFloat();
            _loc3_++;
         }
         this.origMatrix = new Matrix3D(_loc4_);
         this.origMatrix.transpose();
         this.baseMatrix = new Matrix3D(_loc4_);
         MatrixUtil.invert(this.baseMatrix);
         this.baseMatrix.transpose();
         if(param2 >= 2)
         {
            _loc3_ = 0;
            while(_loc3_ < 16)
            {
               _loc4_[_loc3_] = param1.readFloat();
               _loc3_++;
            }
            this.incrMatrix = new Matrix3D(_loc4_);
            this.incrMatrix.transpose();
         }
         this.fixed = false;
      }
   }
}
