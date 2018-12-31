package com.zam.gw2
{
   import com.zam.Shader;
   import com.zam.ZamUtil;
   import flash.display3D.Context3DBlendFactor;
   import flash.display3D.IndexBuffer3D;
   import flash.display3D.VertexBuffer3D;
   import flash.geom.Vector3D;
   import flash.utils.ByteArray;
   
   public class Gw2Mesh extends Shader
   {
      
      private static const AlphaBlendMats:Object = {
         "GlowShader":1,
         "ElectricModel":1
      };
      
      private static const AlphaTestMats:Object = {
         "hair":1,
         "Wagon4Ration10":1,
         "bodyTEX":1,
         "snakeTEX":1,
         "snakeChestTEX3":1,
         "Alpha":1,
         "AmatShader1":1,
         "AmatShader2":1,
         "AmatShader3":1,
         "AmatShader4":1,
         "AmatShader6":1,
         "AmatShader7":1,
         "AmatShader21":1,
         "Harp":1,
         "ShieldMain":1,
         "Rifle":1,
         "RifleQ":1,
         "ArmorLoadAlpha":1,
         "membrane":1
      };
      
      private static const ColorBlendedMats:Object = {
         "StationaryString":1,
         "AmatShader8":1,
         "AmatShader55":1,
         "CrystalGlowShader":1,
         "CrystalGlowShader1":1,
         "InnardsShader1":1
      };
      
      private static const FullbrightMats:Object = {
         "AmatShader8":1,
         "GlowShader":1,
         "CrystalGlowShader":1,
         "CrystalGlowShader1":1,
         "InnardsShader1":1
      };
      
      private static const HiddenMats:Object = {
         "Rebuild1":1,
         "Rebuild:Rebuild1":1,
         "lambert1":1,
         "DecalFootprints":1,
         "test":1,
         "Mask":1,
         "Distortion":1,
         "FlamesActive":1,
         "Active1":1,
         "thinWater":1,
         "clearWater":1
      };
      
      private static const DelayedMats:Object = {
         "AmatShader55":1,
         "CrystalGlowShader":1,
         "CrystalGlowShader1":1,
         "InnardsShader1":1
      };
       
      
      public var _vertices:Vector.<Vertex>;
      
      public var _indices:Vector.<uint>;
      
      public var _matName:String;
      
      public var _matIndex:uint;
      
      public var _minBounds:Vector3D;
      
      public var _maxBounds:Vector3D;
      
      public var _show:Boolean;
      
      public var _delay:Boolean;
      
      public var hasNormal:Boolean;
      
      public var hasUv:Boolean;
      
      public var hasTangent:Boolean;
      
      public var hasBitangent:Boolean;
      
      public var hasColor:Boolean;
      
      protected var _model:Gw2Model;
      
      protected var _matSet:MaterialSet;
      
      protected var _diffuseReady:Boolean;
      
      protected var _lightmapReady:Boolean;
      
      protected var _normalReady:Boolean;
      
      protected var _vbData:Vector.<Number>;
      
      protected var _vb:VertexBuffer3D;
      
      protected var _ib:IndexBuffer3D;
      
      private var tmpVec:Vector3D;
      
      public function Gw2Mesh(param1:Gw2Model)
      {
         super(param1.viewer);
         this._model = param1;
         this.tmpVec = new Vector3D();
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
      
      override protected function _vertexShader() : void
      {
         op("m44 op, va0, vc0");
         if(this.hasUv)
         {
            op("mov v0, va2");
         }
         if(this.hasNormal)
         {
            op("m44 v3, va1, vc4");
         }
         if(this._normalReady && this.hasTangent && this.hasBitangent)
         {
            op("m44 v1, va3, vc4");
            op("m44 v2, va4, vc4");
         }
      }
      
      override protected function _fragmentShader() : void
      {
         if(this._diffuseReady && this.hasUv)
         {
            op("tex ft0, v0.xy, fs0 <2d, linear, mip, repeat>");
            if(this.isAlphaTested())
            {
               op("sub ft1.w, ft0.w, fc7.y");
               op("kil ft1.w");
            }
         }
         else if(this.hasUv)
         {
            op("mov ft0.xy, v0.xy");
            op("mov ft0.zw, fc0.xy");
         }
         else
         {
            op("mov ft0.rgba, fc0.yxxy");
         }
         if(this._normalReady && this.hasUv)
         {
            op("tex ft2, v0.xy, fs2 <2d, linear, mip, repeat>");
            op("mul ft2.xyz, ft2.xyz, fc0.zzz");
            op("sub ft2.xyz, ft2.xyz, fc0.yyy");
            op("nrm ft2.xyz, ft2.xyz");
         }
         else if(this.hasNormal)
         {
            op("nrm ft2.xyz, v3.xyz");
         }
         else
         {
            op("mov ft2.xyz, fc0.yxx");
         }
         if(this.hasNormal || this._normalReady && this.hasTangent && this.hasBitangent)
         {
            op("mov ft1, fc4");
            if(this._normalReady && this.hasTangent && this.hasBitangent)
            {
               op("m33 ft7.xyz, fc1.xyz, v1");
            }
            else
            {
               op("mov ft7.xyz, fc1.xyz");
            }
            op("dp3 ft3, ft2.xyz, ft7.xyz");
            op("max ft3, ft3, fc0.x");
            op("mul ft4, ft3, fc5.rgb");
            op("add ft1.rgb, ft1.rgb, ft4.rgb");
            if(this._normalReady && this.hasTangent && this.hasBitangent)
            {
               op("m33 ft7.xyz, fc2.xyz, v1");
            }
            else
            {
               op("mov ft7.xyz, fc2.xyz");
            }
            op("dp3 ft3, ft2.xyz, ft7.xyz");
            op("max ft3, ft3, fc0.x");
            op("mul ft4, ft3, fc6.rgb");
            op("add ft1.rgb, ft1.rgb, ft4.rgb");
            if(this._normalReady && this.hasTangent && this.hasBitangent)
            {
               op("m33 ft7.xyz, fc3.xyz, v1");
            }
            else
            {
               op("mov ft7.xyz, fc3.xyz");
            }
            op("dp3 ft3, ft2.xyz, ft7.xyz");
            op("max ft3, ft3, fc0.x");
            op("mul ft4, ft3, fc6.rgb");
            op("add ft1.rgb, ft1.rgb, ft4.rgb");
         }
         else
         {
            op("mov ft1.rgba, fc0.yyyy");
         }
         if(this._lightmapReady && this.hasUv)
         {
            op("tex ft3, v0.xy, fs1 <2d, linear, mip, repeat>");
            op("mul ft0, ft0, ft1");
            op("add oc, ft0, ft3");
         }
         else
         {
            op("mul oc, ft0, ft1");
         }
      }
      
      public function render() : void
      {
         if(this._vb == null || this._ib == null)
         {
            this.updateBuffers();
         }
         context.setVertexBufferAt(0,this._vb,0,"float3");
         var _loc1_:int = 3;
         if(this.hasNormal)
         {
            context.setVertexBufferAt(1,this._vb,_loc1_,"float3");
            _loc1_ = _loc1_ + 3;
         }
         else
         {
            context.setVertexBufferAt(1,null);
         }
         if(this.hasUv)
         {
            context.setVertexBufferAt(2,this._vb,_loc1_,"float2");
            _loc1_ = _loc1_ + 2;
         }
         else
         {
            context.setVertexBufferAt(2,null);
         }
         if(this._normalReady && this.hasTangent && this.hasBitangent)
         {
            context.setVertexBufferAt(3,this._vb,_loc1_,"float3");
            _loc1_ = _loc1_ + 3;
            context.setVertexBufferAt(4,this._vb,_loc1_,"float3");
            _loc1_ = _loc1_ + 3;
         }
         else
         {
            context.setVertexBufferAt(3,null);
            context.setVertexBufferAt(4,null);
         }
         if(this._diffuseReady && this.hasUv)
         {
            context.setTextureAt(0,this._matSet.diffuse.texture);
         }
         else
         {
            context.setTextureAt(0,null);
         }
         if(this._lightmapReady && this.hasUv)
         {
            context.setTextureAt(1,this._matSet.lightmap.texture);
         }
         else
         {
            context.setTextureAt(1,null);
         }
         if(this._normalReady && this.hasUv)
         {
            context.setTextureAt(2,this._matSet.normal.texture);
         }
         else
         {
            context.setTextureAt(2,null);
         }
         context.setProgram(_program);
         if(this.isAlphaBlended())
         {
            context.setBlendFactors(Context3DBlendFactor.ONE,Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
         }
         else if(this.isColorBlended())
         {
            context.setBlendFactors(Context3DBlendFactor.SOURCE_COLOR,Context3DBlendFactor.ONE_MINUS_SOURCE_COLOR);
         }
         else
         {
            context.setBlendFactors(Context3DBlendFactor.ONE,Context3DBlendFactor.ZERO);
         }
         context.drawTriangles(this._ib);
      }
      
      private function isAlphaBlended() : Boolean
      {
         return AlphaBlendMats[this._matName] !== undefined;
      }
      
      private function isAlphaTested() : Boolean
      {
         if(this._matName == "AmatShader1" && (this._model._model == "340726" || this._model._model == "221695" || this._model._model == "62829" || this._model._model == "62849" || this._model._model == "63914" || this._model._model == "65656") || this._model._model == "67640")
         {
            return false;
         }
         if(this._matName == "AmatShader2" && this._model._model == "104441")
         {
            return false;
         }
         return AlphaTestMats[this._matName] !== undefined;
      }
      
      private function isColorBlended() : Boolean
      {
         return ColorBlendedMats[this._matName] !== undefined;
      }
      
      private function isFullbright() : Boolean
      {
         return FullbrightMats[this._matName] !== undefined;
      }
      
      public function updateBuffers(param1:Boolean = true) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:int = 3;
         if(this.hasNormal)
         {
            _loc2_ = _loc2_ + 3;
         }
         if(this.hasUv)
         {
            _loc2_ = _loc2_ + 2;
         }
         if(this.hasTangent)
         {
            _loc2_ = _loc2_ + 3;
         }
         if(this.hasBitangent)
         {
            _loc2_ = _loc2_ + 3;
         }
         var _loc3_:int = this._vertices.length * _loc2_;
         if(!this._vbData)
         {
            this._vbData = new Vector.<Number>(_loc3_);
         }
         if(param1)
         {
            _loc5_ = 0;
            _loc6_ = 0;
            while(_loc5_ < _loc3_)
            {
               this._vbData[_loc5_] = this._vertices[_loc6_].position.x;
               this._vbData[_loc5_ + 1] = this._vertices[_loc6_].position.y;
               this._vbData[_loc5_ + 2] = this._vertices[_loc6_].position.z;
               _loc4_ = 3;
               if(this.hasNormal)
               {
                  this._vbData[_loc5_ + _loc4_] = this._vertices[_loc6_].normal.x;
                  this._vbData[_loc5_ + _loc4_ + 1] = this._vertices[_loc6_].normal.y;
                  this._vbData[_loc5_ + _loc4_ + 2] = this._vertices[_loc6_].normal.z;
                  _loc4_ = _loc4_ + 3;
               }
               if(this.hasUv)
               {
                  this._vbData[_loc5_ + _loc4_] = this._vertices[_loc6_].u;
                  this._vbData[_loc5_ + _loc4_ + 1] = this._vertices[_loc6_].v;
                  _loc4_ = _loc4_ + 2;
               }
               if(this.hasTangent)
               {
                  this._vbData[_loc5_ + _loc4_] = this._vertices[_loc6_].tangent.x;
                  this._vbData[_loc5_ + _loc4_ + 1] = this._vertices[_loc6_].tangent.y;
                  this._vbData[_loc5_ + _loc4_ + 2] = this._vertices[_loc6_].tangent.z;
                  _loc4_ = _loc4_ + 3;
               }
               if(this.hasBitangent)
               {
                  this._vbData[_loc5_ + _loc4_] = this._vertices[_loc6_].bitangent.x;
                  this._vbData[_loc5_ + _loc4_ + 1] = this._vertices[_loc6_].bitangent.y;
                  this._vbData[_loc5_ + _loc4_ + 2] = this._vertices[_loc6_].bitangent.z;
                  _loc4_ = _loc4_ + 3;
               }
               _loc5_ = _loc5_ + _loc2_;
               _loc6_++;
            }
         }
         if(!this._vb)
         {
            this._vb = context.createVertexBuffer(this._vertices.length,_loc2_);
         }
         this._vb.uploadFromVector(this._vbData,0,this._vertices.length);
         if(!this._ib)
         {
            this._ib = context.createIndexBuffer(this._indices.length);
            this._ib.uploadFromVector(this._indices,0,this._indices.length);
         }
      }
      
      public function read(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         this._show = true;
         var _loc3_:uint = param1.readUnsignedInt();
         if(_loc3_ & 1)
         {
            this.hasNormal = true;
         }
         if(_loc3_ & 2)
         {
            this.hasUv = true;
         }
         if(_loc3_ & 4)
         {
            this.hasTangent = true;
         }
         if(_loc3_ & 8)
         {
            this.hasBitangent = true;
         }
         if(_loc3_ & 16)
         {
            this.hasColor = true;
         }
         var _loc4_:uint = param1.readUnsignedInt();
         this._vertices = new Vector.<Vertex>(_loc4_);
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            this._vertices[_loc2_] = new Vertex();
            this._vertices[_loc2_].read(param1,this);
            _loc2_++;
         }
         var _loc5_:uint = param1.readUnsignedInt();
         this._indices = new Vector.<uint>(_loc5_);
         _loc2_ = 0;
         while(_loc2_ < _loc5_)
         {
            this._indices[_loc2_] = param1.readUnsignedShort();
            _loc2_++;
         }
         this._matName = param1.readUTF();
         this._matIndex = param1.readUnsignedInt();
         this._minBounds = ZamUtil.readVector3D(param1);
         this._maxBounds = ZamUtil.readVector3D(param1);
         this._show = !(this._matName.toLowerCase().indexOf("lod") == 0 || HiddenMats[this._matName] !== undefined);
         this._delay = DelayedMats[this._matName] !== undefined;
         upload();
         this.updateBuffers();
      }
      
      public function onTextureLoaded(param1:int) : void
      {
         this._matSet = this._model.getMaterialSet(this._matIndex);
         if(param1 == Gw2Texture.DIFFUSE)
         {
            this._diffuseReady = true;
         }
         else if(param1 == Gw2Texture.LIGHTMAP)
         {
            this._lightmapReady = true;
         }
         else if(param1 == Gw2Texture.NORMAL)
         {
            this._normalReady = true;
         }
         upload();
      }
   }
}
