package com.zam.wow
{
   import flash.utils.ByteArray;
   
   public class WowMaterial
   {
       
      
      public var _filename:String;
      
      public var _texture:WowTexture = null;
      
      public var _specialTexture:int;
      
      protected var _mesh:WowModel;
      
      protected var _index:int;
      
      public function WowMaterial(param1:WowModel, param2:int, param3:String = null)
      {
         super();
         this._mesh = param1;
         this._index = param2;
         if(param3 != null)
         {
            this._filename = param3;
            this._specialTexture = -1;
            this.load();
         }
      }
      
      public function read(param1:ByteArray) : void
      {
         this._filename = param1.readUTF();
         this._specialTexture = param1.readUnsignedByte();
         this.load();
      }
      
      public function load() : void
      {
         if(this._filename.length > 0)
         {
            this._texture = new WowTexture(this._mesh,this._index,this._filename);
         }
      }
   }
}
