package away3d.core.draw
{
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   
   public class DrawScaledBitmap extends DrawPrimitive
   {
       
      
      private var cosh:Number;
      
      public var rotation:Number;
      
      private var width:Number;
      
      var left:ScreenVertex;
      
      public var scale:Number;
      
      private var cosw:Number;
      
      var bottomright:ScreenVertex;
      
      private var cos:Number;
      
      private var sinh:Number;
      
      private var sin:Number;
      
      var top:ScreenVertex;
      
      private var sinw:Number;
      
      var topleft:ScreenVertex;
      
      private var mapping:Matrix;
      
      public var screenvertex:ScreenVertex;
      
      var topright:ScreenVertex;
      
      public var bitmap:BitmapData;
      
      var bottomleft:ScreenVertex;
      
      private var bounds:ScreenVertex;
      
      private var height:Number;
      
      public var smooth:Boolean;
      
      public function DrawScaledBitmap()
      {
         this.topleft = new ScreenVertex();
         this.topright = new ScreenVertex();
         this.bottomleft = new ScreenVertex();
         this.bottomright = new ScreenVertex();
         this.left = new ScreenVertex();
         this.top = new ScreenVertex();
         this.mapping = new Matrix();
         super();
      }
      
      override public function render() : void
      {
         source.session.renderScaledBitmap(this,this.bitmap,this.mapping,this.smooth);
      }
      
      override public function clear() : void
      {
         this.bitmap = null;
      }
      
      override public function calc() : void
      {
         var _loc1_:Array = null;
         screenZ = this.screenvertex.z;
         minZ = screenZ;
         maxZ = screenZ;
         this.width = this.bitmap.width * this.scale;
         this.height = this.bitmap.height * this.scale;
         if(this.rotation != 0)
         {
            this.cos = Math.cos(this.rotation * Math.PI / 180);
            this.sin = Math.sin(this.rotation * Math.PI / 180);
            this.cosw = this.cos * this.width / 2;
            this.cosh = this.cos * this.height / 2;
            this.sinw = this.sin * this.width / 2;
            this.sinh = this.sin * this.height / 2;
            this.topleft.x = this.screenvertex.x - this.cosw - this.sinh;
            this.topleft.y = this.screenvertex.y + this.sinw - this.cosh;
            this.topright.x = this.screenvertex.x + this.cosw - this.sinh;
            this.topright.y = this.screenvertex.y - this.sinw - this.cosh;
            this.bottomleft.x = this.screenvertex.x - this.cosw + this.sinh;
            this.bottomleft.y = this.screenvertex.y + this.sinw + this.cosh;
            this.bottomright.x = this.screenvertex.x + this.cosw + this.sinh;
            this.bottomright.y = this.screenvertex.y - this.sinw + this.cosh;
            _loc1_ = new Array();
            _loc1_.push(this.topleft);
            _loc1_.push(this.topright);
            _loc1_.push(this.bottomleft);
            _loc1_.push(this.bottomright);
            minX = 100000;
            minY = 100000;
            maxX = -100000;
            maxY = -100000;
            for each(this.bounds in _loc1_)
            {
               if(minX > this.bounds.x)
               {
                  minX = this.bounds.x;
               }
               if(maxX < this.bounds.x)
               {
                  maxX = this.bounds.x;
               }
               if(minY > this.bounds.y)
               {
                  minY = this.bounds.y;
               }
               if(maxY < this.bounds.y)
               {
                  maxY = this.bounds.y;
               }
            }
            this.mapping.a = this.scale * this.cos;
            this.mapping.b = -this.scale * this.sin;
            this.mapping.c = this.scale * this.sin;
            this.mapping.d = this.scale * this.cos;
            this.mapping.tx = this.topleft.x;
            this.mapping.ty = this.topleft.y;
         }
         else
         {
            this.topleft.x = this.screenvertex.x - this.width / 2;
            this.topleft.y = this.screenvertex.y - this.height / 2;
            this.topright.x = this.topleft.x + this.width;
            this.topright.y = this.topleft.y;
            this.bottomleft.x = this.topleft.x;
            this.bottomleft.y = this.topleft.y + this.height;
            this.bottomright.x = this.topright.x;
            this.bottomright.y = this.bottomleft.y;
            minX = this.topleft.x;
            minY = this.topleft.y;
            maxX = this.bottomright.x;
            maxY = this.bottomright.y;
            this.mapping.a = this.mapping.d = this.scale;
            this.mapping.c = this.mapping.b = 0;
            this.mapping.tx = this.topleft.x;
            this.mapping.ty = this.topleft.y;
         }
      }
      
      override public function contains(param1:Number, param2:Number) : Boolean
      {
         if(this.rotation != 0)
         {
            if(this.topleft.x * (param2 - this.topright.y) + this.topright.x * (this.topleft.y - param2) + param1 * (this.topright.y - this.topleft.y) > 0.001)
            {
               return false;
            }
            if(this.topright.x * (param2 - this.bottomright.y) + this.bottomright.x * (this.topright.y - param2) + param1 * (this.bottomright.y - this.topright.y) > 0.001)
            {
               return false;
            }
            if(this.bottomright.x * (param2 - this.bottomleft.y) + this.bottomleft.x * (this.bottomright.y - param2) + param1 * (this.bottomleft.y - this.bottomright.y) > 0.001)
            {
               return false;
            }
            if(this.bottomleft.x * (param2 - this.topleft.y) + this.topleft.x * (this.bottomleft.y - param2) + param1 * (this.topleft.y - this.bottomleft.y) > 0.001)
            {
               return false;
            }
         }
         if(!this.bitmap.transparent)
         {
            return true;
         }
         if(this.rotation != 0)
         {
            this.mapping = new Matrix(this.scale * this.cos,-this.scale * this.sin,this.scale * this.sin,this.scale * this.cos,this.topleft.x,this.topleft.y);
         }
         else
         {
            this.mapping = new Matrix(this.scale,0,0,this.scale,this.topleft.x,this.topleft.y);
         }
         this.mapping.invert();
         var _loc3_:Point = this.mapping.transformPoint(new Point(param1,param2));
         if(_loc3_.x < 0)
         {
            _loc3_.x = 0;
         }
         if(_loc3_.y < 0)
         {
            _loc3_.y = 0;
         }
         if(_loc3_.x >= this.bitmap.width)
         {
            _loc3_.x = this.bitmap.width - 1;
         }
         if(_loc3_.y >= this.bitmap.height)
         {
            _loc3_.y = this.bitmap.height - 1;
         }
         var _loc4_:uint = this.bitmap.getPixel32(int(_loc3_.x),int(_loc3_.y));
         return uint(_loc4_ >> 24) > 128;
      }
   }
}
