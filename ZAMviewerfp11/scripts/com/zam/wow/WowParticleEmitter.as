package com.zam.wow
{
   import com.zam.Color;
   import com.zam.MatrixUtil;
   import com.zam.Shader;
   import flash.display3D.Context3DBlendFactor;
   import flash.display3D.Context3DCompareMode;
   import flash.display3D.Context3DTriangleFace;
   import flash.display3D.IndexBuffer3D;
   import flash.display3D.VertexBuffer3D;
   import flash.display3D.textures.Texture;
   import flash.geom.Matrix3D;
   import flash.geom.Vector3D;
   import flash.utils.ByteArray;
   
   public class WowParticleEmitter extends Shader
   {
       
      
      public var id:int;
      
      public var flags:int;
      
      public var position:Vector3D;
      
      public var bone:int;
      
      public var texture:int;
      
      public var blendMode:int;
      
      public var emitterType:int;
      
      public var particleColor:int;
      
      public var particleType:int;
      
      public var tileRotation:int;
      
      public var tileRows:int;
      
      public var tileColumns:int;
      
      public var emissionSpeed:Vector.<AnimatedFloat>;
      
      public var speedVariation:Vector.<AnimatedFloat>;
      
      public var verticalRange:Vector.<AnimatedFloat>;
      
      public var horizontalRange:Vector.<AnimatedFloat>;
      
      public var gravity:Vector.<AnimatedFloat>;
      
      public var lifespan:Vector.<AnimatedFloat>;
      
      public var emissionRate:Vector.<AnimatedFloat>;
      
      public var areaLength:Vector.<AnimatedFloat>;
      
      public var areaWidth:Vector.<AnimatedFloat>;
      
      public var gravity2:Vector.<AnimatedFloat>;
      
      public var color:AnimatedSimpleVector3D;
      
      public var alpha:AnimatedSimpleUShort;
      
      public var size:AnimatedSimpleVector2D;
      
      public var intensity:AnimatedSimpleUShort;
      
      public var scale:Vector3D;
      
      public var slowdown:Number;
      
      public var rotation:Number;
      
      public var modelRotation1:Vector3D;
      
      public var modelRotation2:Vector3D;
      
      public var modelTranslation:Vector3D;
      
      public var enabled:Vector.<AnimatedUShort>;
      
      public var mesh:WowModel;
      
      public var parent:WowBone;
      
      public var particles:Vector.<Particle>;
      
      public var unusedParticles:Vector.<int>;
      
      public var textureCoords:Vector.<Array>;
      
      private var _vb:VertexBuffer3D;
      
      private var _ib:IndexBuffer3D;
      
      private var _vbData:Vector.<Number>;
      
      private var _numTriangles:int;
      
      private var _hasTexture:Boolean;
      
      private var spawnRemainder:Number;
      
      private var spreadMat:Matrix3D;
      
      private var tmpMat1:Matrix3D;
      
      private var tmpMat2:Matrix3D;
      
      private var tmpVec:Vector3D;
      
      private var tmpData:Vector.<Number>;
      
      private var tmpColors:Vector.<Color>;
      
      public const MAX_PARTICLES:int = 500;
      
      public function WowParticleEmitter(param1:WowModel)
      {
         super(param1.viewer);
         this.mesh = param1;
         this.spreadMat = new Matrix3D();
         this.tmpMat1 = new Matrix3D();
         this.tmpMat2 = new Matrix3D();
         this.tmpVec = new Vector3D();
         this.tmpData = new Vector.<Number>(16);
         this.tmpColors = Vector.<Color>([new Color(),new Color(),new Color()]);
         this._vbData = new Vector.<Number>(this.MAX_PARTICLES * 4 * 11);
         this.particles = new Vector.<Particle>(this.MAX_PARTICLES);
         this.unusedParticles = new Vector.<int>();
         var _loc2_:int = this.MAX_PARTICLES - 1;
         while(_loc2_ >= 0)
         {
            this.unusedParticles.push(_loc2_);
            _loc2_--;
         }
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
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         if(this.scale.z == 519)
         {
            this.scale.z = 1.5;
         }
         var _loc1_:int = this.tileRows * this.tileColumns;
         this.textureCoords = new Vector.<Array>(_loc1_);
         var _loc2_:Object = {
            "x":0,
            "y":0
         };
         var _loc3_:Object = {
            "x":0,
            "y":0
         };
         _loc4_ = 0;
         while(_loc4_ < _loc1_)
         {
            _loc6_ = _loc4_ % this.tileColumns;
            _loc7_ = Math.floor(_loc4_ / this.tileColumns);
            _loc2_.x = _loc6_ * (1 / this.tileColumns);
            _loc3_.x = (_loc6_ + 1) * (1 / this.tileColumns);
            _loc2_.y = _loc7_ * (1 / this.tileRows);
            _loc3_.y = (_loc7_ + 1) * (1 / this.tileRows);
            this.textureCoords[_loc4_] = [{
               "x":_loc2_.x,
               "y":_loc2_.y,
               "z":-1,
               "w":1
            },{
               "x":_loc3_.x,
               "y":_loc2_.y,
               "z":1,
               "w":1
            },{
               "x":_loc2_.x,
               "y":_loc3_.y,
               "z":-1,
               "w":-1
            },{
               "x":_loc3_.x,
               "y":_loc3_.y,
               "z":1,
               "w":-1
            }];
            _loc4_++;
         }
         upload();
      }
      
      public function update(param1:int, param2:int, param3:Number) : void
      {
         var _loc6_:Number = NaN;
         var _loc7_:int = 0;
         var _loc11_:Particle = null;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:Vector3D = null;
         var _loc21_:Color = null;
         var _loc22_:Color = null;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc26_:int = 0;
         var _loc27_:Number = NaN;
         var _loc28_:Number = NaN;
         var _loc29_:Number = NaN;
         var _loc30_:Number = NaN;
         var _loc31_:Number = NaN;
         var _loc32_:* = false;
         var _loc4_:Number = AnimatedFloat.getValueFrom(this.gravity,param1,param2);
         var _loc5_:Number = AnimatedFloat.getValueFrom(this.gravity2,param1,param2);
         if(this.emitterType == 1 || this.emitterType == 2)
         {
            _loc23_ = AnimatedFloat.getValueFrom(this.emissionRate,param1,param2);
            _loc24_ = AnimatedFloat.getValueFrom(this.lifespan,param1,param2);
            _loc25_ = 0;
            if(_loc24_ != 0)
            {
               _loc25_ = param3 * _loc23_ / _loc24_ + this.spawnRemainder;
            }
            else
            {
               _loc25_ = this.spawnRemainder;
            }
            if(_loc25_ < 1)
            {
               this.spawnRemainder = _loc25_;
               if(this.spawnRemainder < 0)
               {
                  this.spawnRemainder = 0;
               }
            }
            else
            {
               _loc26_ = Math.floor(_loc25_);
               if(_loc26_ > this.unusedParticles.length)
               {
                  _loc26_ = this.unusedParticles.length;
               }
               this.spawnRemainder = _loc25_ - _loc26_;
               _loc27_ = AnimatedFloat.getValueFrom(this.areaWidth,param1,param2) * 0.5;
               _loc28_ = AnimatedFloat.getValueFrom(this.areaLength,param1,param2) * 0.5;
               _loc6_ = AnimatedFloat.getValueFrom(this.emissionSpeed,param1,param2);
               _loc29_ = AnimatedFloat.getValueFrom(this.speedVariation,param1,param2);
               _loc30_ = AnimatedFloat.getValueFrom(this.verticalRange,param1,param2);
               _loc31_ = AnimatedFloat.getValueFrom(this.horizontalRange,param1,param2);
               _loc32_ = true;
               if(AnimatedUShort.isUsed(this.enabled,param1))
               {
                  _loc32_ = AnimatedUShort.getValueFrom(this.enabled,param1,param2) != 0;
               }
               if(_loc32_ && _loc26_ > 0)
               {
                  _loc7_ = 0;
                  while(_loc7_ < _loc26_)
                  {
                     if(this.emitterType == 1)
                     {
                        this.spawnPlaneParticle(_loc27_,_loc28_,_loc6_,_loc29_,_loc30_,_loc31_,_loc24_);
                     }
                     else if(this.emitterType == 2)
                     {
                        this.spawnSphereParticle(_loc27_,_loc28_,_loc6_,_loc29_,_loc30_,_loc31_,_loc24_);
                     }
                     _loc7_++;
                  }
               }
            }
            if(isNaN(this.spawnRemainder))
            {
               this.spawnRemainder = 0;
            }
         }
         _loc6_ = 1;
         var _loc8_:Number = _loc4_ * param3;
         var _loc9_:Number = _loc5_ * param3;
         var _loc10_:Number = _loc6_ * param3;
         _loc13_ = this.size._data[0].x;
         if(this.size._data.length > 2)
         {
            _loc14_ = this.size._data[1].x;
            _loc15_ = this.size._data[2].x;
         }
         else if(this.size._data.length > 1)
         {
            _loc14_ = this.size._data[1].x;
            _loc15_ = _loc14_;
         }
         else
         {
            _loc15_ = _loc14_ = _loc13_;
         }
         _loc13_ = _loc13_ * this.scale.x;
         _loc14_ = _loc14_ * this.scale.y;
         _loc15_ = _loc15_ * this.scale.z;
         _loc7_ = 0;
         while(_loc7_ < this.MAX_PARTICLES)
         {
            _loc11_ = this.particles[_loc7_];
            if(!(!_loc11_ || _loc11_.maxLife == 0))
            {
               _loc11_.life = _loc11_.life + param3;
               _loc12_ = _loc11_.life / _loc11_.maxLife;
               if(_loc12_ >= 1)
               {
                  _loc11_.maxLife = 0;
                  this.unusedParticles.push(_loc7_);
               }
               else
               {
                  _loc11_.speed.x = _loc11_.speed.x + (_loc11_.down.x * _loc8_ - _loc11_.direction.x * _loc9_);
                  _loc11_.speed.y = _loc11_.speed.y + (_loc11_.down.y * _loc8_ - _loc11_.direction.y * _loc9_);
                  _loc11_.speed.z = _loc11_.speed.z + (_loc11_.down.z * _loc8_ - _loc11_.direction.z * _loc9_);
                  if(this.slowdown > 0)
                  {
                     _loc6_ = Math.exp(-1 * this.slowdown * _loc11_.life);
                     _loc10_ = _loc6_ * param3;
                  }
                  _loc11_.position.x = _loc11_.position.x + _loc11_.speed.x * _loc10_;
                  _loc11_.position.y = _loc11_.position.y + _loc11_.speed.y * _loc10_;
                  _loc11_.position.z = _loc11_.position.z + _loc11_.speed.z * _loc10_;
                  if(_loc12_ <= 0.5)
                  {
                     _loc11_.size = _loc13_ + (_loc14_ - _loc13_) * (_loc12_ / 0.5);
                  }
                  else
                  {
                     _loc11_.size = _loc14_ + (_loc15_ - _loc14_) * ((_loc12_ - 0.5) / 0.5);
                  }
                  _loc19_ = Math.min(3,this.color._data.length);
                  _loc18_ = 0;
                  while(_loc18_ < _loc19_)
                  {
                     _loc20_ = this.color._data[_loc18_];
                     this.tmpColors[_loc18_].reset(_loc20_.x / 255,_loc20_.y / 255,_loc20_.z / 255,this.alpha._data[_loc18_] / 32767);
                     _loc18_++;
                  }
                  if(_loc19_ < 3)
                  {
                     _loc20_ = this.color._data[_loc19_ - 1];
                     _loc18_ = _loc19_;
                     while(_loc18_ < 3)
                     {
                        this.tmpColors[_loc18_].reset(_loc20_.x / 255,_loc20_.y / 255,_loc20_.z / 255,this.alpha._data[_loc18_] / 32767);
                        _loc18_++;
                     }
                  }
                  if(_loc12_ <= 0.5)
                  {
                     _loc21_ = this.tmpColors[0];
                     _loc22_ = this.tmpColors[1];
                     _loc16_ = _loc12_ / 0.5;
                  }
                  else
                  {
                     _loc21_ = this.tmpColors[1];
                     _loc22_ = this.tmpColors[2];
                     _loc16_ = (_loc12_ - 0.5) / 0.5;
                  }
                  _loc11_.color.r = _loc21_.r + (_loc22_.r - _loc21_.r) * _loc16_;
                  _loc11_.color.g = _loc21_.g + (_loc22_.g - _loc21_.g) * _loc16_;
                  _loc11_.color.b = _loc21_.b + (_loc22_.b - _loc21_.b) * _loc16_;
                  _loc11_.color.a = _loc21_.a + (_loc22_.a - _loc21_.a) * _loc16_;
               }
            }
            _loc7_++;
         }
         this.updateBuffers();
      }
      
      override protected function _vertexShader() : void
      {
         if((this.flags & 4096) == 0)
         {
            op("m44 vt0, va0, vc12");
            op("add vt0.xy, vt0.xy, va2.zw");
            op("m44 op, vt0, vc20");
         }
         else
         {
            op("mov vt0, va0");
            op("add vt0.xy, vt0.xy, va2.zw");
            op("m44 op, vt0, vc0");
         }
         op("mov v0, va2.xy");
         op("mov v1, va1");
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
         op("mul ft0, ft0, v1");
         if(this.blendMode == 1)
         {
            op("sub ft1.w, ft0.w, fc7.x");
            op("kil ft1.w");
         }
         op("mov oc, ft0");
      }
      
      public function render() : void
      {
         var _loc1_:Texture = null;
         var _loc2_:WowMaterial = null;
         if(this.unusedParticles.length == this.MAX_PARTICLES)
         {
            return;
         }
         if(this.texture > -1 && this.texture < this.mesh._materials.length)
         {
            _loc2_ = this.mesh._materials[this.texture];
            if(_loc2_._texture && _loc2_._texture.good)
            {
               _loc1_ = _loc2_._texture.texture;
            }
            if(_loc1_ && !this._hasTexture)
            {
               this._hasTexture = true;
               upload();
            }
            context.setTextureAt(0,_loc1_);
         }
         context.setProgram(_program);
         context.setCulling(Context3DTriangleFace.NONE);
         context.setDepthTest(false,Context3DCompareMode.LESS_EQUAL);
         switch(this.blendMode)
         {
            case 0:
            case 1:
               context.setBlendFactors(Context3DBlendFactor.ONE,Context3DBlendFactor.ZERO);
               break;
            case 2:
               context.setBlendFactors(Context3DBlendFactor.SOURCE_ALPHA,Context3DBlendFactor.ONE);
               break;
            case 3:
               context.setBlendFactors(Context3DBlendFactor.SOURCE_COLOR,Context3DBlendFactor.ONE);
               break;
            case 4:
               context.setBlendFactors(Context3DBlendFactor.SOURCE_ALPHA,Context3DBlendFactor.ONE);
               break;
            case 5:
            case 6:
               context.setBlendFactors(Context3DBlendFactor.DESTINATION_COLOR,Context3DBlendFactor.SOURCE_COLOR);
               break;
            default:
               context.setBlendFactors(Context3DBlendFactor.ONE,Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
         }
         context.setVertexBufferAt(0,this._vb,0,"float3");
         context.setVertexBufferAt(1,this._vb,3,"float4");
         context.setVertexBufferAt(2,this._vb,7,"float4");
         context.drawTriangles(this._ib,0,this._numTriangles);
      }
      
      public function updateBuffers() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Particle = null;
         var _loc5_:Array = null;
         var _loc6_:Number = NaN;
         var _loc7_:Vector.<uint> = null;
         var _loc8_:int = 0;
         if(!this._ib)
         {
            this._ib = context.createIndexBuffer(this.MAX_PARTICLES * 6);
            _loc7_ = new Vector.<uint>();
            _loc8_ = 0;
            _loc1_ = 0;
            while(_loc1_ < this.MAX_PARTICLES)
            {
               _loc7_.push(_loc8_);
               _loc7_.push(_loc8_ + 1);
               _loc7_.push(_loc8_ + 2);
               _loc7_.push(_loc8_ + 2);
               _loc7_.push(_loc8_ + 1);
               _loc7_.push(_loc8_ + 3);
               _loc8_ = _loc8_ + 4;
               _loc1_++;
            }
            this._ib.uploadFromVector(_loc7_,0,_loc7_.length);
         }
         if(!this._vb)
         {
            this._vb = context.createVertexBuffer(this.MAX_PARTICLES * 4,11);
         }
         this._numTriangles = 0;
         if(this.particleType == 0 || this.particleType == 2)
         {
            _loc1_ = 0;
            while(_loc1_ < this.MAX_PARTICLES)
            {
               _loc4_ = this.particles[_loc1_];
               if(!(!_loc4_ || _loc4_.maxLife == 0))
               {
                  _loc6_ = _loc4_.size;
                  _loc5_ = this.textureCoords[_loc4_.tile];
                  _loc2_ = 0;
                  while(_loc2_ < 4)
                  {
                     this._vbData[_loc3_] = _loc4_.position.x;
                     this._vbData[_loc3_ + 1] = _loc4_.position.y;
                     this._vbData[_loc3_ + 2] = _loc4_.position.z;
                     this._vbData[_loc3_ + 3] = _loc4_.color.r;
                     this._vbData[_loc3_ + 4] = _loc4_.color.g;
                     this._vbData[_loc3_ + 5] = _loc4_.color.b;
                     this._vbData[_loc3_ + 6] = _loc4_.color.a;
                     this._vbData[_loc3_ + 7] = _loc5_[_loc2_].x;
                     this._vbData[_loc3_ + 8] = _loc5_[_loc2_].y;
                     this._vbData[_loc3_ + 9] = _loc5_[_loc2_].z * _loc6_;
                     this._vbData[_loc3_ + 10] = _loc5_[_loc2_].w * _loc6_;
                     _loc3_ = _loc3_ + 11;
                     _loc2_++;
                  }
                  this._numTriangles = this._numTriangles + 2;
               }
               _loc1_++;
            }
         }
         else
         {
            _loc1_ = 0;
            while(_loc1_ < this.MAX_PARTICLES)
            {
               _loc4_ = this.particles[_loc1_];
               if(!(!_loc4_ || _loc4_.maxLife == 0))
               {
                  _loc6_ = _loc4_.size;
                  _loc5_ = this.textureCoords[_loc4_.tile];
                  this._vbData[_loc3_] = _loc4_.position.x;
                  this._vbData[_loc3_ + 1] = _loc4_.position.y;
                  this._vbData[_loc3_ + 2] = _loc4_.position.z;
                  this._vbData[_loc3_ + 11] = _loc4_.position.x;
                  this._vbData[_loc3_ + 12] = _loc4_.position.y;
                  this._vbData[_loc3_ + 13] = _loc4_.position.z;
                  this._vbData[_loc3_ + 22] = _loc4_.origin.x;
                  this._vbData[_loc3_ + 23] = _loc4_.origin.y;
                  this._vbData[_loc3_ + 24] = _loc4_.origin.z;
                  this._vbData[_loc3_ + 33] = _loc4_.origin.x;
                  this._vbData[_loc3_ + 34] = _loc4_.origin.y;
                  this._vbData[_loc3_ + 35] = _loc4_.origin.z;
                  _loc2_ = 0;
                  while(_loc2_ < 4)
                  {
                     this._vbData[_loc3_ + 3] = _loc4_.color.r;
                     this._vbData[_loc3_ + 4] = _loc4_.color.g;
                     this._vbData[_loc3_ + 5] = _loc4_.color.b;
                     this._vbData[_loc3_ + 6] = _loc4_.color.a;
                     this._vbData[_loc3_ + 7] = _loc5_[_loc2_].x;
                     this._vbData[_loc3_ + 8] = _loc5_[_loc2_].y;
                     this._vbData[_loc3_ + 9] = _loc5_[_loc2_].z * _loc6_;
                     this._vbData[_loc3_ + 10] = _loc5_[_loc2_].w * _loc6_;
                     _loc3_ = _loc3_ + 11;
                     _loc2_++;
                  }
                  this._numTriangles = this._numTriangles + 2;
               }
               _loc1_++;
            }
         }
         this._vb.uploadFromVector(this._vbData,0,this.MAX_PARTICLES * 4);
      }
      
      public function read(param1:ByteArray) : void
      {
         this.id = param1.readInt();
         this.flags = param1.readInt();
         this.position = WowUtil.readVector3D(param1);
         this.bone = param1.readShort();
         this.texture = param1.readShort();
         this.blendMode = param1.readByte();
         this.emitterType = param1.readByte();
         this.particleColor = param1.readShort();
         this.particleType = param1.readByte();
         param1.position = param1.position + 1;
         this.tileRotation = param1.readShort();
         this.tileRows = param1.readShort();
         this.tileColumns = param1.readShort();
         this.emissionSpeed = WowUtil.readAnimatedFloatSet(param1);
         this.speedVariation = WowUtil.readAnimatedFloatSet(param1);
         this.verticalRange = WowUtil.readAnimatedFloatSet(param1);
         this.horizontalRange = WowUtil.readAnimatedFloatSet(param1);
         this.gravity = WowUtil.readAnimatedFloatSet(param1);
         this.lifespan = WowUtil.readAnimatedFloatSet(param1);
         this.emissionRate = WowUtil.readAnimatedFloatSet(param1);
         this.areaLength = WowUtil.readAnimatedFloatSet(param1);
         this.areaWidth = WowUtil.readAnimatedFloatSet(param1);
         this.gravity2 = WowUtil.readAnimatedFloatSet(param1);
         this.color = new AnimatedSimpleVector3D();
         this.color.read(param1,false);
         this.alpha = new AnimatedSimpleUShort();
         this.alpha.read(param1);
         this.size = new AnimatedSimpleVector2D();
         this.size.read(param1);
         this.intensity = new AnimatedSimpleUShort();
         this.intensity.read(param1);
         this.scale = WowUtil.readVector3D(param1,false);
         this.slowdown = param1.readFloat();
         this.rotation = param1.readFloat();
         this.modelRotation1 = WowUtil.readVector3D(param1);
         this.modelRotation2 = WowUtil.readVector3D(param1);
         this.modelTranslation = WowUtil.readVector3D(param1);
         this.enabled = WowUtil.readAnimatedUShortSet(param1);
         this.parent = this.mesh._bones[this.bone];
         this.init();
      }
      
      public function getNextParticle() : Particle
      {
         if(this.unusedParticles.length == 0)
         {
            return null;
         }
         var _loc1_:int = this.unusedParticles.pop();
         if(!this.particles[_loc1_])
         {
            this.particles[_loc1_] = new Particle();
         }
         return this.particles[_loc1_];
      }
      
      public function spawnPlaneParticle(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number) : Particle
      {
         var _loc8_:Particle = this.getNextParticle();
         this.tmpMat1.copyFrom(this.parent._rotMatrix);
         this.calcSpread(param5,param5,1,1);
         this.tmpMat1.prepend(this.spreadMat);
         _loc8_.position.copyFrom(this.position);
         _loc8_.position.x = _loc8_.position.x + (Math.random() * param2 * 2 - param2);
         _loc8_.position.z = _loc8_.position.z + (Math.random() * param1 * 2 - param1);
         MatrixUtil.transformSelf(this.parent._matrix,_loc8_.position);
         _loc8_.direction.setTo(0,1,0);
         MatrixUtil.transformSelf(this.parent._rotMatrix,_loc8_.direction);
         _loc8_.direction.normalize();
         _loc8_.speed.copyFrom(_loc8_.direction);
         _loc8_.speed.scaleBy(param3 * (Math.random() * param4 * 2 - param4));
         _loc8_.down.setTo(0,-1,0);
         _loc8_.life = 0;
         _loc8_.maxLife = param7;
         if(_loc8_.maxLife == 0)
         {
            _loc8_.maxLife = 1;
         }
         _loc8_.origin.copyFrom(_loc8_.position);
         _loc8_.tile = Math.floor(Math.random() * this.tileRows * this.tileColumns);
         _loc8_.color.reset(1,1,1,1);
         return _loc8_;
      }
      
      public function spawnSphereParticle(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number) : Particle
      {
         var _loc8_:Particle = this.getNextParticle();
         var _loc9_:Number = Math.random();
         var _loc10_:Number = 0;
         if(param5 == 0)
         {
            _loc10_ = Math.random() * Math.PI * 2 - Math.PI;
         }
         else
         {
            _loc10_ = Math.random() * param5 * 2 - param5;
         }
         this.tmpMat1.copyFrom(this.parent._rotMatrix);
         this.calcSpread(param5 * 2,param5 * 2,param1,param2);
         this.tmpMat1.prepend(this.spreadMat);
         if((this.flags & 57) == 57 || (this.flags & 313) == 313)
         {
            _loc8_.position.copyFrom(this.position);
            _loc8_.direction.setTo(param1 * Math.cos(_loc10_) * 1.6,0,param2 * Math.sin(_loc10_) * 1.6);
            _loc8_.position.x = _loc8_.position.x + _loc8_.direction.x;
            _loc8_.position.z = _loc8_.position.z + _loc8_.direction.z;
            MatrixUtil.transformSelf(this.parent._matrix,_loc8_.position);
            if(_loc8_.direction.lengthSquared == 0)
            {
               _loc8_.speed.setTo(0,0,0);
            }
            else
            {
               MatrixUtil.transformSelf(this.parent._rotMatrix,_loc8_.direction);
               _loc8_.direction.normalize();
               _loc8_.speed.copyFrom(_loc8_.direction);
               _loc8_.speed.scaleBy(param3 * (1 + Math.random() * param4 * 2 - param4));
            }
         }
         else
         {
            _loc8_.direction.setTo(0,1,0);
            MatrixUtil.transformSelf(this.tmpMat1,_loc8_.direction);
            _loc8_.direction.scaleBy(_loc9_);
            _loc8_.position.copyFrom(this.position);
            _loc8_.position.incrementBy(_loc8_.direction);
            MatrixUtil.transformSelf(this.parent._matrix,_loc8_.position);
            if(_loc8_.direction.lengthSquared == 0 && (this.flags & 256) == 0)
            {
               _loc8_.speed.setTo(0,0,0);
               _loc8_.direction.setTo(0,1,0);
               MatrixUtil.transformSelf(this.parent._rotMatrix,_loc8_.direction);
               _loc8_.direction.normalize();
            }
            else
            {
               if((this.flags & 256) > 0)
               {
                  _loc8_.direction.setTo(0,1,0);
                  MatrixUtil.transformSelf(this.parent._rotMatrix,_loc8_.direction);
               }
               _loc8_.direction.normalize();
               _loc8_.speed.copyFrom(_loc8_.direction);
               _loc8_.speed.scaleBy(param3 * (1 + (Math.random() * param4 * 2 - param4)));
            }
         }
         _loc8_.down.setTo(0,-1,0);
         _loc8_.life = 0;
         _loc8_.maxLife = param7;
         if(_loc8_.maxLife == 0)
         {
            _loc8_.maxLife = 1;
         }
         _loc8_.origin.copyFrom(_loc8_.position);
         _loc8_.tile = Math.floor(Math.random() * this.tileRows * this.tileColumns);
         _loc8_.color.reset(1,1,1,1);
         return _loc8_;
      }
      
      public function calcSpread(param1:Number, param2:Number, param3:Number, param4:Number) : Matrix3D
      {
         var _loc5_:Number = (Math.random() * (param1 * 2) - param1) / 2;
         var _loc6_:Number = (Math.random() * (param2 * 2) - param2) / 2;
         var _loc7_:Number = Math.cos(_loc5_);
         var _loc8_:Number = Math.cos(_loc6_);
         var _loc9_:Number = Math.sin(_loc5_);
         var _loc10_:Number = Math.sin(_loc6_);
         this.spreadMat.identity();
         this.tmpData[0] = this.tmpData[5] = this.tmpData[10] = this.tmpData[15] = 1;
         this.tmpData[1] = this.tmpData[2] = this.tmpData[3] = this.tmpData[4] = this.tmpData[6] = this.tmpData[7] = this.tmpData[8] = this.tmpData[9] = this.tmpData[11] = this.tmpData[12] = this.tmpData[13] = this.tmpData[14] = 0;
         this.tmpData[5] = this.tmpData[10] = _loc7_;
         this.tmpData[9] = _loc9_;
         this.tmpData[6] = -_loc9_;
         this.tmpMat2.copyRawDataFrom(this.tmpData);
         this.spreadMat.prepend(this.tmpMat2);
         this.tmpData[0] = this.tmpData[5] = this.tmpData[10] = this.tmpData[15] = 1;
         this.tmpData[1] = this.tmpData[2] = this.tmpData[3] = this.tmpData[4] = this.tmpData[6] = this.tmpData[7] = this.tmpData[8] = this.tmpData[9] = this.tmpData[11] = this.tmpData[12] = this.tmpData[13] = this.tmpData[14] = 0;
         this.tmpData[0] = this.tmpData[5] = _loc8_;
         this.tmpData[4] = _loc10_;
         this.tmpData[1] = -_loc10_;
         this.tmpMat2.copyRawDataFrom(this.tmpData);
         this.spreadMat.prepend(this.tmpMat2);
         var _loc11_:Number = Math.abs(_loc7_) * param4 * Math.abs(_loc9_) * param3;
         this.spreadMat.copyRawDataTo(this.tmpData);
         this.tmpData[0] = this.tmpData[0] * _loc11_;
         this.tmpData[1] = this.tmpData[1] * _loc11_;
         this.tmpData[2] = this.tmpData[2] * _loc11_;
         this.tmpData[4] = this.tmpData[4] * _loc11_;
         this.tmpData[5] = this.tmpData[5] * _loc11_;
         this.tmpData[6] = this.tmpData[6] * _loc11_;
         this.tmpData[8] = this.tmpData[8] * _loc11_;
         this.tmpData[9] = this.tmpData[9] * _loc11_;
         this.tmpData[10] = this.tmpData[10] * _loc11_;
         this.spreadMat.copyRawDataFrom(this.tmpData);
         return this.spreadMat;
      }
   }
}

import com.zam.Color;
import flash.geom.Vector3D;

class Particle
{
    
   
   public var position:Vector3D;
   
   public var origin:Vector3D;
   
   public var speed:Vector3D;
   
   public var direction:Vector3D;
   
   public var down:Vector3D;
   
   public var color:Color;
   
   public var size:Number;
   
   public var life:Number;
   
   public var maxLife:Number;
   
   public var tile:int;
   
   function Particle()
   {
      super();
      this.position = new Vector3D(0,0,0,1);
      this.origin = new Vector3D(0,0,0,1);
      this.speed = new Vector3D(0,0,0,0);
      this.direction = new Vector3D(0,0,0,0);
      this.down = new Vector3D(0,0,0,0);
      this.color = new Color(1,1,1,1);
   }
}
