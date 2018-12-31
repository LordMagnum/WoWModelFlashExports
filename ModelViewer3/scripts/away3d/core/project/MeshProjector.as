package away3d.core.project
{
   import away3d.cameras.Camera3D;
   import away3d.cameras.lenses.ILens;
   import away3d.containers.View3D;
   import away3d.core.base.Face;
   import away3d.core.base.Mesh;
   import away3d.core.base.Object3D;
   import away3d.core.base.Segment;
   import away3d.core.base.UV;
   import away3d.core.base.Vertex;
   import away3d.core.clip.Clipping;
   import away3d.core.draw.DrawSegment;
   import away3d.core.draw.DrawTriangle;
   import away3d.core.draw.IPrimitiveConsumer;
   import away3d.core.draw.IPrimitiveProvider;
   import away3d.core.draw.ScreenVertex;
   import away3d.core.geom.Frustum;
   import away3d.core.math.MatrixAway3D;
   import away3d.core.utils.CameraVarsStore;
   import away3d.core.utils.DrawPrimitiveStore;
   import away3d.core.utils.FaceMaterialVO;
   import away3d.core.utils.FaceVO;
   import away3d.materials.ILayerMaterial;
   import away3d.materials.ISegmentMaterial;
   import away3d.materials.ITriangleMaterial;
   
   public class MeshProjector implements IPrimitiveProvider
   {
       
      
      private var _faceMaterial:ITriangleMaterial;
      
      private var _view:View3D;
      
      private var _frustumClipping:Boolean;
      
      private var _sv1:ScreenVertex;
      
      private var _uvmaterial:Boolean;
      
      private var _segments:Array;
      
      private var _drawSegment:DrawSegment;
      
      private var _layerMaterial:ILayerMaterial;
      
      private var _smaterial:ISegmentMaterial;
      
      private var _clipping:Clipping;
      
      private var _frustum:Frustum;
      
      private var _backface:Boolean;
      
      private var _clipFaceVOs:Boolean;
      
      private var _cameraVarsStore:CameraVarsStore;
      
      private var _uvt:UV;
      
      private var _faces:Array;
      
      private var _segmentMaterial:ISegmentMaterial;
      
      private var _face:Face;
      
      private var _drawPrimitiveStore:DrawPrimitiveStore;
      
      private var _n01:Face;
      
      private var _vt:ScreenVertex;
      
      private var _zoom:Number;
      
      private var _vertex:Vertex;
      
      private var _camera:Camera3D;
      
      private var _drawTriangle:DrawTriangle;
      
      private var _mesh:Mesh;
      
      private var _n12:Face;
      
      private var _clippedFaceVOs:Array;
      
      private var _focus:Number;
      
      private var _backmat:ITriangleMaterial;
      
      private var _lens:ILens;
      
      private var _vertices:Array;
      
      private var _triangles:Array;
      
      private var _n20:Face;
      
      private var _sv2:ScreenVertex;
      
      private var _tri:DrawTriangle;
      
      private var _segment:Segment;
      
      private var _faceVO:FaceVO;
      
      private var _faceMaterialVO:FaceMaterialVO;
      
      private var _sv0:ScreenVertex;
      
      public function MeshProjector()
      {
         super();
      }
      
      public function get view() : View3D
      {
         return this._view;
      }
      
      private function front(param1:Face, param2:MatrixAway3D) : Number
      {
         this._sv0 = this._lens.project(param2,param1.v0);
         this._sv1 = this._lens.project(param2,param1.v1);
         this._sv2 = this._lens.project(param2,param1.v2);
         return this._sv0.x * (this._sv2.y - this._sv1.y) + this._sv1.x * (this._sv0.y - this._sv2.y) + this._sv2.x * (this._sv1.y - this._sv0.y);
      }
      
      public function set view(param1:View3D) : void
      {
         this._view = param1;
         this._drawPrimitiveStore = this.view.drawPrimitiveStore;
         this._cameraVarsStore = this.view.cameraVarsStore;
      }
      
      public function primitives(param1:Object3D, param2:MatrixAway3D, param3:IPrimitiveConsumer) : void
      {
         this._drawPrimitiveStore.createVertexDictionary(param1);
         this._cameraVarsStore.createVertexClassificationDictionary(param1);
         this._mesh = param1 as Mesh;
         this._vertices = this._mesh.vertices;
         this._faces = this._mesh.faces;
         this._segments = this._mesh.segments;
         this._camera = this._view.camera;
         this._clipping = this._view.screenClipping;
         this._lens = this._camera.lens;
         this._focus = this._camera.focus;
         this._zoom = this._camera.zoom;
         this._faceMaterial = this._mesh.faceMaterial;
         this._segmentMaterial = this._mesh.segmentMaterial;
         this._backmat = this._mesh.back || this._faceMaterial;
         this._clippedFaceVOs = new Array();
         if(this._cameraVarsStore.nodeClassificationDictionary[param1] == Frustum.INTERSECT)
         {
            this._clipFaceVOs = true;
         }
         else
         {
            this._clipFaceVOs = false;
         }
         for each(this._face in this._faces)
         {
            if(this._face.visible)
            {
               if(this._clipFaceVOs)
               {
                  this._clipping.checkFace(this._face.faceVO,param1,this._clippedFaceVOs);
               }
               else
               {
                  this._clippedFaceVOs.push(this._face.faceVO);
               }
            }
         }
         for each(this._faceVO in this._clippedFaceVOs)
         {
            this._sv0 = this._lens.project(param2,this._faceVO.v0);
            this._sv1 = this._lens.project(param2,this._faceVO.v1);
            this._sv2 = this._lens.project(param2,this._faceVO.v2);
            if(!(!this._sv0.visible || !this._sv1.visible || !this._sv2.visible))
            {
               this._face = this._faceVO.face;
               this._tri = this._drawPrimitiveStore.createDrawTriangle(param1,this._faceVO,null,this._sv0,this._sv1,this._sv2,this._faceVO.uv0,this._faceVO.uv1,this._faceVO.uv2,this._faceVO.generated);
               this._backface = this._tri.backface = this._tri.area < 0;
               if(this._backface)
               {
                  if(!this._mesh.bothsides)
                  {
                     continue;
                  }
                  this._tri.material = this._faceVO.back;
                  if(!this._tri.material)
                  {
                     this._tri.material = this._faceVO.material;
                  }
               }
               else
               {
                  this._tri.material = this._faceVO.material;
               }
               if(!this._tri.material)
               {
                  if(this._backface)
                  {
                     this._tri.material = this._backmat;
                  }
                  else
                  {
                     this._tri.material = this._faceMaterial;
                  }
               }
               if(this._tri.material && !this._tri.material.visible)
               {
                  this._tri.material = null;
               }
               if(!(!this._mesh.outline && !this._tri.material))
               {
                  if(param3.primitive(this._tri))
                  {
                  }
               }
            }
         }
      }
   }
}
