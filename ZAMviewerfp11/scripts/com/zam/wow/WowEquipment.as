package com.zam.wow
{
   import com.zam.FileLoadEvent;
   import com.zam.ZamLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   
   public class WowEquipment
   {
       
      
      public var geosets:Vector.<Object>;
      
      public var textures:Vector.<Object>;
      
      public var models:Vector.<Object>;
      
      public var slot:int;
      
      public var uniqueSlot:int;
      
      public var sortValue:int;
      
      public var geoA:int;
      
      public var geoB:int;
      
      public var geoC:int;
      
      public var rootModel:WowModel;
      
      public var modelName:String;
      
      public var loaded:Boolean;
      
      public function WowEquipment(param1:WowModel, param2:int, param3:String = null, param4:int = 0, param5:int = 0)
      {
         super();
         this.rootModel = param1;
         this.slot = param2;
         this.uniqueSlot = WowModel.UniqueSlots[param2];
         this.sortValue = WowModel.SlotOrder[param2];
         if(param3)
         {
            this.load(param3,param4,param5);
         }
      }
      
      public function refresh() : void
      {
         var _loc1_:int = 0;
         if(this.models)
         {
            _loc1_ = 0;
            while(_loc1_ < this.models.length)
            {
               if(this.models[_loc1_].model)
               {
                  this.models[_loc1_].model.refresh();
               }
               _loc1_++;
            }
         }
         if(this.textures)
         {
            _loc1_ = 0;
            while(_loc1_ < this.textures.length)
            {
               if(this.textures[_loc1_].texture)
               {
                  this.textures[_loc1_].texture.refresh();
               }
               _loc1_++;
            }
         }
      }
      
      public function load(param1:String, param2:int, param3:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:WowAttachment = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:ZamLoader = null;
         var _loc12_:String = null;
         this.modelName = param1;
         if(this.slot == WowModel.SlotShoulder)
         {
            this.models = new Vector.<Object>(2);
         }
         else if(WowModel.SlotType[this.slot] != WowModel.TypeArmor)
         {
            this.models = new Vector.<Object>(1);
         }
         if(this.models)
         {
            _loc4_ = this.slot;
            if(this.slot == WowModel.SlotRanged)
            {
               _loc4_ = WowModel.SlotRightHand;
            }
            _loc5_ = 0;
            while(_loc5_ < this.models.length)
            {
               _loc6_ = -1;
               if(this.rootModel._attachments && this.rootModel._attachments.length > 0)
               {
                  _loc9_ = this.rootModel._attachments.length;
                  _loc10_ = 0;
                  while(_loc10_ < _loc9_)
                  {
                     if(this.rootModel._attachments[_loc10_]._slot == _loc4_)
                     {
                        if(_loc8_ == _loc5_)
                        {
                           _loc7_ = this.rootModel._attachments[_loc10_];
                           _loc6_ = this.rootModel._attachments[_loc10_]._bone;
                           break;
                        }
                        _loc8_++;
                     }
                     _loc10_++;
                  }
               }
               this.models[_loc5_] = {
                  "race":param2,
                  "gender":param3,
                  "bone":_loc6_,
                  "attachment":_loc7_
               };
               this.models[_loc5_].model = new WowModel(this.rootModel.contentPath,this.rootModel.viewer,{"_parentModel":this.rootModel});
               this.models[_loc5_].model.load(WowModel.SlotType[this.slot],param1,this.slot == WowModel.SlotShoulder?_loc5_ + 1:this.rootModel._race,this.rootModel._gender);
               this.loaded = true;
               _loc5_++;
            }
         }
         else
         {
            _loc11_ = new ZamLoader();
            _loc11_.dataFormat = URLLoaderDataFormat.TEXT;
            _loc11_.addEventListener(FileLoadEvent.LOAD_COMPLETE,this.slot == WowModel.SlotBelt?this.parseMum:this.parseSis,false,0,true);
            _loc11_.addEventListener(FileLoadEvent.LOAD_ERROR,this.onLoadError,false,0,true);
            _loc11_.addEventListener(FileLoadEvent.LOAD_SECURITY_ERROR,this.onLoadError,false,0,true);
            _loc11_.addEventListener(FileLoadEvent.LOAD_PROGRESS,this.onLoadProgress,false,0,true);
            _loc12_ = "models/armor/" + this.slot + "/" + param1 + (this.slot == WowModel.SlotBelt?".mum":".sis");
            _loc11_.load(new URLRequest(this.rootModel.contentPath + _loc12_.toLowerCase()));
         }
      }
      
      private function _parseSis(param1:Array) : void
      {
         var _loc2_:String = null;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:String = null;
         this.slot = parseInt(param1.shift());
         var _loc5_:int = parseInt(param1.shift());
         this.geosets = new Vector.<Object>(_loc5_);
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc2_ = param1.shift();
            _loc3_ = _loc2_.split(" ");
            this.geosets[_loc4_] = {
               "index":_loc3_[0],
               "value":_loc3_[1]
            };
            _loc4_++;
         }
         var _loc6_:int = parseInt(param1.shift());
         this.textures = new Vector.<Object>(_loc6_);
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc2_ = param1.shift();
            _loc3_ = _loc2_.split(" ");
            _loc7_ = parseInt(_loc3_.shift());
            _loc8_ = parseInt(_loc3_.shift());
            _loc9_ = _loc3_.join(" ");
            this.textures[_loc4_] = {
               "region":_loc7_,
               "gender":_loc8_,
               "file":_loc9_,
               "texture":null
            };
            if(_loc8_ == this.rootModel._gender && !this.rootModel._npcTexture)
            {
               if(_loc7_ > 0)
               {
                  this.textures[_loc4_].texture = new WowTexture(this.rootModel,_loc7_,_loc9_,WowTexture.ARMOR);
               }
               else
               {
                  this.rootModel._specialTextures[2] = new WowTexture(this.rootModel,2,_loc9_,WowTexture.SPECIAL);
               }
            }
            _loc4_++;
         }
         _loc2_ = param1.shift();
         _loc3_ = _loc2_.split(" ");
         if(_loc3_.length == 3)
         {
            this.geoA = parseInt(_loc3_[0]);
            this.geoB = parseInt(_loc3_[1]);
            this.geoC = parseInt(_loc3_[2]);
         }
      }
      
      private function parseSis(param1:FileLoadEvent) : void
      {
         var _loc2_:Array = param1.target.data.split("\r\n");
         this._parseSis(_loc2_);
         this.loaded = true;
         this.rootModel.updateMeshes();
      }
      
      private function parseMum(param1:FileLoadEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:WowAttachment = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:Array = param1.target.data.split("\r\n");
         this._parseSis(_loc2_);
         if(this.slot == WowModel.SlotBelt && _loc2_.length > 1)
         {
            this.models = new Vector.<Object>(1);
            _loc3_ = -1;
            if(this.rootModel._attachments && this.rootModel._attachments.length > 0)
            {
               _loc5_ = this.rootModel._attachments.length;
               _loc6_ = 0;
               while(_loc6_ < _loc5_)
               {
                  if(this.rootModel._attachments[_loc6_]._slot == WowModel.SlotBelt)
                  {
                     _loc4_ = this.rootModel._attachments[_loc6_];
                     _loc3_ = this.rootModel._attachments[_loc6_]._bone;
                     break;
                  }
                  _loc6_++;
               }
            }
            this.models[0] = {
               "race":0,
               "gender":0,
               "bone":_loc3_,
               "attachment":_loc4_
            };
            this.models[0].model = new WowModel(this.rootModel.contentPath,this.rootModel.viewer,{"_parentModel":this.rootModel});
            if(!this.models[0].model._parseMum(_loc2_))
            {
               this.models = null;
            }
         }
         this.loaded = true;
         this.rootModel.updateMeshes();
      }
      
      private function onLoadStart(param1:FileLoadEvent) : void
      {
         var _loc2_:FileLoadEvent = new FileLoadEvent(FileLoadEvent.LOAD_START,param1.url);
         this.rootModel.viewer.dispatchEvent(_loc2_);
      }
      
      private function onLoadProgress(param1:FileLoadEvent) : void
      {
         var _loc2_:FileLoadEvent = new FileLoadEvent(FileLoadEvent.LOAD_PROGRESS,param1.url,param1.currentBytes,param1.totalBytes);
         this.rootModel.viewer.dispatchEvent(_loc2_);
      }
      
      private function onLoadError(param1:FileLoadEvent) : void
      {
         var _loc2_:FileLoadEvent = new FileLoadEvent(FileLoadEvent.LOAD_ERROR,param1.url,-1,-1,param1.errorMessage);
         this.rootModel.viewer.dispatchEvent(_loc2_);
      }
   }
}
