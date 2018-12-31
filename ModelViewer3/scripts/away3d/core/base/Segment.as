package away3d.core.base
{
   import away3d.events.SegmentEvent;
   import away3d.materials.ISegmentMaterial;
   import §away3d:arcane§.notifyVertexChange;
   import §away3d:arcane§.notifyVertexValueChange;
   import flash.events.Event;
   
   public class Segment extends Element
   {
       
      
      var _material:ISegmentMaterial;
      
      var _v0:Vertex;
      
      var _v1:Vertex;
      
      private var _materialchanged:SegmentEvent;
      
      public function Segment(param1:Vertex, param2:Vertex, param3:ISegmentMaterial = null)
      {
         super();
         this.v0 = param1;
         this.v1 = param2;
         this.material = param3;
         vertexDirty = true;
      }
      
      override public function get minY() : Number
      {
         if(this._v0._y < this._v1._y)
         {
            return this._v0._y;
         }
         return this._v1._y;
      }
      
      override public function get minZ() : Number
      {
         if(this._v0._z < this._v1._z)
         {
            return this._v0._z;
         }
         return this._v1._z;
      }
      
      override public function get minX() : Number
      {
         if(this._v0._x < this._v1._x)
         {
            return this._v0._x;
         }
         return this._v1._x;
      }
      
      public function set material(param1:ISegmentMaterial) : void
      {
         if(param1 == this._material)
         {
            return;
         }
         this._material = param1;
         this.notifyMaterialChange();
      }
      
      public function set v0(param1:Vertex) : void
      {
         if(param1 == this._v0)
         {
            return;
         }
         if(this._v0 != null)
         {
            if(this._v0 != this._v1)
            {
               this._v0.removeOnChange(this.onVertexValueChange);
            }
         }
         this._v0 = param1;
         if(this._v0 != null)
         {
            if(this._v0 != this._v1)
            {
               this._v0.addOnChange(this.onVertexValueChange);
            }
         }
         notifyVertexChange();
      }
      
      private function onVertexValueChange(param1:Event) : void
      {
         notifyVertexValueChange();
      }
      
      function notifyMaterialChange() : void
      {
         if(!hasEventListener(SegmentEvent.MATERIAL_CHANGED))
         {
            return;
         }
         if(this._materialchanged == null)
         {
            this._materialchanged = new SegmentEvent(SegmentEvent.MATERIAL_CHANGED,this);
         }
         dispatchEvent(this._materialchanged);
      }
      
      public function removeOnMaterialChange(param1:Function) : void
      {
         removeEventListener(SegmentEvent.MATERIAL_CHANGED,param1,false);
      }
      
      public function get material() : ISegmentMaterial
      {
         return this._material;
      }
      
      override public function get radius2() : Number
      {
         var _loc1_:Number = this._v0._x * this._v0._x + this._v0._y * this._v0._y + this._v0._z * this._v0._z;
         var _loc2_:Number = this._v1._x * this._v1._x + this._v1._y * this._v1._y + this._v1._z * this._v1._z;
         if(_loc1_ > _loc2_)
         {
            return _loc1_;
         }
         return _loc2_;
      }
      
      override public function get maxX() : Number
      {
         if(this._v0._x > this._v1._x)
         {
            return this._v0._x;
         }
         return this._v1._x;
      }
      
      override public function get maxY() : Number
      {
         if(this._v0._y > this._v1._y)
         {
            return this._v0._y;
         }
         return this._v1._y;
      }
      
      public function set v1(param1:Vertex) : void
      {
         if(param1 == this._v1)
         {
            return;
         }
         if(this._v1 != null)
         {
            if(this._v1 != this._v0)
            {
               this._v1.removeOnChange(this.onVertexValueChange);
            }
         }
         this._v1 = param1;
         if(this._v1 != null)
         {
            if(this._v1 != this._v0)
            {
               this._v1.addOnChange(this.onVertexValueChange);
            }
         }
         notifyVertexChange();
      }
      
      public function addOnMaterialChange(param1:Function) : void
      {
         addEventListener(SegmentEvent.MATERIAL_CHANGED,param1,false,0,true);
      }
      
      override public function get vertices() : Array
      {
         return [this._v0,this._v1];
      }
      
      public function get v0() : Vertex
      {
         return this._v0;
      }
      
      public function get v1() : Vertex
      {
         return this._v1;
      }
      
      override public function get maxZ() : Number
      {
         if(this._v0._z > this._v1._z)
         {
            return this._v0._z;
         }
         return this._v1._z;
      }
   }
}
