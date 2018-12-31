package away3d.core.base
{
   import away3d.containers.View3D;
   import away3d.core.math.Number3D;
   import away3d.core.project.ProjectorType;
   import away3d.events.FaceEvent;
   import away3d.events.GeometryEvent;
   import away3d.events.MaterialEvent;
   import away3d.materials.IMaterial;
   import away3d.materials.ISegmentMaterial;
   import away3d.materials.ITriangleMaterial;
   import away3d.materials.IUVMaterial;
   import away3d.materials.WireColorMaterial;
   import away3d.materials.WireframeMaterial;
   import §away3d:arcane§._boundingRadius;
   import §away3d:arcane§._boundingScale;
   import §away3d:arcane§._maxX;
   import §away3d:arcane§._maxY;
   import §away3d:arcane§._maxZ;
   import §away3d:arcane§._minX;
   import §away3d:arcane§._minY;
   import §away3d:arcane§._minZ;
   import §away3d:arcane§._scaleX;
   import §away3d:arcane§._scaleY;
   import §away3d:arcane§._scaleZ;
   import §away3d:arcane§._sessionDirty;
   import §away3d:arcane§._transform;
   import §away3d:arcane§.notifyDimensionsChange;
   import flash.utils.Dictionary;
   
   public class Mesh extends Object3D
   {
       
      
      public var indexes:Array;
      
      private var _faceMaterial:ITriangleMaterial;
      
      private var _scenevertnormalsDirty:Boolean = true;
      
      private var _material:IMaterial;
      
      private var _uvMaterial:IUVMaterial;
      
      public var bothsides:Boolean;
      
      public var type:String = "mesh";
      
      private var _segmentMaterial:ISegmentMaterial;
      
      private var _face:Face;
      
      public var outline:ISegmentMaterial;
      
      private var _back:ITriangleMaterial;
      
      private var _geometry:Geometry;
      
      private var _scenevertnormals:Dictionary;
      
      public var url:String;
      
      public function Mesh(param1:Object = null)
      {
         super(param1);
         this.geometry = new Geometry();
         this.outline = ini.getSegmentMaterial("outline");
         this.material = ini.getMaterial("material");
         this.faceMaterial = ini.getMaterial("faceMaterial") as ITriangleMaterial || this._faceMaterial;
         this.segmentMaterial = ini.getMaterial("segmentMaterial") as ISegmentMaterial || this._segmentMaterial;
         this.back = ini.getMaterial("back") as ITriangleMaterial;
         this.bothsides = ini.getBoolean("bothsides",false);
         projectorType = ProjectorType.MESH;
      }
      
      public function removeFace(param1:Face) : void
      {
         this._geometry.removeFace(param1);
      }
      
      public function updateMaterials(param1:Object3D, param2:View3D) : void
      {
         if(this._material)
         {
            this._material.updateMaterial(param1,param2);
         }
         if(this.back)
         {
            this.back.updateMaterial(param1,param2);
         }
         this.geometry.updateMaterials(param1,param2);
      }
      
      private function onMaterialUpdate(param1:MaterialEvent) : void
      {
         _sessionDirty = true;
      }
      
      public function asXML() : XML
      {
         var refvertices:Dictionary = null;
         var verticeslist:Array = null;
         var refuvs:Dictionary = null;
         var uvslist:Array = null;
         var face:Face = null;
         var vn:int = 0;
         var v:Vertex = null;
         var uvn:int = 0;
         var uv:UV = null;
         var f:Face = null;
         var result:XML = <mesh></mesh>;
         refvertices = new Dictionary();
         verticeslist = [];
         var remembervertex:Function = function(param1:Vertex):void
         {
            if(refvertices[param1] == null)
            {
               refvertices[param1] = verticeslist.length;
               verticeslist.push(param1);
            }
         };
         refuvs = new Dictionary();
         uvslist = [];
         var rememberuv:Function = function(param1:UV):void
         {
            if(param1 == null)
            {
               return;
            }
            if(refuvs[param1] == null)
            {
               refuvs[param1] = uvslist.length;
               uvslist.push(param1);
            }
         };
         for each(face in this._geometry.faces)
         {
            remembervertex(face._v0);
            remembervertex(face._v1);
            remembervertex(face._v2);
            rememberuv(face._uv0);
            rememberuv(face._uv1);
            rememberuv(face._uv2);
         }
         vn = 0;
         for each(v in verticeslist)
         {
            result.appendChild(<vertex id="{vn}" x="{v._x}" y="{v._y}" z="{v._z}"/>);
            vn++;
         }
         uvn = 0;
         for each(uv in uvslist)
         {
            result.appendChild(<uv id="{uvn}" u="{uv._u}" v="{uv._v}"/>);
            uvn++;
         }
         for each(f in this._geometry.faces)
         {
            result.appendChild(<face v0="{refvertices[f._v0]}" v1="{refvertices[f._v1]}" v2="{refvertices[f._v2]}" uv0="{refuvs[f._uv0]}" uv1="{refuvs[f._uv1]}" uv2="{refuvs[f._uv2]}"/>);
         }
         return result;
      }
      
      public function removeSegment(param1:Segment) : void
      {
         this._geometry.removeSegment(param1);
      }
      
      public function splitFace(param1:Face, param2:int = 0) : void
      {
         this._geometry.splitFace(param1,param2);
      }
      
      public function cloneAll(param1:Object3D = null) : Object3D
      {
         var _loc2_:Mesh = param1 as Mesh || new Mesh();
         super.clone(_loc2_);
         _loc2_.type = this.type;
         _loc2_.material = this.material;
         _loc2_.outline = this.outline;
         _loc2_.back = this.back;
         _loc2_.bothsides = this.bothsides;
         _loc2_.debugbb = debugbb;
         _loc2_.geometry = this.geometry.clone();
         return _loc2_;
      }
      
      public function addFace(param1:Face) : void
      {
         this._geometry.addFace(param1);
      }
      
      public function get segments() : Array
      {
         return this._geometry.segments;
      }
      
      public function get faceMaterial() : ITriangleMaterial
      {
         return this._faceMaterial;
      }
      
      public function get material() : IMaterial
      {
         return this._material;
      }
      
      public function triFace(param1:Face) : void
      {
         this._geometry.triFace(param1);
      }
      
      private function onFaceMappingChange(param1:FaceEvent) : void
      {
         _sessionDirty = true;
         if(param1.face.material)
         {
            this._uvMaterial = param1.face.material as IUVMaterial;
         }
         else
         {
            this._uvMaterial = this._faceMaterial as IUVMaterial;
         }
         if(this._uvMaterial)
         {
            this._uvMaterial.getFaceMaterialVO(param1.face.faceVO,this).invalidated = true;
         }
      }
      
      public function invertFaces() : void
      {
         this._geometry.invertFaces();
      }
      
      public function quarterFace(param1:Face) : void
      {
         this._geometry.quarterFace(param1);
      }
      
      override public function applyPosition(param1:Number, param2:Number, param3:Number) : void
      {
         this._geometry.applyPosition(param1,param2,param3);
         var _loc4_:Number3D = new Number3D(param1,param2,param3);
         _loc4_.rotate(_loc4_,_transform);
         _loc4_.add(_loc4_,position);
         moveTo(_loc4_.x,_loc4_.y,_loc4_.z);
      }
      
      public function get activePrefix() : String
      {
         return this.geometry.activePrefix;
      }
      
      public function get faces() : Array
      {
         return this._geometry.faces;
      }
      
      public function splitFaces(param1:int = 0) : void
      {
         this._geometry.splitFaces(param1);
      }
      
      public function set faceMaterial(param1:ITriangleMaterial) : void
      {
         if(this._faceMaterial == param1)
         {
            return;
         }
         this.removeMaterial(this._faceMaterial);
         this.addMaterial(this._faceMaterial = param1);
      }
      
      private function removeMaterial(param1:IMaterial) : void
      {
         if(!param1)
         {
            return;
         }
         param1.removeOnMaterialUpdate(this.onMaterialUpdate);
      }
      
      public function updateVertex(param1:Vertex, param2:Number, param3:Number, param4:Number, param5:Boolean = false) : void
      {
         this._geometry.updateVertex(param1,param2,param3,param4,param5);
      }
      
      public function set material(param1:IMaterial) : void
      {
         if(this._material == param1 && this._material != null)
         {
            return;
         }
         this.removeMaterial(this._material);
         this.addMaterial(this._material = param1);
         if(this._material is ITriangleMaterial)
         {
            this._faceMaterial = this._material as ITriangleMaterial;
         }
         else
         {
            this.faceMaterial = new WireColorMaterial();
         }
         if(this._material is ISegmentMaterial)
         {
            this._segmentMaterial = this._material as ISegmentMaterial;
         }
         else
         {
            this.segmentMaterial = new WireframeMaterial();
         }
         _sessionDirty = true;
      }
      
      public function addSegment(param1:Segment) : void
      {
         this._geometry.addSegment(param1);
      }
      
      public function set back(param1:ITriangleMaterial) : void
      {
         if(this._back == param1)
         {
            return;
         }
         this.removeMaterial(this._back);
         this.addMaterial(this._back = param1);
      }
      
      public function triFaces() : void
      {
         this._geometry.triFaces();
      }
      
      private function onDimensionsChange(param1:GeometryEvent) : void
      {
         _sessionDirty = true;
         notifyDimensionsChange();
      }
      
      override public function clone(param1:Object3D = null) : Object3D
      {
         var _loc2_:Mesh = param1 as Mesh || new Mesh();
         super.clone(_loc2_);
         _loc2_.type = this.type;
         _loc2_.material = this.material;
         _loc2_.outline = this.outline;
         _loc2_.back = this.back;
         _loc2_.bothsides = this.bothsides;
         _loc2_.debugbb = debugbb;
         _loc2_.geometry = this.geometry;
         return _loc2_;
      }
      
      public function set geometry(param1:Geometry) : void
      {
         if(this._geometry == param1)
         {
            return;
         }
         if(this._geometry != null)
         {
            this._geometry.removeOnMaterialUpdate(this.onMaterialUpdate);
            this._geometry.removeOnMappingChange(this.onFaceMappingChange);
            this._geometry.removeOnDimensionsChange(this.onDimensionsChange);
         }
         this._geometry = param1;
         if(this._geometry != null)
         {
            this._geometry.addOnMaterialUpdate(this.onMaterialUpdate);
            this._geometry.addOnMappingChange(this.onFaceMappingChange);
            this._geometry.addOnDimensionsChange(this.onDimensionsChange);
         }
      }
      
      public function get back() : ITriangleMaterial
      {
         return this._back;
      }
      
      private function addMaterial(param1:IMaterial) : void
      {
         if(!param1)
         {
            return;
         }
         param1.addOnMaterialUpdate(this.onMaterialUpdate);
      }
      
      public function quarterFaces() : void
      {
         this._geometry.quarterFaces();
      }
      
      public function get geometry() : Geometry
      {
         return this._geometry;
      }
      
      public function set segmentMaterial(param1:ISegmentMaterial) : void
      {
         if(this._segmentMaterial == param1)
         {
            return;
         }
         this.removeMaterial(this._segmentMaterial);
         this.addMaterial(this._segmentMaterial = param1);
      }
      
      override protected function updateDimensions() : void
      {
         var _loc1_:Array = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number3D = null;
         var _loc5_:Vertex = null;
         _loc1_ = this.geometry.vertices.concat();
         if(_loc1_.length)
         {
            if(_scaleX < 0)
            {
               _boundingScale = -_scaleX;
            }
            else
            {
               _boundingScale = _scaleX;
            }
            if(_scaleY < 0 && _boundingScale < -_scaleY)
            {
               _boundingScale = -_scaleY;
            }
            else if(_boundingScale < _scaleY)
            {
               _boundingScale = _scaleY;
            }
            if(_scaleZ < 0 && _boundingScale < -_scaleZ)
            {
               _boundingScale = -_scaleZ;
            }
            else if(_boundingScale < _scaleZ)
            {
               _boundingScale = _scaleZ;
            }
            _loc2_ = 0;
            _loc4_ = new Number3D();
            for each(_loc5_ in _loc1_)
            {
               _loc4_.sub(_loc5_.position,_pivotPoint);
               _loc3_ = _loc4_.modulo2;
               if(_loc2_ < _loc3_)
               {
                  _loc2_ = _loc3_;
               }
            }
            if(_loc2_)
            {
               _boundingRadius = Math.sqrt(_loc2_);
            }
            else
            {
               _boundingRadius = 0;
            }
            _loc1_.sortOn("x",Array.DESCENDING | Array.NUMERIC);
            _maxX = _loc1_[0].x;
            _minX = _loc1_[_loc1_.length - 1].x;
            _loc1_.sortOn("y",Array.DESCENDING | Array.NUMERIC);
            _maxY = _loc1_[0].y;
            _minY = _loc1_[_loc1_.length - 1].y;
            _loc1_.sortOn("z",Array.DESCENDING | Array.NUMERIC);
            _maxZ = _loc1_[0].z;
            _minZ = _loc1_[_loc1_.length - 1].z;
         }
         super.updateDimensions();
      }
      
      public function get elements() : Array
      {
         return this._geometry.elements;
      }
      
      public function get vertices() : Array
      {
         return this._geometry.vertices;
      }
      
      public function get segmentMaterial() : ISegmentMaterial
      {
         return this._segmentMaterial;
      }
      
      override public function applyRotations() : void
      {
         this._geometry.applyRotations(rotationX,rotationY,rotationZ);
         rotationX = 0;
         rotationY = 0;
         rotationZ = 0;
      }
   }
}
