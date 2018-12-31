package away3d.cameras.lenses
{
   import away3d.cameras.Camera3D;
   import away3d.containers.View3D;
   import away3d.core.clip.Clipping;
   import away3d.core.draw.ScreenVertex;
   import away3d.core.geom.Frustum;
   import away3d.core.geom.Plane3D;
   import away3d.core.math.MatrixAway3D;
   import away3d.core.utils.CameraVarsStore;
   import away3d.core.utils.DrawPrimitiveStore;
   
   public class AbstractLens
   {
       
      
      protected var _sw:Number;
      
      protected var _view:View3D;
      
      protected var _sy:Number;
      
      protected var _sz:Number;
      
      protected var _sx:Number;
      
      protected var _near:Number;
      
      protected var _screenVertex:ScreenVertex;
      
      protected var _clipping:Clipping;
      
      protected var _frustum:Frustum;
      
      protected var view:MatrixAway3D;
      
      protected var _clipTop:Number;
      
      protected var _clipRight:Number;
      
      protected var _cameraVarsStore:CameraVarsStore;
      
      protected const toDEGREES:Number = 57.29577951308232;
      
      protected var _clipHeight:Number;
      
      protected var _drawPrimitiveStore:DrawPrimitiveStore;
      
      protected var _focusOverZoom:Number;
      
      protected var _clipBottom:Number;
      
      protected var _camera:Camera3D;
      
      protected var _zoom2:Number;
      
      protected var _persp:Number;
      
      protected var viewTransform:MatrixAway3D;
      
      protected var _clipLeft:Number;
      
      protected var _clipWidth:Number;
      
      protected var _plane:Plane3D;
      
      protected var _far:Number;
      
      protected var _vx:Number;
      
      protected var _vz:Number;
      
      protected var _len:Number;
      
      protected var classification:int;
      
      protected var _vy:Number;
      
      protected var _scz:Number;
      
      protected const toRADIANS:Number = 0.017453292519943295;
      
      protected var _projected:ScreenVertex;
      
      public function AbstractLens()
      {
         this.view = new MatrixAway3D();
         super();
      }
      
      public function setView(param1:View3D) : void
      {
         this._view = param1;
         this._drawPrimitiveStore = param1.drawPrimitiveStore;
         this._cameraVarsStore = param1.cameraVarsStore;
         this._camera = param1.camera;
         this._clipping = param1.screenClipping;
         this._clipTop = this._clipping.maxY;
         this._clipBottom = this._clipping.minY;
         this._clipLeft = this._clipping.minX;
         this._clipRight = this._clipping.maxX;
         this._clipHeight = this._clipBottom - this._clipTop;
         this._clipWidth = this._clipRight - this._clipLeft;
         this._far = this._clipping.maxZ;
      }
   }
}
