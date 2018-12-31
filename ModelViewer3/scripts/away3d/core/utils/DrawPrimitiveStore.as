package away3d.core.utils
{
   import away3d.containers.View3D;
   import away3d.core.base.Object3D;
   import away3d.core.base.UV;
   import away3d.core.base.Vertex;
   import away3d.core.draw.DrawDisplayObject;
   import away3d.core.draw.DrawScaledBitmap;
   import away3d.core.draw.DrawSegment;
   import away3d.core.draw.DrawTriangle;
   import away3d.core.draw.ScreenVertex;
   import away3d.core.render.AbstractRenderSession;
   import away3d.materials.ISegmentMaterial;
   import away3d.materials.ITriangleMaterial;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.utils.Dictionary;
   
   public class DrawPrimitiveStore
   {
       
      
      private var _sv:ScreenVertex;
      
      private var _cbStore:Array;
      
      private var _sbArray:Array;
      
      private var _dbDictionary:Dictionary;
      
      private var _seg:DrawSegment;
      
      private var _sbStore:Array;
      
      private var _sbitmap:DrawScaledBitmap;
      
      private var _sbDictionary:Dictionary;
      
      private var _dtDictionary:Dictionary;
      
      public var blockerDictionary:Dictionary;
      
      private var _cbDictionary:Dictionary;
      
      private var _vertexDictionary:Dictionary;
      
      private var _source:Object3D;
      
      private var _dbArray:Array;
      
      private var _vertex:Object;
      
      private var _dbStore:Array;
      
      public var view:View3D;
      
      private var _dsArray:Array;
      
      private var _dsStore:Array;
      
      private var _doArray:Array;
      
      private var _session:AbstractRenderSession;
      
      private var _dsDictionary:Dictionary;
      
      private var _object:Object;
      
      private var _doStore:Array;
      
      private var _doDictionary:Dictionary;
      
      private var _dtArray:Array;
      
      private var _dobject:DrawDisplayObject;
      
      private var _tri:DrawTriangle;
      
      private var _sourceDictionary:Dictionary;
      
      private var _dtStore:Array;
      
      private var _cbArray:Array;
      
      private var _svStore:Array;
      
      public function DrawPrimitiveStore()
      {
         this._sourceDictionary = new Dictionary(true);
         this._svStore = new Array();
         this._dtDictionary = new Dictionary(true);
         this._dtStore = new Array();
         this._dsDictionary = new Dictionary(true);
         this._dsStore = new Array();
         this._dbDictionary = new Dictionary(true);
         this._dbStore = new Array();
         this._cbDictionary = new Dictionary(true);
         this._cbStore = new Array();
         this._sbDictionary = new Dictionary(true);
         this._sbStore = new Array();
         this._doDictionary = new Dictionary(true);
         this._doStore = new Array();
         super();
      }
      
      public function createDrawTriangle(param1:Object3D, param2:FaceVO, param3:ITriangleMaterial, param4:ScreenVertex, param5:ScreenVertex, param6:ScreenVertex, param7:UV, param8:UV, param9:UV, param10:Boolean = false) : DrawTriangle
      {
         if(!(this._dtArray = this._dtDictionary[param1.session]))
         {
            this._dtArray = this._dtDictionary[param1.session] = [];
         }
         if(this._dtStore.length)
         {
            this._dtArray.push(this._tri = this._dtStore.pop());
         }
         else
         {
            this._dtArray.push(this._tri = new DrawTriangle());
            this._tri.view = this.view;
            this._tri.create = this.createDrawTriangle;
         }
         this._tri.generated = param10;
         this._tri.source = param1;
         this._tri.faceVO = param2;
         this._tri.material = param3;
         this._tri.v0 = param4;
         this._tri.v1 = param5;
         this._tri.v2 = param6;
         this._tri.uv0 = param7;
         this._tri.uv1 = param8;
         this._tri.uv2 = param9;
         this._tri.calc();
         return this._tri;
      }
      
      public function createDrawDisplayObject(param1:Object3D, param2:ScreenVertex, param3:AbstractRenderSession, param4:DisplayObject, param5:Boolean = false) : DrawDisplayObject
      {
         if(!(this._doArray = this._doDictionary[param1.session]))
         {
            this._doArray = this._doDictionary[param1.session] = [];
         }
         if(this._doStore.length)
         {
            this._doArray.push(this._dobject = this._doStore.pop());
         }
         else
         {
            this._doArray.push(this._dobject = new DrawDisplayObject());
            this._dobject.view = this.view;
            this._dobject.create = this.createDrawSegment;
         }
         this._dobject.generated = param5;
         this._dobject.source = param1;
         this._dobject.screenvertex = param2;
         this._dobject.session = param3;
         this._dobject.displayobject = param4;
         this._dobject.calc();
         return this._dobject;
      }
      
      public function createDrawScaledBitmap(param1:Object3D, param2:ScreenVertex, param3:Boolean, param4:BitmapData, param5:Number, param6:Number, param7:Boolean = false) : DrawScaledBitmap
      {
         if(!(this._sbArray = this._sbDictionary[param1.session]))
         {
            this._sbArray = this._sbDictionary[param1.session] = [];
         }
         if(this._sbStore.length)
         {
            this._sbArray.push(this._sbitmap = this._sbStore.pop());
         }
         else
         {
            this._sbArray.push(this._sbitmap = new DrawScaledBitmap());
            this._sbitmap.view = this.view;
            this._sbitmap.create = this.createDrawSegment;
         }
         this._sbitmap.generated = param7;
         this._sbitmap.source = param1;
         this._sbitmap.screenvertex = param2;
         this._sbitmap.smooth = param3;
         this._sbitmap.bitmap = param4;
         this._sbitmap.scale = param5;
         this._sbitmap.rotation = param6;
         this._sbitmap.calc();
         return this._sbitmap;
      }
      
      public function createDrawSegment(param1:Object3D, param2:ISegmentMaterial, param3:ScreenVertex, param4:ScreenVertex, param5:Boolean = false) : DrawSegment
      {
         if(!(this._dsArray = this._dsDictionary[param1.session]))
         {
            this._dsArray = this._dsDictionary[param1.session] = [];
         }
         if(this._dsStore.length)
         {
            this._dsArray.push(this._seg = this._dsStore.pop());
         }
         else
         {
            this._dsArray.push(this._seg = new DrawSegment());
            this._seg.view = this.view;
            this._seg.create = this.createDrawSegment;
         }
         this._seg.generated = param5;
         this._seg.source = param1;
         this._seg.material = param2;
         this._seg.v0 = param3;
         this._seg.v1 = param4;
         this._seg.calc();
         return this._seg;
      }
      
      public function createScreenVertex(param1:Vertex) : ScreenVertex
      {
         if(this._sv = this._vertexDictionary[param1])
         {
            return this._sv;
         }
         if(this._svStore.length)
         {
            this._sv = this._vertexDictionary[param1] = this._svStore.pop();
         }
         else
         {
            this._sv = this._vertexDictionary[param1] = new ScreenVertex();
         }
         return this._sv;
      }
      
      public function reset() : void
      {
         for(this._object in this._sourceDictionary)
         {
            this._source = this._object as Object3D;
            if(this._source.session && this._source.session.updated)
            {
               for(this._vertex in this._sourceDictionary[this._source])
               {
                  this._sv = this._sourceDictionary[this._source][this._vertex];
                  this._svStore.push(this._sv);
                  delete this._sourceDictionary[this._source][this._vertex];
               }
            }
         }
         for(this._object in this._dtDictionary)
         {
            this._session = this._object as AbstractRenderSession;
            if(this._session.updated)
            {
               this._dtStore = this._dtStore.concat(this._dtDictionary[this._session] as Array);
               delete this._dtDictionary[this._session];
            }
         }
         for(this._object in this._dsDictionary)
         {
            this._session = this._object as AbstractRenderSession;
            if(this._session.updated)
            {
               this._dsStore = this._dsStore.concat(this._dsDictionary[this._session] as Array);
               delete this._dsDictionary[this._session];
            }
         }
         for(this._object in this._dbDictionary)
         {
            this._session = this._object as AbstractRenderSession;
            if(this._session.updated)
            {
               this._dbStore = this._dbStore.concat(this._dbDictionary[this._session] as Array);
               delete this._dbDictionary[this._session];
            }
         }
         for(this._object in this._cbDictionary)
         {
            this._session = this._object as AbstractRenderSession;
            if(this._session.updated)
            {
               this._cbStore = this._cbStore.concat(this._cbDictionary[this._session] as Array);
               delete this._cbDictionary[this._session];
            }
         }
         for(this._object in this._sbDictionary)
         {
            this._session = this._object as AbstractRenderSession;
            if(this._session.updated)
            {
               this._sbStore = this._sbStore.concat(this._sbDictionary[this._session] as Array);
               delete this._sbDictionary[this._session];
            }
         }
         for(this._object in this._doDictionary)
         {
            this._session = this._object as AbstractRenderSession;
            if(this._session.updated)
            {
               this._doStore = this._doStore.concat(this._doDictionary[this._session] as Array);
               delete this._doDictionary[this._session];
            }
         }
      }
      
      public function createVertexDictionary(param1:Object3D) : Dictionary
      {
         if(!(this._vertexDictionary = this._sourceDictionary[param1]))
         {
            this._vertexDictionary = this._sourceDictionary[param1] = new Dictionary(true);
         }
         return this._vertexDictionary;
      }
   }
}
