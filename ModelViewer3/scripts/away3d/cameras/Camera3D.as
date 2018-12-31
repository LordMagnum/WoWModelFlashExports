package away3d.cameras
{
   import away3d.cameras.lenses.AbstractLens;
   import away3d.cameras.lenses.ILens;
   import away3d.cameras.lenses.ZoomFocusLens;
   import away3d.containers.View3D;
   import away3d.core.base.Object3D;
   import away3d.core.base.Vertex;
   import away3d.core.clip.Clipping;
   import away3d.core.draw.ScreenVertex;
   import away3d.core.math.MatrixAway3D;
   import away3d.core.math.Number3D;
   import away3d.core.utils.CameraVarsStore;
   import away3d.core.utils.DofCache;
   import away3d.core.utils.DrawPrimitiveStore;
   import away3d.events.CameraEvent;
   
   public class Camera3D extends Object3D
   {
       
      
      private var _y:Number;
      
      private var _view:View3D;
      
      private var _sz:Number;
      
      private var _flipY:MatrixAway3D;
      
      private var _fov:Number = 0;
      
      public var invViewMatrix:MatrixAway3D;
      
      private var _clipping:Clipping;
      
      private var _clipTop:Number;
      
      private var _clipRight:Number;
      
      private var _cameraVarsStore:CameraVarsStore;
      
      private var _zoom:Number = 10;
      
      protected const toDEGREES:Number = 57.29577951308232;
      
      private var _clipBottom:Number;
      
      private var _persp:Number;
      
      private var _drawPrimitiveStore:DrawPrimitiveStore;
      
      private var _zoomDirty:Boolean;
      
      public var maxblur:Number = 150;
      
      private var _clipLeft:Number;
      
      private var _focus:Number;
      
      private var _lens:ILens;
      
      private var _fovDirty:Boolean;
      
      private var _viewMatrix:MatrixAway3D;
      
      public var fixedZoom:Boolean;
      
      public var doflevels:Number = 16;
      
      private var _vt:MatrixAway3D;
      
      private var _aperture:Number = 22;
      
      private var _cameraupdated:CameraEvent;
      
      private var _x:Number;
      
      private var _z:Number;
      
      private var _dof:Boolean = false;
      
      protected const toRADIANS:Number = 0.017453292519943295;
      
      public function Camera3D(param1:Object = null)
      {
         this._flipY = new MatrixAway3D();
         this._viewMatrix = new MatrixAway3D();
         this.invViewMatrix = new MatrixAway3D();
         super(param1);
         this.fov = ini.getNumber("fov",this._fov);
         this.focus = ini.getNumber("focus",100);
         this.zoom = ini.getNumber("zoom",this._zoom);
         this.fixedZoom = ini.getBoolean("fixedZoom",true);
         this.lens = ini.getObject("lens",AbstractLens) as ILens || new ZoomFocusLens();
         this.aperture = ini.getNumber("aperture",22);
         this.maxblur = ini.getNumber("maxblur",150);
         this.doflevels = ini.getNumber("doflevels",16);
         this.dof = ini.getBoolean("dof",false);
         var _loc2_:Number3D = ini.getPosition("lookat");
         this._flipY.syy = -1;
         if(_loc2_)
         {
            lookAt(_loc2_);
         }
      }
      
      public function unproject(param1:Number, param2:Number) : Number3D
      {
         var _loc3_:Number = this.focus * this.zoom / this.focus;
         var _loc4_:Number3D = new Number3D(param1 / _loc3_,-param2 / _loc3_,this.focus);
         transform.multiplyVector3x3(_loc4_);
         return _loc4_;
      }
      
      public function set dof(param1:Boolean) : void
      {
         this._dof = param1;
         if(this._dof)
         {
            this.enableDof();
         }
         else
         {
            this.disableDof();
         }
      }
      
      public function set lens(param1:ILens) : void
      {
         if(this._lens == param1)
         {
            return;
         }
         this._lens = param1;
         this.notifyCameraUpdate();
      }
      
      public function get aperture() : Number
      {
         return this._aperture;
      }
      
      public function get lens() : ILens
      {
         return this._lens;
      }
      
      public function get zoom() : Number
      {
         return this._zoom;
      }
      
      public function set aperture(param1:Number) : void
      {
         this._aperture = param1;
         DofCache.aperture = this._aperture;
      }
      
      public function pan(param1:Number) : void
      {
         super.yaw(param1);
      }
      
      public function get view() : View3D
      {
         return this._view;
      }
      
      public function set fov(param1:Number) : void
      {
         if(this._fov == param1)
         {
            return;
         }
         this._fov = param1;
         this._fovDirty = false;
         this._zoomDirty = true;
         this.notifyCameraUpdate();
      }
      
      public function set focus(param1:Number) : void
      {
         this._focus = param1;
         DofCache.focus = this._focus;
         this.notifyCameraUpdate();
      }
      
      public function set zoom(param1:Number) : void
      {
         if(this._zoom == param1)
         {
            return;
         }
         this._zoom = param1;
         this._zoomDirty = false;
         this._fovDirty = true;
         this.notifyCameraUpdate();
      }
      
      private function notifyCameraUpdate() : void
      {
         if(!hasEventListener(CameraEvent.CAMERA_UPDATED))
         {
            return;
         }
         if(this._cameraupdated == null)
         {
            this._cameraupdated = new CameraEvent(CameraEvent.CAMERA_UPDATED,this);
         }
         dispatchEvent(this._cameraupdated);
      }
      
      public function enableDof() : void
      {
         DofCache.doflevels = this.doflevels;
         DofCache.aperture = this.aperture;
         DofCache.maxblur = this.maxblur;
         DofCache.focus = this.focus;
         DofCache.resetDof(true);
      }
      
      public function tilt(param1:Number) : void
      {
         super.pitch(param1);
      }
      
      public function get viewMatrix() : MatrixAway3D
      {
         this.invViewMatrix.multiply(sceneTransform,this._flipY);
         this._viewMatrix.inverse(this.invViewMatrix);
         return this._viewMatrix;
      }
      
      public function get fov() : Number
      {
         return this._fov;
      }
      
      public function update() : void
      {
         this._view.updateScreenClipping();
         this._clipping = this._view.screenClipping;
         if(this._clipTop != this._clipping.maxY || this._clipBottom != this._clipping.minY || this._clipLeft != this._clipping.minX || this._clipRight != this._clipping.maxX)
         {
            if(!this._fovDirty && !this._zoomDirty)
            {
               if(this.fixedZoom)
               {
                  this._fovDirty = true;
               }
               else
               {
                  this._zoomDirty = true;
               }
            }
            this._clipTop = this._clipping.maxY;
            this._clipBottom = this._clipping.minY;
            this._clipLeft = this._clipping.minX;
            this._clipRight = this._clipping.maxX;
         }
         this.lens.setView(this._view);
         if(this._fovDirty)
         {
            this._fovDirty = false;
            this._fov = this.lens.getFOV();
         }
         if(this._zoomDirty)
         {
            this._zoomDirty = false;
            this._zoom = this.lens.getZoom();
         }
      }
      
      public function set view(param1:View3D) : void
      {
         if(this._view == param1)
         {
            return;
         }
         this._view = param1;
         this._drawPrimitiveStore = param1.drawPrimitiveStore;
         this._cameraVarsStore = param1.cameraVarsStore;
      }
      
      public function get dof() : Boolean
      {
         return this._dof;
      }
      
      public function get focus() : Number
      {
         return this._focus;
      }
      
      public function disableDof() : void
      {
         DofCache.resetDof(false);
      }
      
      public function addOnCameraUpdate(param1:Function) : void
      {
         addEventListener(CameraEvent.CAMERA_UPDATED,param1,false,0,false);
      }
      
      public function removeOnCameraUpdate(param1:Function) : void
      {
         removeEventListener(CameraEvent.CAMERA_UPDATED,param1,false);
      }
      
      public function screen(param1:Object3D, param2:Vertex = null) : ScreenVertex
      {
         if(param2 == null)
         {
            param2 = param1.center;
         }
         this._cameraVarsStore.createViewTransform(param1).multiply(this.viewMatrix,param1.sceneTransform);
         this._drawPrimitiveStore.createVertexDictionary(param1);
         return this.lens.project(this._cameraVarsStore.viewTransformDictionary[param1],param2);
      }
      
      override public function clone(param1:Object3D = null) : Object3D
      {
         var _loc2_:Camera3D = param1 as Camera3D || new Camera3D();
         super.clone(_loc2_);
         _loc2_.zoom = this.zoom;
         _loc2_.focus = this.focus;
         _loc2_.lens = this.lens;
         return _loc2_;
      }
   }
}
