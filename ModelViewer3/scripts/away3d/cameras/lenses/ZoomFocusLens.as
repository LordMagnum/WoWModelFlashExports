package away3d.cameras.lenses
{
   import away3d.containers.View3D;
   import away3d.core.base.Object3D;
   import away3d.core.base.Vertex;
   import away3d.core.clip.RectangleClipping;
   import away3d.core.draw.ScreenVertex;
   import away3d.core.geom.Frustum;
   import away3d.core.math.MatrixAway3D;
   
   public class ZoomFocusLens extends AbstractLens implements ILens
   {
       
      
      public function ZoomFocusLens()
      {
         super();
      }
      
      public function getFrustum(param1:Object3D, param2:MatrixAway3D) : Frustum
      {
         _frustum = _cameraVarsStore.createFrustum(param1);
         _focusOverZoom = _camera.focus / _camera.zoom;
         _zoom2 = _camera.zoom * _camera.zoom;
         _plane = _frustum.planes[Frustum.NEAR];
         _plane.a = 0;
         _plane.b = 0;
         _plane.c = 1;
         _plane.d = -_near;
         _plane.transform(param2);
         _plane = _frustum.planes[Frustum.FAR];
         _plane.a = 0;
         _plane.b = 0;
         _plane.c = -1;
         _plane.d = _far;
         _plane.transform(param2);
         _plane = _frustum.planes[Frustum.LEFT];
         _plane.a = -_clipHeight * _focusOverZoom;
         _plane.b = 0;
         _plane.c = _clipHeight * _clipLeft / _zoom2;
         _plane.d = _plane.c * _camera.focus;
         _plane.transform(param2);
         _plane = _frustum.planes[Frustum.RIGHT];
         _plane.a = _clipHeight * _focusOverZoom;
         _plane.b = 0;
         _plane.c = -_clipHeight * _clipRight / _zoom2;
         _plane.d = _plane.c * _camera.focus;
         _plane.transform(param2);
         _plane = _frustum.planes[Frustum.TOP];
         _plane.a = 0;
         _plane.b = -_clipWidth * _focusOverZoom;
         _plane.c = _clipWidth * _clipTop / _zoom2;
         _plane.d = _plane.c * _camera.focus;
         _plane.transform(param2);
         _plane = _frustum.planes[Frustum.BOTTOM];
         _plane.a = 0;
         _plane.b = _clipWidth * _focusOverZoom;
         _plane.c = -_clipWidth * _clipBottom / _zoom2;
         _plane.d = _plane.c * _camera.focus;
         _plane.transform(param2);
         return _frustum;
      }
      
      override public function setView(param1:View3D) : void
      {
         super.setView(param1);
         if(_clipping.minZ == -Infinity)
         {
            _near = _clipping.minZ = -_camera.focus / 2;
         }
         else
         {
            _near = _clipping.minZ;
         }
      }
      
      public function project(param1:MatrixAway3D, param2:Vertex) : ScreenVertex
      {
         _screenVertex = _drawPrimitiveStore.createScreenVertex(param2);
         if(_screenVertex.viewTimer == _camera.view.viewTimer)
         {
            return _screenVertex;
         }
         _screenVertex.viewTimer = _camera.view.viewTimer;
         _vx = param2.x;
         _vy = param2.y;
         _vz = param2.z;
         _sz = _vx * param1.szx + _vy * param1.szy + _vz * param1.szz + param1.tz;
         if(isNaN(_sz))
         {
            throw new Error("isNaN(sz)");
         }
         if(_sz < _near && _clipping is RectangleClipping)
         {
            _screenVertex.visible = false;
            return _screenVertex;
         }
         _persp = _camera.zoom / (1 + _sz / _camera.focus);
         _screenVertex.x = (_screenVertex.vx = _vx * param1.sxx + _vy * param1.sxy + _vz * param1.sxz + param1.tx) * _persp;
         _screenVertex.y = (_screenVertex.vy = _vx * param1.syx + _vy * param1.syy + _vz * param1.syz + param1.ty) * _persp;
         _screenVertex.z = _sz;
         _screenVertex.visible = true;
         return _screenVertex;
      }
      
      public function getZoom() : Number
      {
         return ((_clipTop - _clipBottom) / Math.tan(_camera.fov * toRADIANS) - _clipTop * _clipBottom) / _camera.focus;
      }
      
      public function getFOV() : Number
      {
         return Math.atan2(_clipTop - _clipBottom,_camera.focus * _camera.zoom + _clipTop * _clipBottom) * toDEGREES;
      }
   }
}
