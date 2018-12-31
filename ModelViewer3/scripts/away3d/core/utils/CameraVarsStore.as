package away3d.core.utils
{
   import away3d.containers.View3D;
   import away3d.core.base.Face;
   import away3d.core.base.Object3D;
   import away3d.core.base.UV;
   import away3d.core.base.Vertex;
   import away3d.core.base.VertexClassification;
   import away3d.core.geom.Frustum;
   import away3d.core.math.MatrixAway3D;
   import away3d.core.render.AbstractRenderSession;
   import away3d.materials.ITriangleMaterial;
   import flash.utils.Dictionary;
   
   public class CameraVarsStore
   {
       
      
      private var _uvStore:Array;
      
      private var _vtStore:Array;
      
      public var frustumDictionary:Dictionary;
      
      private var _frustum:Frustum;
      
      public var view:View3D;
      
      private var _vStore:Array;
      
      private var _frStore:Array;
      
      public var viewTransformDictionary:Dictionary;
      
      public var nodeClassificationDictionary:Dictionary;
      
      private var _uv:UV;
      
      private var _vertex:Vertex;
      
      private var _fStore:Array;
      
      private var _vtActive:Array;
      
      private var _vc:VertexClassification;
      
      private var _fActive:Array;
      
      private var _frActive:Array;
      
      private var _source:Object3D;
      
      private var _session:AbstractRenderSession;
      
      private var _vt:MatrixAway3D;
      
      private var _object:Object;
      
      private var _vActive:Array;
      
      private var _vcArray:Array;
      
      private var _sourceDictionary:Dictionary;
      
      private var _faceVO:FaceVO;
      
      private var _uvDictionary:Dictionary;
      
      private var _v:Object;
      
      private var _uvArray:Array;
      
      private var _vcStore:Array;
      
      private var _vertexClassificationDictionary:Dictionary;
      
      public function CameraVarsStore()
      {
         this._sourceDictionary = new Dictionary(true);
         this._vtActive = new Array();
         this._vtStore = new Array();
         this._frActive = new Array();
         this._frStore = new Array();
         this._vActive = new Array();
         this._vStore = new Array();
         this._vcStore = new Array();
         this._uvDictionary = new Dictionary(true);
         this._uvStore = new Array();
         this._fActive = new Array();
         this._fStore = new Array();
         this.viewTransformDictionary = new Dictionary(true);
         this.frustumDictionary = new Dictionary(true);
         super();
      }
      
      public function createFaceVO(param1:Face, param2:Vertex, param3:Vertex, param4:Vertex, param5:ITriangleMaterial, param6:ITriangleMaterial, param7:UV, param8:UV, param9:UV) : FaceVO
      {
         if(this._fStore.length)
         {
            this._fActive.push(this._faceVO = this._fStore.pop());
         }
         else
         {
            this._fActive.push(this._faceVO = new FaceVO());
         }
         this._faceVO.face = param1;
         this._faceVO.v0 = param2;
         this._faceVO.v1 = param3;
         this._faceVO.v2 = param4;
         this._faceVO.uv0 = param7;
         this._faceVO.uv1 = param8;
         this._faceVO.uv2 = param9;
         this._faceVO.material = param5;
         this._faceVO.back = param6;
         this._faceVO.generated = true;
         return this._faceVO;
      }
      
      public function createVertexClassificationDictionary(param1:Object3D) : Dictionary
      {
         if(!(this._vertexClassificationDictionary = this._sourceDictionary[param1]))
         {
            this._vertexClassificationDictionary = this._sourceDictionary[param1] = new Dictionary(true);
         }
         return this._vertexClassificationDictionary;
      }
      
      public function createUV(param1:Number, param2:Number, param3:AbstractRenderSession) : UV
      {
         if(!(this._uvArray = this._uvDictionary[param3]))
         {
            this._uvArray = this._uvDictionary[param3] = [];
         }
         if(this._uvStore.length)
         {
            this._uvArray.push(this._uv = this._uvStore.pop());
            this._uv.u = param1;
            this._uv.v = param2;
         }
         else
         {
            this._uvArray.push(this._uv = new UV(param1,param2));
         }
         return this._uv;
      }
      
      public function createViewTransform(param1:Object3D) : MatrixAway3D
      {
         if(this._vtStore.length)
         {
            this._vtActive.push(this._vt = this.viewTransformDictionary[param1] = this._vtStore.pop());
         }
         else
         {
            this._vtActive.push(this._vt = this.viewTransformDictionary[param1] = new MatrixAway3D());
         }
         return this._vt;
      }
      
      public function createVertex(param1:Number, param2:Number, param3:Number) : Vertex
      {
         if(this._vStore.length)
         {
            this._vActive.push(this._vertex = this._vStore.pop());
            this._vertex.x = param1;
            this._vertex.y = param2;
            this._vertex.z = param3;
         }
         else
         {
            this._vActive.push(this._vertex = new Vertex(param1,param2,param3));
         }
         return this._vertex;
      }
      
      public function reset() : void
      {
         for(this._object in this._sourceDictionary)
         {
            this._source = this._object as Object3D;
            if(this._source.session && this._source.session.updated)
            {
               for(this._v in this._sourceDictionary[this._source])
               {
                  this._vcStore.push(this._sourceDictionary[this._source][this._v]);
                  delete this._sourceDictionary[this._source][this._v];
               }
            }
         }
         this.nodeClassificationDictionary = new Dictionary(true);
         this._vtStore = this._vtStore.concat(this._vtActive);
         this._vtActive = new Array();
         this._frStore = this._frStore.concat(this._frActive);
         this._frActive = new Array();
         this._vStore = this._vStore.concat(this._vActive);
         this._vActive = new Array();
         for(this._object in this._uvDictionary)
         {
            this._session = this._object as AbstractRenderSession;
            if(this._session.updated)
            {
               this._uvStore = this._uvStore.concat(this._uvDictionary[this._session] as Array);
               this._uvDictionary[this._session] = [];
            }
         }
         this._fStore = this._fStore.concat(this._fActive);
         this._fActive = new Array();
      }
      
      public function createVertexClassification(param1:Vertex) : VertexClassification
      {
         if(this._vc = this._vertexClassificationDictionary[param1])
         {
            return this._vc;
         }
         if(this._vcStore.length)
         {
            this._vc = this._vertexClassificationDictionary[param1] = this._vcStore.pop();
         }
         else
         {
            this._vc = this._vertexClassificationDictionary[param1] = new VertexClassification();
         }
         this._vc.vertex = param1;
         this._vc.plane = null;
         return this._vc;
      }
      
      public function createFrustum(param1:Object3D) : Frustum
      {
         if(this._frStore.length)
         {
            this._frActive.push(this._frustum = this.frustumDictionary[param1] = this._frStore.pop());
         }
         else
         {
            this._frActive.push(this._frustum = this.frustumDictionary[param1] = new Frustum());
         }
         return this._frustum;
      }
   }
}
