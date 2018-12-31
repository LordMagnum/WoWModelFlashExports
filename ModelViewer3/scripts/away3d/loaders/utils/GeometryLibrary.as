package away3d.loaders.utils
{
   import away3d.core.utils.Debug;
   import away3d.loaders.data.GeometryData;
   import flash.utils.Dictionary;
   
   public dynamic class GeometryLibrary extends Dictionary
   {
       
      
      private var _geometryArray:Array;
      
      private var _geometryArrayDirty:Boolean;
      
      public var name:String;
      
      private var _geometry:GeometryData;
      
      public function GeometryLibrary()
      {
         super();
      }
      
      public function getGeometry(param1:String) : GeometryData
      {
         if(this[param1])
         {
            return this[param1];
         }
         Debug.warning("Geometry \'" + param1 + "\' does not exist");
         return null;
      }
      
      public function addGeometry(param1:String, param2:XML = null, param3:XML = null) : GeometryData
      {
         if(this[param1])
         {
            return this[param1];
         }
         this._geometryArrayDirty = true;
         var _loc4_:GeometryData = new GeometryData();
         _loc4_.geoXML = param2;
         _loc4_.ctrlXML = param3;
         var _loc5_:* = _loc4_.name = param1;
         this[_loc5_] = _loc4_;
         return _loc4_;
      }
      
      public function getGeometryArray() : Array
      {
         if(this._geometryArrayDirty)
         {
            this.updateGeometryArray();
         }
         return this._geometryArray;
      }
      
      private function updateGeometryArray() : void
      {
         this._geometryArray = [];
         for each(this._geometry in this)
         {
            this._geometryArray.push(this._geometry);
         }
      }
   }
}
