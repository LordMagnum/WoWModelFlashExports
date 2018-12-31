package org.papervision3d.core.math.util
{
   import flash.geom.Rectangle;
   import org.papervision3d.core.math.Number3D;
   
   public class FastRectangleTools
   {
       
      
      public function FastRectangleTools()
      {
         super();
      }
      
      public static function getRotatedBounds(param1:Rectangle, param2:Number, param3:Rectangle = null) : Rectangle
      {
         if(!param3)
         {
            param3 = new Rectangle();
         }
         param2 = param2 * Number3D.toRADIANS;
         var _loc4_:Number = param1.width;
         var _loc5_:Number = param1.height;
         var _loc6_:Number = Math.abs(Math.sin(param2));
         var _loc7_:Number = Math.abs(Math.cos(param2));
         param3.left = param1.x - 0.5 * (_loc4_ * _loc7_ + _loc5_ * _loc6_);
         param3.right = param1.x + 0.5 * (_loc4_ * _loc7_ + _loc5_ * _loc6_);
         param3.top = param1.y - 0.5 * (_loc4_ * _loc6_ + _loc5_ * _loc7_);
         param3.bottom = param1.y + 0.5 * (_loc4_ * _loc6_ + _loc5_ * _loc7_);
         return param3;
      }
      
      public static function intersection(param1:Rectangle, param2:Rectangle, param3:Rectangle = null) : Rectangle
      {
         if(!param3)
         {
            param3 = new Rectangle();
         }
         if(!intersects(param1,param2))
         {
            param3.x = param3.y = param3.width = param3.height = 0;
            return param3;
         }
         param3.left = param1.left > param2.left?Number(param1.left):Number(param2.left);
         param3.right = param1.right < param2.right?Number(param1.right):Number(param2.right);
         param3.top = param1.top > param2.top?Number(param1.top):Number(param2.top);
         param3.bottom = param1.bottom < param2.bottom?Number(param1.bottom):Number(param2.bottom);
         return param3;
      }
      
      public static function intersects(param1:Rectangle, param2:Rectangle) : Boolean
      {
         if(!(param1.right < param2.left || param1.left > param2.right) && !(param1.bottom < param2.top || param1.top > param2.bottom))
         {
            return true;
         }
         return false;
      }
   }
}
