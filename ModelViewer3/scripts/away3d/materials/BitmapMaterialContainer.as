package away3d.materials
{
   import away3d.containers.View3D;
   import away3d.core.base.Object3D;
   import away3d.core.draw.DrawTriangle;
   import away3d.core.utils.FaceMaterialVO;
   import away3d.core.utils.FaceVO;
   import away3d.events.MaterialEvent;
   import §away3d:arcane§._bitmapDirty;
   import §away3d:arcane§._bitmapRect;
   import §away3d:arcane§._blendMode;
   import §away3d:arcane§._blendModeDirty;
   import §away3d:arcane§._colorTransform;
   import §away3d:arcane§._colorTransformDirty;
   import §away3d:arcane§._faceMaterialVO;
   import §away3d:arcane§._materialDirty;
   import §away3d:arcane§._renderBitmap;
   import §away3d:arcane§._sourceVO;
   import §away3d:arcane§._zeroPoint;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class BitmapMaterialContainer extends BitmapMaterial implements ITriangleMaterial, ILayerMaterial
   {
       
      
      private var _faceHeight:int;
      
      private var _height:Number;
      
      private var _width:Number;
      
      public var transparent:Boolean;
      
      private var _material:ILayerMaterial;
      
      private var _forceRender:Boolean;
      
      private var _fMaterialVO:FaceMaterialVO;
      
      private var _faceWidth:int;
      
      protected var materials:Array;
      
      private var _faceVO:FaceVO;
      
      private var _containerDictionary:Dictionary;
      
      private var _cacheDictionary:Dictionary;
      
      private var _viewDictionary:Dictionary;
      
      private var _containerVO:FaceMaterialVO;
      
      public function BitmapMaterialContainer(param1:int, param2:int, param3:Object = null)
      {
         this._containerDictionary = new Dictionary(true);
         this._cacheDictionary = new Dictionary(true);
         this._viewDictionary = new Dictionary(true);
         super(new BitmapData(param1,param2,true,16777215),param3);
         this.materials = ini.getArray("materials");
         this._width = param1;
         this._height = param2;
         _bitmapRect = new Rectangle(0,0,this._width,this._height);
         for each(this._material in this.materials)
         {
            this._material.addOnMaterialUpdate(this.onMaterialUpdate);
         }
         this.transparent = ini.getBoolean("transparent",true);
      }
      
      public function removeMaterial(param1:ILayerMaterial) : void
      {
         var _loc2_:int = this.materials.indexOf(param1);
         if(_loc2_ == -1)
         {
            return;
         }
         param1.removeOnMaterialUpdate(this.onMaterialUpdate);
         this.materials.splice(_loc2_,1);
         _materialDirty = true;
      }
      
      private function onMaterialUpdate(param1:MaterialEvent) : void
      {
         _materialDirty = true;
      }
      
      override public function updateMaterial(param1:Object3D, param2:View3D) : void
      {
         for each(this._material in this.materials)
         {
            this._material.updateMaterial(param1,param2);
         }
         if(_colorTransformDirty)
         {
            updateColorTransform();
         }
         if(_bitmapDirty)
         {
            this.updateRenderBitmap();
         }
         if(_materialDirty || _blendModeDirty)
         {
            clearFaces();
         }
         _blendModeDirty = false;
      }
      
      override public function renderBitmapLayer(param1:DrawTriangle, param2:Rectangle, param3:FaceMaterialVO) : FaceMaterialVO
      {
         _faceMaterialVO = getFaceMaterialVO(param1.faceVO);
         this._faceWidth = param1.faceVO.bitmapRect.width;
         this._faceHeight = param1.faceVO.bitmapRect.height;
         if(!(this._containerVO = this._containerDictionary[param1]))
         {
            this._containerVO = this._containerDictionary[param1] = new FaceMaterialVO();
         }
         if(param3.resized)
         {
            param3.resized = false;
            this._containerVO.resize(this._faceWidth,this._faceHeight,this.transparent);
         }
         for each(this._material in this.materials)
         {
            this._containerVO = this._material.renderBitmapLayer(param1,param2,this._containerVO);
         }
         if(param3.updated || this._containerVO.updated)
         {
            param3.updated = false;
            this._containerVO.updated = false;
            _faceMaterialVO.invalidated = false;
            _faceMaterialVO.cleared = false;
            _faceMaterialVO.updated = true;
            _faceMaterialVO.bitmap = param3.bitmap.clone();
            _faceMaterialVO.bitmap.lock();
            _sourceVO = _faceMaterialVO;
            if(_blendMode == BlendMode.NORMAL && !_colorTransform)
            {
               _faceMaterialVO.bitmap.copyPixels(this._containerVO.bitmap,this._containerVO.bitmap.rect,_zeroPoint,null,null,true);
            }
            else
            {
               _faceMaterialVO.bitmap.draw(this._containerVO.bitmap,null,_colorTransform,_blendMode);
            }
         }
         return _faceMaterialVO;
      }
      
      override public function renderLayer(param1:DrawTriangle, param2:Sprite, param3:int) : int
      {
         throw new Error("Not implemented");
      }
      
      override protected function updateRenderBitmap() : void
      {
         _bitmapDirty = false;
         invalidateFaces();
         _materialDirty = true;
      }
      
      override protected function getMapping(param1:DrawTriangle) : Matrix
      {
         this._faceVO = param1.faceVO;
         _faceMaterialVO = getFaceMaterialVO(param1.faceVO,param1.source,param1.view);
         if(param1.generated || _faceMaterialVO.invalidated || _faceMaterialVO.updated)
         {
            _faceMaterialVO.updated = true;
            _faceMaterialVO.cleared = false;
            if(_faceMaterialVO.invalidated)
            {
               _faceMaterialVO.invalidated = false;
               this._faceVO.bitmapRect = new Rectangle(int(this._width * this._faceVO.minU),int(this._height * (1 - this._faceVO.maxV)),int(this._width * (this._faceVO.maxU - this._faceVO.minU) + 2),int(this._height * (this._faceVO.maxV - this._faceVO.minV) + 2));
               this._faceWidth = this._faceVO.bitmapRect.width;
               this._faceHeight = this._faceVO.bitmapRect.height;
               _faceMaterialVO.invtexturemapping = param1.transformUV(this).clone();
               _faceMaterialVO.texturemapping = _faceMaterialVO.invtexturemapping.clone();
               _faceMaterialVO.texturemapping.invert();
               _faceMaterialVO.resize(this._faceWidth,this._faceHeight,this.transparent);
            }
            this._fMaterialVO = _faceMaterialVO;
            for each(this._material in this.materials)
            {
               this._fMaterialVO = this._material.renderBitmapLayer(param1,_bitmapRect,this._fMaterialVO);
            }
            _renderBitmap = this._cacheDictionary[this._faceVO] = this._fMaterialVO.bitmap;
            this._fMaterialVO.updated = false;
            return _faceMaterialVO.texturemapping;
         }
         _renderBitmap = this._cacheDictionary[this._faceVO];
         if(_faceMaterialVO.invalidated)
         {
            _faceMaterialVO.invalidated = false;
            _faceMaterialVO.invtexturemapping = param1.transformUV(this).clone();
            _faceMaterialVO.texturemapping = _faceMaterialVO.invtexturemapping.clone();
            _faceMaterialVO.texturemapping.invert();
         }
         return _faceMaterialVO.texturemapping;
      }
      
      public function clearMaterials() : void
      {
         var _loc1_:int = this.materials.length;
         while(_loc1_--)
         {
            this.removeMaterial(this.materials[_loc1_]);
         }
      }
      
      public function addMaterial(param1:ILayerMaterial) : void
      {
         param1.addOnMaterialUpdate(this.onMaterialUpdate);
         this.materials.push(param1);
         _materialDirty = true;
      }
   }
}
