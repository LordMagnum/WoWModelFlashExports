package com.zam.gw2
{
   import com.zam.FileLoadEvent;
   import com.zam.Mesh;
   import com.zam.Viewer;
   import com.zam.ZamLoader;
   import flash.events.MouseEvent;
   import flash.geom.Matrix3D;
   import flash.geom.Vector3D;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class Gw2Model extends Mesh
   {
      
      private static var _numChecks:int = 0;
       
      
      public var _model:String;
      
      protected var _modelType:int;
      
      protected var _ready:Boolean;
      
      protected var _boundsMin:Vector3D;
      
      protected var _boundsMax:Vector3D;
      
      protected var _boundsSize:Vector3D;
      
      protected var _boundsCenter:Vector3D;
      
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
      
      protected var _meshes:Vector.<Gw2Mesh>;
      
      protected var _materials:Vector.<Material>;
      
      protected var _textures:Array;
      
      private var _checks:Object;
      
      public function Gw2Model(param1:String, param2:Viewer, param3:Object)
      {
         this._textures = new Array();
         this._checks = {};
         super(param1,param2,param3);
         this._matrix = new Matrix3D();
         var _loc4_:Vector3D = new Vector3D(5,5,-5);
         _loc4_.normalize();
         var _loc5_:Vector3D = new Vector3D(5,5,5);
         _loc5_.normalize();
         var _loc6_:Vector3D = new Vector3D(-5,-5,-5);
         _loc6_.normalize();
         this._constants = Vector.<Number>([0,1,2,Math.PI]);
         this._constants2 = Vector.<Number>([0.7,0.1,0,0]);
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
      
      public function get modelMatrix() : Matrix3D
      {
         return this._matrix;
      }
      
      public function getMaterialSet(param1:int) : MaterialSet
      {
         if(this._textures[param1] === undefined)
         {
            this._textures[param1] = new MaterialSet();
         }
         return this._textures[param1];
      }
      
      override public function refresh() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MaterialSet = null;
         _loc1_ = 0;
         while(this._meshes && _loc1_ < this._meshes.length)
         {
            this._meshes[_loc1_].refresh();
            _loc1_++;
         }
         for each(_loc2_ in this._textures)
         {
            if(_loc2_.diffuse)
            {
               _loc2_.diffuse.refresh();
            }
            if(_loc2_.lightmap)
            {
               _loc2_.lightmap.refresh();
            }
            if(_loc2_.normal)
            {
               _loc2_.normal.refresh();
            }
         }
      }
      
      override public function load(param1:int, param2:String, param3:int = -1, param4:int = -1) : void
      {
         var url:String = null;
         var type:int = param1;
         var model:String = param2;
         var race:int = param3;
         var gender:int = param4;
         this._model = model;
         var loader:ZamLoader = new ZamLoader();
         loader.dataFormat = URLLoaderDataFormat.BINARY;
         loader.addEventListener(FileLoadEvent.LOAD_COMPLETE,this.onLoaded,false,0,true);
         loader.addEventListener(FileLoadEvent.LOAD_ERROR,this.onLoadError,false,0,true);
         loader.addEventListener(FileLoadEvent.LOAD_SECURITY_ERROR,this.onLoadError,false,0,true);
         loader.addEventListener(FileLoadEvent.LOAD_PROGRESS,this.onLoadProgress,false,0,true);
         try
         {
            url = "models/" + model + ".gwm?9";
            loader.load(new URLRequest(_contentPath + url));
            return;
         }
         catch(ex:Error)
         {
            return;
         }
      }
      
      override public function update(param1:Number) : void
      {
         if(!this._ready)
         {
            return;
         }
      }
      
      override public function render(param1:Number, param2:Boolean = true) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(!this._ready)
         {
            return;
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
         var _loc5_:int = this._meshes.length;
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            if(this._meshes[_loc3_]._show && !this._meshes[_loc3_]._delay)
            {
               this._meshes[_loc3_].render();
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            if(this._meshes[_loc3_]._show && this._meshes[_loc3_]._delay)
            {
               this._meshes[_loc3_].render();
            }
            _loc3_++;
         }
      }
      
      override protected function _vertexShader() : void
      {
      }
      
      override protected function _fragmentShader() : void
      {
      }
      
      private function onLoaded(param1:FileLoadEvent) : void
      {
         var magic:uint = 0;
         var version:uint = 0;
         var numMaterials:uint = 0;
         var numMeshes:uint = 0;
         var e:FileLoadEvent = param1;
         var i:uint = 0;
         var data:ByteArray = e.target.data;
         data.endian = Endian.LITTLE_ENDIAN;
         try
         {
            magic = data.readUnsignedInt();
            if(magic != 604210093)
            {
               throw new Error("Magic number doesn\'t match");
            }
            version = data.readUnsignedInt();
            numMaterials = data.readUnsignedInt();
            this._materials = new Vector.<Material>(numMaterials);
            i = 0;
            while(i < numMaterials)
            {
               this._materials[i] = new Material();
               this._materials[i].read(data);
               i++;
            }
            numMeshes = data.readUnsignedInt();
            this._meshes = new Vector.<Gw2Mesh>(numMeshes);
            i = 0;
            while(i < numMeshes)
            {
               this._meshes[i] = new Gw2Mesh(this);
               this._meshes[i].read(data);
               i++;
            }
         }
         catch(ex:Error)
         {
         }
         this.calcBounds();
         this.loadTextures();
         this._ready = true;
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
      
      private function calcBounds() : void
      {
         var _loc1_:Vector3D = null;
         var _loc2_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         this._boundsMin = new Vector3D(9999,9999,9999);
         this._boundsMax = new Vector3D(-9999,-9999,-9999);
         this._boundsCenter = new Vector3D();
         this._boundsSize = new Vector3D();
         var _loc3_:int = this._meshes.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc1_ = this._meshes[_loc2_]._minBounds;
            this._boundsMin.x = Math.min(this._boundsMin.x,_loc1_.x);
            this._boundsMin.y = Math.min(this._boundsMin.y,_loc1_.y);
            this._boundsMin.z = Math.min(this._boundsMin.z,_loc1_.z);
            _loc1_ = this._meshes[_loc2_]._maxBounds;
            this._boundsMax.x = Math.max(this._boundsMax.x,_loc1_.x);
            this._boundsMax.y = Math.max(this._boundsMax.y,_loc1_.y);
            this._boundsMax.z = Math.max(this._boundsMax.z,_loc1_.z);
            _loc2_++;
         }
         this._boundsSize.setTo(this._boundsMax.x - this._boundsMin.x,this._boundsMax.y - this._boundsMin.y,this._boundsMax.z - this._boundsMin.z);
         _loc4_ = this._boundsSize.z;
         _loc5_ = this._boundsSize.x;
         _loc6_ = Math.max(_loc4_,_loc5_);
         this._boundsCenter.setTo(this._boundsMin.x + this._boundsSize.x * 0.5,this._boundsMin.y + this._boundsSize.y * 0.5,this._boundsMin.z + this._boundsSize.z * 0.5);
         var _loc7_:Number = viewer.stage.stageWidth / viewer.stage.stageHeight;
         var _loc8_:Number = 2 * Math.tan(45 / 2);
         var _loc9_:Number = _loc8_ * camera.zNear;
         var _loc10_:Number = _loc9_ * _loc7_;
         var _loc11_:Number = _loc8_ * camera.zFar;
         var _loc12_:Number = _loc11_ * _loc7_;
         var _loc13_:Number = (_loc11_ - _loc9_) / camera.zFar;
         var _loc14_:Number = (_loc12_ - _loc10_) / camera.zFar;
         var _loc15_:Number = (_loc4_ * 1.5 - _loc9_ + _loc5_ / 2) / _loc13_;
         var _loc16_:Number = (Math.max(this._boundsSize.x,this._boundsSize.y) * 1.5 + _loc4_ / 2 - _loc10_) / _loc14_;
         var _loc17_:Number = Math.max(_loc15_,_loc16_);
         if(params.initialZoom)
         {
            _loc17_ = parseFloat(params.initialZoom);
         }
         camera.setDistance(_loc17_);
         if(_loc17_ > 500)
         {
            camera.setClipDistance(_loc17_ * 2);
         }
         else
         {
            camera.setClipDistance(1000);
         }
         this._matrix.identity();
         this._matrix.prependTranslation(-this._boundsCenter.x,-this._boundsCenter.y,-this._boundsCenter.z);
         this._matrix.appendRotation(90,Vector3D.X_AXIS);
         this._matrix.appendRotation(180,Vector3D.Y_AXIS);
      }
      
      private function loadTextures() : void
      {
         var _loc1_:uint = 0;
         var _loc3_:Material = null;
         var _loc2_:uint = this._materials.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this._materials[_loc1_];
            if(this._textures[_loc3_.index] === undefined)
            {
               this._textures[_loc3_.index] = new MaterialSet();
            }
            if(_loc3_.type == Gw2Texture.DIFFUSE && !this._textures[_loc3_.index].diffuse)
            {
               this._textures[_loc3_.index].diffuse = new Gw2Texture(this,_loc1_,"" + _loc3_.fileId + ".png",Gw2Texture.DIFFUSE);
            }
            else if(_loc3_.type == Gw2Texture.NORMAL && !this._textures[_loc3_.index].normal)
            {
               this._textures[_loc3_.index].normal = new Gw2Texture(this,_loc1_,"" + _loc3_.fileId + ".png",Gw2Texture.NORMAL);
            }
            else if(_loc3_.type == Gw2Texture.LIGHTMAP && !this._textures[_loc3_.index].lightmap)
            {
               this._textures[_loc3_.index].lightmap = new Gw2Texture(this,_loc1_,"" + _loc3_.fileId + ".png",Gw2Texture.LIGHTMAP);
            }
            _loc1_++;
         }
      }
      
      public function onTextureLoaded(param1:Gw2Texture, param2:int, param3:int) : void
      {
         var _loc4_:Material = null;
         var _loc5_:Gw2Mesh = null;
         if(param2 == Gw2Texture.DIFFUSE || param2 == Gw2Texture.NORMAL || param2 == Gw2Texture.LIGHTMAP)
         {
            _loc4_ = this._materials[param3];
            for each(_loc5_ in this._meshes)
            {
               if(_loc5_._matIndex == _loc4_.index)
               {
                  _loc5_.onTextureLoaded(param2);
               }
            }
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
