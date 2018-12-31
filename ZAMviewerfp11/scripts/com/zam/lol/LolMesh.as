package com.zam.lol
{
   import com.zam.FileLoadEvent;
   import com.zam.MatrixUtil;
   import com.zam.Mesh;
   import com.zam.Viewer;
   import com.zam.ZamLoader;
   import com.zam.ZamUtil;
   import flash.display3D.IndexBuffer3D;
   import flash.display3D.VertexBuffer3D;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.geom.Matrix3D;
   import flash.geom.Vector3D;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.Endian;
   
   public class LolMesh extends Mesh
   {
      
      private static var _numChecks:int = 0;
       
      
      public var model:String;
      
      public var skinId:int;
      
      protected var _ready:Boolean;
      
      protected var _animsLoading:Boolean;
      
      protected var _version:uint;
      
      protected var _children:Vector.<LolMesh>;
      
      protected var _boundsMin:Vector3D;
      
      protected var _boundsMax:Vector3D;
      
      protected var _boundsSize:Vector3D;
      
      protected var _boundsCenter:Vector3D;
      
      protected var _boundsAnimated:Boolean;
      
      protected var _texture:LolTexture;
      
      protected var _hasTexture:Boolean;
      
      protected var _meshes:Vector.<Object>;
      
      protected var _vertices:Vector.<Vertex>;
      
      protected var _indices:Vector.<uint>;
      
      protected var _bones:Vector.<Bone>;
      
      protected var _boneLookup:Dictionary;
      
      protected var _animations:Vector.<Animation>;
      
      protected var _currentAnimation:int = -1;
      
      protected var _animName:String;
      
      protected var _animTime:int;
      
      protected var _vbData:Vector.<Number>;
      
      protected var _vb:VertexBuffer3D;
      
      protected var _ib:IndexBuffer3D;
      
      protected var _matrix:Matrix3D;
      
      protected var _constants:Vector.<Number>;
      
      protected var _constants2:Vector.<Number>;
      
      protected var _lightPos1:Vector.<Number>;
      
      protected var _lightPos2:Vector.<Number>;
      
      protected var _lightPos3:Vector.<Number>;
      
      protected var _ambientColor:Vector.<Number>;
      
      protected var _primaryColor:Vector.<Number>;
      
      protected var _secondColor:Vector.<Number>;
      
      private var mvpMatrix:Matrix3D;
      
      private var mvMatrix:Matrix3D;
      
      private var normalMatrix:Matrix3D;
      
      private var matVector:Vector.<Number>;
      
      private var tmpVec:Vector3D;
      
      private var offset:Vector3D;
      
      private var offsetAdjust:Vector3D;
      
      public var transforms:Vector.<Matrix3D>;
      
      private var _checks:Object;
      
      private var _debugLookup:Object;
      
      protected var _fixedModelBones:Object;
      
      public function LolMesh(param1:String, param2:Viewer, param3:Object)
      {
         this._checks = {};
         this._debugLookup = {};
         this._fixedModelBones = {"43":{
            0:{
               "r_thumb1":1,
               "r_hand":1
            },
            1:{
               "r_thumb1":1,
               "r_hand":1,
               "r_fan1":1,
               "r_fan3":1
            },
            2:{
               "r_thumb1":1,
               "r_thumb2":1,
               "r_index1":1,
               "r_hand":1,
               "r_fan":1,
               "r_fan2":1,
               "l_fan":1,
               "l_fan2":1,
               "l_fan3":1,
               "l_fan4":1,
               "r_foot":1
            },
            3:{
               "r_thumb1":1,
               "r_hand":1
            }
         }};
         super(param1,param2,param3);
         var _loc4_:Vector3D = new Vector3D(5,5,-5);
         _loc4_.normalize();
         var _loc5_:Vector3D = new Vector3D(5,5,5);
         _loc5_.normalize();
         var _loc6_:Vector3D = new Vector3D(-5,-5,-5);
         _loc6_.normalize();
         this._constants = Vector.<Number>([0,1,2,Math.PI]);
         this._constants2 = Vector.<Number>([0.7,0,0,0]);
         this._lightPos1 = Vector.<Number>([_loc4_.x,_loc4_.y,_loc4_.z,0]);
         this._lightPos2 = Vector.<Number>([_loc5_.x,_loc5_.y,_loc5_.z,0]);
         this._lightPos3 = Vector.<Number>([_loc6_.x,_loc6_.y,_loc6_.z,0]);
         this._ambientColor = Vector.<Number>([0.35,0.35,0.35,1]);
         this._primaryColor = Vector.<Number>([1,1,1,1]);
         this._secondColor = Vector.<Number>([0.35,0.35,0.35,1]);
         this._matrix = new Matrix3D();
         this.mvpMatrix = new Matrix3D();
         this.mvMatrix = new Matrix3D();
         this.normalMatrix = new Matrix3D();
         this.matVector = new Vector.<Number>(16);
         this.tmpVec = new Vector3D();
         this.offset = new Vector3D();
         this.offsetAdjust = new Vector3D();
         this._boneLookup = new Dictionary();
      }
      
      public function get ready() : Boolean
      {
         return this._ready;
      }
      
      public function get modelMatrix() : Matrix3D
      {
         return this._matrix;
      }
      
      public function get bones() : Vector.<Bone>
      {
         return this._bones;
      }
      
      public function get boneLookup() : Dictionary
      {
         return this._boneLookup;
      }
      
      public function get currentAnim() : Animation
      {
         return this._animations[this._currentAnimation];
      }
      
      override public function refresh() : void
      {
         var _loc1_:int = 0;
         if(this._texture)
         {
            this._texture.refresh();
         }
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
         if(this._children)
         {
            _loc1_ = 0;
            while(_loc1_ < this._children.length)
            {
               this._children[_loc1_].refresh();
               _loc1_++;
            }
         }
      }
      
      override public function load(param1:int, param2:String, param3:int = -1, param4:int = -1) : void
      {
         var info:Array = null;
         var numModels:int = 0;
         var i:int = 0;
         var skin:int = param1;
         var m:String = param2;
         var foo1:int = param3;
         var foo2:int = param4;
         this.model = m;
         this.skinId = skin;
         if(params.otherModels)
         {
            info = params.otherModels.split(",");
            if(info.length % 2 != 0)
            {
               info.pop();
            }
            if(info.length > 0)
            {
               numModels = info.length / 2;
               this._children = new Vector.<LolMesh>(numModels);
               i = 0;
               while(i < numModels)
               {
                  this._children[i] = new LolMesh(contentPath,viewer,{"_parentModel":this});
                  this._children[i].load(parseInt(info[i * 2 + 1]),info[i * 2]);
                  i++;
               }
            }
         }
         var loader:ZamLoader = new ZamLoader();
         loader.dataFormat = URLLoaderDataFormat.BINARY;
         loader.addEventListener(FileLoadEvent.LOAD_COMPLETE,this.readMesh,false,0,true);
         loader.addEventListener(FileLoadEvent.LOAD_ERROR,this.onLoadError,false,0,true);
         loader.addEventListener(FileLoadEvent.LOAD_SECURITY_ERROR,this.onLoadError,false,0,true);
         loader.addEventListener(FileLoadEvent.LOAD_PROGRESS,this.onLoadProgress,false,0,true);
         var url:String = "models/" + this.model + "_" + this.skinId + ".lmesh";
         try
         {
            loader.load(new URLRequest(_contentPath + url.toLowerCase()));
            return;
         }
         catch(ex:Error)
         {
            return;
         }
      }
      
      public function setAnimation(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc4_:Vector.<int> = null;
         param1 = param1.toLowerCase();
         this._currentAnimation = -1;
         var _loc3_:int = this._animations.length;
         if(param1 == "idle" || param1 == "attack")
         {
            _loc4_ = new Vector.<int>();
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               if(this._animations[_loc2_].name.indexOf(param1) == 0)
               {
                  _loc4_.push(_loc2_);
               }
               _loc2_++;
            }
            if(_loc4_.length > 0)
            {
               this._currentAnimation = _loc4_[ZamUtil.randomInt(0,_loc4_.length)];
            }
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               if(this._animations[_loc2_].name == param1)
               {
                  this._currentAnimation = _loc2_;
                  break;
               }
               _loc2_++;
            }
         }
         if(this._currentAnimation == -1)
         {
            if(param1 == "idle")
            {
               this._currentAnimation = 0;
               if(this._currentAnimation < this._animations.length)
               {
                  this._animName = this._animations[this._currentAnimation].name;
               }
            }
            else
            {
               this.setAnimation("idle");
            }
         }
         else
         {
            this._animName = param1;
         }
         this._animTime = viewer.time;
      }
      
      override public function update(param1:Number) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Number = NaN;
         var _loc7_:int = 0;
         var _loc8_:Number = NaN;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:Vertex = null;
         var _loc12_:Matrix3D = null;
         var _loc13_:Number = NaN;
         var _loc14_:int = 0;
         var _loc15_:AnimationBone = null;
         if(!this._ready || !this._animations || this._animations.length == 0)
         {
            return;
         }
         if(this._currentAnimation == -1)
         {
            this.setAnimation("idle");
         }
         var _loc2_:Animation = this._animations[this._currentAnimation];
         var _loc3_:int = viewer.time - this._animTime;
         if(_loc3_ >= _loc2_.duration)
         {
            this.setAnimation(this._animName);
            _loc2_ = this._animations[this._currentAnimation];
            _loc3_ = 0;
         }
         _loc6_ = 1000 / _loc2_.fps;
         _loc7_ = Math.floor(_loc3_ / _loc6_);
         _loc8_ = _loc3_ % _loc2_.fps / _loc6_;
         if(this._version >= 2)
         {
            _loc9_ = this._bones.length;
            _loc4_ = 0;
            while(_loc4_ < _loc9_)
            {
               if(this._bones[_loc4_].fixed || _loc2_.lookup[this._bones[_loc4_].name] === undefined)
               {
                  if(this._bones[_loc4_].parent != -1)
                  {
                     MatrixUtil.multiply(this._bones[_loc4_].incrMatrix,this.transforms[this._bones[_loc4_].parent],this.transforms[_loc4_]);
                  }
                  else
                  {
                     this.transforms[_loc4_].copyFrom(this._bones[_loc4_].incrMatrix);
                  }
               }
               else
               {
                  _loc2_.bones[_loc2_.lookup[this._bones[_loc4_].name]].calc(_loc4_,_loc2_,_loc7_,_loc8_);
               }
               _loc4_++;
            }
         }
         else
         {
            _loc9_ = _loc2_.bones.length;
            _loc4_ = 0;
            while(_loc4_ < _loc9_)
            {
               if(this._boneLookup[_loc2_.bones[_loc4_].bone] !== undefined)
               {
                  _loc10_ = this._boneLookup[_loc2_.bones[_loc4_].bone];
                  _loc2_.bones[_loc4_].calc(_loc10_,_loc2_,_loc7_,_loc8_);
               }
               else
               {
                  _loc15_ = _loc2_.bones[_loc4_ - 1];
                  if(_loc15_.idx + 1 < this.transforms.length)
                  {
                     this.transforms[_loc15_.idx + 1].copyFrom(this.transforms[_loc15_.idx]);
                  }
                  _loc2_.bones[_loc4_].idx = _loc15_.idx + 1;
               }
               _loc4_++;
            }
         }
         _loc9_ = Math.min(this.transforms.length,this.bones.length);
         _loc4_ = 0;
         while(_loc4_ < _loc9_)
         {
            MatrixUtil.multiply(this._bones[_loc4_].baseMatrix,this.transforms[_loc4_],this.transforms[_loc4_]);
            _loc4_++;
         }
         _loc14_ = this._vertices.length;
         _loc4_ = 0;
         while(_loc4_ < _loc14_)
         {
            _loc11_ = this._vertices[_loc4_];
            _loc10_ = _loc4_ * 8;
            this._vbData[_loc10_] = this._vbData[_loc10_ + 1] = this._vbData[_loc10_ + 2] = this._vbData[_loc10_ + 3] = this._vbData[_loc10_ + 4] = this._vbData[_loc10_ + 5] = 0;
            _loc5_ = 0;
            while(_loc5_ < 4)
            {
               if(_loc11_.weights[_loc5_] > 0)
               {
                  _loc13_ = _loc11_.weights[_loc5_];
                  _loc12_ = this.transforms[_loc11_.bones[_loc5_]];
                  MatrixUtil.transform(_loc12_,_loc11_.position,this.tmpVec);
                  this._vbData[_loc10_] = this._vbData[_loc10_] + this.tmpVec.x * _loc13_;
                  this._vbData[_loc10_ + 1] = this._vbData[_loc10_ + 1] + this.tmpVec.y * _loc13_;
                  this._vbData[_loc10_ + 2] = this._vbData[_loc10_ + 2] + this.tmpVec.z * _loc13_;
                  MatrixUtil.transform(_loc12_,_loc11_.normal,this.tmpVec);
                  this._vbData[_loc10_ + 3] = this._vbData[_loc10_ + 3] + this.tmpVec.x * _loc13_;
                  this._vbData[_loc10_ + 4] = this._vbData[_loc10_ + 4] + this.tmpVec.y * _loc13_;
                  this._vbData[_loc10_ + 5] = this._vbData[_loc10_ + 5] + this.tmpVec.z * _loc13_;
               }
               _loc5_++;
            }
            _loc4_++;
         }
         if(!this._boundsAnimated)
         {
            this._boundsMin = new Vector3D(9999,9999,9999);
            this._boundsMax = new Vector3D(-9999,-9999,-9999);
            this._boundsAnimated = true;
            _loc4_ = 0;
            while(_loc4_ < _loc14_)
            {
               _loc11_ = this._vertices[_loc4_];
               _loc10_ = _loc4_ * 8;
               this._boundsMin.x = Math.min(this._boundsMin.x,this._vbData[_loc10_]);
               this._boundsMin.y = Math.min(this._boundsMin.y,Math.max(0,this._vbData[_loc10_ + 1]));
               this._boundsMin.z = Math.min(this._boundsMin.z,this._vbData[_loc10_ + 2]);
               this._boundsMax.x = Math.max(this._boundsMax.x,this._vbData[_loc10_]);
               this._boundsMax.y = Math.max(this._boundsMax.y,this._vbData[_loc10_ + 1]);
               this._boundsMax.z = Math.max(this._boundsMax.z,this._vbData[_loc10_ + 2]);
               _loc4_++;
            }
            this._calcBounds();
         }
         this.updateBuffers(false);
         if(this._children)
         {
            _loc4_ = 0;
            while(_loc4_ < this._children.length)
            {
               this._children[_loc4_].update(param1);
               _loc4_++;
            }
         }
      }
      
      override public function render(param1:Number, param2:Boolean = true) : void
      {
         var _loc3_:int = 0;
         if(!this._ready)
         {
            return;
         }
         this.mvpMatrix.copyFrom(camera.matrix);
         this.mvpMatrix.prependTranslation(this.offset.x,this.offset.y,this.offset.z);
         this.mvpMatrix.prepend(camera.modelMatrix);
         this.mvpMatrix.prepend(this._matrix);
         this.mvMatrix.copyFrom(camera.viewMatrix);
         this.mvMatrix.prependTranslation(this.offset.x,this.offset.y,this.offset.z);
         this.mvMatrix.prepend(camera.modelMatrix);
         this.mvMatrix.prepend(this._matrix);
         this.normalMatrix.copyFrom(camera.viewMatrix);
         this.normalMatrix.prepend(camera.modelMatrix);
         this.normalMatrix.prepend(this._matrix);
         this.normalMatrix.invert();
         this.normalMatrix.transpose();
         context.setProgramConstantsFromMatrix("vertex",0,this.mvpMatrix,true);
         context.setProgramConstantsFromMatrix("vertex",4,this.normalMatrix,true);
         context.setProgramConstantsFromMatrix("vertex",12,this.mvMatrix,true);
         context.setProgramConstantsFromMatrix("vertex",20,camera.projMatrix,true);
         context.setProgramConstantsFromVector("vertex",9,camera.positionVec);
         if(param2)
         {
            context.setProgramConstantsFromVector("vertex",8,this._constants);
            context.setProgramConstantsFromVector("fragment",0,this._constants);
            context.setProgramConstantsFromVector("fragment",1,this._lightPos1);
            context.setProgramConstantsFromVector("fragment",2,this._lightPos2);
            context.setProgramConstantsFromVector("fragment",3,this._lightPos3);
            context.setProgramConstantsFromVector("fragment",4,this._ambientColor);
            context.setProgramConstantsFromVector("fragment",5,this._primaryColor);
            context.setProgramConstantsFromVector("fragment",6,this._secondColor);
            context.setProgramConstantsFromVector("fragment",7,this._constants2);
         }
         context.setVertexBufferAt(0,this._vb,0,"float3");
         context.setVertexBufferAt(1,this._vb,3,"float3");
         context.setVertexBufferAt(2,this._vb,6,"float2");
         if(this._texture && this._texture.good)
         {
            if(!this._hasTexture)
            {
               this._hasTexture = true;
               upload();
            }
            context.setTextureAt(0,this._texture.texture);
         }
         else
         {
            context.setTextureAt(0,null);
         }
         context.setProgram(_program);
         if(this._meshes && this._meshes.length > 0)
         {
            _loc3_ = 0;
            while(_loc3_ < this._meshes.length)
            {
               context.drawTriangles(this._ib,this._meshes[_loc3_].iStart,this._meshes[_loc3_].iCount / 3);
               _loc3_++;
            }
         }
         else
         {
            context.drawTriangles(this._ib);
         }
         if(this._children)
         {
            _loc3_ = 0;
            while(_loc3_ < this._children.length)
            {
               this._children[_loc3_].render(param1,false);
               _loc3_++;
            }
         }
      }
      
      override protected function _vertexShader() : void
      {
         op("m44 op, va0, vc0");
         op("mov v0, va2");
         op("m44 v1, va1, vc4");
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
         op("mul oc, ft0, ft1");
      }
      
      private function updateBuffers(param1:Boolean = true) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = 8;
         var _loc3_:int = this._vertices.length * _loc2_;
         if(!this._vbData)
         {
            this._vbData = new Vector.<Number>(_loc3_);
         }
         if(param1)
         {
            _loc4_ = 0;
            _loc5_ = 0;
            while(_loc4_ < _loc3_)
            {
               this._vbData[_loc4_] = this._vertices[_loc5_].position.x;
               this._vbData[_loc4_ + 1] = this._vertices[_loc5_].position.y;
               this._vbData[_loc4_ + 2] = this._vertices[_loc5_].position.z;
               this._vbData[_loc4_ + 3] = this._vertices[_loc5_].normal.x;
               this._vbData[_loc4_ + 4] = this._vertices[_loc5_].normal.y;
               this._vbData[_loc4_ + 5] = this._vertices[_loc5_].normal.z;
               this._vbData[_loc4_ + 6] = this._vertices[_loc5_].u;
               this._vbData[_loc4_ + 7] = this._vertices[_loc5_].v;
               _loc4_ = _loc4_ + _loc2_;
               _loc5_++;
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
         this._ready = true;
      }
      
      private function readMesh(param1:FileLoadEvent) : void
      {
         var i:int = 0;
         var textureFile:String = null;
         var animFile:String = null;
         var magic:uint = 0;
         var numMeshes:uint = 0;
         var numVerts:uint = 0;
         var numIndices:uint = 0;
         var numBones:uint = 0;
         var name:String = null;
         var vertexStart:uint = 0;
         var vertexCount:uint = 0;
         var indexStart:uint = 0;
         var indexCount:uint = 0;
         var loader:ZamLoader = null;
         var url:String = null;
         var e:FileLoadEvent = param1;
         var data:ByteArray = e.target.data;
         data.endian = Endian.LITTLE_ENDIAN;
         try
         {
            magic = data.readUnsignedInt();
            if(magic != 604210091)
            {
               return;
            }
            this._version = data.readUnsignedInt();
            animFile = data.readUTF();
            textureFile = data.readUTF();
            numMeshes = data.readUnsignedInt();
            if(numMeshes > 0)
            {
               this._meshes = new Vector.<Object>(numMeshes);
               i = 0;
               while(i < numMeshes)
               {
                  name = data.readUTF();
                  vertexStart = data.readUnsignedInt();
                  vertexCount = data.readUnsignedInt();
                  indexStart = data.readUnsignedInt();
                  indexCount = data.readUnsignedInt();
                  this._meshes[i] = {
                     "name":name,
                     "vStart":vertexStart,
                     "vCount":vertexCount,
                     "iStart":indexStart,
                     "iCount":indexCount
                  };
                  i++;
               }
            }
            numVerts = data.readUnsignedInt();
            this._vertices = new Vector.<Vertex>(numVerts);
            i = 0;
            while(i < numVerts)
            {
               this._vertices[i] = new Vertex();
               this._vertices[i].read(data);
               i++;
            }
            numIndices = data.readUnsignedInt();
            this._indices = new Vector.<uint>(numIndices);
            i = 0;
            while(i < numIndices)
            {
               this._indices[i] = data.readUnsignedShort();
               i++;
            }
            numBones = data.readUnsignedInt();
            this.transforms = new Vector.<Matrix3D>(numBones);
            this._bones = new Vector.<Bone>(numBones);
            i = 0;
            while(i < numBones)
            {
               this._bones[i] = new Bone(this,i);
               this._bones[i].read(data,this._version);
               if(this._boneLookup[this._bones[i].name] !== undefined)
               {
                  this.bones[i].name = this.bones[i].name + "2";
               }
               if(this._fixedModelBones[this.model] && this._fixedModelBones[this.model][this.skinId] && this._fixedModelBones[this.model][this.skinId][this.bones[i].name])
               {
                  this.bones[i].fixed = true;
               }
               this._boneLookup[this._bones[i].name] = i;
               this.transforms[i] = new Matrix3D();
               i++;
            }
         }
         catch(ex:Error)
         {
         }
         if(animFile && animFile.length > 0)
         {
            loader = new ZamLoader();
            loader.dataFormat = URLLoaderDataFormat.BINARY;
            loader.addEventListener(FileLoadEvent.LOAD_COMPLETE,this.readAnim,false,0,true);
            loader.addEventListener(FileLoadEvent.LOAD_ERROR,this.onLoadError,false,0,true);
            loader.addEventListener(FileLoadEvent.LOAD_SECURITY_ERROR,this.onLoadError,false,0,true);
            loader.addEventListener(FileLoadEvent.LOAD_PROGRESS,this.onLoadProgress,false,0,true);
            url = "models/" + animFile + ".lanim";
            try
            {
               loader.load(new URLRequest(_contentPath + url.toLowerCase()));
               this._animsLoading = true;
            }
            catch(ex:Error)
            {
               _animsLoading = false;
            }
         }
         if(textureFile && textureFile.length > 0)
         {
            this._texture = new LolTexture(viewer,this.model + "/" + textureFile + ".png");
         }
         upload();
         this.updateBuffers();
         this.calcBounds();
      }
      
      private function readAnim(param1:FileLoadEvent) : void
      {
         var i:int = 0;
         var magic:uint = 0;
         var version:uint = 0;
         var numAnims:uint = 0;
         var newData:ByteArray = null;
         var e:FileLoadEvent = param1;
         var data:ByteArray = e.target.data;
         data.endian = Endian.LITTLE_ENDIAN;
         try
         {
            magic = data.readUnsignedInt();
            if(magic != 604210092)
            {
               return;
            }
            version = data.readUnsignedInt();
            if(version >= 2)
            {
               newData = new ByteArray();
               newData.endian = Endian.LITTLE_ENDIAN;
               data.readBytes(newData);
               newData.uncompress();
               data = newData;
            }
            numAnims = data.readUnsignedInt();
            this._animations = new Vector.<Animation>(numAnims);
            i = 0;
            while(i < numAnims)
            {
               this._animations[i] = new Animation(this);
               this._animations[i].read(data);
               i++;
            }
         }
         catch(ex:Error)
         {
         }
         this._animsLoading = false;
      }
      
      public function onClickBone(param1:MouseEvent) : void
      {
         var _loc2_:int = this._debugLookup[param1.target.text];
         this._bones[_loc2_].fixed = !this._bones[_loc2_].fixed;
         var _loc3_:Matrix3D = this._bones[_loc2_].incrMatrix;
         var _loc4_:Animation = this._animations[this._currentAnimation];
         if(_loc4_.lookup[this._bones[_loc2_].name] !== undefined)
         {
            _loc4_.bones[_loc4_.lookup[this._bones[_loc2_].name]].dump(_loc2_);
         }
      }
      
      public function onClickAnim(param1:MouseEvent) : void
      {
         this.setAnimation(param1.target.text);
      }
      
      private function calcBounds() : void
      {
         var _loc1_:Vector3D = null;
         var _loc2_:int = 0;
         this._boundsMin = new Vector3D(9999,9999,9999);
         this._boundsMax = new Vector3D(-9999,-9999,-9999);
         this._boundsCenter = new Vector3D();
         this._boundsSize = new Vector3D();
         var _loc3_:int = this._vertices.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc1_ = this._vertices[_loc2_].position;
            this._boundsMin.x = Math.min(this._boundsMin.x,_loc1_.x);
            this._boundsMin.y = Math.min(this._boundsMin.y,_loc1_.y);
            this._boundsMin.z = Math.min(this._boundsMin.z,_loc1_.z);
            this._boundsMax.x = Math.max(this._boundsMax.x,_loc1_.x);
            this._boundsMax.y = Math.max(this._boundsMax.y,_loc1_.y);
            this._boundsMax.z = Math.max(this._boundsMax.z,_loc1_.z);
            _loc2_++;
         }
         this._calcBounds();
      }
      
      private function _calcBounds() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Array = null;
         var _loc18_:Array = null;
         var _loc19_:Vector.<int> = null;
         this._boundsSize.setTo(this._boundsMax.x - this._boundsMin.x,this._boundsMax.y - this._boundsMin.y,this._boundsMax.z - this._boundsMin.z);
         _loc2_ = this._boundsSize.y;
         _loc3_ = this._boundsSize.x;
         _loc4_ = Math.max(_loc2_,_loc3_);
         this._boundsCenter.setTo(this._boundsMin.x + this._boundsSize.x * 0.5,this._boundsMin.y + this._boundsSize.y * 0.5,this._boundsMin.z + this._boundsSize.z * 0.5);
         if(!params._parentModel)
         {
            _loc5_ = viewer.stage.stageWidth / viewer.stage.stageHeight;
            _loc6_ = 2 * Math.tan(45 / 2);
            _loc7_ = _loc6_ * 0.01;
            _loc8_ = _loc7_ * _loc5_;
            _loc9_ = _loc6_ * 500;
            _loc10_ = _loc9_ * _loc5_;
            _loc11_ = (_loc9_ - _loc7_) / 500;
            _loc12_ = (_loc10_ - _loc8_) / 500;
            _loc13_ = (_loc2_ * 1.5 - _loc7_ + _loc3_ / 2) / _loc11_;
            _loc14_ = (Math.max(this._boundsSize.x,this._boundsSize.z) * 1.5 + _loc2_ / 2 - _loc8_) / _loc12_;
            _loc15_ = Math.max(_loc13_,_loc14_);
            _loc16_ = 1;
            if(this._children)
            {
               _loc18_ = null;
               if(params.otherOffsets)
               {
                  _loc18_ = params.otherOffsets.split(",");
                  _loc1_ = 0;
                  while(_loc1_ < _loc18_.length)
                  {
                     _loc18_[_loc1_] = _loc18_[_loc1_].split(" ");
                     if(_loc18_[_loc1_].length != 3)
                     {
                        _loc18_[_loc1_] = [0,0,0];
                     }
                     _loc1_++;
                  }
               }
               _loc19_ = Vector.<int>([1,-1,2,-2,3,-3,4,-4]);
               _loc1_ = 0;
               while(_loc1_ < this._children.length)
               {
                  if(_loc18_ && _loc18_[_loc1_])
                  {
                     this._children[_loc1_].offset.setTo(_loc18_[_loc1_][0],_loc18_[_loc1_][1],_loc18_[_loc1_][2]);
                  }
                  else
                  {
                     this._children[_loc1_].offset.setTo(this._boundsSize.x * 1.75 * _loc19_[_loc1_],0,-this._boundsSize.z * Math.abs(_loc19_[_loc1_]));
                  }
                  _loc1_++;
               }
               _loc16_ = _loc16_ + Math.ceil(this._children.length / 2);
            }
            if(params.offset)
            {
               _loc17_ = params.offset.split(" ");
               if(_loc17_.length != 3)
               {
                  _loc17_ = [0,0,0];
               }
               this.offset.setTo(_loc17_[0],_loc17_[1],_loc17_[2]);
            }
            if(params.offsetAdjust)
            {
               _loc17_ = params.offsetAdjust.split(" ");
               if(_loc17_.length != 3)
               {
                  _loc17_ = [0,0,0];
               }
               this.offsetAdjust.setTo(_loc17_[0],_loc17_[1],_loc17_[2]);
            }
            if(params.initialZoom)
            {
               camera.setDistance(parseFloat(params.initialZoom));
            }
            else
            {
               camera.setDistance(_loc15_ * _loc16_);
            }
         }
         this._matrix.identity();
         this._matrix.prependTranslation(-this._boundsCenter.x + this.offsetAdjust.x,-this._boundsCenter.y + this.offsetAdjust.y,-this._boundsCenter.z + this.offsetAdjust.z);
      }
      
      override public function registerExternalInterface() : void
      {
         ExternalInterface.addCallback("getNumAnimations",this.extGetNumAnimations);
         ExternalInterface.addCallback("getAnimation",this.extGetAnimation);
         ExternalInterface.addCallback("setAnimation",this.extSetAnimation);
         ExternalInterface.addCallback("isLoaded",this.extIsLoaded);
      }
      
      public function extGetNumAnimations() : int
      {
         return !!this._animations?int(this._animations.length):0;
      }
      
      public function extGetAnimation(param1:int) : String
      {
         if(this._animations && param1 > -1 && param1 < this._animations.length)
         {
            return this._animations[param1].name;
         }
         return "";
      }
      
      public function extSetAnimation(param1:String) : void
      {
         this.setAnimation(param1.toLowerCase());
      }
      
      public function extIsLoaded() : Boolean
      {
         return this._ready && !this._animsLoading;
      }
      
      private function onLoadStart(param1:FileLoadEvent) : void
      {
         var _loc2_:FileLoadEvent = new FileLoadEvent(FileLoadEvent.LOAD_START,param1.url);
         _viewer.dispatchEvent(_loc2_);
      }
      
      private function onLoadProgress(param1:FileLoadEvent) : void
      {
         var _loc2_:FileLoadEvent = new FileLoadEvent(FileLoadEvent.LOAD_PROGRESS,param1.url,param1.currentBytes,param1.totalBytes);
         _viewer.dispatchEvent(_loc2_);
      }
      
      private function onLoadError(param1:FileLoadEvent) : void
      {
         var _loc2_:FileLoadEvent = new FileLoadEvent(FileLoadEvent.LOAD_ERROR,param1.url,-1,-1,param1.errorMessage);
         _viewer.dispatchEvent(_loc2_);
      }
   }
}
