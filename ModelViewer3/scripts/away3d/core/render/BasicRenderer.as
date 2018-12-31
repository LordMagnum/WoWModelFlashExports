package away3d.core.render
{
   import away3d.cameras.Camera3D;
   import away3d.containers.Scene3D;
   import away3d.containers.View3D;
   import away3d.core.clip.Clipping;
   import away3d.core.draw.DrawPrimitive;
   import away3d.core.draw.IPrimitiveConsumer;
   import away3d.core.filter.IPrimitiveFilter;
   import away3d.core.filter.ZSortFilter;
   
   public class BasicRenderer implements IRenderer, IPrimitiveConsumer
   {
       
      
      private var _camera:Camera3D;
      
      private var _view:View3D;
      
      private var _primitives:Array;
      
      private var _scene:Scene3D;
      
      private var _filter:IPrimitiveFilter;
      
      private var _primitive:DrawPrimitive;
      
      private var _screenClipping:Clipping;
      
      private var _filters:Array;
      
      public function BasicRenderer(... rest)
      {
         this._primitives = [];
         super();
         this._filters = rest;
         this._filters.push(new ZSortFilter());
      }
      
      public function clear(param1:View3D) : void
      {
         this._primitives = [];
         this._scene = param1.scene;
         this._camera = param1.camera;
         this._screenClipping = param1.screenClipping;
      }
      
      public function render(param1:View3D) : void
      {
         for each(this._filter in this._filters)
         {
            this._primitives = this._filter.filter(this._primitives,this._scene,this._camera,this._screenClipping);
         }
         for each(this._primitive in this._primitives)
         {
            this._primitive.render();
         }
      }
      
      public function clone() : IPrimitiveConsumer
      {
         var _loc1_:BasicRenderer = new BasicRenderer();
         _loc1_.filters = this.filters;
         return _loc1_;
      }
      
      public function list() : Array
      {
         return this._primitives;
      }
      
      public function primitive(param1:DrawPrimitive) : Boolean
      {
         if(!this._screenClipping.checkPrimitive(param1))
         {
            return false;
         }
         this._primitives.push(param1);
         return true;
      }
      
      public function toString() : String
      {
         return "Basic [" + this._filters.join("+") + "]";
      }
      
      public function set filters(param1:Array) : void
      {
         this._filters = param1;
         this._filters.push(new ZSortFilter());
      }
      
      public function get filters() : Array
      {
         return this._filters.slice(0,this._filters.length - 1);
      }
   }
}
