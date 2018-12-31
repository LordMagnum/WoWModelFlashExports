package com.zam.wow
{
   import com.zam.MatrixUtil;
   import com.zam.Quaternion;
   import flash.geom.Matrix3D;
   import flash.geom.Vector3D;
   import flash.utils.ByteArray;
   
   public class WowBone
   {
       
      
      public var _parent:int;
      
      public var _index:int;
      
      public var _flags:int;
      
      public var _pivot:Vector3D;
      
      public var _transformedPivot:Vector3D;
      
      public var _matrix:Matrix3D;
      
      public var _rotMatrix:Matrix3D;
      
      public var _rot:Matrix3D;
      
      public var _calc:Boolean;
      
      protected var _hasRot:Boolean;
      
      protected var _mesh:WowModel;
      
      private var m:Matrix3D;
      
      private var tmpVec:Vector3D;
      
      private var tmpMat:Matrix3D;
      
      private var tmpQuat:Quaternion;
      
      public function WowBone(param1:WowModel, param2:int)
      {
         super();
         this._parent = -1;
         this._mesh = param1;
         this._index = param2;
         this._matrix = new Matrix3D();
         this._rotMatrix = new Matrix3D();
         this._rot = new Matrix3D();
         this.m = new Matrix3D();
         this.tmpVec = new Vector3D();
         this.tmpMat = new Matrix3D();
         this.tmpQuat = new Quaternion();
      }
      
      public function calcMatrix(param1:int) : void
      {
         if(this._calc)
         {
            return;
         }
         this._calc = true;
         if(this._mesh == null || this._mesh.animations == null)
         {
            return;
         }
         this.m.identity();
         this.tmpMat.identity();
         this._hasRot = false;
         var _loc2_:WowAnimation = this._mesh.currentAnimation;
         if(_loc2_._translation.length == 0 || _loc2_._rotation.length == 0 || _loc2_._scale.length == 0)
         {
            this._matrix.identity();
            this._rotMatrix.identity();
            return;
         }
         var _loc3_:* = (this._flags & 8) > 0;
         var _loc4_:Boolean = _loc2_._translation[this._index]._used || _loc2_._rotation[this._index]._used || _loc2_._scale[this._index]._used || _loc3_;
         if(_loc4_)
         {
            this.m.prependTranslation(this._pivot.x,this._pivot.y,this._pivot.z);
            if(_loc2_._translation[this._index]._used)
            {
               this.tmpVec.setTo(0,0,0);
               _loc2_._translation[this._index].getValue(param1,this.tmpVec);
               this.m.prependTranslation(this.tmpVec.x,this.tmpVec.y,this.tmpVec.z);
            }
            if(_loc2_._rotation[this._index]._used)
            {
               this.tmpQuat.setTo();
               _loc2_._rotation[this._index].getValue(param1,this.tmpQuat);
               this.tmpQuat.toMatrix(this._rot);
               this._rot.transpose();
               this.m.prepend(this._rot);
               this._hasRot = true;
            }
            if(_loc2_._scale[this._index]._used)
            {
               this.tmpVec.setTo(1,1,1);
               _loc2_._scale[this._index].getValue(param1,this.tmpVec);
               if(this.tmpVec.x > 10 || Math.abs(this.tmpVec.x) < 1.0e-6)
               {
                  this.tmpVec.x = 1;
               }
               if(this.tmpVec.y > 10 || Math.abs(this.tmpVec.y) < 1.0e-6)
               {
                  this.tmpVec.y = 1;
               }
               if(this.tmpVec.z > 10 || Math.abs(this.tmpVec.z) < 1.0e-6)
               {
                  this.tmpVec.z = 1;
               }
               this.m.prependScale(this.tmpVec.x,this.tmpVec.y,this.tmpVec.z);
            }
            if(false && _loc3_)
            {
               this.tmpMat.copyFrom(this._mesh.modelMatrix);
               this.tmpMat.append(this._mesh.camera.viewMatrix);
               this.m.rawData[2] = -this.tmpMat.rawData[0];
               this.m.rawData[6] = -this.tmpMat.rawData[4];
               this.m.rawData[10] = -this.tmpMat.rawData[8];
               this.m.rawData[1] = this.tmpMat.rawData[1];
               this.m.rawData[5] = this.tmpMat.rawData[5];
               this.m.rawData[9] = this.tmpMat.rawData[9];
            }
            this.m.prependTranslation(-this._pivot.x,-this._pivot.y,-this._pivot.z);
         }
         else
         {
            this._hasRot = false;
         }
         this._matrix = this.m;
         if(this._parent > -1)
         {
            this._mesh.bones[this._parent].calcMatrix(param1);
            this._matrix.append(this._mesh.bones[this._parent]._matrix);
         }
         if(this._hasRot)
         {
            this._rotMatrix.copyFrom(this._rot);
            if(this._parent > -1)
            {
               this._rotMatrix.append(this._mesh.bones[this._parent]._rotMatrix);
            }
         }
         else
         {
            this._rotMatrix.identity();
         }
         MatrixUtil.transform(this._matrix,this._pivot,this._transformedPivot);
      }
      
      public function read(param1:ByteArray) : void
      {
         this._parent = param1.readInt();
         this._pivot = WowUtil.readVector3D(param1);
         this._pivot.w = 1;
         this._transformedPivot = this._pivot.clone();
         this._flags = param1.readInt();
         var _loc2_:Vector.<Number> = new Vector.<Number>(16);
         var _loc3_:int = 0;
         while(_loc3_ < 16)
         {
            _loc2_[_loc3_] = param1.readFloat();
            _loc3_++;
         }
         var _loc4_:Matrix3D = new Matrix3D();
         _loc4_.rawData = _loc2_;
      }
   }
}
