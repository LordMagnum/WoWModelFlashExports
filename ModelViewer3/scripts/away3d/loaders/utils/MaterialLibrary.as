package away3d.loaders.utils
{
   import away3d.core.base.Face;
   import away3d.core.utils.Debug;
   import away3d.loaders.data.MaterialData;
   import away3d.materials.BitmapMaterial;
   import flash.display.BitmapData;
   import flash.utils.Dictionary;
   
   public dynamic class MaterialLibrary extends Dictionary
   {
       
      
      public var texturePath:String;
      
      private var _face:Face;
      
      public var loadRequired:Boolean;
      
      private var length:int = 0;
      
      public var autoLoadTextures:Boolean;
      
      private var _materialData:MaterialData;
      
      private var _image:TextureLoader;
      
      public function MaterialLibrary()
      {
         super();
      }
      
      public function texturesLoaded(param1:TextureLoadQueue) : void
      {
         this.loadRequired = false;
         var _loc2_:Array = param1.images;
         for each(this._materialData in this)
         {
            for each(this._image in _loc2_)
            {
               if(this.texturePath + this._materialData.textureFileName == this._image.filename)
               {
                  this._materialData.textureBitmap = new BitmapData(this._image.width,this._image.height,true,16777215);
                  this._materialData.textureBitmap.draw(this._image);
                  this._materialData.material = new BitmapMaterial(this._materialData.textureBitmap);
               }
            }
         }
      }
      
      public function addMaterial(param1:String) : MaterialData
      {
         if(this[param1])
         {
            return this[param1];
         }
         this.length++;
         var _loc2_:MaterialData = new MaterialData();
         this[_loc2_.name = param1] = _loc2_;
         return _loc2_;
      }
      
      public function getMaterial(param1:String) : MaterialData
      {
         if(this[param1])
         {
            return this[param1];
         }
         Debug.warning("Material \'" + param1 + "\' does not exist");
         return null;
      }
   }
}
