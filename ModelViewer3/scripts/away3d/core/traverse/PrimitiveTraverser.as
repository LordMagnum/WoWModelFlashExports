package away3d.core.traverse
{
   import away3d.containers.View3D;
   import away3d.core.base.Object3D;
   import away3d.core.clip.Clipping;
   import away3d.core.draw.IPrimitiveConsumer;
   import away3d.core.draw.IPrimitiveProvider;
   import away3d.core.math.MatrixAway3D;
   import away3d.core.project.ProjectorType;
   import away3d.core.utils.CameraVarsStore;
   import flash.utils.Dictionary;
   
   public class PrimitiveTraverser extends Traverser
   {
       
      
      private var _clipping:Clipping;
      
      private var _view:View3D;
      
      private var _nodeClassification:int;
      
      private var _viewTransform:MatrixAway3D;
      
      private var _cameraVarsStore:CameraVarsStore;
      
      private var _projectorDictionary:Dictionary;
      
      private var _consumer:IPrimitiveConsumer;
      
      private var _mouseEnableds:Array;
      
      private var _mouseEnabled:Boolean;
      
      public function PrimitiveTraverser()
      {
         this._projectorDictionary = new Dictionary(true);
         super();
      }
      
      public function get view() : View3D
      {
         return this._view;
      }
      
      override public function match(param1:Object3D) : Boolean
      {
         this._clipping = this._view.clipping;
         if(!param1.visible || this._clipping.objectCulling && !this._cameraVarsStore.nodeClassificationDictionary[param1])
         {
            return false;
         }
         return true;
      }
      
      public function set view(param1:View3D) : void
      {
         this._view = param1;
         this._mouseEnabled = true;
         this._mouseEnableds = [];
         this._cameraVarsStore = this._view.cameraVarsStore;
         this._projectorDictionary[ProjectorType.MESH] = this._view._meshProjector;
         this._projectorDictionary[ProjectorType.OBJECT_CONTAINER] = this._view._objectContainerProjector;
      }
      
      override public function apply(param1:Object3D) : void
      {
         if(param1.session.updated)
         {
            this._viewTransform = this._cameraVarsStore.viewTransformDictionary[param1];
            this._consumer = param1.session.getConsumer(this._view);
            if(param1.projectorType)
            {
               (this._projectorDictionary[param1.projectorType] as IPrimitiveProvider).primitives(param1,this._viewTransform,this._consumer);
            }
         }
         this._mouseEnabled = param1._mouseEnabled = this._mouseEnabled && param1.mouseEnabled;
      }
      
      override public function leave(param1:Object3D) : void
      {
         this._mouseEnabled = this._mouseEnableds.pop();
      }
      
      override public function enter(param1:Object3D) : void
      {
         this._mouseEnableds.push(this._mouseEnabled);
      }
   }
}
