package away3d.containers
{
   import away3d.cameras.Camera3D;
   import away3d.core.base.Object3D;
   import away3d.core.base.UV;
   import away3d.core.clip.Clipping;
   import away3d.core.clip.RectangleClipping;
   import away3d.core.draw.DrawDisplayObject;
   import away3d.core.draw.DrawPrimitive;
   import away3d.core.draw.IPrimitiveConsumer;
   import away3d.core.draw.ScreenVertex;
   import away3d.core.math.MatrixAway3D;
   import away3d.core.project.MeshProjector;
   import away3d.core.project.ObjectContainerProjector;
   import away3d.core.render.AbstractRenderSession;
   import away3d.core.render.BasicRenderer;
   import away3d.core.render.BitmapRenderSession;
   import away3d.core.render.IRenderer;
   import away3d.core.render.SpriteRenderSession;
   import away3d.core.traverse.PrimitiveTraverser;
   import away3d.core.utils.CameraVarsStore;
   import away3d.core.utils.DrawPrimitiveStore;
   import away3d.core.utils.Init;
   import away3d.events.CameraEvent;
   import away3d.events.ClippingEvent;
   import away3d.events.MouseEvent3D;
   import away3d.events.Object3DEvent;
   import away3d.events.SessionEvent;
   import away3d.events.ViewEvent;
   import away3d.materials.IUVMaterial;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public class View3D extends Sprite
   {
       
      
      private var _loaderHeight:Number;
      
      private var _y:Number;
      
      private var _container:DisplayObject;
      
      private var _stageHeight:Number;
      
      private var _stageWidth:Number;
      
      private var _renderComplete:ViewEvent;
      
      private var _clipping:Clipping;
      
      private var _renderer:IRenderer;
      
      private var _ini:Init;
      
      private var material:IUVMaterial;
      
      private var _mouseIsOverView:Boolean;
      
      public var background:Sprite;
      
      private var _ddo:DrawDisplayObject;
      
      private var _cameraVarsStore:CameraVarsStore;
      
      var _objectContainerProjector:ObjectContainerProjector;
      
      private var persp:Number;
      
      private var _drawPrimitiveStore:DrawPrimitiveStore;
      
      private var object:Object3D;
      
      private var _camera:Camera3D;
      
      private var _mousedown:Boolean;
      
      private var _viewZero:Point;
      
      private var sceneY:Number;
      
      var _meshProjector:MeshProjector;
      
      private var sceneX:Number;
      
      public var sourceURL:String;
      
      private var _consumer:IPrimitiveConsumer;
      
      private var _session:AbstractRenderSession;
      
      private var _pritraverser:PrimitiveTraverser;
      
      private var sceneZ:Number;
      
      public var mouseZeroMove:Boolean;
      
      private var _screenClippingDirty:Boolean;
      
      public var mouseObject:Object3D;
      
      private var _cleared:Boolean;
      
      private var screenZ:Number = Infinity;
      
      private var screenX:Number;
      
      private var _updated:Boolean;
      
      private var screenY:Number;
      
      private var _scene:Scene3D;
      
      var _screenClipping:Clipping;
      
      public var forceUpdate:Boolean;
      
      private var uv:UV;
      
      private var _updatescene:ViewEvent;
      
      public var viewTimer:int;
      
      private var _loaderWidth:Number;
      
      private var _loaderDirty:Boolean;
      
      private var primitive:DrawPrimitive;
      
      private var drawpri:DrawPrimitive;
      
      private var _lastmove_mouseX:Number;
      
      private var _lastmove_mouseY:Number;
      
      var _interactiveLayer:Sprite;
      
      private var _sc:ScreenVertex;
      
      private var inv:MatrixAway3D;
      
      public var mouseMaterial:IUVMaterial;
      
      public var hud:Sprite;
      
      private var _x:Number;
      
      private var _internalsession:AbstractRenderSession;
      
      private var element:Object;
      
      public function View3D(param1:Object = null)
      {
         this._interactiveLayer = new Sprite();
         this._meshProjector = new MeshProjector();
         this._objectContainerProjector = new ObjectContainerProjector();
         this._viewZero = new Point();
         this._drawPrimitiveStore = new DrawPrimitiveStore();
         this._cameraVarsStore = new CameraVarsStore();
         this._pritraverser = new PrimitiveTraverser();
         this._ddo = new DrawDisplayObject();
         this._sc = new ScreenVertex();
         this.inv = new MatrixAway3D();
         this.background = new Sprite();
         this.hud = new Sprite();
         super();
         this._ini = Init.parse(param1) as Init;
         var _loc2_:Boolean = this._ini.getBoolean("stats",true);
         this.session = this._ini.getObject("session") as AbstractRenderSession || new SpriteRenderSession();
         this.scene = this._ini.getObjectOrInit("scene",Scene3D) as Scene3D || new Scene3D();
         this.camera = this._ini.getObjectOrInit("camera",Camera3D) as Camera3D || new Camera3D({
            "x":0,
            "y":0,
            "z":-1000,
            "lookat":"center"
         });
         this.renderer = this._ini.getObject("renderer") as IRenderer || new BasicRenderer();
         this.clipping = this._ini.getObject("clipping",Clipping) as Clipping || new RectangleClipping();
         x = this._ini.getNumber("x",0);
         y = this._ini.getNumber("y",0);
         this.forceUpdate = this._ini.getBoolean("forceUpdate",false);
         this.mouseZeroMove = this._ini.getBoolean("mouseZeroMove",false);
         this._interactiveLayer.blendMode = BlendMode.ALPHA;
         this._meshProjector.view = this;
         this._objectContainerProjector.view = this;
         this._drawPrimitiveStore.view = this;
         this._cameraVarsStore.view = this;
         this._pritraverser.view = this;
      }
      
      function dispatchMouseEvent(param1:MouseEvent3D) : void
      {
         if(!hasEventListener(param1.type))
         {
            return;
         }
         dispatchEvent(param1);
      }
      
      public function set scene(param1:Scene3D) : void
      {
         if(this._scene == param1)
         {
            return;
         }
         if(this._scene)
         {
            this._scene.internalRemoveView(this);
            delete this._scene.viewDictionary[this];
            this._scene.removeOnSessionChange(this.onSessionChange);
            if(this._session)
            {
               this._session.internalRemoveSceneSession(this._scene.ownSession);
            }
         }
         this._scene = param1;
         this._updated = true;
         if(this._scene)
         {
            this._scene.internalAddView(this);
            this._scene.addOnSessionChange(this.onSessionChange);
            this._scene.viewDictionary[this] = this;
            if(this._session)
            {
               this._session.internalAddSceneSession(this._scene.ownSession);
            }
            return;
         }
         throw new Error("View cannot have scene set to null");
      }
      
      public function get camera() : Camera3D
      {
         return this._camera;
      }
      
      public function set session(param1:AbstractRenderSession) : void
      {
         if(this._session == param1)
         {
            return;
         }
         if(this._session)
         {
            this._session.removeOnSessionUpdate(this.onSessionUpdate);
            if(this._scene)
            {
               this._session.internalRemoveSceneSession(this._scene.ownSession);
            }
         }
         this._session = param1;
         this._updated = true;
         if(this._session)
         {
            this._session.addOnSessionUpdate(this.onSessionUpdate);
            if(this._scene)
            {
               this._session.internalAddSceneSession(this._scene.ownSession);
            }
            while(numChildren)
            {
               removeChildAt(0);
            }
            addChild(this.background);
            addChild(this._session.getContainer(this));
            addChild(this._interactiveLayer);
            addChild(this.hud);
            return;
         }
         throw new Error("View cannot have session set to null");
      }
      
      private function onCameraUpdated(param1:CameraEvent) : void
      {
         this._updated = true;
      }
      
      private function onSessionChange(param1:Object3DEvent) : void
      {
         this._session.sessions = [param1.object.session];
      }
      
      public function set camera(param1:Camera3D) : void
      {
         if(this._camera == param1)
         {
            return;
         }
         if(this._camera)
         {
            this._camera.removeOnSceneTransformChange(this.onCameraTransformChange);
            this._camera.removeOnCameraUpdate(this.onCameraUpdated);
         }
         this._camera = param1;
         this._camera.view = this;
         this._updated = true;
         if(this._camera)
         {
            this._camera.addOnSceneTransformChange(this.onCameraTransformChange);
            this._camera.addOnCameraUpdate(this.onCameraUpdated);
            return;
         }
         throw new Error("View cannot have camera set to null");
      }
      
      private function onSessionUpdate(param1:SessionEvent) : void
      {
         if(param1.target is BitmapRenderSession)
         {
            this._scene.updatedSessions[param1.target] = param1.target;
         }
      }
      
      private function notifySceneUpdate() : void
      {
         if(!this._updatescene)
         {
            this._updatescene = new ViewEvent(ViewEvent.UPDATE_SCENE,this);
         }
         dispatchEvent(this._updatescene);
      }
      
      public function getBitmapData() : BitmapData
      {
         if(this._session is BitmapRenderSession)
         {
            return (this._session as BitmapRenderSession).getBitmapData(this);
         }
         throw new Error("incorrect session object - require BitmapRenderSession");
      }
      
      public function get screenClipping() : Clipping
      {
         if(this._screenClippingDirty)
         {
            this._screenClippingDirty = false;
            return this._screenClipping = this._clipping.screen(this,this._loaderWidth,this._loaderHeight);
         }
         return this._screenClipping;
      }
      
      public function get cameraVarsStore() : CameraVarsStore
      {
         return this._cameraVarsStore;
      }
      
      public function set clipping(param1:Clipping) : void
      {
         if(this._clipping == param1)
         {
            return;
         }
         if(this._clipping)
         {
            this._clipping.removeOnClippingUpdate(this.onClippingUpdated);
         }
         this._clipping = param1;
         this._clipping.view = this;
         if(this._clipping)
         {
            this._clipping.addOnClippingUpdate(this.onClippingUpdated);
            this._updated = true;
            this._screenClippingDirty = true;
            return;
         }
         throw new Error("View cannot have clip set to null");
      }
      
      public function set renderer(param1:IRenderer) : void
      {
         if(this._renderer == param1)
         {
            return;
         }
         this._renderer = param1;
         this._updated = true;
         if(!this._renderer)
         {
            throw new Error("View cannot have renderer set to null");
         }
      }
      
      public function get scene() : Scene3D
      {
         return this._scene;
      }
      
      public function clear() : void
      {
         this._updated = true;
         if(this._internalsession)
         {
            this.session.clear(this);
         }
      }
      
      public function get session() : AbstractRenderSession
      {
         return this._session;
      }
      
      public function updateScreenClipping() : void
      {
         try
         {
            this._loaderWidth = loaderInfo.width;
            this._loaderHeight = loaderInfo.height;
            if(this._loaderDirty)
            {
               this._loaderDirty = false;
               this._screenClippingDirty = true;
            }
         }
         catch(error:Error)
         {
            _loaderDirty = true;
            _loaderWidth = stage.stageWidth;
            _loaderHeight = stage.stageHeight;
         }
         this._viewZero.x = 0;
         this._viewZero.y = 0;
         this._viewZero = localToGlobal(this._viewZero);
         if(this._x != this._viewZero.x || this._y != this._viewZero.y || stage.scaleMode != StageScaleMode.NO_SCALE && (this._stageWidth != stage.stageWidth || this._stageHeight != stage.stageHeight))
         {
            this._x = this._viewZero.x;
            this._y = this._viewZero.y;
            this._stageWidth = stage.stageWidth;
            this._stageHeight = stage.stageHeight;
            this._screenClippingDirty = true;
         }
      }
      
      public function render() : void
      {
         this.viewTimer = getTimer();
         this.notifySceneUpdate();
         if(this._internalsession != this._session)
         {
            this._internalsession = this._session;
         }
         if(this._session.renderer != this._renderer as IPrimitiveConsumer)
         {
            this._session.renderer = this._renderer as IPrimitiveConsumer;
         }
         this._session.clear(this);
         this._drawPrimitiveStore.reset();
         if(this._session.updated)
         {
            if(this._scene.ownSession is SpriteRenderSession)
            {
               (this._scene.ownSession as SpriteRenderSession).cacheAsBitmap = true;
            }
            this._ddo.view = this;
            this._ddo.displayobject = this._scene.session.getContainer(this);
            this._ddo.session = this._session;
            this._ddo.screenvertex = this._sc;
            this._ddo.calc();
            this._consumer = this._session.getConsumer(this);
            this._consumer.primitive(this._ddo);
         }
         this._scene.traverse(this._pritraverser);
         this._session.render(this);
         this._updated = false;
         Init.checkUnusedArguments();
         this.notifyRenderComplete();
      }
      
      public function get drawPrimitiveStore() : DrawPrimitiveStore
      {
         return this._drawPrimitiveStore;
      }
      
      private function notifyRenderComplete() : void
      {
         if(!this._renderComplete)
         {
            this._renderComplete = new ViewEvent(ViewEvent.RENDER_COMPLETE,this);
         }
         dispatchEvent(this._renderComplete);
      }
      
      public function addSourceURL(param1:String) : void
      {
         this.sourceURL = param1;
      }
      
      private function onCameraTransformChange(param1:Object3DEvent) : void
      {
         this._updated = true;
      }
      
      private function onClippingUpdated(param1:ClippingEvent) : void
      {
         this._updated = true;
      }
      
      public function get updated() : Boolean
      {
         return this._updated;
      }
      
      public function get clipping() : Clipping
      {
         return this._clipping;
      }
      
      public function get renderer() : IRenderer
      {
         return this._renderer;
      }
      
      public function getContainer() : DisplayObject
      {
         return this._session.getContainer(this);
      }
      
      private function onStageResized(param1:Event) : void
      {
         this._screenClippingDirty = true;
      }
   }
}
