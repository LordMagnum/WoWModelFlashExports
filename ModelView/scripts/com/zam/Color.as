package com.zam
{
   public class Color
   {
       
      
      private var _blue:uint;
      
      private var _green:uint;
      
      private var _red:uint;
      
      private var _alpha:uint = 255;
      
      public function Color(param1:uint = 4.27819008E9)
      {
         super();
         this.setARGB(param1 >> 24 & 255,param1 >> 16 & 255,param1 >> 8 & 255,param1 & 255);
      }
      
      public static function dechex(param1:uint) : String
      {
         var _loc2_:Color = new Color(param1);
         return _loc2_.hex;
      }
      
      public static function random(param1:uint = 255, param2:Boolean = false) : uint
      {
         if(param1 != 255 || param2)
         {
            return uint((param1 & 255) << 24 | (int(Math.random() * 255) & 255) << 16 | (int(Math.random() * 255) & 255) << 8 | int(Math.random() * 255) & 255);
         }
         return uint((int(Math.random() * 255) & 255) << 16 | (int(Math.random() * 255) & 255) << 8 | int(Math.random() * 255) & 255);
      }
      
      public function get blue() : uint
      {
         return this._blue;
      }
      
      public function set red(param1:uint) : void
      {
         this._red = param1 & 255;
      }
      
      public function get green() : uint
      {
         return this._green;
      }
      
      public function get alpha() : uint
      {
         return this._alpha;
      }
      
      public function set green(param1:uint) : void
      {
         this._green = param1 & 255;
      }
      
      public function get argb() : uint
      {
         return (this._alpha & 255) << 24 | (this._red & 255) << 16 | (this._green & 255) << 8 | this._blue & 255;
      }
      
      public function get rgb() : uint
      {
         return (this._red & 255) << 16 | (this._green & 255) << 8 | this._blue & 255;
      }
      
      public function setARGB(param1:uint, param2:uint, param3:uint, param4:uint) : void
      {
         this._alpha = param1;
         this._red = param2;
         this._green = param3;
         this._blue = param4;
      }
      
      public function toString() : String
      {
         return this.hex;
      }
      
      public function get red() : uint
      {
         return this._red;
      }
      
      public function set blue(param1:uint) : void
      {
         this._blue = param1 & 255;
      }
      
      public function set argb(param1:uint) : void
      {
         this.setARGB(param1 >> 24 & 255,param1 >> 16 & 255,param1 >> 8 & 255,param1 & 255);
      }
      
      public function set rgb(param1:uint) : void
      {
         this.setARGB(255,param1 >> 16 & 255,param1 >> 8 & 255,param1 & 255);
      }
      
      public function get hex() : String
      {
         var _loc1_:Array = [this._red.toString(16),this._green.toString(16),this._blue.toString(16)];
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            while(_loc1_[_loc2_].length < 2)
            {
               _loc1_[_loc2_] = "0" + _loc1_[_loc2_];
            }
            _loc1_[_loc2_] = _loc1_[_loc2_].toUpperCase();
            _loc2_++;
         }
         return _loc1_.join("");
      }
      
      public function set alpha(param1:uint) : void
      {
         this._alpha = param1 & 255;
      }
   }
}
