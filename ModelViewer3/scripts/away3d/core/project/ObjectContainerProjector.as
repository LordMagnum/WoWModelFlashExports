package away3d.core.project
{
   import away3d.cameras.Camera3D;
   import away3d.containers.ObjectContainer3D;
   import away3d.containers.View3D;
   import away3d.core.base.Object3D;
   import away3d.core.draw.IPrimitiveConsumer;
   import away3d.core.draw.IPrimitiveProvider;
   import away3d.core.draw.ScreenVertex;
   import away3d.core.math.MatrixAway3D;
   import away3d.core.math.Number3D;
   import away3d.core.render.SpriteRenderSession;
   import away3d.core.utils.DrawPrimitiveStore;
   import flash.utils.Dictionary;
   
   public class ObjectContainerProjector implements IPrimitiveProvider
   {
       
      
      private var _container:ObjectContainer3D;
      
      private var _view:View3D;
      
      private var _camera:Camera3D;
      
      private var _screenVertex:ScreenVertex;
      
      private var _child:Object3D;
      
      private var _cameraViewMatrix:MatrixAway3D;
      
      private var _vertexDictionary:Dictionary;
      
      private var _depthPoint:Number3D;
      
      private var _drawPrimitiveStore:DrawPrimitiveStore;
      
      private var _viewTransformDictionary:Dictionary;
      
      public function ObjectContainerProjector()
      {
         this._depthPoint = new Number3D();
         super();
      }
      
      public function set view(param1:View3D) : void
      {
         this._view = param1;
         this._drawPrimitiveStore = this.view.drawPrimitiveStore;
      }
      
      public function get view() : View3D
      {
         return this._view;
      }
      
      public function primitives(param1:Object3D, param2:MatrixAway3D, param3:IPrimitiveConsumer) : void
      {
         this._vertexDictionary = this._drawPrimitiveStore.createVertexDictionary(param1);
         this._container = param1 as ObjectContainer3D;
         this._cameraViewMatrix = this._view.camera.viewMatrix;
         this._viewTransformDictionary = this._view.cameraVarsStore.viewTransformDictionary;
         for each(this._child in this._container.children)
         {
            if(this._child.ownCanvas && this._child.visible)
            {
               if(this._child.ownSession is SpriteRenderSession)
               {
                  (this._child.ownSession as SpriteRenderSession).cacheAsBitmap = true;
               }
               this._screenVertex = this._drawPrimitiveStore.createScreenVertex(this._child.center);
               this._screenVertex.x = 0;
               this._screenVertex.y = 0;
               if(!isNaN(this._child.ownSession.screenZ))
               {
                  this._screenVertex.z = this._child.ownSession.screenZ;
               }
               else
               {
                  if(this._child.scenePivotPoint.modulo)
                  {
                     this._depthPoint.clone(this._child.scenePivotPoint);
                     this._depthPoint.rotate(this._depthPoint,this._cameraViewMatrix);
                     this._depthPoint.add(this._viewTransformDictionary[this._child].position,this._depthPoint);
                     this._screenVertex.z = this._depthPoint.modulo;
                  }
                  else
                  {
                     this._screenVertex.z = this._viewTransformDictionary[this._child].position.modulo;
                  }
                  if(this._child.pushback)
                  {
                     this._screenVertex.z = this._screenVertex.z + this._child.parentBoundingRadius;
                  }
                  if(this._child.pushfront)
                  {
                     this._screenVertex.z = this._screenVertex.z - this._child.parentBoundingRadius;
                  }
                  this._screenVertex.z = this._screenVertex.z + this._child.screenZOffset;
               }
               param3.primitive(this._drawPrimitiveStore.createDrawDisplayObject(this._child,this._screenVertex,this._container.session,this._child.session.getContainer(this.view)));
            }
         }
      }
   }
}
