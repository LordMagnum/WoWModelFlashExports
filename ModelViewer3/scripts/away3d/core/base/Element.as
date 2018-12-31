package away3d.core.base
{
   import away3d.events.ElementEvent;
   import flash.events.EventDispatcher;
   
   public class Element extends EventDispatcher
   {
       
      
      public var vertexDirty:Boolean;
      
      public var extra:Object;
      
      private var _vertexchanged:ElementEvent;
      
      private var _visiblechanged:ElementEvent;
      
      private var _vertexvaluechanged:ElementEvent;
      
      public var parent:Geometry;
      
      var _visible:Boolean = true;
      
      public function Element()
      {
         super();
      }
      
      function notifyVisibleChange() : void
      {
         if(!hasEventListener(ElementEvent.VISIBLE_CHANGED))
         {
            return;
         }
         if(this._visiblechanged == null)
         {
            this._visiblechanged = new ElementEvent(ElementEvent.VISIBLE_CHANGED,this);
         }
         dispatchEvent(this._visiblechanged);
      }
      
      public function addOnVertexChange(param1:Function) : void
      {
         addEventListener(ElementEvent.VERTEX_CHANGED,param1,false,0,true);
      }
      
      public function get minX() : Number
      {
         return -Math.sqrt(this.radius2);
      }
      
      public function get minY() : Number
      {
         return -Math.sqrt(this.radius2);
      }
      
      public function get minZ() : Number
      {
         return -Math.sqrt(this.radius2);
      }
      
      public function addOnVisibleChange(param1:Function) : void
      {
         addEventListener(ElementEvent.VISIBLE_CHANGED,param1,false,0,true);
      }
      
      public function removeOnVertexChange(param1:Function) : void
      {
         removeEventListener(ElementEvent.VERTEX_CHANGED,param1,false);
      }
      
      function notifyVertexChange() : void
      {
         if(!hasEventListener(ElementEvent.VERTEX_CHANGED))
         {
            return;
         }
         if(this._vertexchanged == null)
         {
            this._vertexchanged = new ElementEvent(ElementEvent.VERTEX_CHANGED,this);
         }
         dispatchEvent(this._vertexchanged);
      }
      
      public function set visible(param1:Boolean) : void
      {
         if(param1 == this._visible)
         {
            return;
         }
         this._visible = param1;
         this.notifyVisibleChange();
      }
      
      public function get radius2() : Number
      {
         var _loc2_:Vertex = null;
         var _loc3_:Number = NaN;
         var _loc1_:Number = 0;
         for each(_loc2_ in this.vertices)
         {
            _loc3_ = _loc2_._x * _loc2_._x + _loc2_._y * _loc2_._y + _loc2_._z * _loc2_._z;
            if(_loc3_ > _loc1_)
            {
               _loc1_ = _loc3_;
            }
         }
         return _loc1_;
      }
      
      public function get visible() : Boolean
      {
         return this._visible;
      }
      
      public function get maxX() : Number
      {
         return Math.sqrt(this.radius2);
      }
      
      public function get maxY() : Number
      {
         return Math.sqrt(this.radius2);
      }
      
      public function get maxZ() : Number
      {
         return Math.sqrt(this.radius2);
      }
      
      public function get vertices() : Array
      {
         throw new Error("Not implemented");
      }
      
      public function removeOnVertexValueChange(param1:Function) : void
      {
         removeEventListener(ElementEvent.VERTEXVALUE_CHANGED,param1,false);
      }
      
      function notifyVertexValueChange() : void
      {
         if(!hasEventListener(ElementEvent.VERTEXVALUE_CHANGED))
         {
            return;
         }
         if(this._vertexvaluechanged == null)
         {
            this._vertexvaluechanged = new ElementEvent(ElementEvent.VERTEXVALUE_CHANGED,this);
         }
         dispatchEvent(this._vertexvaluechanged);
      }
      
      public function addOnVertexValueChange(param1:Function) : void
      {
         addEventListener(ElementEvent.VERTEXVALUE_CHANGED,param1,false,0,true);
      }
      
      public function removeOnVisibleChange(param1:Function) : void
      {
         removeEventListener(ElementEvent.VISIBLE_CHANGED,param1,false);
      }
   }
}
