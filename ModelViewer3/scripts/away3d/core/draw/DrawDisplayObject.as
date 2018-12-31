package away3d.core.draw
{
   import away3d.core.render.AbstractRenderSession;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   
   public class DrawDisplayObject extends DrawPrimitive
   {
       
      
      public var displayobject:DisplayObject;
      
      private var displayRect:Rectangle;
      
      public var screenvertex:ScreenVertex;
      
      public var session:AbstractRenderSession;
      
      public function DrawDisplayObject()
      {
         super();
      }
      
      override public function clear() : void
      {
         this.displayobject = null;
      }
      
      override public function calc() : void
      {
         this.displayRect = this.displayobject.getBounds(this.displayobject);
         screenZ = this.screenvertex.z;
         minZ = screenZ;
         maxZ = screenZ;
         minX = this.screenvertex.x + this.displayRect.left;
         minY = this.screenvertex.y + this.displayRect.top;
         maxX = this.screenvertex.x + this.displayRect.right;
         maxY = this.screenvertex.y + this.displayRect.bottom;
      }
      
      override public function render() : void
      {
         this.displayobject.x = this.screenvertex.x;
         this.displayobject.y = this.screenvertex.y;
         this.session.addDisplayObject(this.displayobject);
      }
      
      override public function contains(param1:Number, param2:Number) : Boolean
      {
         return true;
      }
   }
}
