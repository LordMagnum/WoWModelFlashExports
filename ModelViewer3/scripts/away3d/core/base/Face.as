package away3d.core.base
{
   import away3d.core.math.Number3D;
   import away3d.core.utils.FaceVO;
   import away3d.events.FaceEvent;
   import away3d.materials.ITriangleMaterial;
   import §away3d:arcane§.notifyVertexChange;
   import flash.events.Event;
   
   public class Face extends Element
   {
       
      
      var _uv2:UV;
      
      private var _s:Number;
      
      var _material:ITriangleMaterial;
      
      private var _normal:Number3D;
      
      var _v0:Vertex;
      
      var _v1:Vertex;
      
      var _v2:Vertex;
      
      private var _mappingchanged:FaceEvent;
      
      var _back:ITriangleMaterial;
      
      private var _index:int;
      
      public var faceVO:FaceVO;
      
      private var _a:Number;
      
      private var _b:Number;
      
      private var _c:Number;
      
      private var _materialchanged:FaceEvent;
      
      var _uv0:UV;
      
      var _uv1:UV;
      
      public function Face(param1:Vertex, param2:Vertex, param3:Vertex, param4:ITriangleMaterial = null, param5:UV = null, param6:UV = null, param7:UV = null)
      {
         this._normal = new Number3D();
         this.faceVO = new FaceVO();
         super();
         this.v0 = param1;
         this.v1 = param2;
         this.v2 = param3;
         this.material = param4;
         this.uv0 = param5;
         this.uv1 = param6;
         this.uv2 = param7;
         this.faceVO.face = this;
         vertexDirty = true;
      }
      
      public function set uv1(param1:UV) : void
      {
         if(param1 == this._uv1)
         {
            return;
         }
         if(this._uv1 != null)
         {
            if(this._uv1 != this._uv0 && this._uv1 != this._uv2)
            {
               this._uv1.removeOnChange(this.onUVChange);
            }
         }
         this._uv1 = this.faceVO.uv1 = param1;
         if(this._uv1 != null)
         {
            if(this._uv1 != this._uv0 && this._uv1 != this._uv2)
            {
               this._uv1.addOnChange(this.onUVChange);
            }
         }
         this.notifyMappingChange();
      }
      
      public function set uv2(param1:UV) : void
      {
         if(param1 == this._uv2)
         {
            return;
         }
         if(this._uv2 != null)
         {
            if(this._uv2 != this._uv1 && this._uv2 != this._uv0)
            {
               this._uv2.removeOnChange(this.onUVChange);
            }
         }
         this._uv2 = this.faceVO.uv2 = param1;
         if(this._uv2 != null)
         {
            if(this._uv2 != this._uv1 && this._uv2 != this._uv0)
            {
               this._uv2.addOnChange(this.onUVChange);
            }
         }
         this.notifyMappingChange();
      }
      
      private function onUVChange(param1:Event) : void
      {
         this.notifyMappingChange();
      }
      
      public function get area() : Number
      {
         this._a = this.v0.position.distance(this.v1.position);
         this._b = this.v1.position.distance(this.v2.position);
         this._c = this.v2.position.distance(this.v0.position);
         this._s = (this._a + this._b + this._c) / 2;
         return Math.sqrt(this._s * (this._s - this._a) * (this._s - this._b) * (this._s - this._c));
      }
      
      override public function get maxX() : Number
      {
         if(this._v0._x > this._v1._x)
         {
            if(this._v0._x > this._v2._x)
            {
               return this._v0._x;
            }
            return this._v2._x;
         }
         if(this._v1._x > this._v2._x)
         {
            return this._v1._x;
         }
         return this._v2._x;
      }
      
      public function addOnMappingChange(param1:Function) : void
      {
         addEventListener(FaceEvent.MAPPING_CHANGED,param1,false,0,true);
      }
      
      public function get material() : ITriangleMaterial
      {
         return this._material;
      }
      
      public function get uv0() : UV
      {
         return this._uv0;
      }
      
      public function get uv1() : UV
      {
         return this._uv1;
      }
      
      public function get uv2() : UV
      {
         return this._uv2;
      }
      
      override public function get radius2() : Number
      {
         var _loc1_:Number = this._v0._x * this._v0._x + this._v0._y * this._v0._y + this._v0._z * this._v0._z;
         var _loc2_:Number = this._v1._x * this._v1._x + this._v1._y * this._v1._y + this._v1._z * this._v1._z;
         var _loc3_:Number = this._v2._x * this._v2._x + this._v2._y * this._v2._y + this._v2._z * this._v2._z;
         if(_loc1_ > _loc2_)
         {
            if(_loc1_ > _loc3_)
            {
               return _loc1_;
            }
            return _loc3_;
         }
         if(_loc2_ > _loc3_)
         {
            return _loc2_;
         }
         return _loc3_;
      }
      
      override public function get minY() : Number
      {
         if(this._v0._y < this._v1._y)
         {
            if(this._v0._y < this._v2._y)
            {
               return this._v0._y;
            }
            return this._v2._y;
         }
         if(this._v1._y < this._v2._y)
         {
            return this._v1._y;
         }
         return this._v2._y;
      }
      
      public function set back(param1:ITriangleMaterial) : void
      {
         if(param1 == this._back)
         {
            return;
         }
         if(this._back != null)
         {
            parent.removeMaterial(this,this._back);
         }
         this._back = this.faceVO.back = param1;
         if(this._back != null)
         {
            parent.addMaterial(this,this._back);
         }
         this.notifyMappingChange();
      }
      
      override public function get minZ() : Number
      {
         if(this._v0._z < this._v1._z)
         {
            if(this._v0._z < this._v2._z)
            {
               return this._v0._z;
            }
            return this._v2._z;
         }
         if(this._v1._z < this._v2._z)
         {
            return this._v1._z;
         }
         return this._v2._z;
      }
      
      public function set material(param1:ITriangleMaterial) : void
      {
         if(param1 == this._material)
         {
            return;
         }
         if(this._material != null && parent)
         {
            parent.removeMaterial(this,this._material);
         }
         this._material = this.faceVO.material = param1;
         if(this._material != null && parent)
         {
            parent.addMaterial(this,this._material);
         }
         this.notifyMappingChange();
      }
      
      public function removeOnMappingChange(param1:Function) : void
      {
         removeEventListener(FaceEvent.MAPPING_CHANGED,param1,false);
      }
      
      function notifyMappingChange() : void
      {
         if(!hasEventListener(FaceEvent.MAPPING_CHANGED))
         {
            return;
         }
         if(this._mappingchanged == null)
         {
            this._mappingchanged = new FaceEvent(FaceEvent.MAPPING_CHANGED,this);
         }
         dispatchEvent(this._mappingchanged);
      }
      
      public function set normalDirty(param1:Boolean) : void
      {
         vertexDirty = true;
      }
      
      public function set uv0(param1:UV) : void
      {
         if(param1 == this._uv0)
         {
            return;
         }
         if(this._uv0 != null)
         {
            if(this._uv0 != this._uv1 && this._uv0 != this._uv2)
            {
               this._uv0.removeOnChange(this.onUVChange);
            }
         }
         this._uv0 = this.faceVO.uv0 = param1;
         if(this._uv0 != null)
         {
            if(this._uv0 != this._uv1 && this._uv0 != this._uv2)
            {
               this._uv0.addOnChange(this.onUVChange);
            }
         }
         this.notifyMappingChange();
      }
      
      public function invert() : void
      {
         var _loc1_:Vertex = this._v1;
         var _loc2_:Vertex = this._v2;
         var _loc3_:UV = this._uv1;
         var _loc4_:UV = this._uv2;
         this._v1 = _loc2_;
         this._v2 = _loc1_;
         this._uv1 = _loc4_;
         this._uv2 = _loc3_;
         notifyVertexChange();
         this.notifyMappingChange();
      }
      
      public function get back() : ITriangleMaterial
      {
         return this._back;
      }
      
      private function updateVertexProperties() : void
      {
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         vertexDirty = false;
         var _loc1_:Number = this._v1.x - this._v0.x;
         var _loc2_:Number = this._v1.y - this._v0.y;
         var _loc3_:Number = this._v1.z - this._v0.z;
         var _loc4_:Number = this._v2.x - this._v0.x;
         var _loc5_:Number = this._v2.y - this._v0.y;
         var _loc6_:Number = this._v2.z - this._v0.z;
         var _loc7_:Number = _loc2_ * _loc6_ - _loc3_ * _loc5_;
         var _loc8_:Number = _loc3_ * _loc4_ - _loc1_ * _loc6_;
         _loc9_ = _loc1_ * _loc5_ - _loc2_ * _loc4_;
         _loc10_ = Math.sqrt(_loc7_ * _loc7_ + _loc8_ * _loc8_ + _loc9_ * _loc9_);
         this._normal.x = _loc7_ / _loc10_;
         this._normal.y = _loc8_ / _loc10_;
         this._normal.z = _loc9_ / _loc10_;
      }
      
      public function get uvs() : Array
      {
         return [this._uv0,this._uv1,this._uv2];
      }
      
      override public function get minX() : Number
      {
         if(this._v0._x < this._v1._x)
         {
            if(this._v0._x < this._v2._x)
            {
               return this._v0._x;
            }
            return this._v2._x;
         }
         if(this._v1._x < this._v2._x)
         {
            return this._v1._x;
         }
         return this._v2._x;
      }
      
      public function set v0(param1:Vertex) : void
      {
         if(this._v0 == param1)
         {
            return;
         }
         if(this._v0)
         {
            this._index = this._v0.parents.indexOf(this);
            if(this._index != -1)
            {
               this._v0.parents.splice(this._index,1);
            }
         }
         this._v0 = this.faceVO.v0 = param1;
         if(this._v0)
         {
            this._v0.parents.push(this);
         }
         vertexDirty = true;
      }
      
      override public function get maxY() : Number
      {
         if(this._v0._y > this._v1._y)
         {
            if(this._v0._y > this._v2._y)
            {
               return this._v0._y;
            }
            return this._v2._y;
         }
         if(this._v1._y > this._v2._y)
         {
            return this._v1._y;
         }
         return this._v2._y;
      }
      
      public function set v1(param1:Vertex) : void
      {
         if(this._v1 == param1)
         {
            return;
         }
         if(this._v1)
         {
            this._index = this._v1.parents.indexOf(this);
            if(this._index != -1)
            {
               this._v1.parents.splice(this._index,1);
            }
         }
         this._v1 = this.faceVO.v1 = param1;
         if(this._v1)
         {
            this._v1.parents.push(this);
         }
         vertexDirty = true;
      }
      
      public function set v2(param1:Vertex) : void
      {
         if(this._v2 == param1)
         {
            return;
         }
         if(this._v2)
         {
            this._index = this._v2.parents.indexOf(this);
            if(this._index != -1)
            {
               this._v2.parents.splice(this._index,1);
            }
         }
         this._v2 = this.faceVO.v2 = param1;
         if(this._v2)
         {
            this._v2.parents.push(this);
         }
         vertexDirty = true;
      }
      
      override public function get vertices() : Array
      {
         return [this._v0,this._v1,this._v2];
      }
      
      public function get v0() : Vertex
      {
         return this._v0;
      }
      
      public function get v1() : Vertex
      {
         return this._v1;
      }
      
      public function get v2() : Vertex
      {
         return this._v2;
      }
      
      override public function get maxZ() : Number
      {
         if(this._v0._z > this._v1._z)
         {
            if(this._v0._z > this._v2._z)
            {
               return this._v0._z;
            }
            return this._v2._z;
         }
         if(this._v1._z > this._v2._z)
         {
            return this._v1._z;
         }
         return this._v2._z;
      }
      
      public function get normal() : Number3D
      {
         if(vertexDirty)
         {
            this.updateVertexProperties();
         }
         return this._normal;
      }
   }
}
