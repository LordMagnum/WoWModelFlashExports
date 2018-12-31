package away3d.materials
{
   import away3d.cameras.lenses.ZoomFocusLens;
   import away3d.containers.View3D;
   import away3d.core.base.Object3D;
   import away3d.core.draw.DrawTriangle;
   import away3d.core.draw.ScreenVertex;
   import away3d.core.math.MatrixAway3D;
   import away3d.core.math.Number3D;
   import away3d.core.render.AbstractRenderSession;
   import away3d.core.utils.FaceMaterialVO;
   import away3d.core.utils.FaceVO;
   import away3d.core.utils.Init;
   import away3d.events.MaterialEvent;
   import §away3d:arcane§.*;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class BitmapMaterial extends EventDispatcher implements ITriangleMaterial, IUVMaterial, ILayerMaterial
   {
       
      
      var _green:Number = 1;
      
      var _uvtData:Vector.<Number>;
      
      private var _near:Number;
      
      var _blendMode:String;
      
      private var triangle:DrawTriangle;
      
      var _bitmapDirty:Boolean;
      
      var _blue:Number = 1;
      
      var _renderBitmap:BitmapData;
      
      var _zeroPoint:Point;
      
      var _colorTransformDirty:Boolean;
      
      var _bitmap:BitmapData;
      
      var _bitmapRect:Rectangle;
      
      private var _debug:Boolean;
      
      var _session:AbstractRenderSession;
      
      var _alpha:Number = 1;
      
      private var map:Matrix;
      
      var _color:uint = 16777215;
      
      private var _nn:Number3D;
      
      var _colorTransform:ColorTransform;
      
      private var _sv0:ScreenVertex;
      
      private var _sv1:ScreenVertex;
      
      var _texturemapping:Matrix;
      
      var _sourceVO:FaceMaterialVO;
      
      private var _materialupdated:MaterialEvent;
      
      private var x:Number;
      
      private var y:Number;
      
      var _faceMaterialVO:FaceMaterialVO;
      
      private var _view:View3D;
      
      var _mapping:Matrix;
      
      private var _shape:Shape;
      
      private var svArray:Array;
      
      private var _repeat:Boolean;
      
      var _blendModeDirty:Boolean;
      
      private var _smooth:Boolean;
      
      var _red:Number = 1;
      
      var _focus:Number;
      
      protected var ini:Init;
      
      var _graphics:Graphics;
      
      var _materialDirty:Boolean;
      
      var _faceDictionary:Dictionary;
      
      var _s:Shape;
      
      private var _showNormals:Boolean;
      
      private var _precision:Number;
      
      public function BitmapMaterial(param1:BitmapData, param2:Object = null)
      {
         this._uvtData = new Vector.<Number>(9,true);
         this._faceDictionary = new Dictionary(true);
         this._zeroPoint = new Point(0,0);
         this._s = new Shape();
         this.map = new Matrix();
         this.triangle = new DrawTriangle();
         this.svArray = new Array();
         super();
         this._bitmap = param1;
         this.ini = Init.parse(param2);
         this.smooth = this.ini.getBoolean("smooth",false);
         this.debug = this.ini.getBoolean("debug",false);
         this.repeat = this.ini.getBoolean("repeat",false);
         this.precision = this.ini.getNumber("precision",0);
         this._blendMode = this.ini.getString("blendMode",BlendMode.NORMAL);
         this.alpha = this.ini.getNumber("alpha",this._alpha,{
            "min":0,
            "max":1
         });
         this.color = this.ini.getColor("color",this._color);
         this.colorTransform = this.ini.getObject("colorTransform",ColorTransform) as ColorTransform;
         this.showNormals = this.ini.getBoolean("showNormals",false);
         this._colorTransformDirty = true;
         this.createVertexArray();
      }
      
      public function set precision(param1:Number) : void
      {
         this._precision = param1 * param1 * 1.4;
         this._materialDirty = true;
      }
      
      public function set color(param1:uint) : void
      {
         if(this._color == param1)
         {
            return;
         }
         this._color = param1;
         this._red = ((this._color & 16711680) >> 16) / 255;
         this._green = ((this._color & 65280) >> 8) / 255;
         this._blue = (this._color & 255) / 255;
         this._colorTransformDirty = true;
      }
      
      public function updateMaterial(param1:Object3D, param2:View3D) : void
      {
         this._graphics = null;
         if(this._colorTransformDirty)
         {
            this.updateColorTransform();
         }
         if(this._bitmapDirty)
         {
            this.updateRenderBitmap();
         }
         if(this._materialDirty || this._blendModeDirty)
         {
            this.clearFaces(param1,param2);
         }
         this._blendModeDirty = false;
      }
      
      public function get height() : Number
      {
         return this._bitmap.height;
      }
      
      public function set blendMode(param1:String) : void
      {
         if(this._blendMode == param1)
         {
            return;
         }
         this._blendMode = param1;
         this._blendModeDirty = true;
      }
      
      public function get bitmap() : BitmapData
      {
         return this._bitmap;
      }
      
      public function set repeat(param1:Boolean) : void
      {
         if(this._repeat == param1)
         {
            return;
         }
         this._repeat = param1;
         this._materialDirty = true;
      }
      
      public function removeOnMaterialUpdate(param1:Function) : void
      {
         removeEventListener(MaterialEvent.MATERIAL_UPDATED,param1,false);
      }
      
      public function invalidateFaces(param1:Object3D = null, param2:View3D = null) : void
      {
         this._materialDirty = true;
         for each(this._faceMaterialVO in this._faceDictionary)
         {
            this._faceMaterialVO.invalidated = true;
         }
      }
      
      public function getPixel32(param1:Number, param2:Number) : uint
      {
         if(this.repeat)
         {
            this.x = param1 % 1;
            this.y = 1 - param2 % 1;
         }
         else
         {
            this.x = param1;
            this.y = 1 - param2;
         }
         return this._bitmap.getPixel32(this.x * this._bitmap.width,this.y * this._bitmap.height);
      }
      
      public function get colorTransform() : ColorTransform
      {
         return this._colorTransform;
      }
      
      function renderSource(param1:Object3D, param2:Rectangle, param3:Matrix) : void
      {
         if(!(this._sourceVO = this._faceDictionary[param1]))
         {
            this._sourceVO = this._faceDictionary[param1] = new FaceMaterialVO();
         }
         this._sourceVO.resize(param2.width,param2.height);
         if(this._sourceVO.invalidated || this._sourceVO.updated)
         {
            param3.scale(param2.width / this.width,param2.height / this.height);
            this._sourceVO.invalidated = false;
            this._sourceVO.cleared = false;
            this._sourceVO.updated = false;
            if(param3.a == 1 && param3.d == 1 && param3.b == 0 && param3.c == 0 && param3.tx == 0 && param3.ty == 0)
            {
               this._sourceVO.bitmap.copyPixels(this._bitmap,param2,this._zeroPoint);
            }
            else
            {
               this._graphics = this._s.graphics;
               this._graphics.clear();
               this._graphics.beginBitmapFill(this._bitmap,param3,this.repeat,this.smooth);
               this._graphics.drawRect(0,0,param2.width,param2.height);
               this._graphics.endFill();
               this._sourceVO.bitmap.draw(this._s,null,this._colorTransform,this._blendMode,this._sourceVO.bitmap.rect);
            }
         }
      }
      
      public function get debug() : Boolean
      {
         return this._debug;
      }
      
      public function getFaceMaterialVO(param1:FaceVO, param2:Object3D = null, param3:View3D = null) : FaceMaterialVO
      {
         if(this._faceMaterialVO = this._faceDictionary[param1])
         {
            return this._faceMaterialVO;
         }
         return this._faceDictionary[param1] = new FaceMaterialVO();
      }
      
      public function renderLayer(param1:DrawTriangle, param2:Sprite, param3:int) : int
      {
         if(this.blendMode == BlendMode.NORMAL)
         {
            this._graphics = param2.graphics;
         }
         else
         {
            this._session = param1.source.session;
            this._shape = this._session.getShape(this,param3++,param2);
            this._shape.blendMode = this._blendMode;
            this._graphics = this._shape.graphics;
         }
         this.renderTriangle(param1);
         return param3;
      }
      
      public function set smooth(param1:Boolean) : void
      {
         if(this._smooth == param1)
         {
            return;
         }
         this._smooth = param1;
         this._materialDirty = true;
      }
      
      public function set bitmap(param1:BitmapData) : void
      {
         this._bitmap = param1;
         this._bitmapDirty = true;
      }
      
      public function get alpha() : Number
      {
         return this._alpha;
      }
      
      public function clearFaces(param1:Object3D = null, param2:View3D = null) : void
      {
         this.notifyMaterialUpdate();
         for each(this._faceMaterialVO in this._faceDictionary)
         {
            if(!this._faceMaterialVO.cleared)
            {
               this._faceMaterialVO.clear();
            }
         }
      }
      
      public function get color() : uint
      {
         return this._color;
      }
      
      public function set showNormals(param1:Boolean) : void
      {
         if(this._showNormals == param1)
         {
            return;
         }
         this._showNormals = param1;
         this._materialDirty = true;
      }
      
      public function get precision() : Number
      {
         return this._precision;
      }
      
      private function createVertexArray() : void
      {
         var _loc1_:Number = 100;
         while(_loc1_--)
         {
            this.svArray.push(new ScreenVertex());
         }
      }
      
      protected function updateColorTransform() : void
      {
         this._colorTransformDirty = false;
         this._bitmapDirty = true;
         this._materialDirty = true;
         if(this._alpha == 1 && this._color == 16777215)
         {
            this._renderBitmap = this._bitmap;
            if(!this._colorTransform || !this._colorTransform.redOffset && !this._colorTransform.greenOffset && !this._colorTransform.blueOffset)
            {
               this._colorTransform = null;
               return;
            }
         }
         else if(!this._colorTransform)
         {
            this._colorTransform = new ColorTransform();
         }
         this._colorTransform.redMultiplier = this._red;
         this._colorTransform.greenMultiplier = this._green;
         this._colorTransform.blueMultiplier = this._blue;
         this._colorTransform.alphaMultiplier = this._alpha;
         if(this._alpha == 0)
         {
            this._renderBitmap = null;
            return;
         }
      }
      
      public function addOnMaterialUpdate(param1:Function) : void
      {
         addEventListener(MaterialEvent.MATERIAL_UPDATED,param1,false,0,true);
      }
      
      function notifyMaterialUpdate() : void
      {
         this._materialDirty = false;
         if(!hasEventListener(MaterialEvent.MATERIAL_UPDATED))
         {
            return;
         }
         if(this._materialupdated == null)
         {
            this._materialupdated = new MaterialEvent(MaterialEvent.MATERIAL_UPDATED,this);
         }
         dispatchEvent(this._materialupdated);
      }
      
      protected function getMapping(param1:DrawTriangle) : Matrix
      {
         if(param1.generated)
         {
            this._texturemapping = param1.transformUV(this).clone();
            this._texturemapping.invert();
            return this._texturemapping;
         }
         this._faceMaterialVO = this.getFaceMaterialVO(param1.faceVO);
         if(!this._faceMaterialVO.invalidated)
         {
            return this._faceMaterialVO.texturemapping;
         }
         this._faceMaterialVO.invalidated = false;
         this._texturemapping = param1.transformUV(this).clone();
         this._texturemapping.invert();
         return this._faceMaterialVO.texturemapping = this._texturemapping;
      }
      
      public function set colorTransform(param1:ColorTransform) : void
      {
         this._colorTransform = param1;
         if(this._colorTransform)
         {
            this._red = this._colorTransform.redMultiplier;
            this._green = this._colorTransform.greenMultiplier;
            this._blue = this._colorTransform.blueMultiplier;
            this._alpha = this._colorTransform.alphaMultiplier;
            this._color = (this._red * 255 << 16) + (this._green * 255 << 8) + this._blue * 255;
         }
         this._colorTransformDirty = true;
      }
      
      public function get repeat() : Boolean
      {
         return this._repeat;
      }
      
      public function get visible() : Boolean
      {
         return this._alpha > 0;
      }
      
      public function get blendMode() : String
      {
         return this._blendMode;
      }
      
      public function set debug(param1:Boolean) : void
      {
         if(this._debug == param1)
         {
            return;
         }
         this._debug = param1;
         this._materialDirty = true;
      }
      
      public function get showNormals() : Boolean
      {
         return this._showNormals;
      }
      
      public function get smooth() : Boolean
      {
         return this._smooth;
      }
      
      public function set alpha(param1:Number) : void
      {
         if(param1 > 1)
         {
            param1 = 1;
         }
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(this._alpha == param1)
         {
            return;
         }
         this._alpha = param1;
         this._colorTransformDirty = true;
      }
      
      protected function getUVData(param1:DrawTriangle) : Vector.<Number>
      {
         this._faceMaterialVO = this.getFaceMaterialVO(param1.faceVO,param1.source,param1.view);
         if(this._view.camera.lens is ZoomFocusLens)
         {
            this._focus = param1.view.camera.focus;
         }
         else
         {
            this._focus = 0;
         }
         if(param1.generated)
         {
            this._uvtData[2] = 1 / (this._focus + param1.v0.z);
            this._uvtData[5] = 1 / (this._focus + param1.v1.z);
            this._uvtData[8] = 1 / (this._focus + param1.v2.z);
            this._uvtData[0] = param1.uv0.u;
            this._uvtData[1] = 1 - param1.uv0.v;
            this._uvtData[3] = param1.uv1.u;
            this._uvtData[4] = 1 - param1.uv1.v;
            this._uvtData[6] = param1.uv2.u;
            this._uvtData[7] = 1 - param1.uv2.v;
            return this._uvtData;
         }
         this._faceMaterialVO.uvtData[2] = 1 / (this._focus + param1.v0.z);
         this._faceMaterialVO.uvtData[5] = 1 / (this._focus + param1.v1.z);
         this._faceMaterialVO.uvtData[8] = 1 / (this._focus + param1.v2.z);
         if(!this._faceMaterialVO.invalidated)
         {
            return this._faceMaterialVO.uvtData;
         }
         this._faceMaterialVO.invalidated = false;
         this._faceMaterialVO.uvtData[0] = param1.uv0.u;
         this._faceMaterialVO.uvtData[1] = 1 - param1.uv0.v;
         this._faceMaterialVO.uvtData[3] = param1.uv1.u;
         this._faceMaterialVO.uvtData[4] = 1 - param1.uv1.v;
         this._faceMaterialVO.uvtData[6] = param1.uv2.u;
         this._faceMaterialVO.uvtData[7] = 1 - param1.uv2.v;
         return this._faceMaterialVO.uvtData;
      }
      
      public function get width() : Number
      {
         return this._bitmap.width;
      }
      
      protected function updateRenderBitmap() : void
      {
         this._bitmapDirty = false;
         if(this._colorTransform)
         {
            if(!this._bitmap.transparent && this._alpha != 1)
            {
               this._renderBitmap = new BitmapData(this._bitmap.width,this._bitmap.height,true);
               this._renderBitmap.draw(this._bitmap);
            }
            else
            {
               this._renderBitmap = this._bitmap.clone();
            }
            this._renderBitmap.colorTransform(this._renderBitmap.rect,this._colorTransform);
         }
         else
         {
            this._renderBitmap = this._bitmap;
         }
         this.invalidateFaces();
      }
      
      public function renderTriangle(param1:DrawTriangle) : void
      {
         var _loc2_:MatrixAway3D = null;
         this._session = param1.source.session;
         this._view = param1.view;
         this._near = this._view.screenClipping.minZ;
         this._session.renderTriangleBitmapF10(this._renderBitmap,param1.vertices,this.getUVData(param1),this.smooth,this.repeat,this._graphics);
         if(this.debug)
         {
            this._session.renderTriangleLine(0,255,1,param1.v0,param1.v1,param1.v2);
         }
         if(this.showNormals)
         {
            if(this._nn == null)
            {
               this._nn = new Number3D();
               this._sv0 = new ScreenVertex();
               this._sv1 = new ScreenVertex();
            }
            _loc2_ = param1.view.cameraVarsStore.viewTransformDictionary[param1.source];
            this._nn.rotate(param1.faceVO.face.normal,_loc2_);
            this._sv0.x = (param1.v0.x + param1.v1.x + param1.v2.x) / 3;
            this._sv0.y = (param1.v0.y + param1.v1.y + param1.v2.y) / 3;
            this._sv0.z = (param1.v0.z + param1.v1.z + param1.v2.z) / 3;
            this._sv1.x = this._sv0.x - 30 * this._nn.x;
            this._sv1.y = this._sv0.y - 30 * this._nn.y;
            this._sv1.z = this._sv0.z - 30 * this._nn.z;
            this._session.renderLine(this._sv0,this._sv1,0,16711935,1);
         }
      }
      
      public function renderBitmapLayer(param1:DrawTriangle, param2:Rectangle, param3:FaceMaterialVO) : FaceMaterialVO
      {
         this.renderSource(param1.source,param2,new Matrix());
         this._faceMaterialVO = this.getFaceMaterialVO(param1.faceVO);
         if(param3.resized)
         {
            param3.resized = false;
            this._faceMaterialVO.resized = true;
         }
         this._faceMaterialVO.invtexturemapping = param3.invtexturemapping;
         if(param3.updated || this._faceMaterialVO.invalidated || this._faceMaterialVO.updated)
         {
            param3.updated = false;
            this._faceMaterialVO.invalidated = false;
            this._faceMaterialVO.cleared = false;
            this._faceMaterialVO.updated = true;
            this._faceMaterialVO.bitmap = param3.bitmap.clone();
            this._faceMaterialVO.bitmap.copyPixels(this._sourceVO.bitmap,param1.faceVO.bitmapRect,this._zeroPoint,null,null,true);
         }
         return this._faceMaterialVO;
      }
   }
}
