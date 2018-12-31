package away3d.core.draw
{
   import away3d.core.base.Vertex;
   
   public final class ScreenVertex
   {
       
      
      private var persp:Number;
      
      public var vx:Number;
      
      public var vy:Number;
      
      private var my2:Number;
      
      public var clipX:Number;
      
      public var clipY:Number;
      
      public var clipZ:Number;
      
      private var dx:Number;
      
      private var dy:Number;
      
      public var num:Number;
      
      private var faz:Number;
      
      public var viewTimer:int;
      
      private var mx2:Number;
      
      private var ifmz2:Number;
      
      public var visible:Boolean;
      
      public var x:Number;
      
      public var y:Number;
      
      public var z:Number;
      
      private var fbz:Number;
      
      public function ScreenVertex(param1:Number = 0, param2:Number = 0, param3:Number = 0)
      {
         super();
         this.x = param1;
         this.y = param2;
         this.z = param3;
         this.visible = false;
      }
      
      public static function median(param1:ScreenVertex, param2:ScreenVertex, param3:Number) : ScreenVertex
      {
         var _loc4_:Number = (param1.z + param2.z) / 2;
         var _loc5_:Number = param3 + param1.z;
         var _loc6_:Number = param3 + param2.z;
         var _loc7_:Number = 1 / (param3 + _loc4_) / 2;
         return new ScreenVertex((param1.x * _loc5_ + param2.x * _loc6_) * _loc7_,(param1.y * _loc5_ + param2.y * _loc6_) * _loc7_,_loc4_);
      }
      
      public static function weighted(param1:ScreenVertex, param2:ScreenVertex, param3:Number, param4:Number, param5:Number) : ScreenVertex
      {
         if(param4 == 0 && param3 == 0)
         {
            throw new Error("Zero weights");
         }
         if(param4 == 0)
         {
            return new ScreenVertex(param1.x,param1.y,param1.z);
         }
         if(param3 == 0)
         {
            return new ScreenVertex(param2.x,param2.y,param2.z);
         }
         var _loc6_:Number = param3 + param4;
         var _loc7_:Number = param3 / _loc6_;
         var _loc8_:Number = param4 / _loc6_;
         var _loc9_:Number = param1.x * _loc7_ + param2.x * _loc8_;
         var _loc10_:Number = param1.y * _loc7_ + param2.y * _loc8_;
         var _loc11_:Number = param1.z / param5;
         var _loc12_:Number = param2.z / param5;
         var _loc13_:Number = 1 + _loc11_;
         var _loc14_:Number = 1 + _loc12_;
         var _loc15_:Number = param1.x * _loc13_ - _loc9_ * _loc11_;
         var _loc16_:Number = param2.x * _loc14_ - _loc9_ * _loc12_;
         var _loc17_:Number = param1.y * _loc13_ - _loc10_ * _loc11_;
         var _loc18_:Number = param2.y * _loc14_ - _loc10_ * _loc12_;
         var _loc19_:Number = _loc15_ * _loc18_ - _loc16_ * _loc17_;
         var _loc20_:Number = _loc9_ * _loc18_ - _loc16_ * _loc10_;
         var _loc21_:Number = _loc15_ * _loc10_ - _loc9_ * _loc17_;
         return new ScreenVertex(_loc9_,_loc10_,(_loc20_ * param1.z + _loc21_ * param2.z) / _loc19_);
      }
      
      public function distortSqr(param1:ScreenVertex, param2:Number) : Number
      {
         this.faz = param2 + this.z;
         this.fbz = param2 + this.z;
         this.ifmz2 = 2 / (this.faz + this.fbz);
         this.mx2 = (this.x * this.faz + param1.x * this.fbz) * this.ifmz2;
         this.my2 = (this.y * this.faz + param1.y * this.fbz) * this.ifmz2;
         this.dx = this.x + param1.x - this.mx2;
         this.dy = this.y + param1.y - this.my2;
         return 50 * (this.dx * this.dx + this.dy + this.dy);
      }
      
      public function deperspective(param1:Number) : Vertex
      {
         this.persp = 1 + this.z / param1;
         return new Vertex(this.x * this.persp,this.y * this.persp,this.z);
      }
      
      public function distanceSqr(param1:ScreenVertex) : Number
      {
         return (this.x - param1.x) * (this.x - param1.x) + (this.y - param1.y) * (this.y - param1.y);
      }
      
      public function toString() : String
      {
         return "new ScreenVertex(" + this.x + ", " + this.y + ", " + this.z + ")";
      }
      
      public function distance(param1:ScreenVertex) : Number
      {
         return Math.sqrt((this.x - param1.x) * (this.x - param1.x) + (this.y - param1.y) * (this.y - param1.y));
      }
   }
}
