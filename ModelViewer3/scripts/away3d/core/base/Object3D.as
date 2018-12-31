package away3d.core.base
{
   import away3d.containers.ObjectContainer3D;
   import away3d.containers.Scene3D;
   import away3d.core.draw.IPrimitiveConsumer;
   import away3d.core.math.MatrixAway3D;
   import away3d.core.math.Number3D;
   import away3d.core.math.Quaternion;
   import away3d.core.render.AbstractRenderSession;
   import away3d.core.render.BitmapRenderSession;
   import away3d.core.render.SpriteRenderSession;
   import away3d.core.traverse.Traverser;
   import away3d.core.utils.Debug;
   import away3d.core.utils.IClonable;
   import away3d.core.utils.Init;
   import away3d.events.MouseEvent3D;
   import away3d.events.Object3DEvent;
   import away3d.events.SessionEvent;
   import away3d.loaders.utils.GeometryLibrary;
   import away3d.loaders.utils.MaterialLibrary;
   import flash.display.BlendMode;
   import flash.events.EventDispatcher;
   
   public class Object3D extends EventDispatcher implements IClonable
   {
      
      private static var toDEGREES:Number = 180 / Math.PI;
      
      private static var toRADIANS:Number = Math.PI / 180;
       
      
      var _boundingScale:Number = 1;
      
      protected var _pivotPoint:Number3D;
      
      public var extra:Object;
      
      var _objectDirty:Boolean;
      
      private var _blendMode:String;
      
      public var projectorType:String;
      
      private var _renderer:IPrimitiveConsumer;
      
      private var _oldscene:Scene3D;
      
      private var _transformchanged:Object3DEvent;
      
      private var _dispatchedDimensionsChange:Boolean;
      
      private var _zAxis:Number3D;
      
      var _maxX:Number = 0;
      
      var _maxY:Number = 0;
      
      var _maxZ:Number = 0;
      
      var _sceneTransform:MatrixAway3D;
      
      private var _vector:Number3D;
      
      public var center:Vertex;
      
      private var _alpha:Number;
      
      private var _scenechanged:Object3DEvent;
      
      private var _pivotZero:Boolean;
      
      public var name:String;
      
      var _sceneTransformDirty:Boolean;
      
      var _mouseEnabled:Boolean = true;
      
      private var _filters:Array;
      
      private var _quaternion:Quaternion;
      
      var _sessionDirty:Boolean;
      
      private var _yAxis:Number3D;
      
      private var _parentupdated:Object3DEvent;
      
      public var mouseEnabled:Boolean = true;
      
      private var _rotationDirty:Boolean;
      
      private var _ownCanvas:Boolean;
      
      public var pushback:Boolean;
      
      private var _rot:Number3D;
      
      var _rotationX:Number = 0;
      
      var _rotationY:Number = 0;
      
      var _rotationZ:Number = 0;
      
      var _minX:Number = 0;
      
      var _minY:Number = 0;
      
      var _minZ:Number = 0;
      
      private var _visible:Boolean;
      
      private var _xAxis:Number3D;
      
      private var _eulers:Number3D;
      
      public var pushfront:Boolean;
      
      var _localTransformDirty:Boolean;
      
      private var _scenetransformchanged:Object3DEvent;
      
      var _session:AbstractRenderSession;
      
      private var _sca:Number3D;
      
      var _lookingAtTarget:Number3D;
      
      var _scaleX:Number = 1;
      
      var _scaleY:Number = 1;
      
      var _scaleZ:Number = 1;
      
      var _boundingRadius:Number = 0;
      
      private var _sessionchanged:Object3DEvent;
      
      private var _sessionupdated:Object3DEvent;
      
      var _scene:Scene3D;
      
      public var materialLibrary:MaterialLibrary;
      
      public var inverseSceneTransform:MatrixAway3D;
      
      private var _parentradius:Number3D;
      
      public var screenZOffset:Number;
      
      public var useHandCursor:Boolean = false;
      
      private var _ownLights:Boolean;
      
      var _dimensionsDirty:Boolean = false;
      
      private var _dimensionschanged:Object3DEvent;
      
      private var _parent:ObjectContainer3D;
      
      private var _ownSession:AbstractRenderSession;
      
      public var debugbb:Boolean;
      
      private var _scenePivotPoint:Number3D;
      
      protected var ini:Init;
      
      var _transformDirty:Boolean;
      
      public var geometryLibrary:GeometryLibrary;
      
      public var debugbs:Boolean;
      
      var _transform:MatrixAway3D;
      
      private var _m:MatrixAway3D;
      
      private var _lightsDirty:Boolean;
      
      public function Object3D(param1:Object = null)
      {
         this._transform = new MatrixAway3D();
         this._sceneTransform = new MatrixAway3D();
         this._lookingAtTarget = new Number3D();
         this._eulers = new Number3D();
         this._pivotPoint = new Number3D();
         this._scenePivotPoint = new Number3D();
         this._parentradius = new Number3D();
         this._quaternion = new Quaternion();
         this._rot = new Number3D();
         this._sca = new Number3D();
         this._vector = new Number3D();
         this._m = new MatrixAway3D();
         this._xAxis = new Number3D();
         this._yAxis = new Number3D();
         this._zAxis = new Number3D();
         this.inverseSceneTransform = new MatrixAway3D();
         this.center = new Vertex();
         super();
         this.ini = Init.parse(param1);
         this.name = this.ini.getString("name",this.name);
         this.ownSession = this.ini.getObject("ownSession",AbstractRenderSession) as AbstractRenderSession;
         this.ownCanvas = this.ini.getBoolean("ownCanvas",this.ownCanvas);
         this.ownLights = this.ini.getBoolean("ownLights",false);
         this.visible = this.ini.getBoolean("visible",true);
         this.mouseEnabled = this.ini.getBoolean("mouseEnabled",this.mouseEnabled);
         this.useHandCursor = this.ini.getBoolean("useHandCursor",this.useHandCursor);
         this.renderer = this.ini.getObject("renderer",IPrimitiveConsumer) as IPrimitiveConsumer;
         this.filters = this.ini.getArray("filters");
         this.alpha = this.ini.getNumber("alpha",1);
         this.blendMode = this.ini.getString("blendMode",BlendMode.NORMAL);
         this.debugbb = this.ini.getBoolean("debugbb",false);
         this.debugbs = this.ini.getBoolean("debugbs",false);
         this.pushback = this.ini.getBoolean("pushback",false);
         this.pushfront = this.ini.getBoolean("pushfront",false);
         this.screenZOffset = this.ini.getNumber("screenZOffset",0);
         this.x = this.ini.getNumber("x",0);
         this.y = this.ini.getNumber("y",0);
         this.z = this.ini.getNumber("z",0);
         this.rotationX = this.ini.getNumber("rotationX",0);
         this.rotationY = this.ini.getNumber("rotationY",0);
         this.rotationZ = this.ini.getNumber("rotationZ",0);
         this.pivotPoint = this.ini.getNumber3D("pivotPoint") || new Number3D();
         this.extra = this.ini.getObject("extra");
         if(this is Scene3D)
         {
            this._scene = this as Scene3D;
         }
         else
         {
            this.parent = this.ini.getObject3D("parent") as ObjectContainer3D;
         }
      }
      
      public function get pivotZero() : Boolean
      {
         return this._pivotZero;
      }
      
      public function moveDown(param1:Number) : void
      {
         this.translate(Number3D.DOWN,param1);
      }
      
      public function get scenePivotPoint() : Number3D
      {
         if(this._sceneTransformDirty)
         {
            this.updateSceneTransform();
         }
         return this._scenePivotPoint;
      }
      
      public function get eulers() : Number3D
      {
         if(this._rotationDirty)
         {
            this.updateRotation();
         }
         this._eulers.x = this._rotationX * toDEGREES;
         this._eulers.y = this._rotationY * toDEGREES;
         this._eulers.z = this._rotationZ * toDEGREES;
         return this._eulers;
      }
      
      private function onParentSceneChange(param1:Object3DEvent) : void
      {
         if(this._scene == this._parent.scene)
         {
            return;
         }
         this._scene = this._parent.scene;
         this.notifySceneChange();
      }
      
      function notifySessionUpdate() : void
      {
         if(this._scene)
         {
            this._scene.updatedSessions[this._session] = this._session;
         }
         if(!hasEventListener(Object3DEvent.SESSION_UPDATED))
         {
            return;
         }
         if(!this._sessionupdated)
         {
            this._sessionupdated = new Object3DEvent(Object3DEvent.SESSION_UPDATED,this);
         }
         dispatchEvent(this._sessionupdated);
      }
      
      public function get ownSession() : AbstractRenderSession
      {
         return this._ownSession;
      }
      
      public function removeOnTransformChange(param1:Function) : void
      {
         removeEventListener(Object3DEvent.TRANSFORM_CHANGED,param1,false);
      }
      
      public function moveTo(param1:Number, param2:Number, param3:Number) : void
      {
         if(this._transform.tx == param1 && this._transform.ty == param2 && this._transform.tz == param3)
         {
            return;
         }
         this._transform.tx = param1;
         this._transform.ty = param2;
         this._transform.tz = param3;
         this._localTransformDirty = true;
         this._sceneTransformDirty = true;
      }
      
      public function get sceneTransform() : MatrixAway3D
      {
         if(this._scene == null || this._scene == this)
         {
            if(this._transformDirty)
            {
               this._sceneTransformDirty = true;
            }
            if(this._sceneTransformDirty)
            {
               this.notifySceneTransformChange();
            }
            return this.transform;
         }
         if(this._transformDirty)
         {
            this.updateTransform();
         }
         if(this._sceneTransformDirty)
         {
            this.updateSceneTransform();
         }
         if(this._localTransformDirty)
         {
            this.notifyTransformChange();
         }
         return this._sceneTransform;
      }
      
      public function get minX() : Number
      {
         if(this._dimensionsDirty)
         {
            this.updateDimensions();
         }
         return this._minX;
      }
      
      public function get minY() : Number
      {
         if(this._dimensionsDirty)
         {
            this.updateDimensions();
         }
         return this._minY;
      }
      
      public function removeOnSceneTransformChange(param1:Function) : void
      {
         removeEventListener(Object3DEvent.SCENETRANSFORM_CHANGED,param1,false);
      }
      
      public function get minZ() : Number
      {
         if(this._dimensionsDirty)
         {
            this.updateDimensions();
         }
         return this._minZ;
      }
      
      public function get scaleZ() : Number
      {
         return this._scaleZ;
      }
      
      public function set position(param1:Number3D) : void
      {
         this._transform.tx = param1.x;
         this._transform.ty = param1.y;
         this._transform.tz = param1.z;
         this._sceneTransformDirty = true;
         this._localTransformDirty = true;
      }
      
      public function get scaleY() : Number
      {
         return this._scaleY;
      }
      
      function notifySceneChange() : void
      {
         this._sceneTransformDirty = true;
         if(!hasEventListener(Object3DEvent.SCENE_CHANGED))
         {
            return;
         }
         if(!this._scenechanged)
         {
            this._scenechanged = new Object3DEvent(Object3DEvent.SCENE_CHANGED,this);
         }
         dispatchEvent(this._scenechanged);
      }
      
      public function set eulers(param1:Number3D) : void
      {
         this._rotationX = param1.x * toRADIANS;
         this._rotationY = param1.y * toRADIANS;
         this._rotationZ = param1.z * toRADIANS;
         this._transformDirty = true;
      }
      
      public function get scaleX() : Number
      {
         return this._scaleX;
      }
      
      public function set ownSession(param1:AbstractRenderSession) : void
      {
         if(this._ownSession == param1)
         {
            return;
         }
         if(this._ownSession)
         {
            if(this._parent && this._parent.session)
            {
               this._parent.session.removeChildSession(this._ownSession);
            }
            this._ownSession.clearChildSessions();
            this._ownSession.renderer = null;
            this._ownSession.internalRemoveOwnSession(this);
            this._ownSession.removeOnSessionUpdate(this.onSessionUpdate);
         }
         else if(this._parent && this._parent.session)
         {
            this._parent.session.internalRemoveOwnSession(this);
         }
         this._ownSession = param1;
         if(this._ownSession)
         {
            if(this._parent && this._parent.session)
            {
               this._parent.session.addChildSession(this._ownSession);
            }
            this._ownSession.clearChildSessions();
            this._ownSession.renderer = this._renderer;
            this._ownSession.filters = this._filters;
            this._ownSession.alpha = this._alpha;
            this._ownSession.blendMode = this._blendMode;
            this._ownSession.internalAddOwnSession(this);
            this._ownSession.addOnSessionUpdate(this.onSessionUpdate);
         }
         else
         {
            if(this is Scene3D)
            {
               throw new Error("Scene cannot have ownSession set to null");
            }
            if(this._parent && this._parent.session)
            {
               this._parent.session.internalAddOwnSession(this);
            }
         }
         if(this._ownSession)
         {
            this._ownCanvas = true;
         }
         else
         {
            this._ownCanvas = false;
         }
         this.notifySessionChange();
      }
      
      public function addOnMouseDown(param1:Function) : void
      {
         addEventListener(MouseEvent3D.MOUSE_DOWN,param1,false,0,false);
      }
      
      override public function toString() : String
      {
         return (!!this.name?this.name:"$") + ": x:" + Math.round(this.x) + " y:" + Math.round(this.y) + " z:" + Math.round(this.z);
      }
      
      public function get pivotPoint() : Number3D
      {
         return this._pivotPoint;
      }
      
      public function yaw(param1:Number) : void
      {
         this.rotate(Number3D.UP,param1);
      }
      
      public function get visible() : Boolean
      {
         return this._visible;
      }
      
      public function addOnDimensionsChange(param1:Function) : void
      {
         addEventListener(Object3DEvent.DIMENSIONS_CHANGED,param1,false,0,true);
      }
      
      public function get y() : Number
      {
         return this._transform.ty;
      }
      
      public function get z() : Number
      {
         return this._transform.tz;
      }
      
      public function roll(param1:Number) : void
      {
         this.rotate(Number3D.FORWARD,param1);
      }
      
      public function get ownCanvas() : Boolean
      {
         return this._ownCanvas;
      }
      
      public function get x() : Number
      {
         return this._transform.tx;
      }
      
      public function moveUp(param1:Number) : void
      {
         this.translate(Number3D.UP,param1);
      }
      
      public function set ownLights(param1:Boolean) : void
      {
         this._ownLights = param1;
         this._lightsDirty = true;
      }
      
      public function get scene() : Scene3D
      {
         return this._scene;
      }
      
      public function removeOnRollOut(param1:Function) : void
      {
         removeEventListener(MouseEvent3D.ROLL_OUT,param1,false);
      }
      
      public function addOnSceneTransformChange(param1:Function) : void
      {
         addEventListener(Object3DEvent.SCENETRANSFORM_CHANGED,param1,false,0,true);
      }
      
      public function addOnParentUpdate(param1:Function) : void
      {
         addEventListener(Object3DEvent.PARENT_UPDATED,param1,false,0,true);
      }
      
      public function get session() : AbstractRenderSession
      {
         return this._session;
      }
      
      public function addOnMouseOver(param1:Function) : void
      {
         addEventListener(MouseEvent3D.MOUSE_OVER,param1,false,0,false);
      }
      
      public function get rotationY() : Number
      {
         if(this._rotationDirty)
         {
            this.updateRotation();
         }
         return this._rotationY * toDEGREES;
      }
      
      public function get rotationZ() : Number
      {
         if(this._rotationDirty)
         {
            this.updateRotation();
         }
         return this._rotationZ * toDEGREES;
      }
      
      public function get parentBoundingRadius() : Number
      {
         return this.boundingRadius * this._boundingScale;
      }
      
      public function get rotationX() : Number
      {
         if(this._rotationDirty)
         {
            this.updateRotation();
         }
         return this._rotationX * toDEGREES;
      }
      
      protected function updateTransform() : void
      {
         if(this._rotationDirty)
         {
            this.updateRotation();
         }
         this._quaternion.euler2quaternion(this._rotationY,this._rotationZ,-this._rotationX);
         this._transform.quaternion2matrix(this._quaternion);
         this._transform.scale(this._transform,this._scaleX,this._scaleY,this._scaleZ);
         this._transformDirty = false;
         this._sceneTransformDirty = true;
         this._localTransformDirty = true;
      }
      
      public function set scaleY(param1:Number) : void
      {
         if(this._scaleY == param1)
         {
            return;
         }
         this._scaleY = param1;
         this._transformDirty = true;
         this._dimensionsDirty = true;
      }
      
      public function set scaleZ(param1:Number) : void
      {
         if(this._scaleZ == param1)
         {
            return;
         }
         this._scaleZ = param1;
         this._transformDirty = true;
         this._dimensionsDirty = true;
      }
      
      public function set scaleX(param1:Number) : void
      {
         if(this._scaleX == param1)
         {
            return;
         }
         this._scaleX = param1;
         this._transformDirty = true;
         this._dimensionsDirty = true;
      }
      
      public function applyPosition(param1:Number, param2:Number, param3:Number) : void
      {
         throw new Error("Not implemented in Object3D - Use Mesh or ObjectContainer3D");
      }
      
      public function get renderer() : IPrimitiveConsumer
      {
         return this._renderer;
      }
      
      private function changeSession() : void
      {
         if(this._ownSession)
         {
            this._session = this._ownSession;
         }
         else if(this._parent)
         {
            this._session = this._parent.session;
         }
         else
         {
            this._session = null;
         }
         this._sessionDirty = true;
      }
      
      public function set alpha(param1:Number) : void
      {
         if(this._alpha == param1)
         {
            return;
         }
         this._alpha = param1;
         if(this._ownSession)
         {
            this._ownSession.alpha = this._alpha;
         }
      }
      
      public function get parent() : ObjectContainer3D
      {
         return this._parent;
      }
      
      public function removeOnMouseDown(param1:Function) : void
      {
         removeEventListener(MouseEvent3D.MOUSE_DOWN,param1,false);
      }
      
      public function get objectDepth() : Number
      {
         if(this._dimensionsDirty)
         {
            this.updateDimensions();
         }
         return this._maxZ - this._minZ;
      }
      
      public function moveBackward(param1:Number) : void
      {
         this.translate(Number3D.BACKWARD,param1);
      }
      
      public function removeOnMouseOver(param1:Function) : void
      {
         removeEventListener(MouseEvent3D.MOUSE_OVER,param1,false);
      }
      
      public function set transform(param1:MatrixAway3D) : void
      {
         if(this._transform.compare(param1))
         {
            return;
         }
         this._transform.clone(param1);
         this._transformDirty = false;
         this._rotationDirty = true;
         this._sceneTransformDirty = true;
         this._localTransformDirty = true;
         this._sca.matrix2scale(this._transform);
         if(this._scaleX != this._sca.x || this._scaleY != this._sca.y || this._scaleZ != this._sca.z)
         {
            this._scaleX = this._sca.x;
            this._scaleY = this._sca.y;
            this._scaleZ = this._sca.z;
            this._dimensionsDirty = true;
         }
      }
      
      public function set visible(param1:Boolean) : void
      {
         if(this._visible == param1)
         {
            return;
         }
         this._visible = param1;
         this._sessionDirty = true;
         this.notifyParentUpdate();
      }
      
      public function applyRotations() : void
      {
         throw new Error("Not implemented in Object3D - Use Mesh or ObjectContainer3D");
      }
      
      public function addOnMouseOut(param1:Function) : void
      {
         addEventListener(MouseEvent3D.MOUSE_OUT,param1,false,0,false);
      }
      
      public function set pivotPoint(param1:Number3D) : void
      {
         this._pivotPoint.clone(param1);
         this._pivotZero = !this._pivotPoint.x && !this._pivotPoint.y && !this._pivotPoint.z;
         this._sceneTransformDirty = true;
         this._dimensionsDirty = true;
         this.notifyParentUpdate();
      }
      
      public function moveRight(param1:Number) : void
      {
         this.translate(Number3D.RIGHT,param1);
      }
      
      public function set x(param1:Number) : void
      {
         if(isNaN(param1))
         {
            throw new Error("isNaN(x)");
         }
         if(this._transform.tx == param1)
         {
            return;
         }
         if(param1 == Infinity)
         {
            Debug.warning("x == Infinity");
         }
         if(param1 == -Infinity)
         {
            Debug.warning("x == -Infinity");
         }
         this._transform.tx = param1;
         this._sceneTransformDirty = true;
         this._localTransformDirty = true;
      }
      
      public function movePivot(param1:Number, param2:Number, param3:Number) : void
      {
         this._pivotPoint.x = param1;
         this._pivotPoint.y = param2;
         this._pivotPoint.z = param3;
         this._pivotZero = !param1 && !param2 && !param3;
         this._sceneTransformDirty = true;
         this._dimensionsDirty = true;
         this.notifyParentUpdate();
      }
      
      public function set y(param1:Number) : void
      {
         if(isNaN(param1))
         {
            throw new Error("isNaN(y)");
         }
         if(this._transform.ty == param1)
         {
            return;
         }
         if(param1 == Infinity)
         {
            Debug.warning("y == Infinity");
         }
         if(param1 == -Infinity)
         {
            Debug.warning("y == -Infinity");
         }
         this._transform.ty = param1;
         this._sceneTransformDirty = true;
         this._localTransformDirty = true;
      }
      
      public function set z(param1:Number) : void
      {
         if(isNaN(param1))
         {
            throw new Error("isNaN(z)");
         }
         if(this._transform.tz == param1)
         {
            return;
         }
         if(param1 == Infinity)
         {
            Debug.warning("z == Infinity");
         }
         if(param1 == -Infinity)
         {
            Debug.warning("z == -Infinity");
         }
         this._transform.tz = param1;
         this._sceneTransformDirty = true;
         this._localTransformDirty = true;
      }
      
      function notifySceneTransformChange() : void
      {
         this._sceneTransformDirty = false;
         this._objectDirty = true;
         if(!hasEventListener(Object3DEvent.SCENETRANSFORM_CHANGED))
         {
            return;
         }
         if(!this._scenetransformchanged)
         {
            this._scenetransformchanged = new Object3DEvent(Object3DEvent.SCENETRANSFORM_CHANGED,this);
         }
         dispatchEvent(this._scenetransformchanged);
      }
      
      public function set ownCanvas(param1:Boolean) : void
      {
         if(this._ownCanvas == param1)
         {
            return;
         }
         if(param1)
         {
            this.ownSession = new SpriteRenderSession();
         }
         else
         {
            if(this is Scene3D)
            {
               throw new Error("Scene cannot have ownCanvas set to false");
            }
            this.ownSession = null;
         }
      }
      
      private function onParentSessionChange(param1:Object3DEvent) : void
      {
         if(this._ownSession && param1.object.parent)
         {
            param1.object.parent.session.removeChildSession(this._ownSession);
         }
         if(this._ownSession && this._parent.session)
         {
            this._parent.session.addChildSession(this._ownSession);
         }
         if(!this._ownSession && this._session != this._parent.session)
         {
            this.changeSession();
            dispatchEvent(param1);
         }
      }
      
      public function addOnSceneChange(param1:Function) : void
      {
         addEventListener(Object3DEvent.SCENE_CHANGED,param1,false,0,true);
      }
      
      public function centerPivot() : void
      {
         var _loc1_:Number3D = new Number3D((this.maxX + this.minX) / 2,(this.maxY + this.minY) / 2,(this.maxZ + this.minZ) / 2);
         this.movePivot(_loc1_.x,_loc1_.y,_loc1_.z);
         this.moveTo(_loc1_.x,_loc1_.y,_loc1_.z);
      }
      
      public function removeOnMouseOut(param1:Function) : void
      {
         removeEventListener(MouseEvent3D.MOUSE_OUT,param1,false);
      }
      
      function dispatchMouseEvent(param1:MouseEvent3D) : Boolean
      {
         if(!hasEventListener(param1.type))
         {
            return false;
         }
         dispatchEvent(param1);
         return true;
      }
      
      public function addOnRollOut(param1:Function) : void
      {
         addEventListener(MouseEvent3D.ROLL_OUT,param1,false,0,false);
      }
      
      function notifySessionChange() : void
      {
         this.changeSession();
         if(!hasEventListener(Object3DEvent.SESSION_CHANGED))
         {
            return;
         }
         if(!this._sessionchanged)
         {
            this._sessionchanged = new Object3DEvent(Object3DEvent.SESSION_CHANGED,this);
         }
         dispatchEvent(this._sessionchanged);
      }
      
      public function get parentmaxX() : Number
      {
         return this.boundingRadius * this._boundingScale + this._transform.tx;
      }
      
      public function get parentmaxY() : Number
      {
         return this.boundingRadius * this._boundingScale + this._transform.ty;
      }
      
      public function get parentmaxZ() : Number
      {
         return this.boundingRadius * this._boundingScale + this._transform.tz;
      }
      
      public function removeOnSessionChange(param1:Function) : void
      {
         removeEventListener(Object3DEvent.SESSION_CHANGED,param1,false);
      }
      
      public function get position() : Number3D
      {
         return this.transform.position;
      }
      
      public function removeOnMouseUp(param1:Function) : void
      {
         removeEventListener(MouseEvent3D.MOUSE_UP,param1,false);
      }
      
      public function lookAt(param1:Number3D, param2:Number3D = null) : void
      {
         this._lookingAtTarget = param1;
         this._zAxis.sub(param1,this.position);
         this._zAxis.normalize();
         if(this._zAxis.modulo > 0.1 && (this._zAxis.x != this._transform.sxz || this._zAxis.y != this._transform.syz || this._zAxis.z != this._transform.szz))
         {
            this._xAxis.cross(this._zAxis,param2 || Number3D.UP);
            if(!this._xAxis.modulo2)
            {
               this._xAxis.cross(this._zAxis,Number3D.BACKWARD);
            }
            this._xAxis.normalize();
            this._yAxis.cross(this._zAxis,this._xAxis);
            this._yAxis.normalize();
            this._transform.sxx = this._xAxis.x * this._scaleX;
            this._transform.syx = this._xAxis.y * this._scaleX;
            this._transform.szx = this._xAxis.z * this._scaleX;
            this._transform.sxy = -this._yAxis.x * this._scaleY;
            this._transform.syy = -this._yAxis.y * this._scaleY;
            this._transform.szy = -this._yAxis.z * this._scaleY;
            this._transform.sxz = this._zAxis.x * this._scaleZ;
            this._transform.syz = this._zAxis.y * this._scaleZ;
            this._transform.szz = this._zAxis.z * this._scaleZ;
            this._transformDirty = false;
            this._rotationDirty = true;
            this._sceneTransformDirty = true;
            this._localTransformDirty = true;
         }
      }
      
      public function set rotationX(param1:Number) : void
      {
         if(this.rotationX == param1)
         {
            return;
         }
         this._rotationX = param1 * toRADIANS;
         this._transformDirty = true;
      }
      
      public function set blendMode(param1:String) : void
      {
         if(this._blendMode == param1)
         {
            return;
         }
         this._blendMode = param1;
         if(this._ownSession)
         {
            this._ownSession.blendMode = this._blendMode;
         }
      }
      
      public function set rotationZ(param1:Number) : void
      {
         if(this.rotationZ == param1)
         {
            return;
         }
         this._rotationZ = param1 * toRADIANS;
         this._transformDirty = true;
      }
      
      public function set rotationY(param1:Number) : void
      {
         if(this.rotationY == param1)
         {
            return;
         }
         this._rotationY = param1 * toRADIANS;
         this._transformDirty = true;
      }
      
      public function pitch(param1:Number) : void
      {
         this.rotate(Number3D.RIGHT,param1);
      }
      
      public function get ownLights() : Boolean
      {
         return this._ownLights;
      }
      
      public function rotateTo(param1:Number, param2:Number, param3:Number) : void
      {
         this._rotationX = param1 * toRADIANS;
         this._rotationY = param2 * toRADIANS;
         this._rotationZ = param3 * toRADIANS;
         this._rotationDirty = false;
         this._transformDirty = true;
      }
      
      function notifyDimensionsChange() : void
      {
         this._dimensionsDirty = true;
         if(this._dispatchedDimensionsChange || !hasEventListener(Object3DEvent.DIMENSIONS_CHANGED))
         {
            return;
         }
         if(!this._dimensionschanged)
         {
            this._dimensionschanged = new Object3DEvent(Object3DEvent.DIMENSIONS_CHANGED,this);
         }
         dispatchEvent(this._dimensionschanged);
         this._dispatchedDimensionsChange = true;
      }
      
      public function scale(param1:Number) : void
      {
         this._scaleX = this._scaleY = this._scaleZ = param1;
         this._transformDirty = true;
         this._dimensionsDirty = true;
      }
      
      public function get objectHeight() : Number
      {
         if(this._dimensionsDirty)
         {
            this.updateDimensions();
         }
         return this._maxY - this._minY;
      }
      
      public function translate(param1:Number3D, param2:Number) : void
      {
         param1.normalize();
         this._vector.rotate(param1,this.transform);
         this.x = this.x + param2 * this._vector.x;
         this.y = this.y + param2 * this._vector.y;
         this.z = this.z + param2 * this._vector.z;
      }
      
      public function distanceTo(param1:Object3D) : Number
      {
         var _loc2_:MatrixAway3D = this._scene == this?this.transform:this.sceneTransform;
         var _loc3_:MatrixAway3D = param1.scene == param1?param1.transform:param1.sceneTransform;
         var _loc4_:Number = _loc2_.tx - _loc3_.tx;
         var _loc5_:Number = _loc2_.ty - _loc3_.ty;
         var _loc6_:Number = _loc2_.tz - _loc3_.tz;
         return Math.sqrt(_loc4_ * _loc4_ + _loc5_ * _loc5_ + _loc6_ * _loc6_);
      }
      
      public function set parent(param1:ObjectContainer3D) : void
      {
         if(this is Scene3D)
         {
            throw new Error("Scene cannot be parented");
         }
         if(param1 == this._parent)
         {
            return;
         }
         this._oldscene = this._scene;
         if(this._parent != null)
         {
            this._parent.removeOnParentUpdate(this.onParentUpdate);
            this._parent.removeOnSessionChange(this.onParentSessionChange);
            this._parent.removeOnSceneChange(this.onParentSceneChange);
            this._parent.removeOnSceneTransformChange(this.onParentTransformChange);
            this._parent.internalRemoveChild(this);
            if(this._ownSession && this._parent.session)
            {
               this._parent.session.removeChildSession(this._ownSession);
            }
         }
         this._parent = param1;
         this._scene = !!this._parent?this._parent.scene:null;
         if(this._parent != null)
         {
            this._parent.internalAddChild(this);
            this._parent.addOnParentUpdate(this.onParentUpdate);
            this._parent.addOnSessionChange(this.onParentSessionChange);
            this._parent.addOnSceneChange(this.onParentSceneChange);
            this._parent.addOnSceneTransformChange(this.onParentTransformChange);
            if(this._ownSession && this._parent.session)
            {
               this._parent.session.addChildSession(this._ownSession);
            }
         }
         if(this._scene != this._oldscene)
         {
            this.notifySceneChange();
         }
         if(!this._ownSession && (!this._parent || this._session != this._parent.session))
         {
            this.notifySessionChange();
         }
         this._sceneTransformDirty = true;
         this._localTransformDirty = true;
      }
      
      public function get boundingRadius() : Number
      {
         if(this._dimensionsDirty)
         {
            this.updateDimensions();
         }
         return this._boundingRadius;
      }
      
      public function removeOnParentUpdate(param1:Function) : void
      {
         removeEventListener(Object3DEvent.PARENT_UPDATED,param1,false);
      }
      
      public function rotate(param1:Number3D, param2:Number) : void
      {
         param1.normalize();
         this._m.rotationMatrix(param1.x,param1.y,param1.z,param2 * toRADIANS);
         this._transform.multiply3x3(this.transform,this._m);
         this._rotationDirty = true;
         this._sceneTransformDirty = true;
         this._localTransformDirty = true;
      }
      
      public function clone(param1:Object3D = null) : Object3D
      {
         var _loc2_:Object3D = param1 || new Object3D();
         _loc2_.transform = this.transform;
         _loc2_.name = this.name;
         _loc2_.ownCanvas = this._ownCanvas;
         _loc2_.renderer = this._renderer;
         _loc2_.filters = this._filters.concat();
         _loc2_.alpha = this._alpha;
         _loc2_.visible = this.visible;
         _loc2_.mouseEnabled = this.mouseEnabled;
         _loc2_.useHandCursor = this.useHandCursor;
         _loc2_.pushback = this.pushback;
         _loc2_.pushfront = this.pushfront;
         _loc2_.screenZOffset = this.screenZOffset;
         _loc2_.pivotPoint = this.pivotPoint;
         _loc2_.projectorType = this.projectorType;
         _loc2_.extra = this.extra is IClonable?(this.extra as IClonable).clone():this.extra;
         return _loc2_;
      }
      
      public function get alpha() : Number
      {
         return this._alpha;
      }
      
      private function onSessionUpdate(param1:SessionEvent) : void
      {
         if(param1.target is BitmapRenderSession)
         {
            this._scene.updatedSessions[param1.target] = param1.target;
         }
      }
      
      private function updateRotation() : void
      {
         this._rot.matrix2euler(this._transform,this._scaleX,this._scaleY,this._scaleZ);
         this._rotationX = this._rot.x;
         this._rotationY = this._rot.y;
         this._rotationZ = this._rot.z;
         this._rotationDirty = false;
      }
      
      private function updateSceneTransform() : void
      {
         this._sceneTransform.multiply(this._parent.sceneTransform,this.transform);
         if(!this._pivotZero)
         {
            this._scenePivotPoint.rotate(this._pivotPoint,this._sceneTransform);
            this._sceneTransform.tx = this._sceneTransform.tx - this._scenePivotPoint.x;
            this._sceneTransform.ty = this._sceneTransform.ty - this._scenePivotPoint.y;
            this._sceneTransform.tz = this._sceneTransform.tz - this._scenePivotPoint.z;
         }
         this.inverseSceneTransform.inverse(this._sceneTransform);
         this.notifySceneTransformChange();
      }
      
      public function get transform() : MatrixAway3D
      {
         if(this._transformDirty)
         {
            this.updateTransform();
         }
         return this._transform;
      }
      
      public function addOnRollOver(param1:Function) : void
      {
         addEventListener(MouseEvent3D.ROLL_OVER,param1,false,0,false);
      }
      
      public function traverse(param1:Traverser) : void
      {
         if(param1.match(this))
         {
            param1.enter(this);
            param1.apply(this);
            param1.leave(this);
         }
      }
      
      public function get maxX() : Number
      {
         if(this._dimensionsDirty)
         {
            this.updateDimensions();
         }
         return this._maxX;
      }
      
      public function updateObject() : void
      {
         if(this._objectDirty)
         {
            this._scene.updatedObjects[this] = this;
            this._objectDirty = false;
            this._sessionDirty = true;
         }
      }
      
      public function get maxY() : Number
      {
         if(this._dimensionsDirty)
         {
            this.updateDimensions();
         }
         return this._maxY;
      }
      
      public function addOnSessionChange(param1:Function) : void
      {
         addEventListener(Object3DEvent.SESSION_CHANGED,param1,false,0,true);
      }
      
      public function moveLeft(param1:Number) : void
      {
         this.translate(Number3D.LEFT,param1);
      }
      
      public function removeOnDimensionsChange(param1:Function) : void
      {
         removeEventListener(Object3DEvent.DIMENSIONS_CHANGED,param1,false);
      }
      
      public function set renderer(param1:IPrimitiveConsumer) : void
      {
         if(this._renderer == param1)
         {
            return;
         }
         this._renderer = param1;
         if(this._ownSession)
         {
            this._ownSession.renderer = this._renderer;
         }
         this._sessionDirty = true;
      }
      
      protected function updateDimensions() : void
      {
         this._dimensionsDirty = false;
         this._dispatchedDimensionsChange = false;
      }
      
      private function onParentTransformChange(param1:Object3DEvent) : void
      {
         this._sceneTransformDirty = true;
      }
      
      public function addOnMouseMove(param1:Function) : void
      {
         addEventListener(MouseEvent3D.MOUSE_MOVE,param1,false,0,false);
      }
      
      public function get maxZ() : Number
      {
         if(this._dimensionsDirty)
         {
            this.updateDimensions();
         }
         return this._maxZ;
      }
      
      private function onParentUpdate(param1:Object3DEvent) : void
      {
         this._sessionDirty = true;
         dispatchEvent(param1);
      }
      
      public function updateSession() : void
      {
         if(this._sessionDirty)
         {
            this.notifySessionUpdate();
            this._sessionDirty = false;
         }
      }
      
      public function tick(param1:int) : void
      {
      }
      
      public function addOnMouseUp(param1:Function) : void
      {
         addEventListener(MouseEvent3D.MOUSE_UP,param1,false,0,false);
      }
      
      public function get blendMode() : String
      {
         return this._blendMode;
      }
      
      public function get lookingAtTarget() : Number3D
      {
         return this._lookingAtTarget;
      }
      
      public function removeOnRollOver(param1:Function) : void
      {
         removeEventListener(MouseEvent3D.ROLL_OVER,param1,false);
      }
      
      function notifyTransformChange() : void
      {
         this._localTransformDirty = false;
         if(!hasEventListener(Object3DEvent.TRANSFORM_CHANGED))
         {
            return;
         }
         if(!this._transformchanged)
         {
            this._transformchanged = new Object3DEvent(Object3DEvent.TRANSFORM_CHANGED,this);
         }
         dispatchEvent(this._transformchanged);
      }
      
      public function moveForward(param1:Number) : void
      {
         this.translate(Number3D.FORWARD,param1);
      }
      
      public function addOnTransformChange(param1:Function) : void
      {
         addEventListener(Object3DEvent.TRANSFORM_CHANGED,param1,false,0,true);
      }
      
      public function get objectWidth() : Number
      {
         if(this._dimensionsDirty)
         {
            this.updateDimensions();
         }
         return this._maxX - this._minX;
      }
      
      public function get scenePosition() : Number3D
      {
         return this.sceneTransform.position;
      }
      
      public function removeOnSceneChange(param1:Function) : void
      {
         removeEventListener(Object3DEvent.SCENE_CHANGED,param1,false);
      }
      
      public function removeOnMouseMove(param1:Function) : void
      {
         removeEventListener(MouseEvent3D.MOUSE_MOVE,param1,false);
      }
      
      public function get parentminX() : Number
      {
         return -this.boundingRadius * this._boundingScale + this._transform.tx;
      }
      
      public function get parentminY() : Number
      {
         return -this.boundingRadius * this._boundingScale + this._transform.ty;
      }
      
      public function get parentminZ() : Number
      {
         return -this.boundingRadius * this._boundingScale + this._transform.tz;
      }
      
      public function set filters(param1:Array) : void
      {
         if(this._filters == param1)
         {
            return;
         }
         this._filters = param1;
         if(this._ownSession)
         {
            this._ownSession.filters = this._filters;
         }
      }
      
      public function get filters() : Array
      {
         return this._filters;
      }
      
      function notifyParentUpdate() : void
      {
         if(this._ownCanvas && this._parent)
         {
            this._parent._sessionDirty = true;
         }
         if(!hasEventListener(Object3DEvent.PARENT_UPDATED))
         {
            return;
         }
         if(!this._parentupdated)
         {
            this._parentupdated = new Object3DEvent(Object3DEvent.PARENT_UPDATED,this);
         }
         dispatchEvent(this._parentupdated);
      }
   }
}
