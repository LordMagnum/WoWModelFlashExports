package mx.core
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import mx.utils.NameUtil;
   
   use namespace mx_internal;
   
   public class FlexBitmap extends Bitmap
   {
      
      mx_internal static const VERSION:String = "3.3.0.4852";
       
      
      public function FlexBitmap(param1:BitmapData = null, param2:String = "auto", param3:Boolean = false)
      {
         var bitmapData:BitmapData = param1;
         var pixelSnapping:String = param2;
         var smoothing:Boolean = param3;
         super(bitmapData,pixelSnapping,smoothing);
         try
         {
            name = NameUtil.createUniqueName(this);
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      override public function toString() : String
      {
         return NameUtil.displayObjectToString(this);
      }
   }
}
