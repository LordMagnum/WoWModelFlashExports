package com.zam.wow
{
   import com.zam.Color;
   import com.zam.Quaternion;
   import com.zam.Shader;
   import flash.display3D.Context3DBlendFactor;
   import flash.display3D.Context3DCompareMode;
   import flash.display3D.Context3DTriangleFace;
   import flash.display3D.IndexBuffer3D;
   import flash.display3D.textures.Texture;
   import flash.geom.Matrix3D;
   import flash.geom.Vector3D;
   import flash.utils.ByteArray;
   
   public class WowMesh extends Shader
   {
       
      
      public var _show:Boolean;
      
      public var _geoset:int;
      
      public var _geosetId:int;
      
      public var _indexStart:int;
      
      public var _indexCount:int;
      
      public var _material:int;
      
      public var _transparent:Boolean;
      
      public var _swrap:Boolean;
      
      public var _twrap:Boolean;
      
      public var _noZWrite:Boolean;
      
      public var _envmap:Boolean;
      
      public var _unlit:Boolean;
      
      public var _billboard:Boolean;
      
      public var _cull:Boolean;
      
      public var _blendMode:int;
      
      public var _texUnit:int;
      
      public var _texAnim:int;
      
      public var _renderFlags:int;
      
      public var _textureFlags:int;
      
      public var _color:Object;
      
      public var _opacity:Number;
      
      public var _colorIndex:int;
      
      public var _opacityIndex:int;
      
      protected var _model:WowModel;
      
      protected var _indices:Vector.<uint>;
      
      protected var _ib:IndexBuffer3D;
      
      protected var _textureMat:Matrix3D;
      
      protected var _hasTexture:Boolean;
      
      private var color:Color;
      
      private var tmpVec:Vector3D;
      
      private var tmpMat:Matrix3D;
      
      private var tmpQuat:Quaternion;
      
      private var matVector:Vector.<Number>;
      
      private var colorVector:Vector.<Number>;
      
      public function WowMesh(param1:WowModel)
      {
         super(param1.viewer);
         this._model = param1;
         this._textureMat = new Matrix3D();
         this.color = new Color();
         this.tmpVec = new Vector3D();
         this.tmpMat = new Matrix3D();
         this.tmpQuat = new Quaternion();
         this.matVector = new Vector.<Number>();
         this.colorVector = new Vector.<Number>([1,1,1,1]);
      }
      
      public function refresh() : void
      {
         if(this._ib)
         {
            this._ib.dispose();
            this._ib = null;
         }
      }
      
      override protected function _vertexShader() : void
      {
         op("m44 op, va0, vc0");
         op("m44 v0, va2, vc16");
         op("m44 v1, va1, vc4");
      }
      
      override protected function _fragmentShader() : void
      {
         if(this._hasTexture)
         {
            if(this._swrap || this._twrap)
            {
               op("tex ft0, v0.xy, fs0 <2d, linear, mip, wrap>");
            }
            else
            {
               op("tex ft0, v0.xy, fs0 <2d, linear, mip, repeat>");
            }
         }
         else
         {
            op("mov ft0.xy, v0.xy");
            op("mov ft0.zw, fc0.xy");
         }
         if(this._blendMode == 1)
         {
            op("sub ft1.w, ft0.w, fc7.x");
            op("kil ft1.w");
         }
         if(!this._unlit)
         {
            op("mov ft1, fc4");
            op("nrm ft2.xyz, v1.xyz");
            op("dp3 ft3, ft2.xyz, fc1.xyz");
            op("max ft3, ft3, fc0.x");
            op("mul ft4, ft3, fc5.rgb");
            op("add ft1.rgb, ft1.rgb, ft4.rgb");
            op("dp3 ft3, ft2.xyz, fc2.xyz");
            op("max ft3, ft3, fc0.x");
            op("mul ft4, ft3, fc6.rgb");
            op("add ft1.rgb, ft1.rgb, ft4.rgb");
            op("dp3 ft3, ft2.xyz, fc3.xyz");
            op("max ft3, ft3, fc0.x");
            op("mul ft4, ft3, fc6.rgb");
            op("add ft1.rgb, ft1.rgb, ft4.rgb");
            op("mul ft0, ft0, ft1");
         }
         op("mul oc, ft0, fc16");
      }
      
      public function render() : void
      {
         var _loc1_:WowTextureAnimation = null;
         var _loc2_:Texture = null;
         var _loc3_:WowMaterial = null;
         this.color.reset();
         if(this._colorIndex != -1)
         {
            this._model._colors[this._colorIndex].getValue(this._model._currentAnim,this._model._time,this.color);
         }
         if(this._opacityIndex != -1)
         {
            this.color.a = this.color.a * this._model._transparency[this._opacityIndex].getValue(this._model._currentAnim,this._model._time);
         }
         if(this.color.a < 0.01)
         {
            return;
         }
         this.colorVector[0] = this.color.r;
         this.colorVector[1] = this.color.g;
         this.colorVector[2] = this.color.b;
         this.colorVector[3] = this.color.a;
         context.setProgramConstantsFromVector("fragment",16,this.colorVector);
         this._textureMat.identity();
         if(this._model._textureAnimations && this._model._textureAnimations.length > this._texAnim && this._texAnim > -1)
         {
            _loc1_ = this._model._textureAnimations[this._texAnim];
            if(_loc1_.translation && _loc1_.translation.length > 0)
            {
               this.tmpVec.setTo(0,0,0);
               AnimatedVector3D.getValueFrom(_loc1_.translation,this._model._currentAnim,this._model._time,this.tmpVec);
               this._textureMat.prependTranslation(this.tmpVec.x,this.tmpVec.y,this.tmpVec.z);
            }
            if(_loc1_.rotation && _loc1_.rotation.length > 0)
            {
               this.tmpQuat.setTo(0,0,0,1);
               AnimatedQuaternion.getValueFrom(_loc1_.rotation,this._model._currentAnim,this._model._time,this.tmpQuat);
               this.tmpQuat.toMatrix(this.tmpMat);
               this._textureMat.prepend(this.tmpMat);
            }
            if(_loc1_.scale && _loc1_.scale.length > 0)
            {
               this.tmpVec.setTo(0,0,0);
               AnimatedVector3D.getValueFrom(_loc1_.scale,this._model._currentAnim,this._model._time,this.tmpVec);
               this._textureMat.prependScale(Number(this.tmpVec.x) || Number(1),Number(this.tmpVec.y) || Number(1),Number(this.tmpVec.z) || Number(1));
            }
         }
         context.setProgramConstantsFromMatrix("vertex",16,this._textureMat,true);
         if(this._ib == null)
         {
            this.updateBuffers();
         }
         if(this._material > -1 && this._material < this._model._materials.length)
         {
            _loc3_ = this._model._materials[this._material];
            if(_loc3_._specialTexture == 1 && this._model._npcTexture && this._model._npcTexture.good)
            {
               _loc2_ = this._model._npcTexture.texture;
            }
            else if(_loc3_._texture && _loc3_._texture.good)
            {
               _loc2_ = _loc3_._texture.texture;
            }
            else if(_loc3_._specialTexture != -1 && this._model._textures[_loc3_._specialTexture] && this._model._textures[_loc3_._specialTexture].good)
            {
               _loc2_ = this._model._textures[_loc3_._specialTexture].texture;
            }
            if(_loc2_ && !this._hasTexture)
            {
               this._hasTexture = true;
               upload();
            }
            context.setTextureAt(0,_loc2_);
         }
         else
         {
            context.setTextureAt(0,null);
         }
         context.setProgram(_program);
         switch(this._blendMode)
         {
            case 0:
            case 1:
               context.setBlendFactors(Context3DBlendFactor.ONE,Context3DBlendFactor.ZERO);
               break;
            case 2:
               context.setBlendFactors(Context3DBlendFactor.ONE,Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
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
         if(this._cull)
         {
            context.setCulling(Context3DTriangleFace.FRONT);
         }
         else
         {
            context.setCulling(Context3DTriangleFace.NONE);
         }
         if(this._noZWrite)
         {
            context.setDepthTest(false,Context3DCompareMode.LESS_EQUAL);
         }
         else
         {
            context.setDepthTest(true,Context3DCompareMode.LESS_EQUAL);
         }
         context.drawTriangles(this._ib);
      }
      
      public function updateBuffers() : void
      {
         this._indices = new Vector.<uint>(this._indexCount);
         var _loc1_:int = 0;
         while(_loc1_ < this._indexCount)
         {
            this._indices[_loc1_] = this._model._indices[this._indexStart + _loc1_];
            _loc1_++;
         }
         this._ib = context.createIndexBuffer(this._indexCount);
         this._ib.uploadFromVector(this._indices,0,this._indexCount);
         upload();
      }
      
      public function read(param1:ByteArray) : void
      {
         this._show = false;
         this._geoset = param1.readInt();
         this._geosetId = param1.readShort();
         this._material = param1.readShort();
         this._texAnim = param1.readShort();
         this._indexStart = param1.readUnsignedShort();
         this._indexCount = param1.readUnsignedShort();
         this._blendMode = param1.readShort();
         this._texUnit = param1.readShort();
         this._renderFlags = param1.readUnsignedShort();
         this._textureFlags = param1.readUnsignedShort();
         this._transparent = false;
         this._swrap = (this._textureFlags & 1) > 0;
         this._twrap = (this._textureFlags & 2) > 0;
         this._unlit = (this._renderFlags & 1) > 0;
         this._cull = (this._renderFlags & 4) == 0;
         this._billboard = (this._renderFlags & 8) > 0;
         this._noZWrite = (this._renderFlags & 16) > 0;
         this._envmap = this._texUnit == -1 && this._billboard && this._blendMode > 2;
         this._colorIndex = param1.readShort();
         this._opacityIndex = param1.readShort();
      }
   }
}
