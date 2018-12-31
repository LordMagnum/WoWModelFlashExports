package away3d.core.base
{
   import away3d.core.draw.ScreenVertex;
   import away3d.core.math.MatrixAway3D;
   import away3d.core.math.Number3D;
   import away3d.core.utils.ValueObject;
   
   public class Vertex extends ValueObject
   {
       
      
      var _x:Number;
      
      private var _persp:Number;
      
      private var _element:Element;
      
      private var _position:Number3D;
      
      public var parents:Array;
      
      public var extra:Object;
      
      public var positionDirty:Boolean;
      
      public var geometry:Geometry;
      
      var _y:Number;
      
      var _z:Number;
      
      public function Vertex(param1:Number = 0, param2:Number = 0, param3:Number = 0)
      {
         this._position = new Number3D();
         this.parents = new Array();
         super();
         this._x = param1;
         this._y = param2;
         this._z = param3;
         this.positionDirty = true;
      }
      
      public static function median(param1:Vertex, param2:Vertex) : Vertex
      {
         return new Vertex((param1._x + param2._x) / 2,(param1._y + param2._y) / 2,(param1._z + param2._z) / 2);
      }
      
      public static function weighted(param1:Vertex, param2:Vertex, param3:Number, param4:Number) : Vertex
      {
         var _loc5_:Number = param3 + param4;
         var _loc6_:Number = param3 / _loc5_;
         var _loc7_:Number = param4 / _loc5_;
         return new Vertex(param1._x * _loc6_ + param2._x * _loc7_,param1._y * _loc6_ + param2._y * _loc7_,param1._z * _loc6_ + param2._z * _loc7_);
      }
      
      public static function distanceSqr(param1:Vertex, param2:Vertex) : Number
      {
         return (param1._x + param2._x) * (param1._x + param2._x) + (param1._y + param2._y) * (param1._y + param2._y) + (param1._z + param2._z) * (param1._z + param2._z);
      }
      
      public function set z(param1:Number) : void
      {
         if(this._z == param1)
         {
            return;
         }
         this._z = param1;
         this.positionDirty = true;
      }
      
      public function set y(param1:Number) : void
      {
         if(this._y == param1)
         {
            return;
         }
         this._y = param1;
         this.positionDirty = true;
      }
      
      public function get position() : Number3D
      {
         if(this.positionDirty)
         {
            this.updatePosition();
         }
         return this._position;
      }
      
      override public function toString() : String
      {
         return "new Vertex(" + this._x + ", " + this._y + ", " + this.z + ")";
      }
      
      public function reset() : void
      {
         this._x = 0;
         this._y = 0;
         this._z = 0;
         this.positionDirty = true;
      }
      
      private function updatePosition() : void
      {
         this.positionDirty = false;
         for each(this._element in this.parents)
         {
            this._element.vertexDirty = true;
         }
         this._position.x = this._x;
         this._position.y = this._y;
         this._position.z = this._z;
      }
      
      public function adjust(param1:Number, param2:Number, param3:Number, param4:Number = 1) : void
      {
         this.setValue(this._x * (1 - param4) + param1 * param4,this._y * (1 - param4) + param2 * param4,this._z * (1 - param4) + param3 * param4);
      }
      
      public function clone() : Vertex
      {
         return new Vertex(this._x,this._y,this._z);
      }
      
      public function get z() : Number
      {
         if(this.positionDirty)
         {
            this.updatePosition();
         }
         return this._z;
      }
      
      public function add(param1:Number3D) : void
      {
         this._x = this._x + param1.x;
         this._y = this._y + param1.y;
         this._z = this._z + param1.z;
         this.positionDirty = true;
      }
      
      public function transform(param1:MatrixAway3D) : void
      {
         this.setValue(this._x * param1.sxx + this._y * param1.sxy + this._z * param1.sxz + param1.tx,this._x * param1.syx + this._y * param1.syy + this._z * param1.syz + param1.ty,this._x * param1.szx + this._y * param1.szy + this._z * param1.szz + param1.tz);
      }
      
      public function setValue(param1:Number, param2:Number, param3:Number) : void
      {
         this._x = param1;
         this._y = param2;
         this._z = param3;
         this.positionDirty = true;
      }
      
      public function set x(param1:Number) : void
      {
         if(this._x == param1)
         {
            return;
         }
         this._x = param1;
         this.positionDirty = true;
      }
      
      public function get x() : Number
      {
         if(this.positionDirty)
         {
            this.updatePosition();
         }
         return this._x;
      }
      
      public function get y() : Number
      {
         if(this.positionDirty)
         {
            this.updatePosition();
         }
         return this._y;
      }
      
      public function perspective(param1:Number) : ScreenVertex
      {
         this._persp = 1 / (1 + this._z / param1);
         return new ScreenVertex(this._x * this._persp,this._y * this._persp,this._z);
      }
   }
}
