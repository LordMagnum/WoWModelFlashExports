package com.zam.lol
{
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class Animation
   {
       
      
      public var name:String;
      
      public var fps:int;
      
      public var bones:Vector.<AnimationBone>;
      
      public var lookup:Dictionary;
      
      public var duration:int;
      
      private var _mesh:LolMesh;
      
      public function Animation(param1:LolMesh)
      {
         super();
         this._mesh = param1;
      }
      
      public function read(param1:ByteArray) : void
      {
         this.name = param1.readUTF().toLowerCase();
         this.fps = param1.readInt();
         var _loc2_:uint = param1.readUnsignedInt();
         this.bones = new Vector.<AnimationBone>(_loc2_);
         this.lookup = new Dictionary();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            this.bones[_loc3_] = new AnimationBone(this._mesh,this);
            this.bones[_loc3_].read(param1);
            if(this.lookup[this.bones[_loc3_].bone] !== undefined)
            {
               this.bones[_loc3_].bone = this.bones[_loc3_].bone + "2";
            }
            this.lookup[this.bones[_loc3_].bone] = _loc3_;
            _loc3_++;
         }
         this.duration = Math.floor(1000 * (this.bones[0].frames.length / this.fps));
      }
   }
}
