package away3d.loaders.data
{
   import away3d.core.base.Element;
   import away3d.core.base.Face;
   import away3d.core.base.Geometry;
   import away3d.core.base.Object3D;
   import away3d.core.base.Segment;
   import away3d.materials.IMaterial;
   import away3d.materials.ISegmentMaterial;
   import away3d.materials.ITriangleMaterial;
   import away3d.materials.IUVMaterial;
   import flash.display.BitmapData;
   
   public class MaterialData
   {
      
      public static const COLOR_MATERIAL:String = "colorMaterial";
      
      public static const TEXTURE_MATERIAL:String = "textureMaterial";
      
      public static const SHADING_MATERIAL:String = "shadingMaterial";
      
      public static const WIREFRAME_MATERIAL:String = "wireframeMaterial";
       
      
      public var materialType:String = "wireframeMaterial";
      
      private var _material:IMaterial;
      
      public var name:String;
      
      public var shininess:Number;
      
      public var specularColor:uint;
      
      public var diffuseColor:uint;
      
      public var textureFileName:String;
      
      public var textureBitmap:BitmapData;
      
      public var ambientColor:uint;
      
      public var elements:Array;
      
      private var _element:Element;
      
      public function MaterialData()
      {
         this.elements = [];
         super();
      }
      
      public function set material(param1:IMaterial) : void
      {
         if(this._material == param1)
         {
            return;
         }
         this._material = param1;
         if(this._material is IUVMaterial)
         {
            this.textureBitmap = (this._material as IUVMaterial).bitmap;
         }
         if(this._material is ITriangleMaterial)
         {
            for each(this._element in this.elements)
            {
               (this._element as Face).material = this._material as ITriangleMaterial;
            }
         }
         else if(this._material is ISegmentMaterial)
         {
            for each(this._element in this.elements)
            {
               (this._element as Segment).material = this._material as ISegmentMaterial;
            }
         }
      }
      
      public function clone(param1:Object3D) : MaterialData
      {
         var _loc3_:Element = null;
         var _loc4_:Geometry = null;
         var _loc5_:Element = null;
         var _loc2_:MaterialData = param1.materialLibrary.addMaterial(this.name);
         _loc2_.materialType = this.materialType;
         _loc2_.ambientColor = this.ambientColor;
         _loc2_.diffuseColor = this.diffuseColor;
         _loc2_.shininess = this.shininess;
         _loc2_.specularColor = this.specularColor;
         _loc2_.textureBitmap = this.textureBitmap;
         _loc2_.textureFileName = this.textureFileName;
         _loc2_.material = this.material;
         for each(_loc3_ in this.elements)
         {
            _loc4_ = _loc3_.parent;
            _loc5_ = _loc4_.cloneElementDictionary[_loc3_];
            _loc2_.elements.push(_loc5_);
         }
         return _loc2_;
      }
      
      public function get material() : IMaterial
      {
         return this._material;
      }
   }
}
