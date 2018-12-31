package com.zam.wow
{
   import com.zam.Color;
   import com.zam.MatrixUtil;
   import com.zam.Shader;
   import com.zam.VectorUtil;
   import flash.display3D.Context3DBlendFactor;
   import flash.display3D.Context3DCompareMode;
   import flash.display3D.Context3DTriangleFace;
   import flash.display3D.IndexBuffer3D;
   import flash.display3D.VertexBuffer3D;
   import flash.display3D.textures.Texture;
   import flash.geom.Vector3D;
   import flash.utils.ByteArray;
   
   public class WowRibbonEmitter extends Shader
   {
       
      
      public var id:int;
      
      public var bone:int;
      
      public var position:Vector3D;
      
      public var textures:Vector.<int>;
      
      public var color:Vector.<AnimatedVector3D>;
      
      public var alpha:Vector.<AnimatedUShort>;
      
      public var above:Vector.<AnimatedFloat>;
      
      public var below:Vector.<AnimatedFloat>;
      
      public var resolution:Number;
      
      public var length:Number;
      
      public var totalLength:Number;
      
      public var emissionAngle:Number;
      
      public var s1:int;
      
      public var s2:int;
      
      public var mesh:WowModel;
      
      public var parent:WowBone;
      
      public var material:WowMaterial;
      
      public var segments:Vector.<RibbonSegment>;
      
      public var currentPosition:Vector3D;
      
      public var currentColor:Color;
      
      public var currentAbove:Number;
      
      public var currentBelow:Number;
      
      public var currentLength:Number;
      
      private var tmpPosition:Vector3D;
      
      private var tmpUp:Vector3D;
      
      private var tmpVec:Vector3D;
      
      private var _hasTexture:Boolean;
      
      private var _ib:IndexBuffer3D;
      
      private var _vb:VertexBuffer3D;
      
      private var _vbData:Vector.<Number>;
      
      private var _colorVector:Vector.<Number>;
      
      public const MAX_SEGMENTS:int = 50;
      
      public var currentSegment:int;
      
      public var numSegments:int;
      
      public function WowRibbonEmitter(param1:WowModel)
      {
         super(param1.viewer);
         this.mesh = param1;
      }
      
      public function refresh() : void
      {
         if(this._vb)
         {
            this._vb.dispose();
            this._vb = null;
         }
         if(this._ib)
         {
            this._ib.dispose();
            this._ib = null;
         }
         upload();
      }
      
      public function init() : void
      {
         this.segments = new Vector.<RibbonSegment>(this.MAX_SEGMENTS);
         var _loc1_:int = 0;
         while(_loc1_ < this.MAX_SEGMENTS)
         {
            this.segments[_loc1_] = new RibbonSegment();
            _loc1_++;
         }
         this.currentPosition = this.position.clone();
         this.currentColor = new Color();
         this.tmpPosition = new Vector3D(0,0,0,1);
         this.tmpUp = new Vector3D(0,1,0,0);
         this.tmpVec = new Vector3D();
         this._vbData = new Vector.<Number>((this.MAX_SEGMENTS * 2 + 2) * 5);
         this._colorVector = Vector.<Number>([1,1,1,1]);
         if(this.textures)
         {
            this.material = this.mesh._materials[this.textures[0]];
         }
         if(this.bone > -1)
         {
            this.parent = this.mesh._bones[this.bone];
         }
         this.totalLength = this.resolution / this.length;
         upload();
      }
      
      public function update(param1:int, param2:int, param3:Number) : void
      {
         var _loc4_:RibbonSegment = null;
         var _loc5_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Number = NaN;
         MatrixUtil.transform(this.parent._matrix,this.position,this.tmpPosition);
         this.tmpUp.setTo(0,1,0);
         MatrixUtil.transformSelf(this.parent._rotMatrix,this.tmpUp);
         this.tmpUp.normalize();
         if(this.numSegments == 0)
         {
            _loc4_ = this.pushSegment();
            _loc4_.start.copyFrom(this.tmpPosition);
            _loc4_.position.copyFrom(this.tmpPosition);
            _loc4_.up.copyFrom(this.tmpUp);
            _loc4_.length = 0;
         }
         else
         {
            _loc8_ = (this.currentSegment + this.numSegments - 1) % this.MAX_SEGMENTS;
            _loc4_ = this.segments[_loc8_];
            _loc4_.position.copyFrom(this.tmpPosition);
            _loc4_.up.copyFrom(this.tmpUp);
            VectorUtil.subtract(_loc4_.position,this.currentPosition,this.tmpVec);
            _loc9_ = this.tmpVec.length;
            _loc4_.length = _loc4_.length + _loc9_;
            if(_loc4_.length >= this.length)
            {
               _loc4_ = this.pushSegment();
               _loc4_.start.copyFrom(this.tmpPosition);
               _loc4_.position.copyFrom(this.tmpPosition);
               _loc4_.up.copyFrom(this.tmpUp);
               _loc4_.length = 0;
            }
         }
         this.currentLength = 0;
         var _loc6_:int = 0;
         while(_loc6_ < this.numSegments)
         {
            _loc5_ = (this.currentSegment + _loc6_) % this.MAX_SEGMENTS;
            this.currentLength = this.currentLength + this.segments[_loc5_].length;
            _loc6_++;
         }
         if(this.currentLength > this.totalLength + 0.1)
         {
            this.currentLength = this.currentLength - this.segments[this.currentSegment].length;
            this.shiftSegment();
         }
         this.currentPosition.copyFrom(this.tmpPosition);
         AnimatedVector3D.getValueFrom(this.color,param1,param2,this.tmpVec);
         var _loc7_:Number = AnimatedUShort.getValueFrom(this.alpha,param1,param2) / 32767;
         this.currentColor.reset(this.tmpVec.x,this.tmpVec.y,this.tmpVec.z,_loc7_);
         this.currentAbove = AnimatedFloat.getValueFrom(this.above,param1,param2);
         this.currentBelow = AnimatedFloat.getValueFrom(this.below,param1,param2);
         this.updateBuffers();
      }
      
      override protected function _vertexShader() : void
      {
         op("m44 op, va0, vc0");
         op("mov v0, va1.xy");
      }
      
      override protected function _fragmentShader() : void
      {
         if(this._hasTexture)
         {
            op("tex ft0, v0.xy, fs0 <2d, linear, mip, repeat>");
         }
         else
         {
            op("mov ft0.xy, v0.xy");
            op("mov ft0.zw, fc0.xy");
         }
         op("mul oc, ft0, fc16");
      }
      
      public function render() : void
      {
         var _loc1_:Texture = null;
         if(this.numSegments == 0)
         {
            return;
         }
         if(this.material && this.material._texture.good)
         {
            if(!this._hasTexture)
            {
               this._hasTexture = true;
               upload();
            }
            _loc1_ = this.material._texture.texture;
         }
         context.setTextureAt(0,_loc1_);
         context.setProgram(_program);
         context.setCulling(Context3DTriangleFace.NONE);
         context.setDepthTest(false,Context3DCompareMode.LESS_EQUAL);
         context.setBlendFactors(Context3DBlendFactor.SOURCE_ALPHA,Context3DBlendFactor.ONE);
         this._colorVector[0] = this.currentColor.r;
         this._colorVector[1] = this.currentColor.g;
         this._colorVector[2] = this.currentColor.b;
         this._colorVector[3] = this.currentColor.a;
         context.setProgramConstantsFromVector("fragment",16,this._colorVector);
         context.setVertexBufferAt(0,this._vb,0,"float3");
         context.setVertexBufferAt(1,this._vb,3,"float2");
         context.setVertexBufferAt(2,null);
         context.drawTriangles(this._ib,0,this.numSegments * 2);
      }
      
      public function updateBuffers() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc8_:Vector.<uint> = null;
         var _loc9_:int = 0;
         if(!this._ib)
         {
            this._ib = context.createIndexBuffer(this.MAX_SEGMENTS * 6);
            _loc8_ = new Vector.<uint>();
            _loc9_ = 0;
            _loc1_ = 0;
            while(_loc1_ < this.MAX_SEGMENTS)
            {
               _loc8_.push(_loc9_);
               _loc8_.push(_loc9_ + 1);
               _loc8_.push(_loc9_ + 2);
               _loc8_.push(_loc9_ + 2);
               _loc8_.push(_loc9_ + 1);
               _loc8_.push(_loc9_ + 3);
               _loc9_ = _loc9_ + 2;
               _loc1_++;
            }
            this._ib.uploadFromVector(_loc8_,0,_loc8_.length);
         }
         if(!this._vb)
         {
            this._vb = context.createVertexBuffer(this.MAX_SEGMENTS * 2 + 2,5);
         }
         var _loc3_:RibbonSegment = this.segments[this.currentSegment];
         var _loc7_:Number = 0;
         this._vbData[_loc4_] = _loc3_.start.x + _loc3_.up.x * this.currentAbove;
         this._vbData[_loc4_ + 1] = _loc3_.start.y + _loc3_.up.y * this.currentAbove;
         this._vbData[_loc4_ + 2] = _loc3_.start.z + _loc3_.up.z * this.currentAbove;
         this._vbData[_loc4_ + 3] = 1;
         this._vbData[_loc4_ + 4] = 0;
         _loc4_ = _loc4_ + 5;
         this._vbData[_loc4_] = _loc3_.start.x - _loc3_.up.x * this.currentBelow;
         this._vbData[_loc4_ + 1] = _loc3_.start.y - _loc3_.up.y * this.currentBelow;
         this._vbData[_loc4_ + 2] = _loc3_.start.z - _loc3_.up.z * this.currentBelow;
         this._vbData[_loc4_ + 3] = 1;
         this._vbData[_loc4_ + 4] = 1;
         _loc4_ = _loc4_ + 5;
         _loc1_ = 0;
         while(_loc1_ < this.numSegments)
         {
            _loc3_ = this.segments[(this.currentSegment + _loc1_) % this.MAX_SEGMENTS];
            _loc5_ = 1 - (this.currentLength != 0?_loc7_ / this.currentLength:0);
            _loc6_ = 1 - (this.currentLength != 0?(_loc7_ + _loc3_.length) / this.currentLength:1);
            this._vbData[_loc4_] = _loc3_.position.x + _loc3_.up.x * this.currentAbove;
            this._vbData[_loc4_ + 1] = _loc3_.position.y + _loc3_.up.y * this.currentAbove;
            this._vbData[_loc4_ + 2] = _loc3_.position.z + _loc3_.up.z * this.currentAbove;
            this._vbData[_loc4_ + 3] = _loc6_;
            this._vbData[_loc4_ + 4] = 0;
            _loc4_ = _loc4_ + 5;
            this._vbData[_loc4_] = _loc3_.position.x - _loc3_.up.x * this.currentBelow;
            this._vbData[_loc4_ + 1] = _loc3_.position.y - _loc3_.up.y * this.currentBelow;
            this._vbData[_loc4_ + 2] = _loc3_.position.z - _loc3_.up.z * this.currentBelow;
            this._vbData[_loc4_ + 3] = _loc6_;
            this._vbData[_loc4_ + 4] = 1;
            _loc4_ = _loc4_ + 5;
            _loc7_ = _loc7_ + _loc3_.length;
            _loc1_++;
         }
         this._vb.uploadFromVector(this._vbData,0,this.MAX_SEGMENTS * 2 + 2);
      }
      
      public function pushSegment() : RibbonSegment
      {
         if(this.numSegments < this.MAX_SEGMENTS)
         {
            this.numSegments++;
         }
         else
         {
            this.currentSegment = (this.currentSegment + 1) % this.MAX_SEGMENTS;
         }
         return this.segments[this.currentSegment];
      }
      
      public function popSegment() : void
      {
         this.numSegments--;
      }
      
      public function shiftSegment() : void
      {
         this.currentSegment = (this.currentSegment + 1) % this.MAX_SEGMENTS;
         this.numSegments--;
      }
      
      public function read(param1:ByteArray) : void
      {
         var _loc3_:int = 0;
         this.id = param1.readInt();
         this.bone = param1.readInt();
         this.position = WowUtil.readVector3D(param1);
         this.position.w = 1;
         var _loc2_:int = param1.readInt();
         if(_loc2_ > 0)
         {
            this.textures = new Vector.<int>(_loc2_);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               this.textures[_loc3_] = param1.readInt();
               _loc3_++;
            }
         }
         this.color = WowUtil.readAnimatedVector3DSet(param1,false);
         this.alpha = WowUtil.readAnimatedUShortSet(param1);
         this.above = WowUtil.readAnimatedFloatSet(param1);
         this.below = WowUtil.readAnimatedFloatSet(param1);
         this.resolution = param1.readFloat();
         this.length = param1.readFloat();
         this.emissionAngle = param1.readFloat();
         this.s1 = param1.readShort();
         this.s2 = param1.readShort();
         this.init();
      }
   }
}

import flash.geom.Vector3D;

class RibbonSegment
{
    
   
   public var position:Vector3D;
   
   public var start:Vector3D;
   
   public var up:Vector3D;
   
   public var length:Number;
   
   function RibbonSegment()
   {
      super();
      this.position = new Vector3D(0,0,0,1);
      this.start = new Vector3D(0,0,0,1);
      this.up = new Vector3D(0,0,0,0);
      this.length = 0;
   }
}
