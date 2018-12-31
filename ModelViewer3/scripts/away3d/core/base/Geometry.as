package away3d.core.base
{
   import away3d.containers.View3D;
   import away3d.core.math.Number3D;
   import away3d.core.utils.IClonable;
   import away3d.core.utils.Init;
   import away3d.events.ElementEvent;
   import away3d.events.FaceEvent;
   import away3d.events.GeometryEvent;
   import away3d.events.MaterialEvent;
   import away3d.loaders.data.MaterialData;
   import away3d.materials.IMaterial;
   import away3d.materials.ITriangleMaterial;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   
   public class Geometry extends EventDispatcher
   {
       
      
      private var _activeprefix:String;
      
      public var materialDictionary:Dictionary;
      
      private var _neighbour01:Dictionary;
      
      private var _fAngle:Number;
      
      private var _n01:Face;
      
      private var clonedskincontrollers:Dictionary;
      
      private var _dispatchedDimensionsChange:Boolean;
      
      private var _neighboursDirty:Boolean = true;
      
      private var _neighbour12:Dictionary;
      
      private var _n12:Face;
      
      private var _materialData:MaterialData;
      
      private var _verticesDirty:Boolean = true;
      
      private var _neighbour20:Dictionary;
      
      private var _vertices:Array;
      
      private var _vertnormals:Dictionary;
      
      private var _n20:Face;
      
      private var _frame:int;
      
      private var clonedskinvertices:Dictionary;
      
      private var _vertfaces:Dictionary;
      
      private var clonedvertices:Dictionary;
      
      private var _fVectors:Array;
      
      private var _fNormal:Number3D;
      
      private var _billboards:Array;
      
      private var _faces:Array;
      
      private var _vertex:Vertex;
      
      private var _vertfacesDirty:Boolean = true;
      
      private var _dimensionschanged:GeometryEvent;
      
      private var _index:int;
      
      public var cloneElementDictionary:Dictionary;
      
      private var _vertnormalsDirty:Boolean = true;
      
      protected var ini:Init;
      
      private var cloneduvs:Dictionary;
      
      private var _segments:Array;
      
      public function Geometry()
      {
         this._faces = [];
         this._segments = [];
         this._billboards = [];
         this.materialDictionary = new Dictionary(true);
         this.cloneElementDictionary = new Dictionary();
         super();
      }
      
      public function removeFace(param1:Face) : void
      {
         var _loc2_:int = this._faces.indexOf(param1);
         if(_loc2_ == -1)
         {
            return;
         }
         this.removeElement(param1);
         if(param1.material)
         {
            this.removeMaterial(param1,param1.material);
         }
         this._vertfacesDirty = true;
         param1.v0.geometry = null;
         param1.v1.geometry = null;
         param1.v2.geometry = null;
         param1.notifyMappingChange();
         param1.removeOnMappingChange(this.onFaceMappingChange);
         this._faces.splice(_loc2_,1);
      }
      
      public function removeSegment(param1:Segment) : void
      {
         var _loc2_:int = this._segments.indexOf(param1);
         if(_loc2_ == -1)
         {
            return;
         }
         this.removeElement(param1);
         if(param1.material)
         {
            this.removeMaterial(param1,param1.material);
         }
         param1.v0.geometry = null;
         param1.v1.geometry = null;
         this._segments.splice(_loc2_,1);
      }
      
      public function get billboards() : Array
      {
         return this._billboards;
      }
      
      public function neighbour20(param1:Face) : Face
      {
         if(this._neighboursDirty)
         {
            this.findNeighbours();
         }
         return this._neighbour20[param1];
      }
      
      function getVertexNormal(param1:Vertex) : Number3D
      {
         if(this._vertfacesDirty)
         {
            this.findVertFaces();
         }
         if(this._vertnormalsDirty)
         {
            this.findVertNormals();
         }
         return this._vertnormals[param1];
      }
      
      private function addElement(param1:Element) : void
      {
         this._verticesDirty = true;
         param1.addOnVertexChange(this.onElementVertexChange);
         param1.addOnVertexValueChange(this.onElementVertexValueChange);
         param1.parent = this;
         this.notifyDimensionsChange();
      }
      
      public function quarterFace(param1:Face, param2:Dictionary = null) : void
      {
         if(param2 == null)
         {
            param2 = new Dictionary();
         }
         var _loc3_:Vertex = param1.v0;
         var _loc4_:Vertex = param1.v1;
         var _loc5_:Vertex = param1.v2;
         if(param2[_loc3_] == null)
         {
            param2[_loc3_] = new Dictionary();
         }
         if(param2[_loc4_] == null)
         {
            param2[_loc4_] = new Dictionary();
         }
         if(param2[_loc5_] == null)
         {
            param2[_loc5_] = new Dictionary();
         }
         var _loc6_:Vertex = param2[_loc3_][_loc4_];
         if(_loc6_ == null)
         {
            _loc6_ = Vertex.median(_loc3_,_loc4_);
            param2[_loc3_][_loc4_] = _loc6_;
            param2[_loc4_][_loc3_] = _loc6_;
         }
         var _loc7_:Vertex = param2[_loc4_][_loc5_];
         if(_loc7_ == null)
         {
            _loc7_ = Vertex.median(_loc4_,_loc5_);
            param2[_loc4_][_loc5_] = _loc7_;
            param2[_loc5_][_loc4_] = _loc7_;
         }
         var _loc8_:Vertex = param2[_loc5_][_loc3_];
         if(_loc8_ == null)
         {
            _loc8_ = Vertex.median(_loc5_,_loc3_);
            param2[_loc5_][_loc3_] = _loc8_;
            param2[_loc3_][_loc5_] = _loc8_;
         }
         var _loc9_:UV = param1.uv0;
         var _loc10_:UV = param1.uv1;
         var _loc11_:UV = param1.uv2;
         var _loc12_:UV = UV.median(_loc9_,_loc10_);
         var _loc13_:UV = UV.median(_loc10_,_loc11_);
         var _loc14_:UV = UV.median(_loc11_,_loc9_);
         var _loc15_:ITriangleMaterial = param1.material;
         this.removeFace(param1);
         this.addFace(new Face(_loc3_,_loc6_,_loc8_,_loc15_,_loc9_,_loc12_,_loc14_));
         this.addFace(new Face(_loc6_,_loc4_,_loc7_,_loc15_,_loc12_,_loc10_,_loc13_));
         this.addFace(new Face(_loc8_,_loc7_,_loc5_,_loc15_,_loc14_,_loc13_,_loc11_));
         this.addFace(new Face(_loc7_,_loc8_,_loc6_,_loc15_,_loc13_,_loc14_,_loc12_));
      }
      
      private function onElementVertexChange(param1:ElementEvent) : void
      {
         this._verticesDirty = true;
         if(param1.element is Face)
         {
            (param1.element as Face).normalDirty = true;
            this._vertfacesDirty = true;
         }
         this.notifyDimensionsChange();
      }
      
      public function get activePrefix() : String
      {
         return this._activeprefix;
      }
      
      public function removeOnMaterialUpdate(param1:Function) : void
      {
         removeEventListener(MaterialEvent.MATERIAL_UPDATED,param1,false);
      }
      
      function notifyDimensionsChange() : void
      {
         if(this._dispatchedDimensionsChange || !hasEventListener(GeometryEvent.DIMENSIONS_CHANGED))
         {
            return;
         }
         if(!this._dimensionschanged)
         {
            this._dimensionschanged = new GeometryEvent(GeometryEvent.DIMENSIONS_CHANGED,this);
         }
         dispatchEvent(this._dimensionschanged);
         this._dispatchedDimensionsChange = true;
      }
      
      public function addSegment(param1:Segment) : void
      {
         this.addElement(param1);
         if(param1.material)
         {
            this.addMaterial(param1,param1.material);
         }
         param1.v0.geometry = this;
         param1.v1.geometry = this;
         this._segments.push(param1);
      }
      
      private function findVertFaces() : void
      {
         var _loc1_:Face = null;
         var _loc2_:Vertex = null;
         var _loc3_:Vertex = null;
         var _loc4_:Vertex = null;
         this._vertfaces = new Dictionary();
         for each(_loc1_ in this.faces)
         {
            _loc2_ = _loc1_.v0;
            if(this._vertfaces[_loc2_] == null)
            {
               this._vertfaces[_loc2_] = [_loc1_];
            }
            else
            {
               this._vertfaces[_loc2_].push(_loc1_);
            }
            _loc3_ = _loc1_.v1;
            if(this._vertfaces[_loc3_] == null)
            {
               this._vertfaces[_loc3_] = [_loc1_];
            }
            else
            {
               this._vertfaces[_loc3_].push(_loc1_);
            }
            _loc4_ = _loc1_.v2;
            if(this._vertfaces[_loc4_] == null)
            {
               this._vertfaces[_loc4_] = [_loc1_];
            }
            else
            {
               this._vertfaces[_loc4_].push(_loc1_);
            }
         }
         this._vertfacesDirty = false;
         this._vertnormalsDirty = true;
      }
      
      public function removeOnMappingChange(param1:Function) : void
      {
         removeEventListener(FaceEvent.MAPPING_CHANGED,param1,false);
      }
      
      public function clone() : Geometry
      {
         var _loc2_:Face = null;
         var _loc3_:Segment = null;
         var _loc4_:int = 0;
         var _loc5_:Face = null;
         var _loc6_:Segment = null;
         var _loc1_:Geometry = new Geometry();
         this.clonedvertices = new Dictionary();
         this.cloneduvs = new Dictionary();
         for each(_loc2_ in this._faces)
         {
            _loc5_ = new Face(this.cloneVertex(_loc2_._v0),this.cloneVertex(_loc2_._v1),this.cloneVertex(_loc2_._v2),_loc2_.material,this.cloneUV(_loc2_._uv0),this.cloneUV(_loc2_._uv1),this.cloneUV(_loc2_._uv2));
            _loc1_.addFace(_loc5_);
            this.cloneElementDictionary[_loc2_] = _loc5_;
         }
         for each(_loc3_ in this._segments)
         {
            _loc6_ = new Segment(this.cloneVertex(_loc3_._v0),this.cloneVertex(_loc3_._v1),_loc3_.material);
            _loc1_.addSegment(_loc6_);
            this.cloneElementDictionary[_loc3_] = _loc6_;
         }
         _loc4_ = 0;
         return _loc1_;
      }
      
      private function cloneVertex(param1:Vertex) : Vertex
      {
         var _loc2_:Vertex = this.clonedvertices[param1];
         if(_loc2_ == null)
         {
            _loc2_ = param1.clone();
            _loc2_.extra = param1.extra is IClonable?(param1.extra as IClonable).clone():param1.extra;
            this.clonedvertices[param1] = _loc2_;
         }
         return _loc2_;
      }
      
      public function addOnDimensionsChange(param1:Function) : void
      {
         addEventListener(GeometryEvent.DIMENSIONS_CHANGED,param1,false,0,true);
      }
      
      public function addOnMaterialUpdate(param1:Function) : void
      {
         addEventListener(MaterialEvent.MATERIAL_UPDATED,param1,false,0,true);
      }
      
      public function quarterFaces() : void
      {
         var _loc2_:Face = null;
         var _loc1_:Dictionary = new Dictionary();
         for each(_loc2_ in this._faces.concat([]))
         {
            this.quarterFace(_loc2_,_loc1_);
         }
      }
      
      public function updateMaterials(param1:Object3D, param2:View3D) : void
      {
         for each(this._materialData in this.materialDictionary)
         {
            this._materialData.material.updateMaterial(param1,param2);
         }
      }
      
      public function invertFaces() : void
      {
         var _loc1_:Face = null;
         for each(_loc1_ in this._faces)
         {
            _loc1_.invert();
         }
      }
      
      private function findVertNormals() : void
      {
         var _loc1_:Vertex = null;
         var _loc2_:Array = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Face = null;
         var _loc7_:Number3D = null;
         var _loc8_:Vertex = null;
         this._vertnormals = new Dictionary();
         for each(_loc1_ in this.vertices)
         {
            _loc2_ = this._vertfaces[_loc1_];
            _loc3_ = 0;
            _loc4_ = 0;
            _loc5_ = 0;
            for each(_loc6_ in _loc2_)
            {
               this._fNormal = _loc6_.normal;
               this._fVectors = new Array();
               for each(_loc8_ in _loc6_.vertices)
               {
                  if(_loc8_ != _loc1_)
                  {
                     this._fVectors.push(new Number3D(_loc8_.x - _loc1_.x,_loc8_.y - _loc1_.y,_loc8_.z - _loc1_.z,true));
                  }
               }
               this._fAngle = Math.acos((this._fVectors[0] as Number3D).dot(this._fVectors[1] as Number3D));
               _loc3_ = _loc3_ + this._fNormal.x * this._fAngle;
               _loc4_ = _loc4_ + this._fNormal.y * this._fAngle;
               _loc5_ = _loc5_ + this._fNormal.z * this._fAngle;
            }
            _loc7_ = new Number3D(_loc3_,_loc4_,_loc5_);
            _loc7_.normalize();
            this._vertnormals[_loc1_] = _loc7_;
         }
         this._vertnormalsDirty = false;
      }
      
      public function removeOnDimensionsChange(param1:Function) : void
      {
         removeEventListener(GeometryEvent.DIMENSIONS_CHANGED,param1,false);
      }
      
      public function get vertexDirty() : Boolean
      {
         for each(this._vertex in this.vertices)
         {
            if(this._vertex.positionDirty)
            {
               return true;
            }
         }
         return false;
      }
      
      private function onMaterialUpdate(param1:MaterialEvent) : void
      {
         dispatchEvent(param1);
      }
      
      private function findNeighbours() : void
      {
         var _loc1_:Face = null;
         var _loc2_:Boolean = false;
         var _loc3_:Face = null;
         this._neighbour01 = new Dictionary();
         this._neighbour12 = new Dictionary();
         this._neighbour20 = new Dictionary();
         for each(_loc1_ in this._faces)
         {
            _loc2_ = true;
            for each(_loc3_ in this._faces)
            {
               if(_loc2_)
               {
                  if(_loc1_ == _loc3_)
                  {
                     _loc2_ = false;
                  }
               }
               else
               {
                  if(_loc1_._v0 == _loc3_._v2 && _loc1_._v1 == _loc3_._v1)
                  {
                     this._neighbour01[_loc1_] = _loc3_;
                     this._neighbour12[_loc3_] = _loc1_;
                  }
                  if(_loc1_._v0 == _loc3_._v0 && _loc1_._v1 == _loc3_._v2)
                  {
                     this._neighbour01[_loc1_] = _loc3_;
                     this._neighbour20[_loc3_] = _loc1_;
                  }
                  if(_loc1_._v0 == _loc3_._v1 && _loc1_._v1 == _loc3_._v0)
                  {
                     this._neighbour01[_loc1_] = _loc3_;
                     this._neighbour01[_loc3_] = _loc1_;
                  }
                  if(_loc1_._v1 == _loc3_._v2 && _loc1_._v2 == _loc3_._v1)
                  {
                     this._neighbour12[_loc1_] = _loc3_;
                     this._neighbour12[_loc3_] = _loc1_;
                  }
                  if(_loc1_._v1 == _loc3_._v0 && _loc1_._v2 == _loc3_._v2)
                  {
                     this._neighbour12[_loc1_] = _loc3_;
                     this._neighbour20[_loc3_] = _loc1_;
                  }
                  if(_loc1_._v1 == _loc3_._v1 && _loc1_._v2 == _loc3_._v0)
                  {
                     this._neighbour12[_loc1_] = _loc3_;
                     this._neighbour01[_loc3_] = _loc1_;
                  }
                  if(_loc1_._v2 == _loc3_._v2 && _loc1_._v0 == _loc3_._v1)
                  {
                     this._neighbour20[_loc1_] = _loc3_;
                     this._neighbour12[_loc3_] = _loc1_;
                  }
                  if(_loc1_._v2 == _loc3_._v0 && _loc1_._v0 == _loc3_._v2)
                  {
                     this._neighbour20[_loc1_] = _loc3_;
                     this._neighbour20[_loc3_] = _loc1_;
                  }
                  if(_loc1_._v2 == _loc3_._v1 && _loc1_._v0 == _loc3_._v0)
                  {
                     this._neighbour20[_loc1_] = _loc3_;
                     this._neighbour01[_loc3_] = _loc1_;
                  }
               }
            }
         }
         this._neighboursDirty = false;
      }
      
      public function splitFace(param1:Face, param2:int = 0) : void
      {
         var _loc9_:Vertex = null;
         var _loc10_:UV = null;
         var _loc3_:Vertex = param1.v0;
         var _loc4_:Vertex = param1.v1;
         var _loc5_:Vertex = param1.v2;
         var _loc6_:UV = param1.uv0;
         var _loc7_:UV = param1.uv1;
         var _loc8_:UV = param1.uv2;
         var _loc11_:ITriangleMaterial = param1.material;
         this.removeFace(param1);
         switch(param2)
         {
            case 0:
               _loc9_ = new Vertex((param1.v0.x + param1.v1.x) * 0.5,(param1.v0.y + param1.v1.y) * 0.5,(param1.v0.z + param1.v1.z) * 0.5);
               _loc10_ = new UV((_loc6_.u + _loc7_.u) * 0.5,(_loc6_.v + _loc7_.v) * 0.5);
               this.addFace(new Face(_loc9_,_loc4_,_loc5_,_loc11_,_loc10_,_loc7_,_loc8_));
               this.addFace(new Face(_loc3_,_loc9_,_loc5_,_loc11_,_loc6_,_loc10_,_loc8_));
               break;
            case 1:
               _loc9_ = new Vertex((param1.v1.x + param1.v2.x) * 0.5,(param1.v1.y + param1.v2.y) * 0.5,(param1.v1.z + param1.v2.z) * 0.5);
               _loc10_ = new UV((_loc7_.u + _loc8_.u) * 0.5,(_loc7_.v + _loc8_.v) * 0.5);
               this.addFace(new Face(_loc3_,_loc4_,_loc9_,_loc11_,_loc6_,_loc7_,_loc8_));
               this.addFace(new Face(_loc3_,_loc9_,_loc5_,_loc11_,_loc6_,_loc10_,_loc8_));
               break;
            default:
               _loc9_ = new Vertex((param1.v2.x + param1.v0.x) * 0.5,(param1.v2.y + param1.v0.y) * 0.5,(param1.v2.z + param1.v0.z) * 0.5);
               _loc10_ = new UV((_loc8_.u + _loc6_.u) * 0.5,(_loc8_.v + _loc6_.v) * 0.5);
               this.addFace(new Face(_loc3_,_loc4_,_loc9_,_loc11_,_loc6_,_loc7_,_loc10_));
               this.addFace(new Face(_loc9_,_loc4_,_loc5_,_loc11_,_loc10_,_loc7_,_loc8_));
         }
      }
      
      public function addFace(param1:Face) : void
      {
         this.addElement(param1);
         if(param1.material)
         {
            this.addMaterial(param1,param1.material);
         }
         this._vertfacesDirty = true;
         param1.v0.geometry = this;
         param1.v1.geometry = this;
         param1.v2.geometry = this;
         param1.addOnMappingChange(this.onFaceMappingChange);
         this._faces.push(param1);
      }
      
      private function onFaceMappingChange(param1:FaceEvent) : void
      {
         dispatchEvent(param1);
      }
      
      public function addOnMappingChange(param1:Function) : void
      {
         addEventListener(FaceEvent.MAPPING_CHANGED,param1,false,0,true);
      }
      
      public function triFace(param1:Face) : void
      {
         var _loc2_:Vertex = param1.v0;
         var _loc3_:Vertex = param1.v1;
         var _loc4_:Vertex = param1.v2;
         var _loc5_:Vertex = new Vertex((param1.v0.x + param1.v1.x + param1.v2.x) / 3,(param1.v0.y + param1.v1.y + param1.v2.y) / 3,(param1.v0.z + param1.v1.z + param1.v2.z) / 3);
         var _loc6_:UV = param1.uv0;
         var _loc7_:UV = param1.uv1;
         var _loc8_:UV = param1.uv2;
         var _loc9_:UV = new UV((_loc6_.u + _loc7_.u + _loc8_.u) / 3,(_loc6_.v + _loc7_.v + _loc8_.v) / 3);
         var _loc10_:ITriangleMaterial = param1.material;
         this.removeFace(param1);
         this.addFace(new Face(_loc2_,_loc3_,_loc5_,_loc10_,_loc6_,_loc7_,_loc9_));
         this.addFace(new Face(_loc5_,_loc3_,_loc4_,_loc10_,_loc9_,_loc7_,_loc8_));
         this.addFace(new Face(_loc2_,_loc5_,_loc4_,_loc10_,_loc6_,_loc9_,_loc8_));
      }
      
      private function cloneVertexPosition(param1:VertexPosition) : VertexPosition
      {
         var _loc2_:VertexPosition = new VertexPosition(this.cloneVertex(param1.vertex));
         _loc2_.x = param1.x;
         _loc2_.y = param1.y;
         _loc2_.z = param1.z;
         return _loc2_;
      }
      
      public function get faces() : Array
      {
         return this._faces;
      }
      
      public function splitFaces(param1:int = 0) : void
      {
         var _loc2_:Face = null;
         param1 = param1 < 0?0:param1 > 2?2:int(param1);
         for each(_loc2_ in this._faces.concat([]))
         {
            this.splitFace(_loc2_,param1);
         }
      }
      
      private function cloneUV(param1:UV) : UV
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:UV = this.cloneduvs[param1];
         if(_loc2_ == null)
         {
            _loc2_ = new UV(param1._u,param1._v);
            this.cloneduvs[param1] = _loc2_;
         }
         return _loc2_;
      }
      
      private function onElementVertexValueChange(param1:ElementEvent) : void
      {
         if(param1.element is Face)
         {
            (param1.element as Face).normalDirty = true;
         }
         this.notifyDimensionsChange();
      }
      
      public function applyPosition(param1:Number, param2:Number, param3:Number) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Vertex = null;
         for each(_loc7_ in this.vertices)
         {
            _loc4_ = _loc7_.x;
            _loc5_ = _loc7_.y;
            _loc6_ = _loc7_.z;
            _loc7_.setValue(_loc4_ - param1,_loc5_ - param2,_loc6_ - param3);
         }
      }
      
      function removeMaterial(param1:Element, param2:IMaterial) : void
      {
         if(this._materialData = this.materialDictionary[param2])
         {
            if((this._index = this._materialData.elements.indexOf(param1)) != -1)
            {
               this._materialData.elements.splice(this._index,1);
            }
            if(!this._materialData.elements.length)
            {
               delete this.materialDictionary[param2];
               param2.removeOnMaterialUpdate(this.onMaterialUpdate);
            }
         }
      }
      
      public function get segments() : Array
      {
         return this._segments;
      }
      
      public function triFaces() : void
      {
         var _loc1_:Face = null;
         for each(_loc1_ in this._faces.concat([]))
         {
            this.triFace(_loc1_);
         }
      }
      
      public function updateVertex(param1:Vertex, param2:Number, param3:Number, param4:Number, param5:Boolean = false) : void
      {
         param1.setValue(param2,param3,param4);
         if(param5)
         {
            this._vertnormalsDirty = true;
         }
      }
      
      private function removeElement(param1:Element) : void
      {
         this._verticesDirty = true;
         param1.removeOnVertexChange(this.onElementVertexChange);
         param1.removeOnVertexValueChange(this.onElementVertexValueChange);
         this.notifyDimensionsChange();
      }
      
      public function neighbour01(param1:Face) : Face
      {
         if(this._neighboursDirty)
         {
            this.findNeighbours();
         }
         return this._neighbour01[param1];
      }
      
      public function updateElements() : void
      {
         this._dispatchedDimensionsChange = false;
         if(this.vertexDirty)
         {
            this.notifyDimensionsChange();
         }
      }
      
      public function applyRotations(param1:Number, param2:Number, param3:Number) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc19_:Vertex = null;
         var _loc9_:Number = Math.PI / 180;
         var _loc10_:Number = param1 * _loc9_;
         var _loc11_:Number = param2 * _loc9_;
         var _loc12_:Number = param3 * _loc9_;
         var _loc13_:Number = Math.sin(_loc10_);
         var _loc14_:Number = Math.cos(_loc10_);
         var _loc15_:Number = Math.sin(_loc11_);
         var _loc16_:Number = Math.cos(_loc11_);
         var _loc17_:Number = Math.sin(_loc12_);
         var _loc18_:Number = Math.cos(_loc12_);
         for each(_loc19_ in this.vertices)
         {
            _loc4_ = _loc19_.x;
            _loc5_ = _loc19_.y;
            _loc6_ = _loc19_.z;
            _loc8_ = _loc5_;
            _loc5_ = _loc8_ * _loc14_ + _loc6_ * -_loc13_;
            _loc6_ = _loc8_ * _loc13_ + _loc6_ * _loc14_;
            _loc7_ = _loc4_;
            _loc4_ = _loc7_ * _loc16_ + _loc6_ * _loc15_;
            _loc6_ = _loc7_ * -_loc15_ + _loc6_ * _loc16_;
            _loc7_ = _loc4_;
            _loc4_ = _loc7_ * _loc18_ + _loc5_ * -_loc17_;
            _loc5_ = _loc7_ * _loc17_ + _loc5_ * _loc18_;
            this.updateVertex(_loc19_,_loc4_,_loc5_,_loc6_,false);
         }
      }
      
      function addMaterial(param1:Element, param2:IMaterial) : void
      {
         if(!(this._materialData = this.materialDictionary[param2]))
         {
            this._materialData = this.materialDictionary[param2] = new MaterialData();
            this._materialData.material = param2;
            param2.addOnMaterialUpdate(this.onMaterialUpdate);
         }
         if(this._materialData.elements.indexOf(param1) == -1)
         {
            this._materialData.elements.push(param1);
         }
      }
      
      public function get elements() : Array
      {
         return this._billboards.concat(this._faces,this._segments);
      }
      
      public function get vertices() : Array
      {
         var _loc1_:Dictionary = null;
         var _loc2_:Element = null;
         var _loc3_:Vertex = null;
         if(this._verticesDirty)
         {
            this._vertices = [];
            _loc1_ = new Dictionary();
            for each(_loc2_ in this.elements)
            {
               for each(_loc3_ in _loc2_.vertices)
               {
                  if(!_loc1_[_loc3_])
                  {
                     this._vertices.push(_loc3_);
                     _loc1_[_loc3_] = true;
                  }
               }
            }
            this._verticesDirty = false;
         }
         return this._vertices;
      }
      
      function getFacesByVertex(param1:Vertex) : Array
      {
         if(this._vertfacesDirty)
         {
            this.findVertFaces();
         }
         return this._vertfaces[param1];
      }
      
      public function neighbour12(param1:Face) : Face
      {
         if(this._neighboursDirty)
         {
            this.findNeighbours();
         }
         return this._neighbour12[param1];
      }
   }
}
