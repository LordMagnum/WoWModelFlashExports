package away3d.core.render
{
   import away3d.core.filter.AnotherRivalFilter;
   
   public class Renderer
   {
       
      
      public function Renderer()
      {
         super();
      }
      
      public static function get CORRECT_Z_ORDER() : IRenderer
      {
         return new QuadrantRenderer(new AnotherRivalFilter(500));
      }
      
      public static function get BASIC() : IRenderer
      {
         return new BasicRenderer();
      }
   }
}
