package away3d.core.utils
{
   import away3d.containers.View3D;
   import away3d.core.base.Object3D;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   
   public class FaceMaterialVO
   {
       
      
      public var invtexturemapping:Matrix;
      
      public var width:int;
      
      public var invalidated:Boolean = true;
      
      public var backface:Boolean = false;
      
      public var texturemapping:Matrix;
      
      public var uvtData:Vector.<Number>;
      
      public var source:Object3D;
      
      public var color:uint;
      
      public var view:View3D;
      
      public var height:int;
      
      public var cleared:Boolean = true;
      
      public var bitmap:BitmapData;
      
      public var resized:Boolean;
      
      public var updated:Boolean = false;
      
      public function FaceMaterialVO(param1:Object3D = null, param2:View3D = null)
      {
         this.uvtData = new Vector.<Number>(9);
         super();
         this.source = param1;
         this.view = param2;
      }
      
      public function clear() : void
      {
         this.cleared = true;
         this.updated = true;
      }
      
      public function resize(param1:Number, param2:Number, param3:Boolean = true) : void
      {
         if(this.width == param1 && this.height == param2)
         {
            return;
         }
         this.resized = true;
         this.updated = true;
         this.width = param1;
         this.height = param2;
         this.color = this.color;
         if(this.bitmap)
         {
            this.bitmap.dispose();
         }
         this.bitmap = new BitmapData(param1,param2,param3,0);
         this.bitmap.lock();
      }
   }
}
