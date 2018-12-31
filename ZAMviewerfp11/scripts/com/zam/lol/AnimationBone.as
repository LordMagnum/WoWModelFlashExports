package com.zam.lol
{
   import com.zam.MatrixUtil;
   import com.zam.Quaternion;
   import com.zam.VectorUtil;
   import flash.geom.Matrix3D;
   import flash.geom.Vector3D;
   import flash.utils.ByteArray;
   
   public class AnimationBone
   {
      
      private static var tmpMat:Matrix3D = new Matrix3D();
      
      private static var tmpVec:Vector3D = new Vector3D();
      
      private static var tmpQuat:Quaternion = new Quaternion();
       
      
      public var bone:String;
      
      public var flags:uint;
      
      public var frames:Vector.<Object>;
      
      public var idx:int;
      
      private var _mesh:LolMesh;
      
      private var _anim:Animation;
      
      private var _parent:int;
      
      private var _scale:Number;
      
      public var matrix:Matrix3D;
      
      public function AnimationBone(param1:LolMesh, param2:Animation)
      {
         super();
         this._mesh = param1;
         this._anim = param2;
         this.matrix = new Matrix3D();
      }
      
      public function calc(param1:int, param2:Animation, param3:int, param4:Number) : void
      {
         this._parent = this._mesh.bones[param1].parent;
         this._scale = this._mesh.bones[param1].scale;
         this.matrix.identity();
         if(param3 >= this.frames.length - 1)
         {
            VectorUtil.interpolate(this.frames[this.frames.length - 1].pos,this.frames[0].pos,param4,tmpVec);
            Quaternion.slerp(this.frames[this.frames.length - 1].rot,this.frames[0].rot,param4,tmpQuat);
         }
         else
         {
            VectorUtil.interpolate(this.frames[param3].pos,this.frames[param3 + 1].pos,param4,tmpVec);
            Quaternion.slerp(this.frames[param3].rot,this.frames[param3 + 1].rot,param4,tmpQuat);
         }
         MatrixUtil.prependTranslation(this.matrix,tmpVec);
         MatrixUtil.fromQuaternion(tmpMat,tmpQuat);
         MatrixUtil.multiply(this.matrix,tmpMat,this.matrix);
         this.matrix.transpose();
         if(this._parent != -1)
         {
            MatrixUtil.multiply(this.matrix,this._mesh.transforms[this._parent],this.matrix);
         }
         this.idx = param1;
         this._mesh.transforms[param1].copyFrom(this.matrix);
      }
      
      public function dump(param1:int) : void
      {
         VectorUtil.interpolate(this.frames[0].pos,this.frames[1].pos,0.5,tmpVec);
         Quaternion.slerp(this.frames[0].rot,this.frames[1].rot,0.5,tmpQuat);
      }
      
      public function read(param1:ByteArray) : void
      {
         var _loc4_:Vector3D = null;
         var _loc5_:Quaternion = null;
         var _loc2_:uint = param1.readUnsignedInt();
         this.bone = param1.readUTF();
         this.bone = this.bone.toLowerCase();
         this.flags = param1.readUnsignedInt();
         this.frames = new Vector.<Object>(_loc2_);
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new Vector3D();
            _loc4_.x = param1.readFloat();
            _loc4_.y = param1.readFloat();
            _loc4_.z = param1.readFloat();
            _loc4_.w = 1;
            _loc5_ = new Quaternion();
            _loc5_.x = param1.readFloat();
            _loc5_.y = param1.readFloat();
            _loc5_.z = param1.readFloat();
            _loc5_.w = param1.readFloat();
            this.frames[_loc3_] = {
               "pos":_loc4_,
               "rot":_loc5_
            };
            _loc3_++;
         }
      }
   }
}
