package away3d.core.geom
{
   import away3d.core.base.Vertex;
   import away3d.core.math.MatrixAway3D;
   import away3d.core.math.Number3D;
   
   public class Plane3D
   {
      
      public static const BACK:int = -1;
      
      public static const FRONT:int = 1;
      
      public static const EPSILON:Number = 0.001;
      
      public static const INTERSECT:int = 0;
       
      
      public var a:Number;
      
      public var c:Number;
      
      public var b:Number;
      
      public var d:Number;
      
      private var _mt:MatrixAway3D;
      
      private var _point:Number3D;
      
      private var _len:Number;
      
      public function Plane3D(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0)
      {
         this._point = new Number3D();
         this._mt = new MatrixAway3D();
         super();
         this.a = param1;
         this.b = param2;
         this.c = param3;
         this.d = param4;
      }
      
      public function getIntersectionLine(param1:Vertex, param2:Vertex) : Vertex
      {
         var _loc3_:Number = this._point.x * param1.x + this._point.y * param1.y + this._point.z * param1.z - this.d;
         var _loc4_:Number = this._point.x * param2.x + this._point.y * param2.y + this._point.z * param2.z - this.d;
         var _loc5_:Number = _loc4_ / (_loc4_ - _loc3_);
         return new Vertex(param2.x + (param1.x - param2.x) * _loc5_,param2.y + (param1.y - param2.y) * _loc5_,param2.z + (param1.z - param2.z) * _loc5_);
      }
      
      public function fromNormalAndPoint(param1:Number3D, param2:Number3D) : void
      {
         this.a = param1.x;
         this.b = param1.y;
         this.c = param1.z;
         this.d = -(this.a * param2.x + this.b * param2.y + this.c * param2.z);
         this._point = param1;
      }
      
      public function classifyPoint(param1:Number3D) : int
      {
         var _loc2_:Number = this.a * param1.x + this.b * param1.y + this.c * param1.z + this.d;
         if(_loc2_ > -EPSILON && _loc2_ < EPSILON)
         {
            return Plane3D.INTERSECT;
         }
         if(_loc2_ < 0)
         {
            return Plane3D.BACK;
         }
         if(_loc2_ > 0)
         {
            return Plane3D.FRONT;
         }
         return Plane3D.INTERSECT;
      }
      
      public function from3vertices(param1:Vertex, param2:Vertex, param3:Vertex) : void
      {
         var _loc4_:Number = param2.x - param1.x;
         var _loc5_:Number = param2.y - param1.y;
         var _loc6_:Number = param2.z - param1.z;
         var _loc7_:Number = param3.x - param1.x;
         var _loc8_:Number = param3.y - param1.y;
         var _loc9_:Number = param3.z - param1.z;
         this.a = _loc5_ * _loc9_ - _loc6_ * _loc8_;
         this.b = _loc6_ * _loc7_ - _loc4_ * _loc9_;
         this.c = _loc4_ * _loc8_ - _loc5_ * _loc7_;
         this.d = -(this.a * param1.x + this.b * param1.y + this.c * param1.z);
      }
      
      public function closestPointFrom(param1:Number3D) : Number3D
      {
         var _loc2_:Number3D = null;
         this._point.x = 0;
         this._point.y = 0;
         if(this.c != 0)
         {
            this._point.z = -this.d / this.c;
         }
         else
         {
            this._point.z = -this.d / this.b;
         }
         _loc2_ = new Number3D();
         _loc2_.sub(param1,this._point);
         var _loc3_:Number = this.a * this._point.x + this.b * this._point.y + this.c * this._point.z;
         _loc2_.x = _loc2_.x - _loc3_ * this.a;
         _loc2_.y = _loc2_.y - _loc3_ * this.b;
         _loc2_.z = _loc2_.z - _loc3_ * this.c;
         return _loc2_;
      }
      
      public function normalize() : Plane3D
      {
         var _loc1_:Number = Math.sqrt(this.a * this.a + this.b * this.b + this.c * this.c);
         this.a = this.a / _loc1_;
         this.b = this.b / _loc1_;
         this.c = this.c / _loc1_;
         this.d = this.d / _loc1_;
         return this;
      }
      
      public function getIntersectionLineNumbers(param1:Number3D, param2:Number3D) : Number3D
      {
         var _loc3_:Number = this._point.x * param1.x + this._point.y * param1.y + this._point.z * param1.z - this.d;
         var _loc4_:Number = this._point.x * param2.x + this._point.y * param2.y + this._point.z * param2.z - this.d;
         var _loc5_:Number = _loc4_ / (_loc4_ - _loc3_);
         return new Number3D(param2.x + (param1.x - param2.x) * _loc5_,param2.y + (param1.y - param2.y) * _loc5_,param2.z + (param1.z - param2.z) * _loc5_);
      }
      
      public function transform(param1:MatrixAway3D) : void
      {
         var _loc2_:Number = this.a;
         var _loc3_:Number = this.b;
         var _loc4_:Number = this.c;
         var _loc5_:Number = this.d;
         this.a = _loc2_ * param1.sxx + _loc3_ * param1.syx + _loc4_ * param1.szx + _loc5_ * param1.swx;
         this.b = _loc2_ * param1.sxy + _loc3_ * param1.syy + _loc4_ * param1.szy + _loc5_ * param1.swy;
         this.c = _loc2_ * param1.sxz + _loc3_ * param1.syz + _loc4_ * param1.szz + _loc5_ * param1.swz;
         this.d = _loc2_ * param1.tx + _loc3_ * param1.ty + _loc4_ * param1.tz + _loc5_ * param1.tw;
         this.normalize();
      }
      
      public function from3points(param1:Number3D, param2:Number3D, param3:Number3D) : void
      {
         var _loc4_:Number = param2.x - param1.x;
         var _loc5_:Number = param2.y - param1.y;
         var _loc6_:Number = param2.z - param1.z;
         var _loc7_:Number = param3.x - param1.x;
         var _loc8_:Number = param3.y - param1.y;
         var _loc9_:Number = param3.z - param1.z;
         this.a = _loc5_ * _loc9_ - _loc6_ * _loc8_;
         this.b = _loc6_ * _loc7_ - _loc4_ * _loc9_;
         this.c = _loc4_ * _loc8_ - _loc5_ * _loc7_;
         this.d = -(this.a * param1.x + this.b * param1.y + this.c * param1.z);
      }
      
      public function distance(param1:Number3D) : Number
      {
         this._len = this.a * param1.x + this.b * param1.y + this.c * param1.z + this.d;
         if(this._len > -EPSILON && this._len < EPSILON)
         {
            this._len = 0;
         }
         return this._len;
      }
   }
}
