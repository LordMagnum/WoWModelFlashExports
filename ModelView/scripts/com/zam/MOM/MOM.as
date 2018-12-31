package com.zam.MOM
{
   import com.zam.Color;
   import com.zam.Viewer;
   import com.zam.ZAMLoader;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   import flash.utils.getTimer;
   import org.papervision3d.core.geom.TriangleMesh3D;
   import org.papervision3d.core.geom.renderables.Triangle3D;
   import org.papervision3d.core.geom.renderables.Vertex3D;
   import org.papervision3d.core.math.Matrix3D;
   import org.papervision3d.core.math.Number3D;
   import org.papervision3d.core.math.NumberUV;
   import org.papervision3d.core.proto.DisplayObjectContainer3D;
   import org.papervision3d.core.proto.GeometryObject3D;
   import org.papervision3d.core.proto.MaterialObject3D;
   import org.papervision3d.events.FileLoadEvent;
   import org.papervision3d.materials.BitmapFileMaterial;
   import org.papervision3d.materials.BitmapMaterial;
   import org.papervision3d.materials.MovieMaterial;
   import org.papervision3d.materials.utils.MaterialsList;
   import org.papervision3d.objects.DisplayObject3D;
   import org.papervision3d.objects.primitives.Plane;
   
   public class MOM extends DisplayObject3D
   {
      
      private static var _loadingIdle:Boolean = true;
      
      private static var _waitingAttachments:Array;
      
      private static var _stage:Viewer;
      
      public static var DEFAULT_SCALING:Number = 1;
      
      private static var _waitingArmor:Array;
      
      private static var BLENDS:Array = [false,true,true,false,true,false,false];
      
      private static const SLOTSORT:Array = [0,16,0,15,1,7,9,5,6,10,11,0,0,17,18,19,14,20,0,8,7,21,22,23,0,24,25];
      
      private static const REGIONS:Array = [new Array(0,0,1,1),new Array(0,0.75,0.5,0.25),new Array(0,0.5,0.5,0.25),new Array(0,0.375,0.5,0.125),new Array(0,0.25,0.5,0.125),new Array(0,0,0.5,0.25),new Array(0.5,0.75,0.5,0.25),new Array(0.5,0.625,0.5,0.125),new Array(0.5,0.375,0.5,0.25),new Array(0.5,0.125,0.5,0.25),new Array(0.5,0,0.5,0.125)];
      
      private static var INTERNAL_SCALING:Number = 100;
      
      private static var showBitmapPos:Number3D = new Number3D();
      
      public static const UNIQUESLOTS:Array = [0,1,0,3,4,5,6,7,8,9,10,0,0,21,22,21,16,21,0,19,5,21,22,22,0,21,21];
      
      private static var _loadedAttachments:Array;
      
      public static const GENDERS:Array = ["Male","Female"];
      
      private static var _isnpc:Boolean = false;
      
      public static const RACES:Array = ["","Human","Orc","Dwarf","NightElf","Scourge","Tauren","Gnome","Troll","Goblin","BloodElf","Draenei","FelOrc","Naga_","Broken","Skeleton","Vrykul","Tuskarr","ForestTroll","Taunka","NorthrendSkeleton","IceTroll"];
      
      private static var counter:int = 0;
       
      
      private var _container:DisplayObjectContainer3D;
      
      public var loaded:Boolean = false;
      
      private var _basespecial:BitmapData;
      
      private var _textures:Array;
      
      private var _type:int;
      
      private var opacity:Number;
      
      public var geometryLoaded:Boolean = false;
      
      private var _basedirty:Boolean = false;
      
      private var _nocache:Boolean;
      
      private var _facialfeature:int = 0;
      
      private var _bones:Vector.<MOMBone>;
      
      private var _haircolor:int = 0;
      
      private var _scaling:Number;
      
      private var _chargeosets:Array;
      
      private var _isattach:Boolean = false;
      
      public var materialsToLoad:int;
      
      private var _vertices:Vector.<MOMVertex>;
      
      private var _contentpath:String;
      
      private var _filename:String;
      
      private var _loadedMaterials:Array;
      
      private var _indices:Vector.<int>;
      
      private var _slotbones:Array;
      
      private var _center:Vertex3D;
      
      private var _showfacefeatures:Boolean = true;
      
      private var _ttimer:int = 0;
      
      private var _meshes:Array;
      
      private var _facetype:int = 0;
      
      private var _special:Array;
      
      public var done:Boolean = false;
      
      private var _skincolor:int = 0;
      
      private var _hairstyle:int = 0;
      
      private var _facialfeatures:Array;
      
      private var _baked:Array;
      
      private var _materials:MaterialsList;
      
      private var _race:int = -1;
      
      private var _mumtextures:Array;
      
      private var _skincolors:Array;
      
      private var _showhair:Boolean = true;
      
      private var _facialcolor:int = 0;
      
      private var _gender:int = -1;
      
      private var _hairstyles:Array;
      
      private var head:Object;
      
      private var _boundingbox:Vertex3D;
      
      private var _attachments:Array;
      
      private var _npcbase:String;
      
      public function MOM(param1:String, param2:* = null)
      {
         var _loc3_:int = 0;
         this._center = new Vertex3D();
         this._boundingbox = new Vertex3D();
         this._attachments = new Array(26);
         super(null,null);
         if(param2 != null)
         {
            _stage = param2 as Viewer;
         }
         this._contentpath = param1;
         this._materials = new MaterialsList();
         this._container = this;
         blendMode = BlendMode.LAYER;
         addEventListener(MOMEvent.GEOMETRY_LOADED,this.onMomGeometryDone);
         addEventListener(MOMEvent.MATERIALS_LOADED,this.onMomMaterialsDone);
         addEventListener(MOMEvent.MOM_LOADED,this.onMomLoadComplete);
         addEventListener(MOMEvent.INTERNAL_ERROR,this.onError);
         this._mumtextures = new Array();
         this._loadedMaterials = new Array();
         if(!_loadedAttachments)
         {
            _loadedAttachments = new Array();
         }
         if(!_waitingAttachments)
         {
            _waitingAttachments = new Array();
         }
         if(!_waitingArmor)
         {
            _waitingArmor = new Array();
         }
         while(_loc3_ < this._attachments.length)
         {
            this._attachments[_loc3_] = null;
            _loc3_++;
         }
         this.loaded = false;
      }
      
      private function addMaterial(param1:String) : MaterialObject3D
      {
         var _loc2_:MaterialObject3D = null;
         var _loc4_:String = null;
         var _loc3_:String = param1.toLowerCase();
         if(this._materials)
         {
            _loc2_ = this._materials.getMaterialByName(_loc3_);
         }
         else
         {
            this._materials = new MaterialsList();
         }
         if(!_loc2_)
         {
            if(_loc3_ != "")
            {
               _loc4_ = !!this._nocache?"?" + Math.floor(Math.random() * 10000) + new Date().getTime():"";
               _loc2_ = new BitmapFileMaterial(this._contentpath + "minalpha/textures/" + _loc3_ + _loc4_);
               _loc2_.addEventListener(FileLoadEvent.LOAD_PROGRESS,this.onFileLoadProgress);
               _loc2_.addEventListener(FileLoadEvent.LOAD_COMPLETE,this.onMaterialLoadComplete);
               _loc2_.addEventListener(FileLoadEvent.LOAD_ERROR,this.onMaterialLoadError);
               _loc2_.addEventListener(FileLoadEvent.SECURITY_LOAD_ERROR,this.onMaterialLoadError);
               _loc2_.name = _loc3_;
               _loc2_.doubleSided = false;
               _loc2_.smooth = true;
               this._materials.addMaterial(_loc2_);
               this.materialsToLoad++;
            }
         }
         return _loc2_;
      }
      
      public function destroy() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         this.dtrace("!!!!!!!!!!!!!!!! DESTROY !!!!!!!!!!!!!!!!");
         _loadingIdle = true;
         for(_loc1_ in this._container.children)
         {
            this._container.removeChildByName(_loc1_);
         }
         while(_loc2_ < this._attachments.length)
         {
            this._attachments[_loc2_] = null;
            _loc2_++;
         }
         this._basespecial = null;
         this._npcbase = "";
         this._filename = "";
         this.done = false;
         this.loaded = false;
         this.geometryLoaded = false;
         this.head = null;
         this.opacity = 1;
         this._race = -1;
         this._gender = -1;
         this._skincolor = 0;
         this._facetype = 0;
         this._haircolor = 0;
         this._hairstyle = 0;
         this._facialfeature = 0;
         this._facialcolor = 0;
         this._showhair = true;
         this._showfacefeatures = true;
         _isnpc = false;
         this._type = 0;
         this._isattach = false;
         _waitingArmor = new Array();
         _loadedAttachments = new Array();
         _waitingAttachments = new Array();
      }
      
      public function setRaceGender(param1:int, param2:int) : void
      {
         if(param1 == 0 || param1 > RACES.length || param2 > GENDERS.length)
         {
            return;
         }
         if(!this.loaded)
         {
            this._race = param1;
            this._gender = param2;
            return;
         }
         if(param1 == this._race && param2 == this._gender)
         {
            return;
         }
         var _loc3_:* = "";
         var _loc4_:int = 0;
         while(_loc4_ < this._attachments.length)
         {
            if(this._attachments[_loc4_] != null)
            {
               if(_loc3_ != "")
               {
                  _loc3_ = _loc3_ + ",";
               }
               _loc3_ = _loc3_ + String(this._attachments[_loc4_].slot + "," + this._attachments[_loc4_].id);
            }
            _loc4_++;
         }
         this.destroy();
         this._race = param1;
         this._gender = param2;
         this.load();
         this.attach(_loc3_);
      }
      
      public function get skincolor() : int
      {
         return this._skincolor;
      }
      
      private function addModel(param1:int, param2:int) : void
      {
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:int = 0;
         var _loc11_:MOM = null;
         var _loc3_:int = UNIQUESLOTS[param1];
         var _loc4_:Array = new Array();
         var _loc5_:int = 0;
         if(_loc3_ == MOMItemSlot.RIGHTHAND && this._attachments[_loc3_] && (param1 == MOMItemSlot.TWOHAND || param1 == MOMItemSlot.ONEHAND))
         {
            param1 = MOMItemSlot.OFFHAND;
            _loc3_ = MOMItemSlot.LEFTHAND;
         }
         var _loc6_:int = 0;
         while(_loc6_ < this._slotbones.length)
         {
            if(this._slotbones[_loc6_].slot == param1 || param1 == MOMItemSlot.RANGED && this._slotbones[_loc6_].slot == _loc3_)
            {
               _loc4_.push(this._slotbones[_loc6_]);
               _loc5_++;
               if(param1 != MOMItemSlot.SHOULDER || _loc5_ == 2)
               {
                  break;
               }
            }
            _loc6_++;
         }
         var _loc7_:int = 0;
         while(_loc7_ < _loc5_)
         {
            _loc8_ = "";
            _loc9_ = param2.toString();
            _loc10_ = MOMModelType.ITEM;
            if(param1 == MOMItemSlot.HEAD)
            {
               this.loader(4,"models/armor/1/" + _loc9_);
               _loc9_ = _loc9_ + "_" + this._race + "_" + this._gender;
               _loc10_ = MOMModelType.HELM;
            }
            else if(param1 == MOMItemSlot.SHOULDER)
            {
               _loc8_ = "_" + (_loc7_ + 1);
               _loc9_ = _loc9_ + _loc8_;
               _loc10_ = MOMModelType.SHOULDER;
            }
            _loc11_ = new MOM(this._contentpath);
            _loc11_.addEventListener(FileLoadEvent.LOAD_PROGRESS,this.onFileLoadProgress);
            _loc11_.addEventListener(FileLoadEvent.LOAD_ERROR,this.onAttachmentLoadError);
            if(!this._isattach)
            {
               _loc11_.addEventListener(MOMEvent.ATTACHMENT_LOADED,this.onAttachmentLoadComplete);
            }
            _loc11_.addEventListener(MOMEvent.CHANGED,this.onMomChange);
            _loc11_.load(_loc10_ + MOMModelType.ATTACH,_loc9_,this._scaling / INTERNAL_SCALING);
            _loc11_.copyTransform(this._bones[_loc4_[_loc7_].bone].matrix);
            _loc11_.x = _loc11_.x + this._bones[_loc4_[_loc7_].bone].transpivot.x;
            _loc11_.y = _loc11_.y + this._bones[_loc4_[_loc7_].bone].transpivot.y;
            _loc11_.z = _loc11_.z + this._bones[_loc4_[_loc7_].bone].transpivot.z;
            _loc11_.name = "slot_" + _loc3_ + _loc8_;
            this._container.removeChildByName(_loc11_.name);
            if(param1 == MOMItemSlot.TWOHAND)
            {
               this._container.removeChildByName("slot_13");
            }
            this._container.addChild(_loc11_);
            this._attachments[_loc3_] = {
               "name":"slot_" + _loc3_,
               "slot":param1,
               "id":param2,
               "geo":null
            };
            this.dtrace("attached \"slot_" + _loc3_ + _loc8_ + "\"");
            _loc7_++;
         }
      }
      
      public function set skincolor(param1:int) : void
      {
         if(this._skincolor != param1 && param1 != -1)
         {
            this._skincolor = param1;
            this.updateCharacter(true);
         }
      }
      
      private function onMomGeometryDone(param1:FileLoadEvent) : void
      {
         this.dtrace("--","momGeometryLoaded" + (!!this._isattach?" (attachment)":"") + ": " + this._contentpath + this._filename);
         this.geometryLoaded = true;
         if(this.materialsToLoad == 0 && !this.done)
         {
            dispatchEvent(new Event(MOMEvent.MOM_LOADED));
         }
         if(this._isattach)
         {
            dispatchEvent(new Event(MOMEvent.ATTACHMENT_LOADED));
         }
         else if(_waitingAttachments.length > 0)
         {
            this.loadNextModel();
         }
         else
         {
            _loadingIdle = true;
         }
      }
      
      public function get hairstyle() : int
      {
         return this._hairstyle;
      }
      
      private function onLoadOMAError(param1:FileLoadEvent) : void
      {
         this._showhair = false;
         this._showfacefeatures = true;
         this.setMeshes();
      }
      
      private function loader(param1:int, param2:String) : void
      {
         var url:String = null;
         var queued:Boolean = false;
         var noCache:String = null;
         var pId:int = param1;
         var pUrl:String = param2;
         url = pUrl.toLowerCase();
         queued = false;
         this.dtrace("loader(" + pId + "," + pUrl + ")");
         var loader:ZAMLoader = new ZAMLoader();
         if(pId == 1)
         {
            url = url + ".mom";
            this._filename = url;
            queued = true;
            loader.dataFormat = URLLoaderDataFormat.BINARY;
            loader.addEventListener(FileLoadEvent.LOAD_COMPLETE,this.parseMOM);
         }
         else if(pId == 2)
         {
            url = url + ".sis";
            loader.dataFormat = URLLoaderDataFormat.TEXT;
            loader.addEventListener(FileLoadEvent.LOAD_COMPLETE,this.parseSISArmor);
         }
         else if(pId == 3)
         {
            url = url + ".sis";
            loader.dataFormat = URLLoaderDataFormat.TEXT;
            loader.addEventListener(FileLoadEvent.LOAD_COMPLETE,this.parseSISNPC);
         }
         else if(pId == 4)
         {
            url = url + ".oma";
            loader.dataFormat = URLLoaderDataFormat.TEXT;
            loader.addEventListener(FileLoadEvent.LOAD_COMPLETE,this.parseOMA);
            loader.addEventListener(FileLoadEvent.LOAD_ERROR,this.onLoadOMAError);
         }
         else if(pId == 5)
         {
            url = url + ".mum";
            loader.dataFormat = URLLoaderDataFormat.TEXT;
            loader.addEventListener(FileLoadEvent.LOAD_COMPLETE,this.parseMUM);
         }
         loader.addEventListener(FileLoadEvent.LOAD_PROGRESS,this.onFileLoadProgress);
         loader.addEventListener(FileLoadEvent.LOAD_ERROR,this.onLoadError);
         loader.addEventListener(FileLoadEvent.SECURITY_LOAD_ERROR,this.onLoadError);
         try
         {
            if(queued)
            {
               _loadingIdle = false;
            }
            url = escape(url);
            noCache = !!this._nocache?"?" + Math.floor(Math.random() * 10000) + new Date().getTime():"";
            this.dtrace("Downloading (" + pId + "): " + this._contentpath + url);
            loader.load(new URLRequest(this._contentpath + url + noCache));
            dispatchEvent(new Event(MOMEvent.OPEN_FILE));
            return;
         }
         catch(ex:Error)
         {
            dtrace("Error loading file: " + url + ": " + ex.message);
            if(queued)
            {
               _loadingIdle = true;
            }
            return;
         }
      }
      
      public function attachArmor(param1:int, param2:int) : void
      {
         if(this._type != MOMModelType.CHAR && this._type != MOMModelType.NPC || this.slotType(param1) == -1)
         {
            return;
         }
         if(this.slotType(param1) == MOMModelType.ITEM)
         {
            this.attachItem(param1,param2);
         }
         else
         {
            this.dtrace("--","queued armor");
            _waitingArmor.push({
               "slot":param1,
               "id":param2
            });
            if(this.done || this.loaded && this.materialsToLoad == 0)
            {
               this.loadNextArmor();
            }
         }
      }
      
      private function parseMUM(param1:FileLoadEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:Array = null;
         var _loc8_:int = 0;
         var _loc9_:String = null;
         this.dtrace("--","parseMUM()");
         var _loc2_:Array = param1.target.data.split("\r\n");
         var _loc5_:String = _loc2_.shift();
         var _loc6_:int = parseInt(_loc2_.shift());
         this._mumtextures = new Array();
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            _loc3_ = _loc2_.shift();
            _loc4_ = _loc3_.split(" ");
            _loc8_ = parseInt(_loc4_.shift());
            _loc9_ = _loc4_.join(" ");
            this._mumtextures[_loc8_] = _loc9_ || "";
            _loc7_++;
         }
         this.loader(1,"models/" + _loc5_.substr(0,_loc5_.lastIndexOf(".")));
      }
      
      private function onMomLoadComplete(param1:Event) : void
      {
         this.dtrace("--","momLoadComplete " + (!!this._isattach?"(attachment)":""));
         this.done = true;
         dispatchEvent(new FileLoadEvent(FileLoadEvent.LOAD_COMPLETE));
      }
      
      public function set hairstyle(param1:int) : void
      {
         if(this._hairstyle != param1 && param1 != -1)
         {
            this._hairstyle = param1;
            this.updateCharacter(true);
         }
      }
      
      public function get facetype() : int
      {
         return this._facetype;
      }
      
      public function get facialfeature() : int
      {
         return this._facialfeature;
      }
      
      public function get contentpath() : String
      {
         return this._contentpath;
      }
      
      public function get type() : int
      {
         return this._type;
      }
      
      public function set contentpath(param1:String) : void
      {
         this._contentpath = param1;
      }
      
      public function set facetype(param1:int) : void
      {
         if(this._facetype != param1 && param1 != -1)
         {
            this._facetype = param1;
            this.updateCharacter(true);
         }
      }
      
      private function onMaterialLoadError(param1:FileLoadEvent) : void
      {
         this.dtrace("--","momMaterialLoadError (" + this.materialsToLoad + "): " + param1.file);
         this.materialsToLoad--;
         if(this.materialsToLoad == 0)
         {
            this._loadedMaterials = [];
            dispatchEvent(new Event(MOMEvent.MATERIALS_LOADED));
         }
      }
      
      public function attach(param1:String) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         this.dtrace("attach(",param1,")");
         if(this._type != MOMModelType.CHAR && this._type != MOMModelType.NPC || param1 == "")
         {
            return;
         }
         var _loc2_:Array = param1.split(",");
         if(_loc2_.length % 2 != 0)
         {
            trace("!!","Lists are not equal length");
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_];
            _loc5_ = _loc2_[_loc3_ + 1];
            if(this.slotType(_loc4_) == MOMModelType.ITEM)
            {
               this.attachItem(_loc4_,_loc5_);
            }
            else
            {
               this.attachArmor(_loc4_,_loc5_);
            }
            _loc3_ = _loc3_ + 2;
         }
      }
      
      public function set facialcolor(param1:int) : void
      {
         if(this._facialcolor != param1 && param1 != -1)
         {
            this._facialcolor = param1;
            this.updateCharacter(true);
         }
      }
      
      private function onLoadMOMError(param1:FileLoadEvent) : void
      {
         this.dtrace("--","loadMOMError: " + param1.message);
         this._filename = "";
         var _loc2_:FileLoadEvent = new FileLoadEvent(FileLoadEvent.LOAD_ERROR,param1.file,-1,-1,param1.message);
         dispatchEvent(_loc2_);
      }
      
      public function get center() : Vertex3D
      {
         return this._center;
      }
      
      private function parseSISArmor(param1:FileLoadEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:Array = null;
         var _loc13_:Object = null;
         var _loc14_:Object = null;
         this.dtrace("--","parseSISArmor()");
         var _loc2_:int = parseInt(param1.file.substring(param1.file.lastIndexOf("/") + 1,param1.file.lastIndexOf(".")));
         var _loc3_:Array = param1.target.data.split("\r\n");
         _loc5_ = _loc3_.shift();
         _loc6_ = _loc5_.split(" ");
         var _loc7_:int = parseInt(_loc6_[0]);
         var _loc8_:int = UNIQUESLOTS[_loc7_];
         if(this._attachments[_loc8_] != null)
         {
            this.clearSlot(_loc7_,false);
         }
         var _loc9_:Array = new Array();
         var _loc10_:int = parseInt(_loc3_.shift());
         _loc4_ = 0;
         while(_loc4_ < _loc10_)
         {
            _loc5_ = _loc3_.shift();
            _loc6_ = _loc5_.split(" ");
            _loc13_ = {
               "index":parseInt(_loc6_[0]),
               "value":parseInt(_loc6_[1])
            };
            _loc9_.push(_loc13_);
            _loc4_++;
         }
         var _loc11_:int = parseInt(_loc3_.shift());
         _loc4_ = 0;
         while(_loc4_ < _loc11_)
         {
            _loc5_ = _loc3_.shift();
            _loc6_ = _loc5_.split(" ");
            if(_loc6_.length > 3)
            {
               _loc6_[2] = _loc6_.slice(2).join(" ");
            }
            _loc14_ = {
               "region":parseInt(_loc6_[0]),
               "gender":parseInt(_loc6_[1]),
               "name":_loc6_[2]
            };
            if(_loc14_.gender == this._gender && !_isnpc)
            {
               if(_loc14_.region > 0)
               {
                  if(!(_loc14_.region == MOMTextureRegion.FOOT && (this._race == 6 || this._race == 8 || this._race == 11 || this.race == 14)))
                  {
                     this._baked.push({
                        "region":_loc14_.region,
                        "layer":SLOTSORT[_loc7_],
                        "name":_loc14_.name,
                        "slot":_loc7_
                     });
                     this.addMaterial(_loc14_.name);
                  }
               }
               else
               {
                  this._special[2] = _loc14_.name;
                  this.addMaterial(_loc14_.name);
               }
            }
            _loc4_++;
         }
         _loc5_ = _loc3_.shift();
         var _loc12_:Array = [0,0,0];
         if(_loc5_ != null)
         {
            _loc6_ = _loc5_.split(" ");
            _loc12_ = [parseInt(_loc6_[0]),parseInt(_loc6_[1]),parseInt(_loc6_[2])];
         }
         this._attachments[_loc8_] = {
            "name":"slot_" + _loc7_,
            "slot":_loc7_,
            "id":_loc2_,
            "geo":_loc9_,
            "abc":_loc12_
         };
         if(_loc7_ == MOMItemSlot.ROBE)
         {
            this._attachments[_loc7_] = {
               "name":"slot_" + _loc7_,
               "slot":_loc7_,
               "id":_loc2_,
               "geo":[],
               "abc":[0,0,0]
            };
         }
         this.dtrace("attached \"slot_" + _loc7_ + "\" (" + this._attachments[_loc7_].abc + ")");
         this.updateCharacter();
         this.loadNextArmor();
      }
      
      public function set facialfeature(param1:int) : void
      {
         if(this._facialfeature != param1 && param1 != -1)
         {
            this._facialfeature = param1;
            this.updateCharacter(true);
         }
      }
      
      private function parseIdFromDisplayName(param1:String) : int
      {
         var _loc2_:RegExp = /_(\d+)/;
         var _loc3_:String = _loc2_.exec(param1)[1];
         if(_loc3_)
         {
            return parseInt(_loc3_);
         }
         return -1;
      }
      
      private function setMeshes() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(this._hairstyles.length == 0)
         {
            return;
         }
         this.dtrace("setMeshes()");
         _loc1_ = 0;
         while(_loc1_ < this._meshes.length)
         {
            this._container.getChildByName("geo_" + this._meshes[_loc1_].index).visible = this._meshes[_loc1_].geosetid == 0;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 16)
         {
            this._chargeosets[_loc1_] = 1;
            _loc1_++;
         }
         this._chargeosets[7] = 2;
         if(this._showfacefeatures && this._facialfeatures[this._facialfeature])
         {
            this._chargeosets[1] = this._facialfeatures[this._facialfeature].geoset1;
            this._chargeosets[2] = this._facialfeatures[this._facialfeature].geoset2;
            this._chargeosets[3] = this._facialfeatures[this._facialfeature].geoset3;
         }
         _loc1_ = 0;
         while(_loc1_ < this._attachments.length)
         {
            if(this._attachments[_loc1_] != null)
            {
               if(this._attachments[_loc1_].geo != null)
               {
                  _loc2_ = 0;
                  while(_loc2_ < this._attachments[_loc1_].geo.length)
                  {
                     this._chargeosets[this._attachments[_loc1_].geo[_loc2_].index] = this._attachments[_loc1_].geo[_loc2_].value;
                     _loc2_++;
                  }
                  if(this._chargeosets[13] == 1)
                  {
                     this._chargeosets[13] = 1 + int(this._attachments[_loc1_].abc[2]);
                  }
                  if(this._attachments[_loc1_].slot == 6)
                  {
                     this._chargeosets[18] = 1 + int(this._attachments[_loc1_].abc[0]);
                     this.dtrace("robe",this._chargeosets[18]);
                  }
               }
            }
            _loc1_++;
         }
         if(this._chargeosets[13] == 2)
         {
            this._chargeosets[5] = this._chargeosets[12] = 0;
         }
         if(this._chargeosets[4] > 1)
         {
            this._chargeosets[8] = 0;
         }
         if(this._showhair && this._hairstyles.length > 0)
         {
            _loc1_ = 0;
            while(_loc1_ < this._hairstyles.length)
            {
               _loc2_ = 0;
               while(_loc2_ < this._meshes.length)
               {
                  if(this._meshes[_loc2_].geosetid != 0 && this._meshes[_loc2_].geosetid == this._hairstyles[_loc1_].geoset)
                  {
                     this._container.getChildByName("geo_" + this._meshes[_loc2_].index).visible = this._hairstyle == _loc1_ && this._showhair;
                  }
                  _loc2_++;
               }
               _loc1_++;
            }
         }
         _loc1_ = 0;
         while(_loc1_ < this._meshes.length)
         {
            if((this._race == 1 || this._race == 7 || this._race == 8 || this._race == 18) && this._gender == 0 && this._hairstyle == 0 && this._meshes[_loc1_].geosetid == 1)
            {
               this._container.getChildByName("geo_" + this._meshes[_loc1_].index).visible = true;
            }
            _loc2_ = 1;
            while(_loc2_ < 20)
            {
               _loc3_ = _loc2_ * 100;
               _loc4_ = (_loc2_ + 1) * 100;
               if(this._meshes[_loc1_].geosetid > _loc3_ && this._meshes[_loc1_].geosetid < _loc4_)
               {
                  this._container.getChildByName("geo_" + this._meshes[_loc1_].index).visible = this._meshes[_loc1_].geosetid == _loc3_ + this._chargeosets[_loc2_];
               }
               _loc2_++;
            }
            _loc1_++;
         }
         dispatchEvent(new Event(MOMEvent.CHANGED,true));
      }
      
      private function parseSISNPC(param1:FileLoadEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:Array = null;
         this.dtrace("--","parseSISNPC()");
         var _loc2_:Array = param1.target.data.split("\r\n");
         _loc3_ = _loc2_.shift();
         _loc4_ = _loc3_.split(" ");
         this._race = parseInt(_loc4_[0]);
         this._gender = parseInt(_loc4_[1]);
         _loc3_ = _loc2_.shift();
         if(_loc3_ != "")
         {
            this._npcbase = _loc3_;
         }
         _loc3_ = _loc2_.shift();
         _loc4_ = _loc3_.split(" ");
         this._skincolor = parseInt(_loc4_[0]);
         this._hairstyle = parseInt(_loc4_[1]);
         this._haircolor = parseInt(_loc4_[2]);
         this._facialfeature = parseInt(_loc4_[3]);
         this._facetype = parseInt(_loc4_[4]);
         this.load();
         _loc3_ = _loc2_.shift();
         _loc4_ = _loc3_.split(" ");
         var _loc5_:int = parseInt(_loc4_[0]);
         var _loc6_:int = parseInt(_loc4_[1]);
         var _loc7_:int = parseInt(_loc4_[2]);
         var _loc8_:int = parseInt(_loc4_[3]);
         var _loc9_:int = parseInt(_loc4_[4]);
         var _loc10_:int = parseInt(_loc4_[5]);
         var _loc11_:int = parseInt(_loc4_[6]);
         var _loc12_:int = parseInt(_loc4_[7]);
         var _loc13_:int = parseInt(_loc4_[8]);
         var _loc14_:int = parseInt(_loc4_[9]);
         if(_loc5_ != 0)
         {
            this.attachArmor(MOMItemSlot.HEAD,_loc5_);
         }
         if(_loc6_ != 0)
         {
            this.attachArmor(MOMItemSlot.SHOULDER,_loc6_);
         }
         if(_loc7_ != 0)
         {
            this.attachArmor(MOMItemSlot.SHIRT,_loc7_);
         }
         if(_loc8_ != 0)
         {
            this.attachArmor(MOMItemSlot.CHEST,_loc8_);
         }
         if(_loc9_ != 0)
         {
            this.attachArmor(MOMItemSlot.BELT,_loc9_);
         }
         if(_loc10_ != 0)
         {
            this.attachArmor(MOMItemSlot.PANTS,_loc10_);
         }
         if(_loc11_ != 0)
         {
            this.attachArmor(MOMItemSlot.BOOTS,_loc11_);
         }
         if(_loc12_ != 0)
         {
            this.attachArmor(MOMItemSlot.BRACERS,_loc12_);
         }
         if(_loc13_ != 0)
         {
            this.attachArmor(MOMItemSlot.GLOVES,_loc13_);
         }
         if(_loc14_ != 0)
         {
            this.attachArmor(MOMItemSlot.TABARD,_loc14_);
         }
      }
      
      private function dtrace(... rest) : void
      {
         var elapsed:String = null;
         var title:String = null;
         var str:String = null;
         var s:String = null;
         var args:Array = rest;
         if(this._ttimer == 0)
         {
            this._ttimer = getTimer();
         }
         elapsed = (getTimer() - this._ttimer).toString();
         while(elapsed.length < 4)
         {
            elapsed = elapsed + " ";
         }
         elapsed = "+" + elapsed;
         try
         {
            title = this._filename.substr(this._filename.lastIndexOf("/") + 1);
            str = args.join(" ");
            for each(s in str.split("\n"))
            {
               trace(elapsed,title,s);
            }
            return;
         }
         catch(ex:Error)
         {
            trace(elapsed,"[d]",args.join(" "));
            return;
         }
      }
      
      private function updateBaked(param1:int, param2:int, param3:String) : void
      {
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         while(_loc5_ < this._baked.length)
         {
            if(this._baked[_loc5_].region == param1 && this._baked[_loc5_].layer == param2)
            {
               this._baked[_loc5_] = {
                  "region":param1,
                  "layer":param2,
                  "name":param3
               };
               _loc4_ = true;
            }
            _loc5_++;
         }
         if(!_loc4_)
         {
            this._baked.push({
               "region":param1,
               "layer":param2,
               "name":param3
            });
         }
      }
      
      private function object_to_string(param1:*) : String
      {
         var _loc4_:* = undefined;
         if(typeof param1 != "object")
         {
            return param1;
         }
         var _loc2_:int = 0;
         var _loc3_:* = "";
         for(_loc4_ in param1)
         {
            if(_loc2_ != 0)
            {
               _loc3_ = _loc3_ + ", ";
            }
            _loc3_ = _loc3_ + (_loc4_ + ":");
            if(param1[_loc4_] !== null)
            {
               _loc3_ = _loc3_ + param1[_loc4_].toString();
            }
            else
            {
               _loc3_ = _loc3_ + "null";
            }
            _loc2_++;
         }
         return "{ " + _loc3_ + " }";
      }
      
      private function buildMeshes() : void
      {
         var _loc3_:MOMMesh = null;
         var _loc4_:DisplayObject3D = null;
         var _loc5_:uint = 0;
         var _loc6_:String = null;
         var _loc7_:MaterialObject3D = null;
         var _loc8_:uint = 0;
         var _loc9_:Vertex3D = null;
         var _loc10_:Vertex3D = null;
         var _loc11_:Vertex3D = null;
         var _loc12_:NumberUV = null;
         var _loc13_:NumberUV = null;
         var _loc14_:NumberUV = null;
         this.dtrace("buildMeshes()");
         this._meshes.sortOn("pass",Array.NUMERIC);
         var _loc1_:Array = new Array();
         var _loc2_:uint = 0;
         for(; _loc2_ < this._meshes.length; _loc2_++)
         {
            _loc3_ = this._meshes[_loc2_];
            this._container.removeChildByName("geo_" + _loc3_.index);
            _loc4_ = this._container.addChild(new TriangleMesh3D(null,null,null,"geo_" + _loc3_.index));
            _loc4_.addGeometry(new GeometryObject3D());
            _loc4_.geometry.vertices = new Array();
            _loc5_ = _loc3_.idx_start;
            while(_loc5_ < _loc3_.idx_end)
            {
               _loc4_.geometry.vertices.push(this._vertices[this._indices[_loc5_]].position);
               _loc5_++;
            }
            _loc4_.geometry.faces = new Array();
            if(_loc3_.opacity == 1 && _loc3_.blendmode != 6 && _loc3_.color == 16777215 && !_loc3_.envmap)
            {
               if(_loc3_.geosetid == 0)
               {
                  _loc3_.show = true;
               }
               if(_loc3_.material.search("armorreflect") == -1)
               {
                  if(_loc3_.material != "item/objectcomponents/weapon/stave_2h_ulduarraid_d_03_glow.png")
                  {
                     if(this._filename == "models/creature/etherial/etherial.mom")
                     {
                        if(_loc3_.pass == 1 || _loc3_.pass == 2 || _loc3_.pass == 3)
                        {
                           _loc3_.show = false;
                        }
                     }
                     else if(this._filename == "models/creature/etherialrobe/etherialrobe.mom")
                     {
                        if(_loc3_.pass == 1 || _loc3_.pass == 2)
                        {
                           _loc3_.show = false;
                        }
                     }
                     else if(this._filename == "models/creature/airelemental/airelemental.mom")
                     {
                        if(_loc3_.pass == 8 || _loc3_.pass == 9)
                        {
                           _loc3_.show = false;
                        }
                     }
                     else if(this._filename == "models/creature/fireelemental/fireelemental.mom")
                     {
                        if(_loc3_.pass == 0 || _loc3_.pass == 1)
                        {
                           _loc3_.show = false;
                        }
                     }
                     else if(this._filename == "models/creature/elementalearth/elementalearth.mom")
                     {
                        if(_loc3_.pass == 2 || _loc3_.pass == 3)
                        {
                           _loc3_.show = false;
                        }
                     }
                     else if(this._filename == "models/creature/waterelemental/waterelemental.mom")
                     {
                        if(_loc3_.pass == 0)
                        {
                           _loc3_.show = false;
                        }
                     }
                     else if(this._filename == "models/creature/infernal/infernal.mom" || this._filename == "models/creature/abyssaloutland/abyssal_outland.mom" || this._filename == "models/creature/abyssalillidan/abyssal_illidan.mom")
                     {
                        if(_loc3_.pass == 0)
                        {
                           _loc3_.show = false;
                        }
                     }
                     else if(this._filename == "models/creature/arthaslichking/arthaslichking_unarmed.mom")
                     {
                        if(_loc3_.pass == 2 || _loc3_.pass == 9 || _loc3_.pass == 10)
                        {
                           _loc3_.show = false;
                        }
                     }
                     if(this._filename.search("glave_1h_dualblade_d_02.mom") != -1 || this._filename.search("knife_1h_blacktemple_d_01.mom") != -1)
                     {
                        if(_loc3_.blendmode == 2)
                        {
                           continue;
                        }
                        if(_loc3_.blendmode == 4)
                        {
                           continue;
                        }
                     }
                     if(_loc3_.show)
                     {
                        this.addMaterial(_loc3_.material);
                     }
                     _loc6_ = "mat_" + (this._textures[_loc3_.matid].special > -1?"s" + this._textures[_loc3_.matid].special:_loc3_.matid.toString()) + "_" + _loc3_.blendmode + "_" + int(_loc3_.transparent);
                     _loc7_ = this._materials.getMaterialByName(_loc6_);
                     if(_loc8_ == _loc3_.idx_start)
                     {
                        if(_loc2_ == 0)
                        {
                           this.dtrace("#\tgs\tb o color\t\tmatid:material");
                        }
                        this.dtrace(_loc3_.pass + "\t" + _loc3_.geosetid + "\t" + _loc3_.blendmode + " " + _loc3_.opacity + "\t0x" + Color.dechex(_loc3_.color) + "\t" + _loc3_.matid + ":" + _loc3_.material + "\t" + _loc6_);
                     }
                     _loc8_ = _loc3_.idx_start;
                     while(_loc8_ < _loc3_.idx_end)
                     {
                        _loc9_ = this._vertices[this._indices[_loc8_ + 0]].position;
                        _loc10_ = this._vertices[this._indices[_loc8_ + 1]].position;
                        _loc11_ = this._vertices[this._indices[_loc8_ + 2]].position;
                        _loc12_ = this._vertices[this._indices[_loc8_ + 0]].uv;
                        _loc13_ = this._vertices[this._indices[_loc8_ + 1]].uv;
                        _loc14_ = this._vertices[this._indices[_loc8_ + 2]].uv;
                        if(_loc3_.show)
                        {
                           _loc1_.push(_loc9_,_loc10_,_loc11_);
                        }
                        _loc4_.geometry.faces.push(new Triangle3D(_loc4_,[_loc9_,_loc10_,_loc11_],_loc7_,[_loc12_,_loc13_,_loc14_]));
                        _loc8_ = _loc8_ + 3;
                     }
                     _loc4_.geometry.ready = true;
                     _loc4_.visible = _loc3_.show;
                  }
               }
               continue;
            }
         }
         this.calcBounds(_loc1_);
         this.setMeshes();
      }
      
      private function calcBounds(param1:Array) : void
      {
         var _loc4_:Vertex3D = null;
         var _loc2_:Vertex3D = new Vertex3D();
         var _loc3_:Vertex3D = new Vertex3D();
         for each(_loc4_ in param1)
         {
            _loc2_.x = Math.min(_loc4_.x,_loc2_.x);
            _loc2_.y = Math.min(_loc4_.y,_loc2_.y);
            _loc2_.z = Math.min(_loc4_.z,_loc2_.z);
            _loc3_.x = Math.max(_loc4_.x,_loc3_.x);
            _loc3_.y = Math.max(_loc4_.y,_loc3_.y);
            _loc3_.z = Math.max(_loc4_.z,_loc3_.z);
         }
         this._center = new Vertex3D((_loc2_.x + _loc3_.x) / 2,(_loc2_.y + _loc3_.y) / 2,(_loc2_.z + _loc3_.z) / 2);
         this._boundingbox = new Vertex3D(_loc3_.x - _loc2_.x,_loc3_.y - _loc2_.y,_loc3_.z - _loc2_.z);
      }
      
      private function buildTextures() : void
      {
         var _loc1_:Object = null;
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc6_:Object = null;
         var _loc7_:String = null;
         var _loc9_:Object = null;
         if(this._skincolors.length == 0 && this._facialfeatures.length == 0 && this._hairstyles.length == 0)
         {
            this.dtrace("not a character model (no features)");
            return;
         }
         this.dtrace("buildTextures()");
         if(this._skincolors.length > 0)
         {
            if(this._skincolor >= this._skincolors.length)
            {
               this._skincolor = 0;
            }
            _loc1_ = this._skincolors[this._skincolor];
            if(this._facetype >= _loc1_.face.length)
            {
               this._facetype = 0;
            }
            _loc2_ = _loc1_.face[this._facetype];
         }
         if(this._facialfeatures.length > 0)
         {
            if(this._facialfeature >= this._facialfeatures.length)
            {
               this._facialfeature = 0;
            }
            _loc3_ = this._facialfeatures[this._facialfeature];
            if(this._facialcolor >= _loc3_.color.length)
            {
               this._facialcolor = 0;
            }
            _loc4_ = _loc3_.color[this._facialcolor];
         }
         else
         {
            _loc3_ = null;
            _loc4_ = {
               "lower":null,
               "upper":null
            };
         }
         if(this._hairstyle >= this._hairstyles.length)
         {
            this._hairstyle = 0;
         }
         _loc5_ = this._hairstyles[this._hairstyle];
         if(this._haircolor >= _loc5_.color.length)
         {
            this._haircolor = 0;
         }
         _loc6_ = _loc5_.color[this._haircolor];
         if(_isnpc)
         {
            this._special[1] = this._npcbase;
         }
         if(_loc1_ != null)
         {
            if(_loc1_.base)
            {
               if(this._special[1] != _loc1_.base)
               {
                  this._basedirty = true;
               }
               this._special[1] = !!_isnpc?this._npcbase:_loc1_.base;
            }
            if(_loc1_.fur)
            {
               this._special[8] = _loc1_.fur;
            }
         }
         if(_loc6_ && _loc6_.texture)
         {
            this._special[6] = _loc6_.texture;
         }
         for each(_loc7_ in this._special)
         {
            this.addMaterial(_loc7_);
         }
         if(!_isnpc)
         {
            if(_loc1_.lower)
            {
               this.updateBaked(MOMTextureRegion.PELVIS_UPPER,2,_loc1_.lower);
            }
            if(_loc1_.upper)
            {
               this.updateBaked(MOMTextureRegion.TORSO_UPPER,2,_loc1_.upper);
            }
            if(_loc2_.lower)
            {
               this.updateBaked(MOMTextureRegion.FACE_LOWER,1,_loc2_.lower);
            }
            if(_loc2_.upper)
            {
               this.updateBaked(MOMTextureRegion.FACE_UPPER,1,_loc2_.upper);
            }
            if(_loc4_.lower)
            {
               this.updateBaked(MOMTextureRegion.FACE_LOWER,2,_loc4_.lower);
            }
            if(_loc4_.upper)
            {
               this.updateBaked(MOMTextureRegion.FACE_UPPER,2,_loc4_.upper);
            }
            if(_loc6_.lower)
            {
               this.updateBaked(MOMTextureRegion.FACE_LOWER,3,_loc6_.lower);
            }
            if(_loc6_.upper)
            {
               this.updateBaked(MOMTextureRegion.FACE_UPPER,3,_loc6_.upper);
            }
            for each(_loc9_ in this._baked)
            {
               this.addMaterial(_loc9_.name);
            }
         }
         this._chargeosets = new Array(20);
         var _loc8_:int = 0;
         while(_loc8_ < 20)
         {
            this._chargeosets[_loc8_] = 1;
            _loc8_++;
         }
         this._chargeosets[7] = 2;
         if(_loc3_)
         {
            this._chargeosets[1] = _loc3_.geoset1;
            this._chargeosets[2] = _loc3_.geoset2;
            this._chargeosets[3] = _loc3_.geoset3;
         }
      }
      
      private function updateCharacter(param1:Boolean = false) : void
      {
         if(this.loaded)
         {
            this.buildTextures();
            this.setMeshes();
            if(this.materialsToLoad == 0)
            {
               this.paintArmor();
            }
         }
         dispatchEvent(new Event(MOMEvent.CHANGED,true));
      }
      
      private function processBitmap(param1:BitmapData, param2:int = 1, param3:Number = 1, param4:uint = 16777215) : void
      {
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Color = null;
         var _loc5_:Color = new Color(param4);
         var _loc6_:BitmapData = param1;
         if(param2 == 0)
         {
            _loc6_.colorTransform(_loc6_.rect,new ColorTransform(1,1,1,1,1,1,1,255));
         }
         else
         {
            _loc7_ = 0;
            while(_loc7_ < _loc6_.width)
            {
               _loc8_ = 0;
               while(_loc8_ < _loc6_.height)
               {
                  _loc9_ = new Color(_loc6_.getPixel32(_loc7_,_loc8_));
                  if(param2 == 4 && _loc9_.alpha == 255)
                  {
                     _loc9_.alpha = Math.max(_loc9_.red,_loc9_.blue,_loc9_.green);
                  }
                  else if(BLENDS[param2] && _loc9_.alpha == 10)
                  {
                     _loc9_.alpha = 0;
                  }
                  else if(_loc9_.alpha != 255)
                  {
                     if(!BLENDS[param2])
                     {
                        _loc9_.alpha = 255;
                     }
                  }
                  if(param4 != 16777215)
                  {
                     _loc9_.red = _loc9_.red * (_loc5_.red / 255);
                     _loc9_.green = _loc9_.green * (_loc5_.green / 255);
                     _loc9_.blue = _loc9_.blue * (_loc5_.blue / 255);
                  }
                  _loc6_.setPixel32(_loc7_,_loc8_,_loc9_.argb);
                  _loc8_++;
               }
               _loc7_++;
            }
         }
      }
      
      private function onAttachmentLoadError(param1:FileLoadEvent) : void
      {
         this.dtrace("--","attachmentLoadError (" + _waitingAttachments.length + "): " + param1.target);
         var _loc2_:int = this.parseIdFromDisplayName(param1.target.name);
         _loadedAttachments[UNIQUESLOTS[_loc2_]] = null;
         if(_waitingAttachments.length > 0)
         {
            this.loadNextModel();
         }
         else
         {
            _loadingIdle = true;
         }
      }
      
      private function parseMOM(param1:FileLoadEvent) : void
      {
         var i:int = 0;
         var j:int = 0;
         var len:int = 0;
         var char:int = 0;
         var x:Number = NaN;
         var y:Number = NaN;
         var z:Number = NaN;
         var skin_num_facetypes:int = 0;
         var facial_num_colors:int = 0;
         var hair_num_colors:int = 0;
         var stex:Object = null;
         var mat:Object = null;
         var btex:Object = null;
         var skin:Object = null;
         var skint:Object = null;
         var facial:Object = null;
         var facialt:Object = null;
         var style:Object = null;
         var stylet:Object = null;
         var mesh:MOMMesh = null;
         var bad:Boolean = false;
         var hasOpaque:Boolean = false;
         var m:MOMMesh = null;
         var name:String = null;
         var color:Color = null;
         var material:BitmapMaterial = null;
         var tmatrix:Array = null;
         var r1:Array = null;
         var r2:Array = null;
         var r3:Array = null;
         var r4:Array = null;
         var c1:Array = null;
         var c2:Array = null;
         var c3:Array = null;
         var c4:Array = null;
         var slotbone:Object = null;
         var e:FileLoadEvent = param1;
         this.dtrace("--","parseMOM()");
         var data:ByteArray = e.target.data;
         data.endian = Endian.LITTLE_ENDIAN;
         try
         {
            this.readHeader(data);
            this.opacity = data.readFloat();
            this._gender = int(data.readByte());
            this._race = int(data.readByte());
            data.position = this.head.offset_vertices;
            this._vertices = new Vector.<MOMVertex>(this.head.num_vertices,true);
            i = 0;
            while(i < this.head.num_vertices)
            {
               this._vertices[i] = new MOMVertex();
               x = data.readFloat() * this._scaling;
               y = data.readFloat() * this._scaling;
               z = data.readFloat() * this._scaling;
               this._vertices[i].position = new Vertex3D(x,z,y);
               data.readFloat();
               data.readFloat();
               data.readFloat();
               this._vertices[i].uv = new NumberUV(data.readFloat(),data.readFloat());
               i++;
            }
            data.position = this.head.offset_indices;
            this._indices = new Vector.<int>(this.head.num_indices,true);
            i = 0;
            while(i < this.head.num_indices)
            {
               this._indices[i] = int(data.readShort());
               i++;
            }
            data.position = this.head.offset_texgroups;
            this._special = new Array(32);
            i = 0;
            while(i < this.head.num_texgroups)
            {
               stex = {
                  "id":data.readByte(),
                  "name":data.readUTF().toLowerCase()
               };
               this._special[stex.id] = stex.name;
               i++;
            }
            this.dtrace(">> type:",this._type);
            data.position = this.head.offset_mats;
            this._textures = new Array();
            i = 0;
            while(i < this.head.num_mats)
            {
               mat = {
                  "name":data.readUTF().toLowerCase(),
                  "special":data.readInt()
               };
               if(mat.name == "" && this._mumtextures[i] != undefined)
               {
                  mat.name = this._mumtextures[i];
               }
               if(mat.special != -1 && this._special[mat.special] == undefined && this._type != MOMModelType.CHAR)
               {
                  mat.special = -1;
               }
               this._textures.push(mat);
               i++;
            }
            this._textures.forEach(this.trace_array);
            data.position = this.head.offset_bakedtexs;
            this._baked = new Array();
            i = 0;
            while(i < this.head.num_bakedtexs)
            {
               btex = {
                  "region":data.readByte(),
                  "layer":data.readByte(),
                  "name":data.readUTF().toLowerCase()
               };
               this._baked.push(btex);
               this.addMaterial(btex.name);
               i++;
            }
            data.position = this.head.offset_skincolors;
            skin_num_facetypes = data.readInt();
            this._skincolors = new Array();
            i = 0;
            while(i < this.head.num_skincolors)
            {
               skin = new Object();
               skin.base = data.readUTF().toLowerCase();
               skin.fur = data.readUTF().toLowerCase();
               skin.lower = data.readUTF().toLowerCase();
               skin.upper = data.readUTF().toLowerCase();
               skin.face = new Array(skin_num_facetypes);
               j = 0;
               while(j < skin_num_facetypes)
               {
                  skint = new Object();
                  skint.lower = data.readUTF().toLowerCase();
                  skint.upper = data.readUTF().toLowerCase();
                  skin.face[j] = skint;
                  j++;
               }
               this._skincolors.push(skin);
               i++;
            }
            data.position = this.head.offset_facialfeatures;
            facial_num_colors = data.readInt();
            this._facialfeatures = new Array();
            i = 0;
            while(i < this.head.num_facialfeatures)
            {
               facial = new Object();
               facial.geoset1 = data.readInt();
               facial.geoset2 = data.readInt();
               facial.geoset3 = data.readInt();
               facial.color = new Array(facial_num_colors);
               j = 0;
               while(j < facial_num_colors)
               {
                  facialt = new Object();
                  facialt.lower = data.readUTF().toLowerCase();
                  facialt.upper = data.readUTF().toLowerCase();
                  facial.color[j] = facialt;
                  j++;
               }
               this._facialfeatures.push(facial);
               i++;
            }
            data.position = this.head.offset_hairstyles;
            hair_num_colors = data.readInt();
            this._hairstyles = new Array();
            i = 0;
            while(i < this.head.num_hairstyles)
            {
               style = new Object();
               style.geoset = data.readInt();
               style.index = data.readInt();
               style.color = new Array(hair_num_colors);
               j = 0;
               while(j < hair_num_colors)
               {
                  stylet = new Object();
                  stylet.texture = data.readUTF().toLowerCase();
                  stylet.lower = data.readUTF().toLowerCase();
                  stylet.upper = data.readUTF().toLowerCase();
                  style.color[j] = stylet;
                  j++;
               }
               this._hairstyles[style.index] = style;
               i++;
            }
            this.buildTextures();
            data.position = this.head.offset_meshes;
            this._meshes = new Array();
            i = 0;
            while(i < this.head.num_meshes)
            {
               mesh = new MOMMesh();
               mesh.index = i;
               mesh.show = data.readBoolean();
               if(this._type != MOMModelType.CHAR)
               {
                  mesh.show = true;
               }
               mesh.pass = data.readInt();
               mesh.geosetid = data.readShort();
               mesh.matid = data.readShort();
               if(this._textures[mesh.matid].special > -1 && this._special[this._textures[mesh.matid].special] != null)
               {
                  mesh.material = this._special[this._textures[mesh.matid].special];
               }
               else
               {
                  mesh.material = this._textures[mesh.matid].name;
               }
               mesh.idx_start = data.readShort();
               mesh.idx_end = mesh.idx_start + data.readShort();
               mesh.transparent = Boolean(data.readByte());
               mesh.blendmode = data.readShort();
               mesh.swrap = Boolean(data.readByte());
               mesh.twrap = Boolean(data.readByte());
               mesh.nozwrite = Boolean(data.readByte());
               mesh.envmap = Boolean(data.readByte());
               mesh.unlit = Boolean(data.readByte());
               mesh.billboard = Boolean(data.readByte());
               mesh.color = uint((data.readFloat() * 255 & 255) << 16 | (data.readFloat() * 255 & 255) << 8 | data.readFloat() * 255 & 255);
               mesh.opacity = data.readFloat();
               mesh.texanim = 0;
               bad = false;
               hasOpaque = false;
               for each(m in this._meshes)
               {
                  if(m.idx_start == mesh.idx_start && m.idx_end == mesh.idx_end && mesh.blendmode > 0)
                  {
                     bad = true;
                  }
                  if(m.blendmode == 0)
                  {
                     hasOpaque = true;
                  }
               }
               if(!(bad && hasOpaque))
               {
                  name = this._textures[mesh.matid].special > -1?"s" + this._textures[mesh.matid].special:mesh.matid.toString();
                  name = name + ("_" + mesh.blendmode + "_" + int(mesh.transparent));
                  if(!this._materials.getMaterialByName("mat_" + name))
                  {
                     color = new Color(Color.random());
                     color.alpha = 255 * 0.6;
                     material = new BitmapMaterial(new BitmapData(1,1,true,color.argb));
                     material.doubleSided = mesh.billboard;
                     material.smooth = true;
                     this._materials.addMaterial(material,"mat_" + name);
                  }
                  if(i == 0)
                  {
                     this.dtrace("i b t e u b o color\tis\tie\tp\tg\tid:file");
                  }
                  this.dtrace(i.toString().substr(-1),mesh.blendmode,int(mesh.transparent),int(mesh.envmap),int(mesh.unlit),int(mesh.billboard),int(mesh.opacity),Color.dechex(mesh.color) + "\t" + mesh.idx_start + "\t" + mesh.idx_end + "\t" + mesh.pass + "\t" + mesh.geosetid + "\t" + mesh.matid + ":" + mesh.material + "\tmat_" + name);
                  this._meshes.push(mesh);
               }
               i++;
            }
            data.position = this.head.offset_bones;
            this._bones = new Vector.<MOMBone>(this.head.num_bones,true);
            i = 0;
            while(i < this.head.num_bones)
            {
               this._bones[i] = new MOMBone();
               this._bones[i].parent = data.readInt();
               x = data.readFloat() * this._scaling;
               y = data.readFloat() * this._scaling;
               z = data.readFloat() * this._scaling;
               this._bones[i].pivot = new Number3D(x,z,y);
               x = data.readFloat() * this._scaling;
               y = data.readFloat() * this._scaling;
               z = data.readFloat() * this._scaling;
               this._bones[i].transpivot = new Number3D(x,z,y);
               tmatrix = new Array(16);
               j = 0;
               while(j < 16)
               {
                  tmatrix[j] = data.readFloat();
                  j++;
               }
               r1 = [tmatrix[0],tmatrix[1],tmatrix[2],tmatrix[3]];
               r2 = [tmatrix[4],tmatrix[5],tmatrix[6],tmatrix[7]];
               r3 = [tmatrix[8],tmatrix[9],tmatrix[10],tmatrix[11]];
               r4 = [tmatrix[12],tmatrix[13],tmatrix[14],tmatrix[15]];
               tmatrix = r1.concat(r3,r2,r4);
               c1 = [tmatrix[0],tmatrix[4],tmatrix[8],tmatrix[12]];
               c2 = [tmatrix[1],tmatrix[5],tmatrix[9],tmatrix[13]];
               c3 = [tmatrix[2],tmatrix[6],tmatrix[10],tmatrix[14]];
               c4 = [tmatrix[3],tmatrix[7],tmatrix[11],tmatrix[15]];
               tmatrix = c1.concat(c3,c2,c4);
               this._bones[i].matrix = new Matrix3D(tmatrix);
               i++;
            }
            data.position = this.head.offset_slotbones;
            this._slotbones = new Array();
            i = 0;
            while(i < this.head.num_slotbones)
            {
               slotbone = new Object();
               slotbone.slot = data.readShort();
               slotbone.bone = data.readShort();
               x = data.readFloat() * this._scaling;
               y = data.readFloat() * this._scaling;
               z = data.readFloat() * this._scaling;
               slotbone.offset = new Number3D(x,z,y);
               this._slotbones.push(slotbone);
               i++;
            }
            this.loaded = true;
            this.buildMeshes();
            dispatchEvent(new FileLoadEvent(MOMEvent.GEOMETRY_LOADED));
            return;
         }
         catch(ex:Error)
         {
            dispatchEvent(new Event(MOMEvent.INTERNAL_ERROR));
            trace(ex.message);
            trace(ex.getStackTrace());
            return;
         }
      }
      
      private function paintArmor() : void
      {
         var _loc1_:int = 0;
         var _loc4_:BitmapData = null;
         var _loc5_:Array = null;
         var _loc6_:Point = null;
         var _loc7_:Matrix = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:MaterialObject3D = null;
         var _loc11_:BitmapMaterial = null;
         var _loc12_:MaterialObject3D = null;
         var _loc13_:BitmapMaterial = null;
         var _loc14_:MaterialObject3D = null;
         var _loc15_:BitmapMaterial = null;
         this.dtrace("paintArmor()");
         if(_isnpc || this._isattach)
         {
            return;
         }
         var _loc2_:Array = new Array();
         _loc1_ = 0;
         for(; _loc1_ < this._baked.length; _loc1_++)
         {
            if(this._baked[_loc1_].layer == 2)
            {
               if(this._baked[_loc1_].region == MOMTextureRegion.TORSO_UPPER && (this._attachments[4] != null || this._attachments[5] != null) || this._baked[_loc1_].region == MOMTextureRegion.PELVIS_UPPER && (this._attachments[7] != null || this._attachments[20] != null))
               {
                  continue;
               }
            }
            if(this._chargeosets[13] == 2)
            {
               if(this._baked[_loc1_].slot == MOMItemSlot.PANTS)
               {
                  this._baked[_loc1_].layer = 6;
               }
               else if(this._baked[_loc1_].slot == MOMItemSlot.BOOTS)
               {
                  this._baked[_loc1_].layer = 5;
               }
            }
            _loc2_.push(this._baked[_loc1_]);
         }
         if(!this._basespecial || this._basedirty)
         {
            this._basespecial = this._materials.getMaterialByName(this._special[1]).bitmap.clone();
            this._basedirty = false;
         }
         var _loc3_:BitmapData = this._basespecial.clone();
         _loc2_.sortOn("layer",Array.NUMERIC);
         _loc1_ = 0;
         while(_loc1_ < _loc2_.length)
         {
            _loc4_ = this._materials.getMaterialByName(_loc2_[_loc1_].name).bitmap;
            if(_loc4_)
            {
               _loc5_ = REGIONS[_loc2_[_loc1_].region];
               _loc6_ = new Point(_loc3_.width * _loc5_[0],_loc3_.height * _loc5_[1]);
               _loc7_ = new Matrix();
               _loc8_ = _loc3_.width / (_loc4_.width / _loc5_[2]);
               _loc9_ = _loc3_.height / (_loc4_.height / _loc5_[3]);
               _loc7_.scale(_loc8_,_loc9_);
               _loc7_.translate(_loc6_.x,_loc6_.y);
               _loc3_.draw(_loc4_,_loc7_);
            }
            _loc1_++;
         }
         (this._materials.getMaterialByName("mat_s1_0_0") as BitmapMaterial).texture = _loc3_;
         if(this._special[2] != null || this._special[6] != null || this._special[8] != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this._meshes.length)
            {
               if(this._special[2] != null && this._textures[this._meshes[_loc1_].matid].special == 2)
               {
                  _loc10_ = this._materials.getMaterialByName(this._special[2]);
                  if(_loc10_)
                  {
                     _loc11_ = this._materials.getMaterialByName("mat_s2_0_0") as BitmapMaterial;
                     _loc11_.texture = _loc10_.bitmap as BitmapData;
                     _loc11_.doubleSided = true;
                  }
               }
               if(this._special[6] != null && this._textures[this._meshes[_loc1_].matid].special == 6)
               {
                  _loc12_ = this._materials.getMaterialByName(this._special[6]);
                  if(_loc12_)
                  {
                     _loc13_ = this._materials.getMaterialByName("mat_s6_1_0") as BitmapMaterial;
                     _loc13_.texture = _loc12_.bitmap as BitmapData;
                  }
               }
               if(this._special[8] != null && this._textures[this._meshes[_loc1_].matid].special == 8)
               {
                  _loc14_ = this._materials.getMaterialByName(this._special[8]);
                  if(_loc14_)
                  {
                     _loc15_ = this._materials.getMaterialByName("mat_s8_1_0") as BitmapMaterial;
                     _loc15_.texture = _loc14_.bitmap as BitmapData;
                     _loc15_.doubleSided = true;
                  }
               }
               _loc1_++;
            }
         }
         dispatchEvent(new Event(MOMEvent.CHANGED,true));
      }
      
      public function set haircolor(param1:int) : void
      {
         if(this._haircolor != param1 && param1 != -1)
         {
            this._haircolor = param1;
            this.updateCharacter(true);
         }
      }
      
      private function onMomChange(param1:Event) : void
      {
         this.dtrace("--","momChange");
         dispatchEvent(new Event(MOMEvent.CHANGED,true));
      }
      
      private function onMaterialLoadComplete(param1:FileLoadEvent) : void
      {
         var _loc4_:MOMMesh = null;
         var _loc5_:* = null;
         var _loc6_:String = null;
         var _loc7_:BitmapMaterial = null;
         this.dtrace("--","momMaterialLoadComplete (" + (this.materialsToLoad - 1) + "): " + param1.file);
         var _loc2_:BitmapFileMaterial = param1.target as BitmapFileMaterial;
         var _loc3_:Boolean = false;
         for each(_loc4_ in this._meshes)
         {
            if(_loc4_.material == _loc2_.name && _loc4_.show)
            {
               if(_loc4_.blendmode == 0)
               {
                  break;
               }
            }
         }
         for(_loc5_ in this._meshes)
         {
            _loc4_ = this._meshes[_loc5_];
            if(_loc4_.material == _loc2_.name && _loc4_.show)
            {
               _loc6_ = "mat_" + (this._textures[_loc4_.matid].special != -1?"s" + this._textures[_loc4_.matid].special:_loc4_.matid) + "_" + _loc4_.blendmode + "_" + int(_loc4_.transparent);
               if(_loc4_.blendmode != 0 && _loc3_)
               {
                  this._meshes[_loc5_].show = false;
                  this._container.getChildByName("geo_" + _loc4_.index).visible = false;
               }
               else if(this._loadedMaterials[_loc6_] == undefined)
               {
                  this.dtrace(">>" + (!!_loc4_.envmap?">":""),_loc6_,_loc4_.index,_loc4_.opacity,int(_loc4_.envmap),int(_loc4_.unlit),int(_loc4_.billboard),Color.dechex(_loc4_.color));
                  _loc7_ = this._materials.getMaterialByName(_loc6_) as BitmapMaterial;
                  _loc7_.texture = _loc2_.bitmap.clone();
                  this.processBitmap(_loc7_.bitmap,_loc4_.blendmode,_loc4_.opacity,_loc4_.color);
                  this._loadedMaterials[_loc6_] = true;
               }
            }
         }
         this.materialsToLoad--;
         if(this.materialsToLoad == 0)
         {
            this._loadedMaterials = [];
            dispatchEvent(new Event(MOMEvent.MATERIALS_LOADED));
         }
      }
      
      private function slotType(param1:int) : int
      {
         var _loc2_:int = UNIQUESLOTS[param1];
         if(param1 < 1 || param1 >= UNIQUESLOTS.length)
         {
            return -1;
         }
         if(_loc2_ == MOMItemSlot.HEAD || _loc2_ == MOMItemSlot.SHOULDER || _loc2_ == MOMItemSlot.RIGHTHAND || _loc2_ == MOMItemSlot.LEFTHAND)
         {
            return MOMModelType.ITEM;
         }
         return MOMModelType.ARMOR;
      }
      
      private function showBitmap(param1:BitmapData, param2:String = "") : void
      {
         if(showBitmapPos.x + param1.width > 600)
         {
            showBitmapPos.x = 0;
            showBitmapPos.y = showBitmapPos.y - showBitmapPos.z;
            showBitmapPos.z = 0;
         }
         var _loc3_:MovieClip = new MovieClip();
         var _loc4_:TextField = new TextField();
         _loc4_.wordWrap = true;
         _loc4_.width = param1.width;
         _loc4_.height = param1.height;
         _loc4_.multiline = true;
         _loc4_.text = param2;
         _loc4_.autoSize = "center";
         _loc3_.graphics.beginBitmapFill(param1);
         _loc3_.graphics.drawRect(0,0,param1.width,param1.height);
         _loc3_.graphics.endFill();
         _loc3_.addChild(_loc4_);
         var _loc5_:MovieMaterial = new MovieMaterial(_loc3_,true,false,true);
         _loc5_.doubleSided = true;
         _loc5_.smooth = true;
         var _loc6_:Plane = new Plane(_loc5_);
         this._container.removeChildByName("showBitmap" + counter);
         this._container.addChild(_loc6_,"showBitmap" + counter);
         _loc6_.rotationY = -90;
         _loc6_.x = 500;
         _loc6_.y = showBitmapPos.y + 100;
         _loc6_.z = showBitmapPos.x - 220;
         showBitmapPos.x = showBitmapPos.x + (param1.width + 1);
         showBitmapPos.z = Math.max(param1.height + 1,showBitmapPos.z);
         counter++;
      }
      
      private function onError(param1:Event) : void
      {
         dispatchEvent(new Event(MOMEvent.ERROR,true));
      }
      
      public function clearSlotsAll() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 27)
         {
            this.clearSlot(_loc1_,false);
            _loc1_++;
         }
         this.updateCharacter();
      }
      
      public function get facialcolor() : int
      {
         return this._facialcolor;
      }
      
      private function parseOMA(param1:FileLoadEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:Array = null;
         this.dtrace("--","parseOMA()");
         var _loc2_:Array = param1.target.data.split("\r\n");
         _loc3_ = _loc2_.shift();
         _loc4_ = _loc3_.split(" ");
         this._showhair = parseInt(_loc4_[0]) == 0?true:false;
         this._showfacefeatures = parseInt(_loc4_[1]) == 0?true:false;
         this.setMeshes();
      }
      
      private function onLoadError(param1:FileLoadEvent) : void
      {
         this.dtrace("--","loadError: " + param1.message);
         var _loc2_:FileLoadEvent = new FileLoadEvent(FileLoadEvent.LOAD_ERROR,param1.file,-1,-1,param1.message);
         dispatchEvent(_loc2_);
      }
      
      private function onMomMaterialsDone(param1:Event) : void
      {
         this.dtrace("--","momMaterialsLoaded");
         if(this._baked.length > 0)
         {
            this.paintArmor();
         }
         if(this.geometryLoaded == true && !this.done)
         {
            dispatchEvent(new Event(MOMEvent.MOM_LOADED));
         }
         dispatchEvent(new Event(MOMEvent.CHANGED,true));
         if(_waitingArmor.length > 0)
         {
            if(this._isattach)
            {
               _loadingIdle = true;
            }
            else
            {
               this.loadNextArmor();
            }
         }
      }
      
      public function get boundingbox() : Vertex3D
      {
         return this._boundingbox;
      }
      
      public function get gender() : int
      {
         return this._gender;
      }
      
      private function readHeader(param1:ByteArray) : void
      {
         this.head = new Object();
         param1.position = 0;
         this.head.version = param1.readInt();
         this.head.end = param1.readInt();
         this.head.num_vertices = param1.readShort();
         this.head.offset_vertices = param1.readInt();
         this.head.num_indices = param1.readUnsignedShort();
         this.head.offset_indices = param1.readInt();
         this.head.num_mats = param1.readShort();
         this.head.offset_mats = param1.readInt();
         this.head.num_meshes = param1.readShort();
         this.head.offset_meshes = param1.readInt();
         this.head.num_texgroups = param1.readShort();
         this.head.offset_texgroups = param1.readInt();
         this.head.num_bakedtexs = param1.readShort();
         this.head.offset_bakedtexs = param1.readInt();
         this.head.num_bones = param1.readShort();
         this.head.offset_bones = param1.readInt();
         this.head.num_slotbones = param1.readShort();
         this.head.offset_slotbones = param1.readInt();
         this.head.num_skincolors = param1.readShort();
         this.head.offset_skincolors = param1.readInt();
         this.head.num_facialfeatures = param1.readShort();
         this.head.offset_facialfeatures = param1.readInt();
         this.head.num_hairstyles = param1.readShort();
         this.head.offset_hairstyles = param1.readInt();
         param1.position = this.head.end;
         this.dtrace("Header: " + " {version:" + this.head.version + " size:" + param1.length + "type:" + this._type + " vertices:" + this.head.num_vertices + "@" + this.head.offset_vertices + " indices:" + this.head.num_indices + "@" + this.head.offset_indices + " materials:" + this.head.num_mats + "@" + this.head.offset_mats + " meshes:" + this.head.num_meshes + "@" + this.head.offset_meshes + " replacement_textures:" + this.head.num_texgroups + "@" + this.head.offset_texgroups + " baked_textures:" + this.head.num_bakedtexs + "@" + this.head.offset_bakedtexs + " bones:" + this.head.num_bones + "@" + this.head.offset_bones + " attach_maps:" + this.head.num_slotbones + "@" + this.head.offset_slotbones + " skins:" + this.head.num_skincolors + "@" + this.head.offset_skincolors + " facial_features:" + this.head.num_facialfeatures + "@" + this.head.offset_facialfeatures + " hair_styles:" + this.head.num_hairstyles + "@" + this.head.offset_hairstyles + "}");
      }
      
      public function get haircolor() : int
      {
         return this._haircolor;
      }
      
      private function onFileLoadProgress(param1:FileLoadEvent) : void
      {
         var _loc2_:FileLoadEvent = new FileLoadEvent(FileLoadEvent.LOAD_PROGRESS,param1.file,param1.bytesLoaded,param1.bytesTotal);
         dispatchEvent(_loc2_);
      }
      
      public function get race() : int
      {
         return this._race;
      }
      
      private function loadNextModel() : void
      {
         var attachment:DisplayObject3D = null;
         if(_waitingAttachments.length == 0)
         {
            return;
         }
         var a:Object = _waitingAttachments.shift();
         this.dtrace("--","loadNextModel (" + _waitingAttachments.length + "): " + a.id + "@" + a.slot);
         if(_loadedAttachments[a.id])
         {
            this.dtrace("--","loading cached model");
            if(_loadedAttachments[a.id].done)
            {
               attachment = _loadedAttachments[a.id];
               this._container.removeChildByName(attachment.name);
               this._container.addChild(attachment);
               this._attachments[UNIQUESLOTS[a.slot]] = {
                  "name":"slot_" + UNIQUESLOTS[a.slot],
                  "slot":a.slot,
                  "id":a.id,
                  "geo":null
               };
            }
            else
            {
               this.dtrace("--- model current in queue (skipped)");
            }
            return;
         }
         try
         {
            this.addModel(a.slot,a.id);
            return;
         }
         catch(ex:Error)
         {
            dtrace("!! Unable to load model: " + ex.message);
            trace(ex.getStackTrace());
            return;
         }
      }
      
      private function loadNextArmor() : void
      {
         if(_waitingArmor.length == 0)
         {
            return;
         }
         var a:Object = _waitingArmor.shift();
         this.dtrace("--","loadNextArmor (" + (_waitingAttachments.length + 1) + "): " + a.id + "@" + a.slot);
         try
         {
            this.loader(2,"models/armor/" + a.slot + "/" + a.id);
            return;
         }
         catch(ex:Error)
         {
            dtrace("!!","Unable to load armor: " + ex.message);
            trace(ex.getStackTrace());
            return;
         }
      }
      
      private function onAttachmentLoadComplete(param1:Event) : void
      {
         this.dtrace("--","attachmentLoaded (" + _waitingAttachments.length + "): " + param1.target);
         var _loc2_:int = this.parseIdFromDisplayName(param1.target.name);
         _loadedAttachments[UNIQUESLOTS[_loc2_]] = param1.target;
         dispatchEvent(new Event(MOMEvent.CHANGED,true));
         if(_waitingAttachments.length > 0)
         {
            this.loadNextModel();
         }
         else
         {
            _loadingIdle = true;
         }
      }
      
      public function toggleGeoset(param1:int) : void
      {
         var _loc3_:DisplayObject3D = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._meshes.length)
         {
            if(this._meshes[_loc2_].geosetid == param1)
            {
               _loc3_ = this._container.getChildByName("geo_" + this._meshes[_loc2_].index);
               _loc3_.visible = !_loc3_.visible;
               break;
            }
            _loc2_++;
         }
      }
      
      public function clearSlot(param1:int = -1, param2:Boolean = true) : void
      {
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         this.dtrace("clearSlot(",param1,param2,")");
         var _loc3_:int = UNIQUESLOTS[param1];
         if(param1 == -1 || this._type != MOMModelType.CHAR && this._type != MOMModelType.NPC || this._attachments[_loc3_] == null)
         {
            this.dtrace("..nop?",_loc3_,this._type,this._attachments[_loc3_]);
            return;
         }
         if(param1 == MOMItemSlot.HEAD || param1 == MOMItemSlot.SHOULDER || _loc3_ == MOMItemSlot.LEFTHAND || _loc3_ == MOMItemSlot.RIGHTHAND)
         {
            _loc4_ = this._attachments[_loc3_].name;
            _loc5_ = [_loc4_];
            param2 = false;
            if(param1 == MOMItemSlot.HEAD)
            {
               this._showhair = true;
               this._showfacefeatures = true;
               this.setMeshes();
            }
            else if(param1 == MOMItemSlot.SHOULDER)
            {
               _loc5_ = [_loc4_ + "_1",_loc4_ + "_2"];
            }
            for each(_loc6_ in _loc5_)
            {
               this._container.removeChildByName(_loc6_);
            }
         }
         else
         {
            this._baked.sortOn("layer");
            _loc7_ = 0;
            while(_loc7_ < this._baked.length)
            {
               if(UNIQUESLOTS[this._baked[_loc7_].slot] == _loc3_)
               {
                  this.dtrace("Removing:",this._baked[_loc7_].name);
                  this._baked.splice(_loc7_,1);
                  _loc7_--;
               }
               _loc7_++;
            }
            if(param1 == MOMItemSlot.ROBE)
            {
               this._attachments[param1] = null;
            }
         }
         if(this._attachments[_loc3_].slot == 20)
         {
            this._attachments[20] = null;
         }
         this._attachments[_loc3_] = null;
         if(param2)
         {
            this.updateCharacter();
         }
      }
      
      public function load(param1:int = 1, param2:* = null, param3:Number = NaN) : void
      {
         var pType:int = param1;
         var pFilename:* = param2;
         var pScale:Number = param3;
         var prefix:String = "models/";
         var filename:String = String(pFilename);
         var type:int = pType;
         var loadtype:int = 1;
         if(filename == "null")
         {
            filename = "";
         }
         if(filename == "" && this._race > -1 && this._gender > -1)
         {
            type = MOMModelType.CHAR;
            filename = RACES[this._race] + GENDERS[this._gender];
         }
         else if(filename == "")
         {
            trace("!!","Item/NPC ID is required.");
            return;
         }
         if(type >= MOMModelType.ATTACH)
         {
            this._isattach = true;
            type = type - MOMModelType.ATTACH;
         }
         switch(type)
         {
            case MOMModelType.ITEM:
               prefix = prefix + "item/";
               loadtype = 5;
               break;
            case MOMModelType.HELM:
               prefix = prefix + "armor/1/";
               if(!this._isattach)
               {
                  filename = filename + "_1_0";
               }
               loadtype = 5;
               break;
            case MOMModelType.SHOULDER:
               prefix = prefix + "armor/3/";
               if(!this._isattach)
               {
                  filename = filename + "_2";
               }
               loadtype = 5;
               break;
            case MOMModelType.NPC:
               prefix = prefix + "npc/";
               _isnpc = true;
               loadtype = 5;
               break;
            case MOMModelType.OBJECT:
               prefix = prefix + "obj/";
               loadtype = 5;
               break;
            case MOMModelType.HUMAN:
               prefix = prefix + "npc/";
               _isnpc = true;
               loadtype = 3;
               break;
            case MOMModelType.CHAR:
               prefix = prefix + "char/";
               loadtype = 1;
               break;
            default:
               type = MOMModelType.ITEM;
               prefix = prefix + "item/";
               loadtype = 5;
         }
         this._type = type;
         this._scaling = Number(pScale) || Number(DEFAULT_SCALING);
         this._scaling = this._scaling * INTERNAL_SCALING;
         if(this._filename)
         {
            trace("!!","Base model already loaded.");
            return;
         }
         this.loaded = false;
         try
         {
            this.loader(loadtype,prefix + filename);
            return;
         }
         catch(ex:Error)
         {
            dtrace("!!","There was an error loading the file: " + ex.message);
            trace(ex.getStackTrace());
            return;
         }
      }
      
      private function trace_array(param1:*, param2:int, param3:Array) : void
      {
         this.dtrace("[ " + param2 + " ] " + (param1 != null?this.object_to_string(param1):"null"));
      }
      
      public function clearSlots(param1:Array) : void
      {
         var _loc2_:int = 0;
         for each(_loc2_ in param1)
         {
            if(_loc2_ > 0 && _loc2_ < 27)
            {
               this.clearSlot(_loc2_,false);
            }
         }
         this.updateCharacter();
      }
      
      public function attachItem(param1:int, param2:int) : void
      {
         var _loc3_:DisplayObject3D = null;
         var _loc4_:int = 0;
         if(this._type != MOMModelType.CHAR && this._type != MOMModelType.NPC || this.slotType(param1) != MOMModelType.ITEM)
         {
            return;
         }
         if(_loadedAttachments[param2])
         {
            this.dtrace("--","loading cached model",param1,param2);
            _loc3_ = _loadedAttachments[param2];
            _loc4_ = UNIQUESLOTS[param1];
            this._container.removeChildByName(_loc3_.name);
            this._container.addChild(_loc3_);
            if(_loc4_ == MOMItemSlot.RIGHTHAND && this._attachments[_loc4_])
            {
               _loc4_ = MOMItemSlot.LEFTHAND;
            }
            this._attachments[_loc4_] = {
               "name":"slot_" + _loc4_,
               "slot":param1,
               "id":param2,
               "geo":null
            };
         }
         else
         {
            this.dtrace("--","queued model (" + (_waitingAttachments.length + 1) + "): " + param2 + "@" + param1 + ")");
            _waitingAttachments.push({
               "slot":param1,
               "id":param2
            });
         }
         if(_loadingIdle)
         {
            this.loadNextModel();
         }
      }
      
      private function trace_r(... rest) : void
      {
         var _loc3_:Object = null;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc6_:* = undefined;
         var _loc2_:int = 0;
         while(_loc2_ < rest.length)
         {
            _loc3_ = rest[_loc2_];
            _loc4_ = 0;
            _loc5_ = "";
            if(_loc2_ != 0)
            {
               _loc5_ = _loc5_ + ", ";
            }
            _loc5_ = _loc5_ + "{ ";
            for(_loc6_ in _loc3_)
            {
               if(_loc4_ != 0)
               {
                  _loc5_ = _loc5_ + ", ";
               }
               _loc5_ = _loc5_ + (_loc6_ + ":");
               if(_loc3_[_loc6_] !== null)
               {
                  _loc5_ = _loc5_ + _loc3_[_loc6_].toString();
               }
               else
               {
                  _loc5_ = _loc5_ + "null";
               }
               _loc4_++;
            }
            _loc5_ = _loc5_ + " }";
            trace(_loc5_);
            _loc2_++;
         }
      }
   }
}
