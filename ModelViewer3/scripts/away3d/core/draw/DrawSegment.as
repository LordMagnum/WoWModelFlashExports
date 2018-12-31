package away3d.core.draw
{
   import away3d.materials.ISegmentMaterial;
   
   public class DrawSegment extends DrawPrimitive
   {
       
      
      public var v0:ScreenVertex;
      
      private var bzf:Number;
      
      private var axf:Number;
      
      private var det:Number;
      
      private var dx:Number;
      
      private var dy:Number;
      
      private var faz:Number;
      
      public var material:ISegmentMaterial;
      
      private var ayf:Number;
      
      private var ax:Number;
      
      private var ay:Number;
      
      private var az:Number;
      
      private var fbz:Number;
      
      private var azf:Number;
      
      private var bxf:Number;
      
      private var bx:Number;
      
      private var by:Number;
      
      private var bz:Number;
      
      private var focus:Number;
      
      private var xfocus:Number;
      
      public var length:Number;
      
      private var byf:Number;
      
      public var v1:ScreenVertex;
      
      private var da:Number;
      
      private var db:Number;
      
      private var yfocus:Number;
      
      public function DrawSegment()
      {
         super();
      }
      
      override public function render() : void
      {
         this.material.renderSegment(this);
      }
      
      function onepointcut(param1:ScreenVertex) : Array
      {
         return [create(source,this.material,this.v0,param1,true),create(source,this.material,param1,this.v1,true)];
      }
      
      override public function quarter(param1:Number) : Array
      {
         if(this.length < 5)
         {
            return null;
         }
         var _loc2_:ScreenVertex = ScreenVertex.median(this.v0,this.v1,param1);
         return [create(source,this.material,this.v0,_loc2_,true),create(source,this.material,_loc2_,this.v1,true)];
      }
      
      override public function contains(param1:Number, param2:Number) : Boolean
      {
         if(Math.abs(this.v0.x * (param2 - this.v1.y) + this.v1.x * (this.v0.y - param2) + param1 * (this.v1.y - this.v0.y)) > 0.001 * 1000 * 1000)
         {
            return false;
         }
         if(this.distanceToCenter(param1,param2) * 2 > this.length)
         {
            return false;
         }
         return true;
      }
      
      override public function getZ(param1:Number, param2:Number) : Number
      {
         this.focus = view.camera.focus;
         this.ax = this.v0.x;
         this.ay = this.v0.y;
         this.az = this.v0.z;
         this.bx = this.v1.x;
         this.by = this.v1.y;
         this.bz = this.v1.z;
         if(this.ax == param1 && this.ay == param2)
         {
            return this.az;
         }
         if(this.bx == param1 && this.by == param2)
         {
            return this.bz;
         }
         this.dx = this.bx - this.ax;
         this.dy = this.by - this.ay;
         this.azf = this.az / this.focus;
         this.bzf = this.bz / this.focus;
         this.faz = 1 + this.azf;
         this.fbz = 1 + this.bzf;
         this.xfocus = param1;
         this.yfocus = param2;
         this.axf = this.ax * this.faz - param1 * this.azf;
         this.bxf = this.bx * this.fbz - param1 * this.bzf;
         this.ayf = this.ay * this.faz - param2 * this.azf;
         this.byf = this.by * this.fbz - param2 * this.bzf;
         this.det = this.dx * (this.axf - this.bxf) + this.dy * (this.ayf - this.byf);
         this.db = this.dx * (this.axf - param1) + this.dy * (this.ayf - param2);
         this.da = this.dx * (param1 - this.bxf) + this.dy * (param2 - this.byf);
         return (this.da * this.az + this.db * this.bz) / this.det;
      }
      
      private function distanceToCenter(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = (this.v0.x + this.v1.x) / 2;
         var _loc4_:Number = (this.v0.y + this.v1.y) / 2;
         return Math.sqrt((_loc3_ - param1) * (_loc3_ - param1) + (_loc4_ - param2) * (_loc4_ - param2));
      }
      
      override public function clear() : void
      {
         this.v0 = null;
         this.v1 = null;
      }
      
      override public function calc() : void
      {
         if(this.v0.z < this.v1.z)
         {
            minZ = this.v0.z;
            maxZ = this.v1.z + 1;
         }
         else
         {
            minZ = this.v1.z;
            maxZ = this.v0.z + 1;
         }
         screenZ = (this.v0.z + this.v1.z) / 2;
         if(this.v0.x < this.v1.x)
         {
            minX = this.v0.x;
            maxX = this.v1.x + 1;
         }
         else
         {
            minX = this.v1.x;
            maxX = this.v0.x + 1;
         }
         if(this.v0.y < this.v1.y)
         {
            minY = this.v0.y;
            maxY = this.v1.y + 1;
         }
         else
         {
            minY = this.v1.y;
            maxY = this.v0.y + 1;
         }
         this.length = Math.sqrt((maxX - minX) * (maxX - minX) + (maxY - minY) * (maxY - minY));
      }
      
      override public function toString() : String
      {
         return "S{ screenZ = " + screenZ + ", minZ = " + minZ + ", maxZ = " + maxZ + " }";
      }
   }
}
