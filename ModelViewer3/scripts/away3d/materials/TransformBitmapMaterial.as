package away3d.materials
{
   import away3d.cameras.lenses.ZoomFocusLens;
   import away3d.containers.View3D;
   import away3d.core.base.Object3D;
   import away3d.core.draw.DrawTriangle;
   import away3d.core.math.Number3D;
   import away3d.core.utils.Debug;
   import away3d.core.utils.FaceMaterialVO;
   import away3d.core.utils.FaceVO;
   import §away3d:arcane§._bitmap;
   import §away3d:arcane§._bitmapDirty;
   import §away3d:arcane§._bitmapRect;
   import §away3d:arcane§._blendMode;
   import §away3d:arcane§._blendModeDirty;
   import §away3d:arcane§._colorTransform;
   import §away3d:arcane§._colorTransformDirty;
   import §away3d:arcane§._faceMaterialVO;
   import §away3d:arcane§._focus;
   import §away3d:arcane§._graphics;
   import §away3d:arcane§._mapping;
   import §away3d:arcane§._materialDirty;
   import §away3d:arcane§._s;
   import §away3d:arcane§._sourceVO;
   import §away3d:arcane§._texturemapping;
   import §away3d:arcane§._uvtData;
   import §away3d:arcane§._zeroPoint;
   import §away3d:arcane§.renderSource;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class TransformBitmapMaterial extends BitmapMaterial implements ITriangleMaterial, IUVMaterial
   {
       
      
      private var _u0:Number;
      
      private var _u1:Number;
      
      private var _invtexturemapping:Matrix;
      
      private var py:Number;
      
      private var _u2:Number;
      
      private var px:Number;
      
      private var line:Point;
      
      private var _v0:Number;
      
      private var _v1:Number;
      
      private var _v2:Number;
      
      private var _sin:Number;
      
      private var v0x:Number;
      
      private var v0y:Number;
      
      private var v0z:Number;
      
      private var overlap:Boolean;
      
      private var dot:Number;
      
      private var normalR:Number3D;
      
      private var v1x:Number;
      
      private var v1y:Number;
      
      private var v1z:Number;
      
      private var h:Number;
      
      private var i:String;
      
      private var flag:Boolean;
      
      private var _scaleX:Number = 1;
      
      private var _scaleY:Number = 1;
      
      private var mPoint2:Point;
      
      private var mPoint3:Point;
      
      private var mPoint4:Point;
      
      private var t:Matrix;
      
      private var _throughProjection:Boolean;
      
      private var w:Number;
      
      private var x:Number;
      
      private var y:Number;
      
      private var v0:Number3D;
      
      private var v1:Number3D;
      
      private var v2y:Number;
      
      private var v2z:Number;
      
      private var v2x:Number;
      
      private var _projectionDirty:Boolean;
      
      private var mapa:Number;
      
      private var mapb:Number;
      
      private var mapc:Number;
      
      private var mapd:Number;
      
      private var v2:Number3D;
      
      private var point:Point;
      
      private var mPoint1:Point;
      
      private var point1:Point;
      
      private var point3:Point;
      
      private var fPoint1:Point;
      
      private var fPoint2:Point;
      
      private var DOWN:Number3D;
      
      private var fPoint4:Point;
      
      private var zero:Number;
      
      private var fPoint3:Point;
      
      private var _globalProjection:Boolean;
      
      private var sign:Number;
      
      private var point2:Point;
      
      private var _cos:Number;
      
      private var _N:Number3D;
      
      private var _projectionVector:Number3D;
      
      private var _M:Number3D;
      
      private var faceVO:FaceVO;
      
      private var _rotation:Number = 0;
      
      private var maptx:Number;
      
      private var _transformDirty:Boolean;
      
      private var _offsetX:Number = 0;
      
      private var _offsetY:Number = 0;
      
      var _transform:Matrix;
      
      private var mapty:Number;
      
      private var RIGHT:Number3D;
      
      public function TransformBitmapMaterial(param1:BitmapData, param2:Object = null)
      {
         this._transform = new Matrix();
         this._N = new Number3D();
         this._M = new Number3D();
         this.DOWN = new Number3D(0,-1,0);
         this.RIGHT = new Number3D(1,0,0);
         this.normalR = new Number3D();
         this.v0 = new Number3D();
         this.v1 = new Number3D();
         this.v2 = new Number3D();
         this.fPoint1 = new Point();
         this.fPoint2 = new Point();
         this.fPoint3 = new Point();
         this.fPoint4 = new Point();
         this.mPoint1 = new Point();
         this.mPoint2 = new Point();
         this.mPoint3 = new Point();
         this.mPoint4 = new Point();
         this.line = new Point();
         super(param1,param2);
         this.transform = ini.getObject("transform",Matrix) as Matrix;
         this.scaleX = ini.getNumber("scaleX",this._scaleX);
         this.scaleY = ini.getNumber("scaleY",this._scaleY);
         this.offsetX = ini.getNumber("offsetX",this._offsetX);
         this.offsetY = ini.getNumber("offsetY",this._offsetY);
         this.rotation = ini.getNumber("rotation",this._rotation);
         this.projectionVector = ini.getObject("projectionVector",Number3D) as Number3D;
         this.throughProjection = ini.getBoolean("throughProjection",true);
         this.globalProjection = ini.getBoolean("globalProjection",false);
      }
      
      public function set throughProjection(param1:Boolean) : void
      {
         this._throughProjection = param1;
         this._projectionDirty = true;
      }
      
      public function set rotation(param1:Number) : void
      {
         if(isNaN(param1))
         {
            throw new Error("isNaN(rotation)");
         }
         if(param1 == Infinity)
         {
            Debug.warning("rotation == Infinity");
         }
         if(param1 == -Infinity)
         {
            Debug.warning("rotation == -Infinity");
         }
         this._rotation = param1;
         this._cos = Math.cos(this._rotation);
         this._sin = Math.sin(this._rotation);
         this._transformDirty = true;
      }
      
      private function findSeparatingAxis(param1:Array, param2:Array) : Boolean
      {
         if(this.checkEdge(param1,param2))
         {
            return true;
         }
         if(this.checkEdge(param2,param1))
         {
            return true;
         }
         return false;
      }
      
      override public function updateMaterial(param1:Object3D, param2:View3D) : void
      {
         _graphics = null;
         if(_colorTransformDirty)
         {
            updateColorTransform();
         }
         if(_bitmapDirty)
         {
            updateRenderBitmap();
         }
         if(this._projectionDirty || this._transformDirty)
         {
            invalidateFaces();
         }
         if(this._transformDirty)
         {
            this.updateTransform();
         }
         if(_materialDirty || _blendModeDirty)
         {
            clearFaces();
         }
         this._projectionDirty = false;
         _blendModeDirty = false;
      }
      
      public function get throughProjection() : Boolean
      {
         return this._throughProjection;
      }
      
      public function get offsetY() : Number
      {
         return this._offsetY;
      }
      
      public function get offsetX() : Number
      {
         return this._offsetX;
      }
      
      override public function getPixel32(param1:Number, param2:Number) : uint
      {
         if(this._transform)
         {
            this.x = param1 * _bitmap.width;
            this.y = (1 - param2) * _bitmap.height;
            this.t = this._transform.clone();
            this.t.invert();
            if(repeat)
            {
               this.px = (this.x * this.t.a + this.y * this.t.c + this.t.tx) % _bitmap.width;
               this.py = (this.x * this.t.b + this.y * this.t.d + this.t.ty) % _bitmap.height;
               if(this.px < 0)
               {
                  this.px = this.px + _bitmap.width;
               }
               if(this.py < 0)
               {
                  this.py = this.py + _bitmap.height;
               }
               return _bitmap.getPixel32(this.px,this.py);
            }
            return _bitmap.getPixel32(this.x * this.t.a + this.y * this.t.c + this.t.tx,this.x * this.t.b + this.y * this.t.d + this.t.ty);
         }
         return super.getPixel32(param1,param2);
      }
      
      public function set offsetX(param1:Number) : void
      {
         if(isNaN(param1))
         {
            throw new Error("isNaN(offsetX)");
         }
         if(param1 == Infinity)
         {
            Debug.warning("offsetX == Infinity");
         }
         if(param1 == -Infinity)
         {
            Debug.warning("offsetX == -Infinity");
         }
         this._offsetX = param1;
         this._transformDirty = true;
      }
      
      public function set offsetY(param1:Number) : void
      {
         if(isNaN(param1))
         {
            throw new Error("isNaN(offsetY)");
         }
         if(param1 == Infinity)
         {
            Debug.warning("offsetY == Infinity");
         }
         if(param1 == -Infinity)
         {
            Debug.warning("offsetY == -Infinity");
         }
         this._offsetY = param1;
         this._transformDirty = true;
      }
      
      public function get scaleY() : Number
      {
         return this._scaleY;
      }
      
      public function get scaleX() : Number
      {
         return this._scaleX;
      }
      
      public function get globalProjection() : Boolean
      {
         return this._globalProjection;
      }
      
      public function get projectionVector() : Number3D
      {
         return this._projectionVector;
      }
      
      public function get transform() : Matrix
      {
         return this._transform;
      }
      
      private function projectUV(param1:DrawTriangle) : Vector.<Number>
      {
         this.faceVO = param1.faceVO;
         if(this.globalProjection)
         {
            this.v0.transform(this.faceVO.v0.position,param1.source.sceneTransform);
            this.v1.transform(this.faceVO.v1.position,param1.source.sceneTransform);
            this.v2.transform(this.faceVO.v2.position,param1.source.sceneTransform);
         }
         else
         {
            this.v0 = this.faceVO.v0.position;
            this.v1 = this.faceVO.v1.position;
            this.v2 = this.faceVO.v2.position;
         }
         this.v0x = this.v0.x;
         this.v0y = this.v0.y;
         this.v0z = this.v0.z;
         this.v1x = this.v1.x;
         this.v1y = this.v1.y;
         this.v1z = this.v1.z;
         this.v2x = this.v2.x;
         this.v2y = this.v2.y;
         this.v2z = this.v2.z;
         _uvtData[0] = this.v0x * this._N.x + this.v0y * this._N.y + this.v0z * this._N.z;
         _uvtData[1] = this.v0x * this._M.x + this.v0y * this._M.y + this.v0z * this._M.z;
         _uvtData[3] = this.v1x * this._N.x + this.v1y * this._N.y + this.v1z * this._N.z;
         _uvtData[4] = this.v1x * this._M.x + this.v1y * this._M.y + this.v1z * this._M.z;
         _uvtData[6] = this.v2x * this._N.x + this.v2y * this._N.y + this.v2z * this._N.z;
         _uvtData[7] = this.v2x * this._M.x + this.v2y * this._M.y + this.v2z * this._M.z;
         return _uvtData;
      }
      
      private function getContainerPoints(param1:Rectangle) : Array
      {
         return [param1.topLeft,new Point(param1.top,param1.right),param1.bottomRight,new Point(param1.bottom,param1.left)];
      }
      
      override protected function getMapping(param1:DrawTriangle) : Matrix
      {
         if(param1.generated)
         {
            if(!this.projectionVector)
            {
               _texturemapping = param1.transformUV(this).clone();
               _texturemapping.invert();
            }
            if(this._transform)
            {
               _mapping = this._transform.clone();
               _mapping.concat(_texturemapping);
            }
            else
            {
               _mapping = _texturemapping;
            }
            return _mapping;
         }
         _faceMaterialVO = getFaceMaterialVO(param1.faceVO,param1.source);
         if(!_faceMaterialVO.invalidated)
         {
            return _faceMaterialVO.texturemapping;
         }
         _faceMaterialVO.invalidated = false;
         if(!this.projectionVector)
         {
            _texturemapping = param1.transformUV(this).clone();
            _texturemapping.invert();
         }
         if(this._transform)
         {
            _faceMaterialVO.texturemapping = this._transform.clone();
            _faceMaterialVO.texturemapping.concat(_texturemapping);
            return _faceMaterialVO.texturemapping;
         }
         return _faceMaterialVO.texturemapping = _texturemapping;
      }
      
      private function getFacePoints(param1:Matrix) : Array
      {
         this.fPoint1.x = this._u0 = param1.tx;
         this.fPoint2.x = param1.a + this._u0;
         this.fPoint3.x = param1.c + this._u0;
         this.fPoint1.y = this._v0 = param1.ty;
         this.fPoint2.y = param1.b + this._v0;
         this.fPoint3.y = param1.d + this._v0;
         return [this.fPoint1,this.fPoint2,this.fPoint3];
      }
      
      public function get rotation() : Number
      {
         return this._rotation;
      }
      
      public function set globalProjection(param1:Boolean) : void
      {
         this._globalProjection = param1;
         this._projectionDirty = true;
      }
      
      public function set scaleY(param1:Number) : void
      {
         if(isNaN(param1))
         {
            throw new Error("isNaN(scaleY)");
         }
         if(param1 == Infinity)
         {
            Debug.warning("scaleY == Infinity");
         }
         if(param1 == -Infinity)
         {
            Debug.warning("scaleY == -Infinity");
         }
         if(param1 == 0)
         {
            Debug.warning("scaleY == 0");
         }
         this._scaleY = param1;
         this._transformDirty = true;
      }
      
      public function set scaleX(param1:Number) : void
      {
         if(isNaN(param1))
         {
            throw new Error("isNaN(scaleX)");
         }
         if(param1 == Infinity)
         {
            Debug.warning("scaleX == Infinity");
         }
         if(param1 == -Infinity)
         {
            Debug.warning("scaleX == -Infinity");
         }
         if(param1 == 0)
         {
            Debug.warning("scaleX == 0");
         }
         this._scaleX = param1;
         this._transformDirty = true;
      }
      
      private function updateTransform() : void
      {
         this._transformDirty = false;
         if(this._scaleX == 1 && this._scaleY == 1 && this._offsetX == 0 && this._offsetY == 0 && this._rotation == 0)
         {
            this._transform = null;
         }
         else
         {
            this._transform = new Matrix();
            this._transform.scale(this._scaleX,this._scaleY);
            this._transform.rotate(this._rotation);
            this._transform.translate(this._offsetX,this._offsetY);
         }
         _materialDirty = true;
      }
      
      private function getMappingPoints(param1:Matrix) : Array
      {
         this.mapa = param1.a * width;
         this.mapb = param1.b * width;
         this.mapc = param1.c * height;
         this.mapd = param1.d * height;
         this.maptx = param1.tx;
         this.mapty = param1.ty;
         this.mPoint1.x = this.maptx;
         this.mPoint1.y = this.mapty;
         this.mPoint2.x = this.maptx + this.mapc;
         this.mPoint2.y = this.mapty + this.mapd;
         this.mPoint3.x = this.maptx + this.mapa + this.mapc;
         this.mPoint3.y = this.mapty + this.mapb + this.mapd;
         this.mPoint4.x = this.maptx + this.mapa;
         this.mPoint4.y = this.mapty + this.mapb;
         return [this.mPoint1,this.mPoint2,this.mPoint3,this.mPoint4];
      }
      
      override public function renderTriangle(param1:DrawTriangle) : void
      {
         if(this._projectionVector && !this.throughProjection)
         {
            if(this.globalProjection)
            {
               this.normalR.rotate(param1.faceVO.face.normal,param1.source.sceneTransform);
               if(this.normalR.dot(this._projectionVector) < 0)
               {
                  return;
               }
            }
            else if(param1.faceVO.face.normal.dot(this._projectionVector) < 0)
            {
               return;
            }
         }
         super.renderTriangle(param1);
      }
      
      override protected function getUVData(param1:DrawTriangle) : Vector.<Number>
      {
         if(param1.view.camera.lens is ZoomFocusLens)
         {
            _focus = param1.view.camera.focus;
         }
         else
         {
            _focus = 0;
         }
         if(param1.generated)
         {
            _uvtData[2] = 1 / (_focus + param1.v0.z);
            _uvtData[5] = 1 / (_focus + param1.v1.z);
            _uvtData[8] = 1 / (_focus + param1.v2.z);
            if(this.projectionVector)
            {
               _uvtData = this.projectUV(param1);
               this._u0 = (_uvtData[0] - this._offsetX) / width;
               this._u1 = (_uvtData[3] - this._offsetX) / width;
               this._u2 = (_uvtData[6] - this._offsetX) / width;
               this._v0 = (_uvtData[1] - this._offsetY) / height;
               this._v1 = (_uvtData[4] - this._offsetY) / height;
               this._v2 = (_uvtData[7] - this._offsetY) / height;
            }
            else
            {
               this._u0 = param1.uv0.u - this._offsetX / width;
               this._u1 = param1.uv1.u - this._offsetX / width;
               this._u2 = param1.uv2.u - this._offsetX / width;
               this._v0 = 1 - param1.uv0.v - this._offsetY / height;
               this._v1 = 1 - param1.uv1.v - this._offsetY / height;
               this._v2 = 1 - param1.uv2.v - this._offsetY / height;
            }
            if(this._rotation)
            {
               _uvtData[0] = (this._u0 * this._cos - this._v0 * this._sin) / this._scaleX;
               _uvtData[1] = (this._u0 * this._sin + this._v0 * this._cos) / this._scaleY;
               _uvtData[3] = (this._u1 * this._cos - this._v1 * this._sin) / this._scaleX;
               _uvtData[4] = (this._u1 * this._sin + this._v1 * this._cos) / this._scaleY;
               _uvtData[6] = (this._u2 * this._cos - this._v2 * this._sin) / this._scaleX;
               _uvtData[7] = (this._u2 * this._sin + this._v2 * this._cos) / this._scaleY;
            }
            else
            {
               _uvtData[0] = this._u0 / this._scaleX;
               _uvtData[1] = this._v0 / this._scaleY;
               _uvtData[3] = this._u1 / this._scaleX;
               _uvtData[4] = this._v1 / this._scaleY;
               _uvtData[6] = this._u2 / this._scaleX;
               _uvtData[7] = this._v2 / this._scaleY;
            }
            return _uvtData;
         }
         _faceMaterialVO = getFaceMaterialVO(param1.faceVO,param1.source,param1.view);
         _faceMaterialVO.uvtData[2] = 1 / (_focus + param1.v0.z);
         _faceMaterialVO.uvtData[5] = 1 / (_focus + param1.v1.z);
         _faceMaterialVO.uvtData[8] = 1 / (_focus + param1.v2.z);
         if(!_faceMaterialVO.invalidated)
         {
            return _faceMaterialVO.uvtData;
         }
         _faceMaterialVO.invalidated = false;
         if(this.projectionVector)
         {
            _uvtData = this.projectUV(param1);
            this._u0 = (_uvtData[0] - this._offsetX) / width;
            this._u1 = (_uvtData[3] - this._offsetX) / width;
            this._u2 = (_uvtData[6] - this._offsetX) / width;
            this._v0 = (_uvtData[1] - this._offsetY) / height;
            this._v1 = (_uvtData[4] - this._offsetY) / height;
            this._v2 = (_uvtData[7] - this._offsetY) / height;
         }
         else
         {
            this._u0 = param1.uv0.u - this._offsetX / width;
            this._u1 = param1.uv1.u - this._offsetX / width;
            this._u2 = param1.uv2.u - this._offsetX / width;
            this._v0 = 1 - param1.uv0.v - this._offsetY / height;
            this._v1 = 1 - param1.uv1.v - this._offsetY / height;
            this._v2 = 1 - param1.uv2.v - this._offsetY / height;
         }
         if(this._rotation)
         {
            _faceMaterialVO.uvtData[0] = (this._u0 * this._cos - this._v0 * this._sin) / this._scaleX;
            _faceMaterialVO.uvtData[1] = (this._u0 * this._sin + this._v0 * this._cos) / this._scaleY;
            _faceMaterialVO.uvtData[3] = (this._u1 * this._cos - this._v1 * this._sin) / this._scaleX;
            _faceMaterialVO.uvtData[4] = (this._u1 * this._sin + this._v1 * this._cos) / this._scaleY;
            _faceMaterialVO.uvtData[6] = (this._u2 * this._cos - this._v2 * this._sin) / this._scaleX;
            _faceMaterialVO.uvtData[7] = (this._u2 * this._sin + this._v2 * this._cos) / this._scaleY;
         }
         else
         {
            _faceMaterialVO.uvtData[0] = this._u0 / this._scaleX;
            _faceMaterialVO.uvtData[1] = this._v0 / this._scaleY;
            _faceMaterialVO.uvtData[3] = this._u1 / this._scaleX;
            _faceMaterialVO.uvtData[4] = this._v1 / this._scaleY;
            _faceMaterialVO.uvtData[6] = this._u2 / this._scaleX;
            _faceMaterialVO.uvtData[7] = this._v2 / this._scaleY;
         }
         return _faceMaterialVO.uvtData;
      }
      
      public function set transform(param1:Matrix) : void
      {
         this._transform = param1;
         if(this._transform)
         {
            this._rotation = Math.atan2(this._transform.b,this._transform.a);
            this._cos = Math.cos(this._rotation);
            this._sin = Math.sin(this._rotation);
            this._scaleX = this._transform.a / Math.cos(this._rotation);
            this._scaleY = this._transform.d / Math.cos(this._rotation);
            this._offsetX = this._transform.tx;
            this._offsetY = this._transform.ty;
         }
         else
         {
            this._scaleX = this._scaleY = 1;
            this._offsetX = this._offsetY = this._rotation = 0;
         }
      }
      
      public function set projectionVector(param1:Number3D) : void
      {
         this._projectionVector = param1;
         if(this._projectionVector)
         {
            this._N.cross(this._projectionVector,this.DOWN);
            if(!this._N.modulo)
            {
               this._N = this.RIGHT;
            }
            this._M.cross(this._N,this._projectionVector);
            this._N.cross(this._M,this._projectionVector);
            this._N.normalize();
            this._M.normalize();
         }
         this._projectionDirty = true;
      }
      
      private function checkEdge(param1:Array, param2:Array) : Boolean
      {
         do
         {
            for(this.i in param1)
            {
               this.point2 = param1[this.i];
               if(int(this.i) == 0)
               {
                  this.point1 = param1[param1.length - 1];
                  this.point3 = param1[param1.length - 2];
               }
               else
               {
                  this.point1 = param1[int(this.i) - 1];
                  if(int(this.i) == 1)
                  {
                     this.point3 = param1[param1.length - 1];
                  }
                  else
                  {
                     this.point3 = param1[int(this.i) - 2];
                  }
               }
               this.line.x = this.point2.y - this.point1.y;
               this.line.y = this.point1.x - this.point2.x;
               this.zero = this.point1.x * this.line.x + this.point1.y * this.line.y;
               this.sign = this.zero - this.point3.x * this.line.x - this.point3.y * this.line.y;
               this.flag = true;
               for each(this.point in param2)
               {
                  this.dot = this.point.x * this.line.x + this.point.y * this.line.y;
                  if(this.zero * this.sign > this.dot * this.sign)
                  {
                     this.flag = false;
                     break;
                  }
               }
            }
            return false;
         }
         while(!this.flag);
         
         return true;
      }
      
      override public function renderBitmapLayer(param1:DrawTriangle, param2:Rectangle, param3:FaceMaterialVO) : FaceMaterialVO
      {
         if(this._transform)
         {
            _mapping = this._transform.clone();
         }
         else
         {
            _mapping = new Matrix();
         }
         if(!this._projectionVector)
         {
            renderSource(param1.source,param2,_mapping);
         }
         _faceMaterialVO = getFaceMaterialVO(param1.faceVO);
         if(param3.resized)
         {
            param3.resized = false;
            _faceMaterialVO.resized = true;
         }
         _faceMaterialVO.invtexturemapping = param3.invtexturemapping;
         if(param3.updated || _faceMaterialVO.invalidated || _faceMaterialVO.updated)
         {
            param3.updated = false;
            _bitmapRect = param1.faceVO.bitmapRect;
            if(_faceMaterialVO.invalidated)
            {
               _faceMaterialVO.invalidated = false;
            }
            else
            {
               _faceMaterialVO.updated = true;
            }
            _faceMaterialVO.bitmap = param3.bitmap.clone();
            if(this._projectionVector)
            {
               this._invtexturemapping = _faceMaterialVO.invtexturemapping;
               _mapping.concat(this._invtexturemapping);
               this.normalR.clone(param1.faceVO.face.normal);
               if(this._globalProjection)
               {
                  this.normalR.rotate(this.normalR,param1.source.sceneTransform);
               }
               if((this.throughProjection || this.normalR.dot(this._projectionVector) >= 0) && (repeat || !this.findSeparatingAxis(this.getFacePoints(this._invtexturemapping),this.getMappingPoints(_mapping))))
               {
                  if(_faceMaterialVO.cleared)
                  {
                     _faceMaterialVO.bitmap = param3.bitmap.clone();
                  }
                  _faceMaterialVO.cleared = false;
                  _faceMaterialVO.updated = true;
                  _graphics = _s.graphics;
                  _graphics.clear();
                  _graphics.beginBitmapFill(_bitmap,_mapping,repeat,smooth);
                  _graphics.drawRect(0,0,_bitmapRect.width,_bitmapRect.height);
                  _graphics.endFill();
                  _faceMaterialVO.bitmap.draw(_s,null,_colorTransform,_blendMode,_faceMaterialVO.bitmap.rect);
               }
            }
            else if(repeat && !this.findSeparatingAxis(this.getContainerPoints(param2),this.getMappingPoints(_mapping)))
            {
               _faceMaterialVO.cleared = false;
               _faceMaterialVO.updated = true;
               _faceMaterialVO.bitmap.copyPixels(_sourceVO.bitmap,_bitmapRect,_zeroPoint,null,null,true);
            }
         }
         return _faceMaterialVO;
      }
   }
}
