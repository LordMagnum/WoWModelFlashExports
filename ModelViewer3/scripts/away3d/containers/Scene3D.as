package away3d.containers
{
   import away3d.core.base.Geometry;
   import away3d.core.base.Mesh;
   import away3d.core.base.Object3D;
   import away3d.core.math.MatrixAway3D;
   import away3d.core.traverse.ProjectionTraverser;
   import away3d.core.traverse.SessionTraverser;
   import away3d.core.traverse.TickTraverser;
   import away3d.core.utils.Debug;
   import away3d.events.ViewEvent;
   import §away3d:arcane§._sceneTransformDirty;
   import §away3d:arcane§._transformDirty;
   import §away3d:arcane§.notifySceneTransformChange;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class Scene3D extends ObjectContainer3D
   {
       
      
      private var _view:View3D;
      
      public var physics:IPhysicsScene;
      
      private var _sessiontraverser:SessionTraverser;
      
      private var _projtraverser:ProjectionTraverser;
      
      private var _mesh:Mesh;
      
      public var geometries:Dictionary;
      
      private var _geometry:Geometry;
      
      public var updatedObjects:Dictionary;
      
      public var viewDictionary:Dictionary;
      
      public var autoUpdate:Boolean;
      
      private var _key:Object;
      
      public var tickTraverser:TickTraverser;
      
      public var meshes:Dictionary;
      
      private var _viewArray:Array;
      
      private var _autoUpdate:Boolean;
      
      public var updatedSessions:Dictionary;
      
      private var _currentView:View3D;
      
      public function Scene3D(... rest)
      {
         var _loc2_:Object = null;
         var _loc4_:Object = null;
         var _loc6_:Object3D = null;
         this._projtraverser = new ProjectionTraverser();
         this._sessiontraverser = new SessionTraverser();
         this.viewDictionary = new Dictionary(true);
         this.tickTraverser = new TickTraverser();
         var _loc3_:Array = [];
         for each(_loc4_ in rest)
         {
            if(_loc4_ is Object3D)
            {
               _loc3_.push(_loc4_);
            }
            else
            {
               _loc2_ = _loc4_;
            }
         }
         if(_loc2_)
         {
            _loc2_.ownCanvas = true;
            _loc2_.ownLights = true;
         }
         else
         {
            _loc2_ = {
               "ownCanvas":true,
               "ownLights":true
            };
         }
         super(_loc2_);
         this.autoUpdate = ini.getBoolean("autoUpdate",true);
         var _loc5_:Object = ini.getObject("physics");
         if(_loc5_ is IPhysicsScene)
         {
            this.physics = _loc5_ as IPhysicsScene;
         }
         if(_loc5_ is Boolean)
         {
            if(_loc5_ == true)
            {
               this.physics = null;
            }
         }
         if(_loc5_ is Object)
         {
            this.physics = null;
         }
         for each(_loc6_ in _loc3_)
         {
            addChild(_loc6_);
         }
      }
      
      public function updateTime(param1:int = -1) : void
      {
         if(param1 == -1)
         {
            param1 = getTimer();
         }
         this.tickTraverser.now = param1;
         traverse(this.tickTraverser);
         if(this.physics != null)
         {
            this.physics.updateTime(param1);
         }
      }
      
      private function onUpdate(param1:ViewEvent) : void
      {
         if(this.autoUpdate)
         {
            if(this._currentView && this._currentView != param1.view)
            {
               Debug.warning("Multiple views detected! Should consider switching to manual update");
            }
            this._currentView = param1.view;
            this.update();
         }
      }
      
      public function update() : void
      {
         this.updatedObjects = new Dictionary(true);
         this.updatedSessions = new Dictionary(true);
         this.meshes = new Dictionary(true);
         this.geometries = new Dictionary(true);
         for each(this._view in this.viewDictionary)
         {
            this._view.camera.update();
            this._view.cameraVarsStore.reset();
            this._projtraverser.view = this._view;
            traverse(this._projtraverser);
         }
         for(this._key in this.meshes)
         {
            this._mesh = this._key as Mesh;
            this._viewArray = this.meshes[this._mesh];
            for each(this._view in this._viewArray)
            {
               this._mesh.updateMaterials(this._mesh,this._view);
            }
         }
         for each(this._geometry in this.geometries)
         {
            this._geometry.updateElements();
         }
         traverse(this._sessiontraverser);
      }
      
      function internalRemoveView(param1:View3D) : void
      {
         param1.removeEventListener(ViewEvent.UPDATE_SCENE,this.onUpdate);
      }
      
      function internalAddView(param1:View3D) : void
      {
         param1.addEventListener(ViewEvent.UPDATE_SCENE,this.onUpdate);
      }
      
      override public function get sceneTransform() : MatrixAway3D
      {
         if(_transformDirty)
         {
            _sceneTransformDirty = true;
         }
         if(_sceneTransformDirty)
         {
            notifySceneTransformChange();
         }
         return transform;
      }
   }
}
