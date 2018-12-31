package away3d.core.traverse
{
   import away3d.cameras.Camera3D;
   import away3d.cameras.lenses.ILens;
   import away3d.containers.Scene3D;
   import away3d.containers.View3D;
   import away3d.core.base.Mesh;
   import away3d.core.base.Object3D;
   import away3d.core.clip.Clipping;
   import away3d.core.geom.Frustum;
   import away3d.core.math.MatrixAway3D;
   import away3d.core.utils.CameraVarsStore;
   
   public class ProjectionTraverser extends Traverser
   {
       
      
      private var _view:View3D;
      
      private var _camera:Camera3D;
      
      private var _mesh:Mesh;
      
      private var _viewTransform:MatrixAway3D;
      
      private var _lens:ILens;
      
      private var _clipping:Clipping;
      
      private var _frustum:Frustum;
      
      private var _nodeClassification:int;
      
      private var _cameraViewMatrix:MatrixAway3D;
      
      private var _cameraVarsStore:CameraVarsStore;
      
      public function ProjectionTraverser()
      {
         super();
      }
      
      override public function match(param1:Object3D) : Boolean
      {
         if(!param1.visible)
         {
            return false;
         }
         this._viewTransform = this._cameraVarsStore.createViewTransform(param1);
         this._viewTransform.multiply(this._cameraViewMatrix,param1.sceneTransform);
         if(this._clipping.objectCulling)
         {
            this._frustum = this._lens.getFrustum(param1,this._viewTransform);
            if(param1 is Scene3D || this._cameraVarsStore.nodeClassificationDictionary[param1.parent] == Frustum.INTERSECT)
            {
               if(param1.pivotZero)
               {
                  this._nodeClassification = this._cameraVarsStore.nodeClassificationDictionary[param1] = this._frustum.classifyRadius(param1.boundingRadius);
               }
               else
               {
                  this._nodeClassification = this._cameraVarsStore.nodeClassificationDictionary[param1] = this._frustum.classifySphere(param1.pivotPoint,param1.boundingRadius);
               }
            }
            else
            {
               this._nodeClassification = this._cameraVarsStore.nodeClassificationDictionary[param1] = this._cameraVarsStore.nodeClassificationDictionary[param1.parent];
            }
            if(this._nodeClassification == Frustum.OUT)
            {
               param1.updateObject();
               return false;
            }
         }
         return true;
      }
      
      public function set view(param1:View3D) : void
      {
         this._view = param1;
         this._cameraVarsStore = param1.cameraVarsStore;
         this._clipping = param1.clipping;
         this._camera = param1.camera;
         this._lens = this._camera.lens;
         this._cameraViewMatrix = this._camera.viewMatrix;
      }
      
      public function get view() : View3D
      {
         return this._view;
      }
      
      override public function apply(param1:Object3D) : void
      {
         if(this._mesh = param1 as Mesh)
         {
            if(!this._view.scene.meshes[param1])
            {
               this._view.scene.meshes[param1] = [];
            }
            this._view.scene.meshes[param1].push(this._view);
            this._view.scene.geometries[this._mesh.geometry] = this._mesh.geometry;
         }
      }
      
      override public function leave(param1:Object3D) : void
      {
         param1.updateObject();
      }
   }
}
