package com.zam.MOM
{
   import flash.utils.ByteArray;
   
   public class MOMMesh
   {
       
      
      public var show:Boolean;
      
      public var opacity:Number;
      
      public var geosetid:int;
      
      public var envmap:Boolean;
      
      public var pass:int;
      
      public var transparent:Boolean;
      
      public var index:int;
      
      public var idx_start:int;
      
      public var color:uint;
      
      public var unlit:Boolean;
      
      public var nozwrite:Boolean;
      
      public var material:String;
      
      public var idx_end:int;
      
      public var blendmode:int;
      
      public var texanim:int;
      
      public var matid:int;
      
      public var swrap:Boolean;
      
      public var twrap:Boolean;
      
      public var billboard:Boolean;
      
      public function MOMMesh(param1:Object = null)
      {
         super();
         this.texanim = 0;
         this.color = 16777215;
         this.opacity = 1;
      }
      
      public function read(param1:ByteArray) : void
      {
      }
   }
}
