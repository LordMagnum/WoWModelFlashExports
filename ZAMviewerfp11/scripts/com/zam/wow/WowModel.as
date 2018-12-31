package com.zam.wow
{
   import com.zam.Color;
   import com.zam.FileLoadEvent;
   import com.zam.MatrixUtil;
   import com.zam.Mesh;
   import com.zam.Viewer;
   import com.zam.ZamLoader;
   import com.zam.ZamUtil;
   import flash.display3D.VertexBuffer3D;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.geom.Matrix3D;
   import flash.geom.Vector3D;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class WowModel extends Mesh
   {
      
      private static var _numChecks:int = 0;
      
      public static const TypeItem:int = 1;
      
      public static const TypeHelm:int = 2;
      
      public static const TypeShoulder:int = 4;
      
      public static const TypeNpc:int = 8;
      
      public static const TypeCharacter:int = 16;
      
      public static const TypeHumanoidNpc:int = 32;
      
      public static const TypeObject:int = 64;
      
      public static const TypeArmor:int = 128;
      
      public static const TypePath:int = 256;
      
      public static const Genders:Array = new Array("Male","Female");
      
      public static const Races:Array = new Array("","Human","Orc","Dwarf","NightElf","Scourge","Tauren","Gnome","Troll","Goblin","BloodElf","Draenei","FelOrc","Naga_","Broken","Skeleton","Vrykul","Tuskarr","ForestTroll","Taunka","NorthrendSkeleton","IceTroll","Worgen","Human","Pandaren");
      
      public static const UniqueSlots:Array = new Array(0,1,0,3,4,5,6,7,8,9,10,0,0,21,22,22,16,21,0,19,5,21,22,22,0,21,21);
      
      public static const SlotOrder:Array = new Array(0,16,0,15,1,7,9,5,6,10,11,0,0,17,18,19,14,20,0,8,7,21,22,23,0,24,25);
      
      public static const SlotType:Array = new Array(0,2,0,4,128,128,128,128,128,128,128,0,0,1,1,1,128,1,0,128,128,1,1,1,0,1,1);
      
      public static const AlternateSlot:Array = new Array(0,0,0,0,0,0,0,0,0,0,0,0,0,22,0,0,0,22,0,0,0,0,0,0,0,0,0);
      
      public static const SlotHead:int = 1;
      
      public static const SlotShoulder:int = 3;
      
      public static const SlotShirt:int = 4;
      
      public static const SlotChest:int = 5;
      
      public static const SlotBelt:int = 6;
      
      public static const SlotPants:int = 7;
      
      public static const SlotBoots:int = 8;
      
      public static const SlotBracers:int = 9;
      
      public static const SlotGloves:int = 10;
      
      public static const SlotOneHand:int = 13;
      
      public static const SlotShield:int = 14;
      
      public static const SlotBow:int = 15;
      
      public static const SlotCape:int = 16;
      
      public static const SlotTwoHand:int = 17;
      
      public static const SlotTabard:int = 19;
      
      public static const SlotRobe:int = 20;
      
      public static const SlotRightHand:int = 21;
      
      public static const SlotLeftHand:int = 22;
      
      public static const SlotOffHand:int = 23;
      
      public static const SlotThrown:int = 25;
      
      public static const SlotRanged:int = 26;
      
      public static const RegionBase:int = 0;
      
      public static const RegionArmUpper:int = 1;
      
      public static const RegionArmLower:int = 2;
      
      public static const RegionHand:int = 3;
      
      public static const RegionFaceUpper:int = 4;
      
      public static const RegionFaceLower:int = 5;
      
      public static const RegionTorsoUpper:int = 6;
      
      public static const RegionTorsoLower:int = 7;
      
      public static const RegionPelvisUpper:int = 8;
      
      public static const RegionLegUpper:int = 8;
      
      public static const RegionPelvisLower:int = 9;
      
      public static const RegionLegLower:int = 9;
      
      public static const RegionFoot:int = 10;
      
      public static const TextureRegions:Array = new Array(new Array(0,0,1,1),new Array(0,0.75,0.5,0.25),new Array(0,0.5,0.5,0.25),new Array(0,0.375,0.5,0.125),new Array(0,0.25,0.5,0.125),new Array(0,0,0.5,0.25),new Array(0.5,0.75,0.5,0.25),new Array(0.5,0.625,0.5,0.125),new Array(0.5,0.375,0.5,0.25),new Array(0.5,0.125,0.5,0.25),new Array(0.5,0,0.5,0.125));
      
      public static const NewTextureRegions:Array = new Array(new Array(0,0,1,1),new Array(0,0.75,0.25,0.25),new Array(0,0.5,0.25,0.25),new Array(0,0.375,0.25,0.125),new Array(0.5,0,0.5,1),new Array(0,0,0.25,0.25),new Array(0.25,0.75,0.25,0.25),new Array(0.25,0.625,0.25,0.125),new Array(0.25,0.375,0.25,0.25),new Array(0.25,0.125,0.25,0.25),new Array(0.25,0,0.25,0.125));
      
      public static const BoneLeftArm:int = 0;
      
      public static const BoneRightArm:int = 1;
      
      public static const BoneLeftShoulder:int = 2;
      
      public static const BoneRightShoulder:int = 3;
      
      public static const BoneStomach:int = 4;
      
      public static const BoneWaist:int = 5;
      
      public static const BoneHead:int = 6;
      
      public static const BoneJaw:int = 7;
      
      public static const BoneRightFinger1:int = 8;
      
      public static const BoneRightFinger2:int = 9;
      
      public static const BoneRightFinger3:int = 10;
      
      public static const BoneRightFingers:int = 11;
      
      public static const BoneRightThumb:int = 12;
      
      public static const BoneLeftFinger1:int = 13;
      
      public static const BoneLeftFinger2:int = 14;
      
      public static const BoneLeftFinger3:int = 15;
      
      public static const BoneLeftFingers:int = 16;
      
      public static const BoneLeftThumb:int = 17;
      
      public static const BoneRoot:int = 26;
       
      
      public var _model:String;
      
      protected var _modelType:int;
      
      protected var _ready:Boolean;
      
      public var _race:int = -1;
      
      public var _gender:int = -1;
      
      protected var _currentSkin:int;
      
      protected var _currentFace:int;
      
      protected var _currentHair:int;
      
      protected var _currentHairTexture:int;
      
      protected var _currentFaceFeature:int;
      
      protected var _currentFaceTexture:int;
      
      protected var _currentFaceMesh:WowMesh;
      
      protected var _currentHairMesh:WowMesh;
      
      protected var _boundsMin:Vector3D;
      
      protected var _boundsMax:Vector3D;
      
      protected var _boundsSize:Vector3D;
      
      protected var _boundsCenter:Vector3D;
      
      protected var _freshBounds:Boolean;
      
      public var _textures:Array;
      
      public var _specialTextures:Array;
      
      public var _bakedTextures:Array;
      
      public var _npcTexture:WowTexture;
      
      public var _bakedTexture:WowTexture;
      
      public var _vertices:Vector.<WowVertex>;
      
      public var _indices:Vector.<uint>;
      
      public var _materials:Vector.<WowMaterial>;
      
      public var _meshes:Vector.<WowMesh>;
      
      public var _bones:Vector.<WowBone>;
      
      public var _attachments:Vector.<WowAttachment>;
      
      public var _boneLookup:Vector.<int>;
      
      public var _animations:Vector.<WowAnimation>;
      
      public var _textureAnimations:Vector.<WowTextureAnimation>;
      
      public var _colors:Vector.<WowColor>;
      
      public var _transparency:Vector.<WowTransparency>;
      
      public var _particleEmitters:Vector.<WowParticleEmitter>;
      
      public var _ribbonEmitters:Vector.<WowRibbonEmitter>;
      
      public var _skin:Vector.<WowSkin>;
      
      public var _faceFeature:Vector.<WowFaceFeature>;
      
      public var _hair:Vector.<WowHair>;
      
      public var _hairVis:Boolean = true;
      
      public var _faceVis:Boolean = true;
      
      protected var _geosets:Vector.<int>;
      
      public var _equipment:Vector.<WowEquipment>;
      
      public var _time:int;
      
      public var _currentAnim:int;
      
      public var _animListIndex:int;
      
      public var _animList:Vector.<WowAnimation>;
      
      public var _startTime:int;
      
      public var _freeze:Boolean;
      
      public var _spinSpeed:int;
      
      protected var _vbData:Vector.<Number>;
      
      protected var _vb:VertexBuffer3D;
      
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
      
      private var _checks:Object;
      
      public function WowModel(param1:String, param2:Viewer, param3:Object)
      {
         this._textures = new Array();
         this._specialTextures = new Array();
         this._bakedTextures = [{},{},{},{},{},{},{},{},{},{},{}];
         this._checks = {};
         super(param1,param2,param3);
         this._geosets = new Vector.<int>(20);
         this._equipment = new Vector.<WowEquipment>();
         this._matrix = new Matrix3D();
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
         this.mvpMatrix = new Matrix3D();
         this.mvMatrix = new Matrix3D();
         this.normalMatrix = new Matrix3D();
         this.matVector = new Vector.<Number>(16);
         this.tmpVec = new Vector3D();
      }
      
      public function get ready() : Boolean
      {
         return this._ready;
      }
      
      public function get animations() : Vector.<WowAnimation>
      {
         return this._animations;
      }
      
      public function get bones() : Vector.<WowBone>
      {
         return this._bones;
      }
      
      public function get currentAnimation() : WowAnimation
      {
         if(this._currentAnim > -1)
         {
            return this._animations[this._currentAnim];
         }
         return null;
      }
      
      public function get modelMatrix() : Matrix3D
      {
         return this._matrix;
      }
      
      override public function refresh() : void
      {
         var _loc1_:int = 0;
         var _loc2_:WowTexture = null;
         if(this._npcTexture)
         {
            this._npcTexture.refresh();
         }
         if(this._bakedTexture)
         {
            this._bakedTexture.refresh();
         }
         for each(_loc2_ in this._textures)
         {
            _loc2_.refresh();
         }
         for each(_loc2_ in this._specialTextures)
         {
            _loc2_.refresh();
         }
         if(this._vb)
         {
            this._vb.dispose();
            this._vb = null;
         }
         _loc1_ = 0;
         while(this._meshes && _loc1_ < this._meshes.length)
         {
            this._meshes[_loc1_].refresh();
            _loc1_++;
         }
         _loc1_ = 0;
         while(this._particleEmitters && _loc1_ < this._particleEmitters.length)
         {
            this._particleEmitters[_loc1_].refresh();
            _loc1_++;
         }
         _loc1_ = 0;
         while(this._ribbonEmitters && _loc1_ < this._ribbonEmitters.length)
         {
            this._ribbonEmitters[_loc1_].refresh();
            _loc1_++;
         }
         _loc1_ = 0;
         while(this._equipment && _loc1_ < this._equipment.length)
         {
            this._equipment[_loc1_].refresh();
            _loc1_++;
         }
      }
      
      override public function load(param1:int, param2:String, param3:int = -1, param4:int = -1) : void
      {
         var url:String = null;
         var type:int = param1;
         var model:String = param2;
         var raceOrIndex:int = param3;
         var gender:int = param4;
         this._model = model;
         this._modelType = type;
         if(this._modelType == TypeHelm && raceOrIndex == -1)
         {
            this._race = 1;
            this._gender = 0;
         }
         else if(this._modelType != TypeShoulder && raceOrIndex > -1)
         {
            this._race = raceOrIndex;
         }
         else if(this._modelType == TypeShoulder && raceOrIndex == -1)
         {
            raceOrIndex = 2;
         }
         if(gender > -1)
         {
            this._gender = gender;
         }
         var loader:ZamLoader = new ZamLoader();
         loader.dataFormat = URLLoaderDataFormat.TEXT;
         loader.addEventListener(FileLoadEvent.LOAD_COMPLETE,this.onLoaded,false,0,true);
         loader.addEventListener(FileLoadEvent.LOAD_ERROR,this.onLoadError,false,0,true);
         loader.addEventListener(FileLoadEvent.LOAD_SECURITY_ERROR,this.onLoadError,false,0,true);
         loader.addEventListener(FileLoadEvent.LOAD_PROGRESS,this.onLoadProgress,false,0,true);
         try
         {
            url = "models/";
            switch(this._modelType)
            {
               case TypeItem:
                  url = url + ("item/" + this._model + ".mum");
                  break;
               case TypeHelm:
                  url = url + ("armor/1/" + this._model + "_" + this._race + "_" + this._gender + ".mum");
                  break;
               case TypeShoulder:
                  url = url + ("armor/3/" + this._model + "_" + raceOrIndex + ".mum");
                  break;
               case TypeNpc:
                  url = url + ("npc/" + this._model + ".mum");
                  break;
               case TypeCharacter:
                  url = url + ("char/" + this._model + ".mo2");
                  loader.dataFormat = URLLoaderDataFormat.BINARY;
                  break;
               case TypeHumanoidNpc:
                  url = url + ("npc/" + this._model + ".sis");
                  break;
               case TypeObject:
                  url = url + ("obj/" + this._model + ".mum");
                  break;
               case TypePath:
                  url = url + model;
                  loader.dataFormat = URLLoaderDataFormat.BINARY;
            }
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
         this._animList = new Vector.<WowAnimation>();
         var _loc2_:int = 0;
         for(; _loc2_ < this._animations.length; _loc2_++)
         {
            if(param1 == "Stand")
            {
               if(this._animations[_loc2_]._name == param1)
               {
                  if(this._model == "pandarenmale" && this._animations[_loc2_]._duration == 11900)
                  {
                     continue;
                  }
                  this._animList.push(this._animations[_loc2_]);
               }
            }
            else if(this._animations[_loc2_]._name.indexOf(param1) == 0)
            {
               this._animList.push(this._animations[_loc2_]);
               continue;
            }
         }
         this._startTime = 0;
         this._animListIndex = 0;
         this._currentAnim = this._animList.length > 0?int(this._animList[0]._index):0;
         if(param1 != "Stand" && this._animList.length == 0)
         {
            this.setAnimation("Stand");
         }
      }
      
      override public function update(param1:Number) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc9_:WowVertex = null;
         var _loc10_:Number = NaN;
         var _loc11_:WowBone = null;
         var _loc12_:int = 0;
         if(!this._ready)
         {
            return;
         }
         if(this._animList != null && this._animList.length > 0)
         {
            this._time = viewer.time;
            if(this._startTime == 0)
            {
               this._startTime = this._time;
            }
            if(this._time - this._startTime >= this.currentAnimation._duration)
            {
               this._animListIndex = ZamUtil.randomInt(0,this._animList.length + 3) - 3;
               this._animListIndex = this._animListIndex < 0?0:int(this._animListIndex);
               this._currentAnim = this._animList[this._animListIndex]._index;
               this._startTime = this._time;
            }
         }
         var _loc7_:int = this._vertices.length;
         var _loc8_:int = this._meshes.length;
         if(!this._freeze && this._meshes.length > 50 && _loc7_ > 3000)
         {
            _loc2_ = true;
            _loc3_ = 0;
            while(_loc3_ < _loc8_)
            {
               if(this._meshes[_loc3_]._show)
               {
                  _loc5_ = this._meshes[_loc3_]._indexCount;
                  _loc6_ = this._meshes[_loc3_]._indexStart;
                  _loc4_ = 0;
                  while(_loc4_ < _loc5_)
                  {
                     this._vertices[this._indices[_loc6_ + _loc4_]].currentTime = this._time;
                     _loc4_++;
                  }
               }
               _loc3_++;
            }
         }
         if(!this._freeze && this._bones.length > 0 && this._animations != null && this._animations.length > 0)
         {
            _loc3_ = 0;
            while(_loc3_ < this._bones.length)
            {
               this._bones[_loc3_]._calc = false;
               _loc3_++;
            }
            _loc3_ = 0;
            while(_loc3_ < this._bones.length)
            {
               this._bones[_loc3_].calcMatrix(this._time - this._startTime);
               _loc3_++;
            }
            if(this._vertices != null)
            {
               _loc3_ = 0;
               while(_loc3_ < _loc7_)
               {
                  _loc9_ = this._vertices[_loc3_];
                  if(!(_loc2_ && _loc9_.currentTime != this._time))
                  {
                     _loc12_ = _loc3_ * 8;
                     this._vbData[_loc12_] = this._vbData[_loc12_ + 1] = this._vbData[_loc12_ + 2] = this._vbData[_loc12_ + 3] = this._vbData[_loc12_ + 4] = this._vbData[_loc12_ + 5] = 0;
                     _loc4_ = 0;
                     while(_loc4_ < 4)
                     {
                        if(_loc9_._weights[_loc4_] > 0)
                        {
                           _loc10_ = _loc9_._weights[_loc4_] / 255;
                           _loc11_ = this._bones[_loc9_._bones[_loc4_]];
                           MatrixUtil.transform(_loc11_._matrix,_loc9_._position,this.tmpVec);
                           this._vbData[_loc12_ + 0] = this._vbData[_loc12_ + 0] + this.tmpVec.x * _loc10_;
                           this._vbData[_loc12_ + 1] = this._vbData[_loc12_ + 1] + this.tmpVec.y * _loc10_;
                           this._vbData[_loc12_ + 2] = this._vbData[_loc12_ + 2] + this.tmpVec.z * _loc10_;
                           MatrixUtil.transform(_loc11_._rotMatrix,_loc9_._normal,this.tmpVec);
                           this._vbData[_loc12_ + 3] = this._vbData[_loc12_ + 3] + this.tmpVec.x * _loc10_;
                           this._vbData[_loc12_ + 4] = this._vbData[_loc12_ + 4] + this.tmpVec.y * _loc10_;
                           this._vbData[_loc12_ + 5] = this._vbData[_loc12_ + 5] + this.tmpVec.z * _loc10_;
                        }
                        _loc4_++;
                     }
                  }
                  _loc3_++;
               }
               this.updateBuffers(false);
               if(!this._freshBounds)
               {
                  this.calcBounds();
                  this._freshBounds = true;
               }
            }
         }
      }
      
      override public function render(param1:Number, param2:Boolean = true) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc7_:WowEquipment = null;
         var _loc8_:WowBone = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         if(!this._ready)
         {
            return;
         }
         if(this._spinSpeed != 0)
         {
            camera.rotate(Math.PI * 2 * (this._spinSpeed / 1000),0);
         }
         this.mvpMatrix.copyFrom(camera.matrix);
         this.mvpMatrix.prepend(camera.modelMatrix);
         this.mvpMatrix.prepend(this._matrix);
         this.mvMatrix.copyFrom(camera.viewMatrix);
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
         var _loc5_:int = this._meshes.length;
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            if(this._meshes[_loc3_]._show)
            {
               this._meshes[_loc3_].render();
            }
            _loc3_++;
         }
         var _loc6_:int = this._equipment.length;
         _loc3_ = 0;
         while(_loc3_ < _loc6_)
         {
            _loc7_ = this._equipment[_loc3_];
            if(_loc7_.models)
            {
               _loc4_ = 0;
               while(_loc4_ < _loc7_.models.length)
               {
                  if(_loc7_.models[_loc4_].model && _loc7_.models[_loc4_].bone > -1 && _loc7_.models[_loc4_].bone < this._bones.length)
                  {
                     _loc7_.models[_loc4_].model.setOrientation(this._matrix,this._bones[_loc7_.models[_loc4_].bone]._matrix,_loc7_.models[_loc4_].attachment._position);
                     _loc7_.models[_loc4_].model.update(param1);
                     _loc7_.models[_loc4_].model.render(param1,false);
                  }
                  _loc4_++;
               }
            }
            _loc3_++;
         }
         if(this._particleEmitters)
         {
            _loc9_ = this._particleEmitters.length;
            _loc3_ = 0;
            while(_loc3_ < _loc9_)
            {
               this._particleEmitters[_loc3_].update(this._currentAnim,this._time,param1);
               this._particleEmitters[_loc3_].render();
               _loc3_++;
            }
         }
         if(this._ribbonEmitters)
         {
            _loc10_ = this._ribbonEmitters.length;
            _loc3_ = 0;
            while(_loc3_ < _loc10_)
            {
               this._ribbonEmitters[_loc3_].update(this._currentAnim,this._time,param1);
               this._ribbonEmitters[_loc3_].render();
               _loc3_++;
            }
         }
      }
      
      override protected function _vertexShader() : void
      {
      }
      
      override protected function _fragmentShader() : void
      {
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
               this._vbData[_loc4_] = this._vertices[_loc5_]._transformedPosition.x;
               this._vbData[_loc4_ + 1] = this._vertices[_loc5_]._transformedPosition.y;
               this._vbData[_loc4_ + 2] = this._vertices[_loc5_]._transformedPosition.z;
               this._vbData[_loc4_ + 3] = this._vertices[_loc5_]._transformedNormal.x;
               this._vbData[_loc4_ + 4] = this._vertices[_loc5_]._transformedNormal.y;
               this._vbData[_loc4_ + 5] = this._vertices[_loc5_]._transformedNormal.z;
               this._vbData[_loc4_ + 6] = this._vertices[_loc5_]._texCoord.u;
               this._vbData[_loc4_ + 7] = this._vertices[_loc5_]._texCoord.v;
               _loc4_ = _loc4_ + _loc2_;
               _loc5_++;
            }
         }
         if(!this._vb)
         {
            this._vb = context.createVertexBuffer(this._vertices.length,_loc2_);
         }
         this._vb.uploadFromVector(this._vbData,0,this._vertices.length);
         this._ready = true;
      }
      
      public function updateMeshes() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:WowFaceFeature = null;
         var _loc5_:WowEquipment = null;
         var _loc7_:WowMesh = null;
         var _loc8_:WowAttachment = null;
         var _loc10_:WowHair = null;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:TextField = null;
         if(!this._ready || !this._meshes || this._meshes.length == 0)
         {
            return;
         }
         var _loc3_:Boolean = true;
         if(this._currentHairMesh)
         {
            _loc3_ = this._currentHairMesh._show;
         }
         _loc1_ = 0;
         while(_loc1_ < this._meshes.length)
         {
            this._meshes[_loc1_]._show = this._meshes[_loc1_]._geosetId == 0;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 20)
         {
            this._geosets[_loc1_] = 1;
            _loc1_++;
         }
         this._geosets[7] = 2;
         if(this._faceVis)
         {
            if(this._faceFeature && this._currentFaceFeature < this._faceFeature.length)
            {
               _loc4_ = this._faceFeature[this._currentFaceFeature];
               this._geosets[1] = _loc4_.geoset1;
               this._geosets[2] = _loc4_.geoset2;
               this._geosets[3] = _loc4_.geoset3;
            }
         }
         else
         {
            this._geosets[1] = this._geosets[2] = this._geosets[3] = 0;
         }
         if(this._race == 9)
         {
            if(this._geosets[1] == 1)
            {
               this._geosets[1]++;
            }
            if(this._geosets[2] == 1)
            {
               this._geosets[2]++;
            }
            if(this._geosets[3] == 1)
            {
               this._geosets[3]++;
            }
         }
         var _loc6_:int = this._equipment.length;
         _loc1_ = 0;
         while(_loc1_ < _loc6_)
         {
            _loc5_ = this._equipment[_loc1_];
            if(_loc5_.geosets)
            {
               _loc2_ = 0;
               while(_loc2_ < _loc5_.geosets.length)
               {
                  this._geosets[_loc5_.geosets[_loc2_].index] = _loc5_.geosets[_loc2_].value;
                  _loc2_++;
               }
               if(this._geosets[13] == 1)
               {
                  this._geosets[13] = 1 + _loc5_.geoC;
               }
               if(_loc5_.slot == 6)
               {
                  this._geosets[18] = 1 + _loc5_.geoA;
               }
               if(this._race == 24 && _loc5_.slot == SlotPants)
               {
                  this._geosets[14] = 0;
               }
            }
            _loc1_++;
         }
         if(this._geosets[13] == 2)
         {
            this._geosets[5] = this._geosets[12] = 0;
         }
         if(this._geosets[4] > 1)
         {
            this._geosets[8] = 0;
         }
         if(this._hair && this._currentHair < this._hair.length)
         {
            _loc10_ = this._hair[this._currentHair];
            _loc1_ = 0;
            while(_loc1_ < this._meshes.length)
            {
               _loc7_ = this._meshes[_loc1_];
               if(_loc7_._geosetId != 0 && _loc7_._geosetId == _loc10_.geoset)
               {
                  _loc7_._show = true;
                  this._currentHairMesh = _loc7_;
               }
               _loc1_++;
            }
         }
         _loc1_ = 0;
         while(_loc1_ < this._meshes.length)
         {
            _loc7_ = this._meshes[_loc1_];
            if(_loc7_._geosetId == 0 && _loc7_._indexCount < 36)
            {
               _loc7_._show = false;
            }
            else
            {
               if(_loc7_._geosetId == 1 && (!this._hairVis || this._gender == 0 && this._currentHair == 0 && (this._race == 1 || this._race == 7 || this._race == 8 || this._race == 18)))
               {
                  _loc7_._show = true;
               }
               _loc2_ = 1;
               while(_loc2_ < 20)
               {
                  _loc11_ = _loc2_ * 100;
                  _loc12_ = (_loc2_ + 1) * 100;
                  if(_loc7_._geosetId > _loc11_ && _loc7_._geosetId < _loc12_)
                  {
                     _loc7_._show = _loc7_._geosetId == _loc11_ + this._geosets[_loc2_];
                  }
                  _loc2_++;
               }
               if(this._race == 9)
               {
                  if(this._gender == 1 && _loc7_._geoset == 0 || this._gender == 0 && _loc7_._geoset == 3)
                  {
                     _loc7_._show = false;
                  }
               }
               else if(this._race == 22)
               {
                  if(this._gender == 0)
                  {
                     if(_loc7_._geoset == 2 || _loc7_._geoset == 3 || _loc7_._geoset >= 36 && _loc7_._geoset <= 47)
                     {
                        _loc7_._show = false;
                     }
                  }
                  else if(_loc7_._geoset == 2 || _loc7_._geoset == 3 || _loc7_._geoset >= 58 && _loc7_._geoset <= 69)
                  {
                     _loc7_._show = false;
                  }
               }
            }
            _loc1_++;
         }
         var _loc9_:int = this._attachments.length;
         _loc1_ = 0;
         while(_loc1_ < _loc6_)
         {
            _loc5_ = this._equipment[_loc1_];
            if(!(!_loc5_.loaded || !_loc5_.models))
            {
               _loc2_ = 0;
               while(_loc2_ < _loc5_.models.length)
               {
                  _loc13_ = 0;
                  _loc14_ = 0;
                  while(_loc14_ < _loc9_)
                  {
                     _loc8_ = this._attachments[_loc14_];
                     if(_loc8_._slot == _loc5_.slot)
                     {
                        if(_loc13_ == _loc2_)
                        {
                           _loc5_.models[_loc2_].bone = _loc8_._bone;
                           _loc5_.models[_loc2_].attachment = _loc8_;
                           break;
                        }
                        _loc13_++;
                     }
                     _loc14_++;
                  }
                  _loc2_++;
               }
            }
            _loc1_++;
         }
         if(this._currentHairMesh)
         {
            this._currentHairMesh._show = _loc3_ && this._hairVis;
         }
         if(false && !params._parentModel)
         {
            _loc1_ = 0;
            while(_loc1_ < this._meshes.length)
            {
               if(!this._checks[_loc1_])
               {
                  _loc15_ = new TextField();
                  _loc15_.x = 5 + Math.floor(_loc1_ / 30) * 90;
                  _loc15_.y = _loc1_ % 30 * 20 + 30;
                  _loc15_.height = 16;
                  _loc15_.width = 200;
                  _loc15_.text = "" + _loc1_ + " mesh " + this._meshes[_loc1_]._geosetId + " " + this._meshes[_loc1_]._geoset;
                  if(this._meshes[_loc1_]._show)
                  {
                     _loc15_.textColor = 65280;
                  }
                  else
                  {
                     _loc15_.textColor = 16711680;
                  }
                  _loc15_.addEventListener(MouseEvent.CLICK,this.onCheck,false,0,true);
                  this._checks[_loc1_] = _loc15_;
                  viewer.stage.addChild(this._checks[_loc1_]);
                  _numChecks++;
               }
               _loc1_++;
            }
         }
      }
      
      public function onCheck(param1:MouseEvent) : void
      {
         var _loc2_:int = parseInt(param1.target.text);
         var _loc3_:* = param1.target.textColor == 65280;
         if(this._meshes[_loc2_]._show && _loc3_)
         {
            this._meshes[_loc2_]._show = false;
            param1.target.textColor = 16711680;
         }
         else if(!this._meshes[_loc2_]._show && !_loc3_)
         {
            this._meshes[_loc2_]._show = true;
            param1.target.textColor = 65280;
         }
      }
      
      private function setup() : void
      {
         var _loc1_:WowSkin = null;
         var _loc2_:WowFace = null;
         var _loc3_:WowFaceFeature = null;
         var _loc4_:WowFaceFeatureTexture = null;
         var _loc5_:WowHair = null;
         var _loc6_:WowHairTexture = null;
         var _loc7_:int = 0;
         if(this._modelType != TypeCharacter && this._modelType != TypeHumanoidNpc || this._race < 1)
         {
            if(this._meshes)
            {
               _loc7_ = 0;
               while(_loc7_ < this._meshes.length)
               {
                  this._meshes[_loc7_]._show = true;
                  _loc7_++;
               }
            }
            return;
         }
         if((this._race == 14 || this._race == 17) && this._currentHair == 0)
         {
            this._currentHair = 1;
         }
         if(this._skin)
         {
            if(this._currentSkin >= this._skin.length)
            {
               this._currentSkin = 0;
            }
            if(this._currentSkin < this._skin.length)
            {
               _loc1_ = this._skin[this._currentSkin];
               if(this._currentFace >= _loc1_.faces.length)
               {
                  this._currentFace = 0;
               }
               if(this._currentFace < _loc1_.faces.length)
               {
                  _loc2_ = _loc1_.faces[this._currentFace];
               }
            }
         }
         if(this._faceFeature)
         {
            if(this._currentFaceFeature >= this._faceFeature.length)
            {
               this._currentFaceFeature = 0;
            }
            if(this._currentFaceFeature < this._faceFeature.length)
            {
               _loc3_ = this._faceFeature[this._currentFaceFeature];
               if(this._currentFaceTexture >= _loc3_.textures.length)
               {
                  this._currentFaceTexture = 0;
               }
               if(this._currentFaceTexture < _loc3_.textures.length)
               {
                  _loc4_ = _loc3_.textures[this._currentFaceTexture];
               }
            }
         }
         if(this._hair)
         {
            if(this._currentHair >= this._hair.length)
            {
               this._currentHair = 0;
            }
            if(this._currentHair < this._hair.length)
            {
               _loc5_ = this._hair[this._currentHair];
               if(this._currentHairTexture >= _loc5_.textures.length)
               {
                  this._currentHairTexture = 0;
               }
               if(this._currentHairTexture < _loc5_.textures.length)
               {
                  _loc6_ = _loc5_.textures[this._currentHairTexture];
               }
            }
         }
         if(!this._npcTexture)
         {
            if(_loc1_)
            {
               if(_loc1_.baseTexture.length > 0 && !this._specialTextures[1])
               {
                  this._specialTextures[1] = new WowTexture(this,1,_loc1_.baseTexture,WowTexture.SPECIAL);
               }
               if(_loc1_.pantiesTexture.length > 0 && !this._bakedTextures[RegionPelvisUpper][1])
               {
                  this._bakedTextures[RegionPelvisUpper][1] = new WowTexture(this,RegionPelvisUpper,_loc1_.pantiesTexture,WowTexture.BAKED);
               }
               if(_loc1_.braTexture.length > 0 && !this._bakedTextures[RegionTorsoUpper][1])
               {
                  this._bakedTextures[RegionTorsoUpper][1] = new WowTexture(this,RegionTorsoUpper,_loc1_.braTexture,WowTexture.BAKED);
               }
            }
            if(_loc2_)
            {
               if(_loc2_.lowerTexture.length > 0 && !this._bakedTextures[RegionFaceLower][1])
               {
                  this._bakedTextures[RegionFaceLower][1] = new WowTexture(this,RegionFaceLower,_loc2_.lowerTexture,WowTexture.BAKED);
               }
               if(_loc2_.upperTexture.length > 0 && !this._bakedTextures[RegionFaceUpper][1])
               {
                  this._bakedTextures[RegionFaceUpper][1] = new WowTexture(this,RegionFaceUpper,_loc2_.upperTexture,WowTexture.BAKED);
               }
            }
            if(_loc4_)
            {
               if(_loc4_.lowerTexture.length > 0 && !this._bakedTextures[RegionFaceLower][2])
               {
                  this._bakedTextures[RegionFaceLower][2] = new WowTexture(this,RegionFaceLower,_loc4_.lowerTexture,WowTexture.BAKED);
               }
               if(_loc4_.upperTexture.length > 0 && !this._bakedTextures[RegionFaceUpper][2])
               {
                  this._bakedTextures[RegionFaceUpper][2] = new WowTexture(this,RegionFaceUpper,_loc4_.upperTexture,WowTexture.BAKED);
               }
            }
            if(_loc6_)
            {
               if(_loc6_.lowerTexture.length > 0 && !this._bakedTextures[RegionFaceLower][3])
               {
                  this._bakedTextures[RegionFaceLower][3] = new WowTexture(this,RegionFaceLower,_loc6_.lowerTexture,WowTexture.BAKED);
               }
               if(_loc6_.upperTexture.length > 0 && !this._bakedTextures[RegionFaceUpper][3])
               {
                  this._bakedTextures[RegionFaceUpper][3] = new WowTexture(this,RegionFaceUpper,_loc6_.upperTexture,WowTexture.BAKED);
               }
            }
         }
         if(_loc1_ && _loc1_.furTexture.length > 0 && !this._specialTextures[8])
         {
            this._specialTextures[8] = new WowTexture(this,8,_loc1_.furTexture,WowTexture.SPECIAL);
         }
         if(_loc6_ && _loc6_.texture.length > 0 && !this._specialTextures[6])
         {
            this._specialTextures[6] = new WowTexture(this,6,_loc6_.texture,WowTexture.SPECIAL);
         }
         this.updateMeshes();
      }
      
      private function _readCountOffset(param1:ByteArray) : Object
      {
         var _loc2_:Object = new Object();
         _loc2_.count = param1.readInt();
         _loc2_.offset = param1.readInt();
         return _loc2_;
      }
      
      private function parseMo2(param1:FileLoadEvent) : void
      {
         var i:int = 0;
         var version:int = 0;
         var headerLength:int = 0;
         var vertices:Object = null;
         var indices:Object = null;
         var textures:Object = null;
         var meshes:Object = null;
         var bones:Object = null;
         var attachments:Object = null;
         var boneLookup:Object = null;
         var animations:Object = null;
         var texAnimations:Object = null;
         var colors:Object = null;
         var transparency:Object = null;
         var particleEmitters:Object = null;
         var ribbonEmitters:Object = null;
         var skins:Object = null;
         var faces:Object = null;
         var faceFeatures:Object = null;
         var faceTextures:Object = null;
         var hairs:Object = null;
         var hairTextures:Object = null;
         var e:FileLoadEvent = param1;
         var data:ByteArray = e.target.data;
         data.endian = Endian.LITTLE_ENDIAN;
         try
         {
            version = data.readInt();
            headerLength = data.readInt();
            vertices = this._readCountOffset(data);
            indices = this._readCountOffset(data);
            textures = this._readCountOffset(data);
            meshes = this._readCountOffset(data);
            bones = this._readCountOffset(data);
            attachments = this._readCountOffset(data);
            boneLookup = this._readCountOffset(data);
            animations = this._readCountOffset(data);
            texAnimations = this._readCountOffset(data);
            colors = this._readCountOffset(data);
            transparency = this._readCountOffset(data);
            particleEmitters = this._readCountOffset(data);
            ribbonEmitters = this._readCountOffset(data);
            skins = this._readCountOffset(data);
            faces = this._readCountOffset(data);
            faceFeatures = this._readCountOffset(data);
            faceTextures = this._readCountOffset(data);
            hairs = this._readCountOffset(data);
            hairTextures = this._readCountOffset(data);
            data.position = headerLength;
            this._race = data.readByte();
            this._gender = data.readByte();
            if(vertices.count > 0)
            {
               data.position = vertices.offset;
               this._vertices = new Vector.<WowVertex>(vertices.count);
               i = 0;
               while(i < vertices.count)
               {
                  this._vertices[i] = new WowVertex();
                  this._vertices[i].read(data);
                  i++;
               }
            }
            if(indices.count > 0)
            {
               data.position = indices.offset;
               this._indices = new Vector.<uint>(indices.count);
               i = 0;
               while(i < indices.count)
               {
                  this._indices[i] = data.readUnsignedShort();
                  i++;
               }
            }
            if(textures.count > 0)
            {
               data.position = textures.offset;
               this._materials = new Vector.<WowMaterial>(textures.count);
               i = 0;
               while(i < textures.count)
               {
                  this._materials[i] = new WowMaterial(this,i);
                  this._materials[i].read(data);
                  if(this._textures[i])
                  {
                     this._materials[i]._filename = this._textures[i]._url;
                     this._materials[i]._texture = this._textures[i];
                  }
                  i++;
               }
            }
            if(meshes.count > 0)
            {
               data.position = meshes.offset;
               this._meshes = new Vector.<WowMesh>(meshes.count);
               i = 0;
               while(i < meshes.count)
               {
                  this._meshes[i] = new WowMesh(this);
                  this._meshes[i].read(data);
                  i++;
               }
            }
            if(bones.count > 0)
            {
               data.position = bones.offset;
               this._bones = new Vector.<WowBone>(bones.count);
               i = 0;
               while(i < bones.count)
               {
                  this._bones[i] = new WowBone(this,i);
                  this._bones[i].read(data);
                  i++;
               }
            }
            if(attachments.count > 0)
            {
               data.position = attachments.offset;
               this._attachments = new Vector.<WowAttachment>(attachments.count);
               i = 0;
               while(i < attachments.count)
               {
                  this._attachments[i] = new WowAttachment();
                  this._attachments[i].read(data);
                  i++;
               }
            }
            if(boneLookup.count > 0)
            {
               data.position = boneLookup.offset;
               this._boneLookup = new Vector.<int>(boneLookup.count);
               i = 0;
               while(i < boneLookup.count)
               {
                  this._boneLookup[i] = data.readInt();
                  i++;
               }
            }
            if(animations.count > 0)
            {
               data.position = animations.offset;
               this._animations = new Vector.<WowAnimation>(animations.count);
               i = 0;
               while(i < animations.count)
               {
                  this._animations[i] = new WowAnimation(i);
                  this._animations[i].read(data,this._bones.length);
                  i++;
               }
            }
            if(texAnimations.count > 0)
            {
               data.position = texAnimations.offset;
               this._textureAnimations = new Vector.<WowTextureAnimation>(texAnimations.count);
               i = 0;
               while(i < texAnimations.count)
               {
                  this._textureAnimations[i] = new WowTextureAnimation();
                  this._textureAnimations[i].read(data);
                  i++;
               }
            }
            if(colors.count > 0)
            {
               data.position = colors.offset;
               this._colors = new Vector.<WowColor>(colors.count);
               i = 0;
               while(i < colors.count)
               {
                  this._colors[i] = new WowColor();
                  this._colors[i].read(data);
                  i++;
               }
            }
            if(transparency.count > 0)
            {
               data.position = transparency.offset;
               this._transparency = new Vector.<WowTransparency>(transparency.count);
               i = 0;
               while(i < transparency.count)
               {
                  this._transparency[i] = new WowTransparency();
                  this._transparency[i].read(data);
                  i++;
               }
            }
            if(particleEmitters.count > 0)
            {
               data.position = particleEmitters.offset;
               this._particleEmitters = new Vector.<WowParticleEmitter>(particleEmitters.count);
               i = 0;
               while(i < particleEmitters.count)
               {
                  this._particleEmitters[i] = new WowParticleEmitter(this);
                  this._particleEmitters[i].read(data);
                  i++;
               }
            }
            if(ribbonEmitters.count > 0)
            {
               data.position = ribbonEmitters.offset;
               this._ribbonEmitters = new Vector.<WowRibbonEmitter>(ribbonEmitters.count);
               i = 0;
               while(i < ribbonEmitters.count)
               {
                  this._ribbonEmitters[i] = new WowRibbonEmitter(this);
                  this._ribbonEmitters[i].read(data);
                  i++;
               }
            }
            if(skins.count > 0)
            {
               data.position = skins.offset;
               this._skin = new Vector.<WowSkin>(skins.count);
               i = 0;
               while(i < skins.count)
               {
                  this._skin[i] = new WowSkin();
                  this._skin[i].read(data);
                  i++;
               }
               if(faces.count > 0)
               {
                  data.position = faces.offset;
                  i = 0;
                  while(i < skins.count)
                  {
                     this._skin[i].readFaces(data);
                     i++;
                  }
               }
            }
            if(faceFeatures.count > 0)
            {
               data.position = faceFeatures.offset;
               this._faceFeature = new Vector.<WowFaceFeature>(faceFeatures.count);
               i = 0;
               while(i < faceFeatures.count)
               {
                  this._faceFeature[i] = new WowFaceFeature();
                  this._faceFeature[i].read(data);
                  i++;
               }
               if(faceTextures.count > 0)
               {
                  data.position = faceTextures.offset;
                  i = 0;
                  while(i < faceFeatures.count)
                  {
                     this._faceFeature[i].readTextures(data);
                     i++;
                  }
               }
            }
            if(hairs.count > 0)
            {
               data.position = hairs.offset;
               this._hair = new Vector.<WowHair>(hairs.count);
               i = 0;
               while(i < hairs.count)
               {
                  this._hair[i] = new WowHair();
                  this._hair[i].read(data);
                  i++;
               }
               if(hairTextures.count > 0)
               {
                  data.position = hairTextures.offset;
                  i = 0;
                  while(i < hairs.count)
                  {
                     this._hair[i].readTextures(data);
                     i++;
                  }
               }
            }
         }
         catch(ex:Error)
         {
         }
         this.setAnimation("Stand");
         this.updateBuffers();
         this.calcBounds();
         if(this._modelType == TypeCharacter)
         {
            if(params.equipList)
            {
               this.loadEquipList(params.equipList);
            }
            if(params.sk)
            {
               this._currentSkin = parseInt(params.sk);
            }
            if(params.ha)
            {
               this._currentHair = parseInt(params.ha);
            }
            if(params.hc)
            {
               this._currentHairTexture = parseInt(params.hc);
            }
            if(params.fa)
            {
               this._currentFace = parseInt(params.fa);
            }
            if(params.fh)
            {
               this._currentFaceFeature = parseInt(params.fh);
            }
            if(params.fc)
            {
               this._currentFaceTexture = parseInt(params.fc);
            }
         }
         this.setup();
      }
      
      private function calcBounds() : void
      {
         var _loc1_:Vector3D = null;
         var _loc3_:WowMesh = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         this._boundsMin = new Vector3D(Number.MAX_VALUE,Number.MAX_VALUE,Number.MAX_VALUE);
         this._boundsMax = new Vector3D(Number.MIN_VALUE,Number.MIN_VALUE,Number.MIN_VALUE);
         this._boundsCenter = new Vector3D();
         this._boundsSize = new Vector3D();
         var _loc2_:int = this._meshes.length;
         var _loc4_:Color = new Color();
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = this._meshes[_loc5_];
            if(_loc3_._show)
            {
               _loc4_.reset();
               if(_loc3_._colorIndex != -1)
               {
                  this._colors[_loc3_._colorIndex].getValue(this._currentAnim,this._time,_loc4_);
               }
               if(_loc3_._opacityIndex != -1)
               {
                  _loc4_.a = _loc4_.a * this._transparency[_loc3_._opacityIndex].getValue(this._currentAnim,this._time);
               }
               if(_loc4_.a >= 0.01)
               {
                  _loc9_ = _loc3_._indexStart;
                  _loc10_ = 0;
                  while(_loc10_ < _loc3_._indexCount)
                  {
                     _loc1_ = this._vertices[this._indices[_loc10_ + _loc9_]]._position;
                     this._boundsMin.x = Math.min(this._boundsMin.x,_loc1_.x);
                     this._boundsMin.y = Math.min(this._boundsMin.y,_loc1_.y);
                     this._boundsMin.z = Math.min(this._boundsMin.z,_loc1_.z);
                     this._boundsMax.x = Math.max(this._boundsMax.x,_loc1_.x);
                     this._boundsMax.y = Math.max(this._boundsMax.y,_loc1_.y);
                     this._boundsMax.z = Math.max(this._boundsMax.z,_loc1_.z);
                     _loc10_++;
                  }
               }
            }
            _loc5_++;
         }
         this._boundsSize.setTo(this._boundsMax.x - this._boundsMin.x,this._boundsMax.y - this._boundsMin.y,this._boundsMax.z - this._boundsMin.z);
         _loc6_ = this._boundsSize.y;
         if(this._modelType != TypeItem)
         {
            _loc7_ = this._boundsSize.z;
         }
         else
         {
            _loc7_ = this._boundsSize.x;
         }
         _loc8_ = Math.max(_loc6_,_loc7_);
         this._boundsCenter.setTo(this._boundsMin.x + this._boundsSize.x * 0.5,this._boundsMin.y + this._boundsSize.y * 0.5,this._boundsMin.z + this._boundsSize.z * 0.5);
         if(!params._parentModel)
         {
            _loc11_ = viewer.stage.stageWidth / viewer.stage.stageHeight;
            _loc12_ = 2 * Math.tan(45 / 2);
            _loc13_ = _loc12_ * 0.01;
            _loc14_ = _loc13_ * _loc11_;
            _loc15_ = _loc12_ * 500;
            _loc16_ = _loc15_ * _loc11_;
            _loc17_ = (_loc15_ - _loc13_) / 500;
            _loc18_ = (_loc16_ - _loc14_) / 500;
            _loc19_ = (_loc6_ * 1.5 - _loc13_ + _loc7_ / 2) / _loc17_;
            _loc20_ = (Math.max(this._boundsSize.x,this._boundsSize.z) * 1.5 + _loc6_ / 2 - _loc14_) / _loc18_;
            _loc21_ = Math.max(_loc19_,_loc20_);
            camera.setDistance(_loc21_);
         }
         this._matrix.identity();
         this._matrix.appendTranslation(-this._boundsCenter.x,-this._boundsCenter.y,-this._boundsCenter.z);
         if(this._modelType != TypeItem)
         {
            this._matrix.appendRotation(-90,Vector3D.Y_AXIS);
         }
      }
      
      private function setOrientation(param1:Matrix3D, param2:Matrix3D, param3:Vector3D) : void
      {
         this._matrix.copyFrom(param1);
         this._matrix.prepend(param2);
         if(param3)
         {
            this._matrix.prependTranslation(param3.x,param3.y,param3.z);
         }
      }
      
      private function loadEquipList(param1:String) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:Array = param1.split(",");
         if(_loc2_.length % 2 != 0)
         {
            viewer.statusText = "Bad equipment list passed :(";
            return;
         }
         while(_loc2_.length > 0)
         {
            _loc3_ = parseInt(_loc2_.shift());
            _loc4_ = parseInt(_loc2_.shift());
            this.attachEquipment(_loc3_,_loc4_);
         }
      }
      
      public function _parseMum(param1:Array) : Boolean
      {
         var _loc2_:String = null;
         var _loc3_:Array = null;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         if(param1.length < 2)
         {
            return false;
         }
         var _loc4_:String = param1.shift();
         if(_loc4_.length < 4)
         {
            return false;
         }
         var _loc5_:int = parseInt(param1.shift());
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc2_ = param1.shift();
            _loc3_ = _loc2_.split(" ");
            _loc7_ = parseInt(_loc3_.shift());
            _loc8_ = _loc3_.join(" ");
            if(_loc8_.length > 0)
            {
               this._textures[_loc7_] = new WowTexture(this,_loc7_,_loc8_);
            }
            _loc6_++;
         }
         this.load(TypePath,_loc4_.replace(".mom",".mo2"));
         return true;
      }
      
      private function parseMum(param1:FileLoadEvent) : void
      {
         var _loc2_:Array = param1.target.data.split("\r\n");
         this._parseMum(_loc2_);
      }
      
      private function parseNpcSis(param1:FileLoadEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:Array = null;
         var _loc2_:Array = param1.target.data.split("\r\n");
         _loc3_ = _loc2_.shift();
         _loc4_ = _loc3_.split(" ");
         this._race = parseInt(_loc4_[0]);
         this._gender = parseInt(_loc4_[1]);
         var _loc5_:String = Races[this._race] + Genders[this._gender];
         this.load(TypeCharacter,_loc5_.toLowerCase(),this._race,this._gender);
         _loc3_ = _loc2_.shift();
         if(_loc3_.length > 0)
         {
            this._npcTexture = new WowTexture(this,-1,_loc3_);
         }
         _loc3_ = _loc2_.shift();
         _loc4_ = _loc3_.split(" ");
         this._currentSkin = parseInt(_loc4_[0]);
         this._currentHair = parseInt(_loc4_[1]);
         this._currentHairTexture = parseInt(_loc4_[2]);
         this._currentFaceFeature = parseInt(_loc4_[3]);
         this._currentFace = parseInt(_loc4_[4]);
         _loc3_ = _loc2_.shift();
         _loc4_ = _loc3_.split(" ");
         var _loc6_:int = parseInt(_loc4_[0]);
         var _loc7_:int = parseInt(_loc4_[1]);
         var _loc8_:int = parseInt(_loc4_[2]);
         var _loc9_:int = parseInt(_loc4_[3]);
         var _loc10_:int = parseInt(_loc4_[4]);
         var _loc11_:int = parseInt(_loc4_[5]);
         var _loc12_:int = parseInt(_loc4_[6]);
         var _loc13_:int = parseInt(_loc4_[7]);
         var _loc14_:int = parseInt(_loc4_[8]);
         var _loc15_:int = parseInt(_loc4_[9]);
         if(_loc6_ != 0)
         {
            this.attachEquipment(SlotHead,_loc6_);
         }
         if(_loc7_ != 0)
         {
            this.attachEquipment(SlotShoulder,_loc7_);
         }
         if(_loc8_ != 0)
         {
            this.attachEquipment(SlotShirt,_loc8_);
         }
         if(_loc9_ != 0)
         {
            this.attachEquipment(SlotChest,_loc9_);
         }
         if(_loc10_ != 0)
         {
            this.attachEquipment(SlotBelt,_loc10_);
         }
         if(_loc11_ != 0)
         {
            this.attachEquipment(SlotPants,_loc11_);
         }
         if(_loc12_ != 0)
         {
            this.attachEquipment(SlotBoots,_loc12_);
         }
         if(_loc13_ != 0)
         {
            this.attachEquipment(SlotBracers,_loc13_);
         }
         if(_loc14_ != 0)
         {
            this.attachEquipment(SlotGloves,_loc14_);
         }
         if(_loc15_ != 0)
         {
            this.attachEquipment(SlotTabard,_loc15_);
         }
      }
      
      private function parseOma(param1:FileLoadEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:Array = null;
         var _loc2_:Array = param1.target.data.split("\r\n");
         _loc3_ = _loc2_.shift();
         _loc4_ = _loc3_.split(" ");
         var _loc5_:int = parseInt(_loc4_[0]);
         var _loc6_:int = parseInt(_loc4_[1]);
         this._hairVis = _loc5_ == 0;
         this._faceVis = _loc6_ == 0;
         this.updateMeshes();
      }
      
      private function onLoaded(param1:FileLoadEvent) : void
      {
         switch(this._modelType)
         {
            case TypeItem:
            case TypeHelm:
            case TypeShoulder:
            case TypeNpc:
            case TypeObject:
               this.parseMum(param1);
               break;
            case TypeCharacter:
            case TypePath:
               this.parseMo2(param1);
               break;
            case TypeHumanoidNpc:
               this.parseNpcSis(param1);
         }
      }
      
      private function attachEquipment(param1:int, param2:int) : void
      {
         var loader:ZamLoader = null;
         var url:String = null;
         var slot:int = param1;
         var id:int = param2;
         var equip:WowEquipment = new WowEquipment(this,slot,id.toString(),this._race,this._gender);
         var uniqueSlot:int = UniqueSlots[slot];
         var alternateSlot:int = AlternateSlot[slot];
         var numEquip:int = this._equipment.length;
         var idx1:int = -1;
         var idx2:int = -1;
         var i:int = 0;
         while(i < numEquip)
         {
            if(this._equipment[i].uniqueSlot == uniqueSlot)
            {
               idx1 = i;
            }
            else if(this._equipment[i].uniqueSlot == alternateSlot)
            {
               idx2 = i;
            }
            i++;
         }
         if(idx1 != -1 && idx2 != -1)
         {
            this._equipment[idx1] = equip;
         }
         else
         {
            if(idx1 != -1 && idx2 == -1)
            {
               equip.slot = alternateSlot;
            }
            this._equipment.push(equip);
         }
         if(slot == SlotHead)
         {
            loader = new ZamLoader();
            loader.dataFormat = URLLoaderDataFormat.TEXT;
            loader.addEventListener(FileLoadEvent.LOAD_COMPLETE,this.parseOma,false,0,true);
            loader.addEventListener(FileLoadEvent.LOAD_ERROR,this.onLoadError,false,0,true);
            loader.addEventListener(FileLoadEvent.LOAD_SECURITY_ERROR,this.onLoadError,false,0,true);
            loader.addEventListener(FileLoadEvent.LOAD_PROGRESS,this.onLoadProgress,false,0,true);
            try
            {
               url = "models/armor/1/" + id + ".oma";
               loader.load(new URLRequest(_contentPath + url.toLowerCase()));
               return;
            }
            catch(ex:Error)
            {
               return;
            }
         }
      }
      
      private function removeEquipment(param1:int, param2:Boolean = true) : void
      {
         var _loc3_:int = UniqueSlots[param1];
         var _loc4_:int = this._equipment.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            if(this._equipment[_loc5_].uniqueSlot == _loc3_)
            {
               this._equipment.splice(_loc5_,1);
            }
            _loc5_++;
         }
         if(param2)
         {
            this.updateMeshes();
            this.attemptTextureCompositing();
         }
      }
      
      public function attemptTextureCompositing() : void
      {
         var i:int = 0;
         var j:int = 0;
         var e:WowEquipment = null;
         var t:Object = null;
         var idx:String = null;
         i = 0;
         while(i < 11)
         {
            for(idx in this._bakedTextures[i])
            {
               if(!this._bakedTextures[i][idx].good)
               {
                  return;
               }
            }
            i++;
         }
         i = 0;
         while(i < this._equipment.length)
         {
            if(!this._equipment[i].loaded)
            {
               return;
            }
            if(this._equipment[i].textures)
            {
               j = 0;
               while(j < this._equipment[i].textures.length)
               {
                  if(this._equipment[i].textures[j].texture && !this._equipment[i].textures[j].texture.good)
                  {
                     return;
                  }
                  j++;
               }
            }
            i++;
         }
         if(!this._specialTextures[1] || !this._specialTextures[1].good)
         {
            return;
         }
         if(!this._bakedTexture)
         {
            this._bakedTexture = new WowTexture(this,-1,null,WowTexture.SPECIAL);
         }
         this._bakedTexture.copyFromTexture(this._specialTextures[1]);
         if(this._bakedTextures[RegionFaceLower][1])
         {
            this._bakedTexture.drawTexture(this._bakedTextures[RegionFaceLower][1],RegionFaceLower);
         }
         if(this._bakedTextures[RegionFaceUpper][1])
         {
            this._bakedTexture.drawTexture(this._bakedTextures[RegionFaceUpper][1],RegionFaceUpper);
         }
         if(this._bakedTextures[RegionFaceLower][2])
         {
            this._bakedTexture.drawTexture(this._bakedTextures[RegionFaceLower][2],RegionFaceLower);
         }
         if(this._bakedTextures[RegionFaceUpper][2])
         {
            this._bakedTexture.drawTexture(this._bakedTextures[RegionFaceUpper][2],RegionFaceUpper);
         }
         if(this._bakedTextures[RegionFaceLower][3])
         {
            this._bakedTexture.drawTexture(this._bakedTextures[RegionFaceLower][3],RegionFaceLower);
         }
         if(this._bakedTextures[RegionFaceUpper][3])
         {
            this._bakedTexture.drawTexture(this._bakedTextures[RegionFaceUpper][3],RegionFaceUpper);
         }
         var drawBra:Boolean = true;
         var drawPanties:Boolean = true;
         i = 0;
         while(i < this._equipment.length)
         {
            e = this._equipment[i];
            if(e.uniqueSlot == 4 || e.uniqueSlot == 5 || e.uniqueSlot == 19)
            {
               drawBra = false;
            }
            else if(e.slot == 2 || e.uniqueSlot == 7)
            {
               drawPanties = false;
            }
            i++;
         }
         if(drawBra && this._bakedTextures[RegionTorsoUpper][1])
         {
            this._bakedTexture.drawTexture(this._bakedTextures[RegionTorsoUpper][1],RegionTorsoUpper);
         }
         if(drawPanties && this._bakedTextures[RegionPelvisUpper][1])
         {
            this._bakedTexture.drawTexture(this._bakedTextures[RegionPelvisUpper][1],RegionPelvisUpper);
         }
         this._equipment.sort(function(param1:WowEquipment, param2:WowEquipment):Number
         {
            if(param1.sortValue < param2.sortValue)
            {
               return -1;
            }
            if(param1.sortValue > param2.sortValue)
            {
               return 1;
            }
            return 0;
         });
         i = 0;
         while(i < this._equipment.length)
         {
            e = this._equipment[i];
            if(e.textures)
            {
               j = 0;
               while(j < e.textures.length)
               {
                  t = e.textures[j];
                  if(!(t.gender != this._gender || !t.texture))
                  {
                     if(t.region > 0)
                     {
                        if(!((this._race == 6 || this._race == 8 || this._race == 11 || this._race == 14) && t.region == RegionFoot))
                        {
                           this._bakedTexture.drawTexture(t.texture,t.region);
                        }
                     }
                  }
                  j++;
               }
            }
            i++;
         }
         this._bakedTexture.uploadTexture();
         this._textures[1] = this._bakedTexture;
      }
      
      override public function registerExternalInterface() : void
      {
         ExternalInterface.addCallback("getNumAnimations",this.extGetNumAnimations);
         ExternalInterface.addCallback("getAnimation",this.extGetAnimation);
         ExternalInterface.addCallback("setAnimation",this.extSetAnimation);
         ExternalInterface.addCallback("resetAnimation",this.extResetAnimation);
         ExternalInterface.addCallback("attachList",this.extAttachList);
         ExternalInterface.addCallback("clearSlots",this.extClearSlots);
         ExternalInterface.addCallback("setAppearance",this.extSetAppearance);
         ExternalInterface.addCallback("setFreeze",this.extSetFreeze);
         ExternalInterface.addCallback("setSpinSpeed",this.extSetSpinSpeed);
         ExternalInterface.addCallback("isLoaded",this.extIsLoaded);
      }
      
      public function extGetNumAnimations() : int
      {
         return this._animations.length;
      }
      
      public function extGetAnimation(param1:int) : String
      {
         if(param1 > -1 && param1 < this._animations.length)
         {
            return this._animations[param1]._name;
         }
         return "";
      }
      
      public function extSetAnimation(param1:String) : void
      {
         this.setAnimation(param1);
      }
      
      public function extResetAnimation() : void
      {
         this.setAnimation("Stand");
      }
      
      public function extAttachList(param1:String) : void
      {
         this.loadEquipList(param1);
      }
      
      public function extClearSlots(param1:String) : void
      {
         var _loc2_:Array = param1.split(",");
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            this.removeEquipment(_loc2_[_loc3_],false);
            _loc3_++;
         }
         this.updateMeshes();
         this.attemptTextureCompositing();
      }
      
      public function extSetAppearance(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : void
      {
         this._currentHair = param1;
         this._currentHairTexture = param2;
         this._currentFace = param3;
         this._currentSkin = param4;
         this._currentFaceFeature = param5;
         this._currentFaceTexture = param2;
         this.setup();
      }
      
      public function extSetFreeze(param1:int) : void
      {
         if(param1 == 0)
         {
            this._freeze = false;
         }
         else
         {
            this._freeze = true;
         }
      }
      
      public function extSetSpinSpeed(param1:int) : void
      {
         this._spinSpeed = param1;
      }
      
      public function extIsLoaded() : Boolean
      {
         return this._ready;
      }
      
      public function onTextureLoaded(param1:WowTexture, param2:int, param3:int) : void
      {
         if(param2 == WowTexture.NORMAL && param3 > -1 && !this._textures[param3])
         {
            this._textures[param3] = param1;
         }
         else if((this._modelType == TypeCharacter || this._modelType == TypeHumanoidNpc) && (param2 == WowTexture.BAKED || param2 == WowTexture.ARMOR || param2 == WowTexture.SPECIAL && param3 == 1))
         {
            this.attemptTextureCompositing();
         }
         else if(param2 == WowTexture.SPECIAL && param3 > -1)
         {
            this._textures[param3] = param1;
         }
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
