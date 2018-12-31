package away3d.core.render
{
   import away3d.cameras.Camera3D;
   import away3d.containers.Scene3D;
   import away3d.containers.View3D;
   import away3d.core.base.Object3D;
   import away3d.core.clip.Clipping;
   import away3d.core.draw.DrawPrimitive;
   import away3d.core.draw.IPrimitiveConsumer;
   import away3d.core.draw.PrimitiveQuadrantTreeNode;
   import away3d.core.filter.IPrimitiveQuadrantFilter;
   
   public class QuadrantRenderer implements IPrimitiveConsumer, IRenderer
   {
       
      
      private var _view:View3D;
      
      private var _primitives:Array;
      
      private var _clippedPrimitives:Array;
      
      private var _scene:Scene3D;
      
      private var _filter:IPrimitiveQuadrantFilter;
      
      private var _child:DrawPrimitive;
      
      private var _blockers:Array;
      
      private var _minY:Number;
      
      private var _minX:Number;
      
      private var _except:Object3D;
      
      private var _result:Array;
      
      private var _root:PrimitiveQuadrantTreeNode;
      
      private var _camera:Camera3D;
      
      private var _maxX:Number;
      
      private var _maxY:Number;
      
      private var _children:Array;
      
      private var i:int;
      
      private var _screenClipping:Clipping;
      
      private var _center:Array;
      
      private var _qdrntfilters:Array;
      
      public function QuadrantRenderer(... rest)
      {
         super();
         this._qdrntfilters = rest;
      }
      
      public function remove(param1:DrawPrimitive) : void
      {
         this._center = param1.quadrant.center;
         this._center.splice(this._center.indexOf(param1),1);
      }
      
      private function getList(param1:PrimitiveQuadrantTreeNode) : void
      {
         if(param1.onlysourceFlag && this._except == param1.onlysource)
         {
            return;
         }
         if(this._minX < param1.xdiv)
         {
            if(param1.lefttopFlag && this._minY < param1.ydiv)
            {
               this.getList(param1.lefttop);
            }
            if(param1.leftbottomFlag && this._maxY > param1.ydiv)
            {
               this.getList(param1.leftbottom);
            }
         }
         if(this._maxX > param1.xdiv)
         {
            if(param1.righttopFlag && this._minY < param1.ydiv)
            {
               this.getList(param1.righttop);
            }
            if(param1.rightbottomFlag && this._maxY > param1.ydiv)
            {
               this.getList(param1.rightbottom);
            }
         }
         this._children = param1.center;
         if(this._children != null)
         {
            this.i = this._children.length;
            while(true)
            {
               if(!this.i--)
               {
                  break;
               }
               this._child = this._children[this.i];
               if((this._except == null || this._child.source != this._except) && this._child.maxX > this._minX && this._child.minX < this._maxX && this._child.maxY > this._minY && this._child.minY < this._maxY)
               {
                  this._result.push(this._child);
               }
            }
         }
      }
      
      public function list() : Array
      {
         this._result = [];
         this._minX = -1000000;
         this._minY = -1000000;
         this._maxX = 1000000;
         this._maxY = 1000000;
         this._except = null;
         this.getList(this._root);
         return this._result;
      }
      
      private function getParent(param1:PrimitiveQuadrantTreeNode = null) : void
      {
         param1 = param1.parent;
         if(param1 == null || param1.onlysourceFlag && this._except == param1.onlysource)
         {
            return;
         }
         this._children = param1.center;
         if(this._children != null)
         {
            this.i = this._children.length;
            while(true)
            {
               if(!this.i--)
               {
                  break;
               }
               this._child = this._children[this.i];
               if((this._except == null || this._child.source != this._except) && this._child.maxX > this._minX && this._child.minX < this._maxX && this._child.maxY > this._minY && this._child.minY < this._maxY)
               {
                  this._result.push(this._child);
               }
            }
         }
         this.getParent(param1);
      }
      
      public function clear(param1:View3D) : void
      {
         this._primitives = [];
         this._scene = param1.scene;
         this._camera = param1.camera;
         this._screenClipping = param1.screenClipping;
         if(!this._root)
         {
            this._root = new PrimitiveQuadrantTreeNode((this._screenClipping.minX + this._screenClipping.maxX) / 2,(this._screenClipping.minY + this._screenClipping.maxY) / 2,this._screenClipping.maxX - this._screenClipping.minX,this._screenClipping.maxY - this._screenClipping.minY,0);
         }
         else
         {
            this._root.reset((this._screenClipping.minX + this._screenClipping.maxX) / 2,(this._screenClipping.minY + this._screenClipping.maxY) / 2,this._screenClipping.maxX - this._screenClipping.minX,this._screenClipping.maxY - this._screenClipping.minY);
         }
      }
      
      public function render(param1:View3D) : void
      {
         for each(this._filter in this._qdrntfilters)
         {
            this._filter.filter(this,this._scene,this._camera,this._screenClipping);
         }
         this._root.render(-Infinity);
      }
      
      public function get(param1:DrawPrimitive, param2:Object3D = null) : Array
      {
         this._result = [];
         this._minX = param1.minX;
         this._minY = param1.minY;
         this._maxX = param1.maxX;
         this._maxY = param1.maxY;
         this._except = param2;
         this.getList(param1.quadrant);
         this.getParent(param1.quadrant);
         return this._result;
      }
      
      public function clone() : IPrimitiveConsumer
      {
         var _loc1_:QuadrantRenderer = new QuadrantRenderer();
         _loc1_.filters = this.filters;
         return _loc1_;
      }
      
      public function toString() : String
      {
         return "Quadrant [" + this._qdrntfilters.join("+") + "]";
      }
      
      public function primitive(param1:DrawPrimitive) : Boolean
      {
         if(!this._screenClipping.checkPrimitive(param1))
         {
            return false;
         }
         this._root.push(param1);
         return true;
      }
      
      public function set filters(param1:Array) : void
      {
         this._qdrntfilters = param1;
      }
      
      public function get filters() : Array
      {
         return this._qdrntfilters;
      }
   }
}
