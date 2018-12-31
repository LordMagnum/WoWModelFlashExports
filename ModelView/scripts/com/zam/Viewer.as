package com.zam
{
   import com.zam.MOM.MOM;
   import com.zam.MOM.MOMEvent;
   import com.zam.MOM.MOMGender;
   import com.zam.MOM.MOMModelType;
   import com.zam.MOM.MOMRace;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.StageDisplayState;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.filters.BlurFilter;
   import flash.filters.GlowFilter;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import org.papervision3d.core.math.Matrix3D;
   import org.papervision3d.core.math.Number3D;
   import org.papervision3d.events.FileLoadEvent;
   import org.papervision3d.objects.DisplayObject3D;
   import org.papervision3d.view.BasicView;
   
   public class Viewer extends BasicView
   {
       
      
      private var currentY:Number = 0;
      
      private var rootNode:MOM;
      
      private var vThrow:Number = 0;
      
      private var WindowPNG:Class;
      
      private var previousX:Number = 0;
      
      private var previousY:Number = 0;
      
      private var _blur:Boolean;
      
      private var FullscreenPNG:Class;
      
      private var _fullscreen:Boolean = false;
      
      private var LogoBR:MovieClip;
      
      private var hThrow:Number = 0;
      
      private var WindowBitmap:Bitmap;
      
      private var _blurFilter:BlurFilter;
      
      private var _contentpath:String;
      
      private var LoadingText:TextField;
      
      private var _initiated:Boolean;
      
      private var _downloads:Object;
      
      private var _mode:int;
      
      private var _logo:String;
      
      private var zThrow:Number = 0;
      
      private var _progress:Number = 0;
      
      private var halted:Boolean;
      
      private var hPush:Number = 0;
      
      private var _baseZoom:Number = 0;
      
      private var _dragging:Boolean;
      
      private var vPush:Number = 0;
      
      private var zPush:Number = 0;
      
      private var _zoom:Number;
      
      private var _totalsize:Number = 0;
      
      private var ZAMLogo:Class;
      
      private var _focus:Boolean;
      
      private var _loaderUrl:String = "";
      
      private var _touched:Boolean;
      
      private var FullscreenBitmap:Bitmap;
      
      private var FullscreenButton:SimpleButton;
      
      private var centerNode:DisplayObject3D;
      
      private var currentX:Number = 0;
      
      public function Viewer(param1:Object = null, param2:String = "")
      {
         var _loc4_:* = null;
         this.ZAMLogo = Viewer_ZAMLogo;
         this.WindowPNG = Viewer_WindowPNG;
         this.FullscreenPNG = Viewer_FullscreenPNG;
         super(600,400,true,false,"Free");
         camera.focus = 100;
         camera.x = 2000;
         camera.z = 0;
         camera.y = 0;
         camera.zoom = 6;
         this.centerNode = DisplayObject3D.ZERO;
         this._downloads = new Object();
         this._blurFilter = new BlurFilter(0,0);
         this._blur = true;
         if(param1.blur != undefined)
         {
            this._blur = Boolean(parseInt(param1.blur));
         }
         this._mode = 1;
         if(param1.mode != undefined)
         {
            this._mode = parseInt(param1.mode);
         }
         if(param2 != "")
         {
            this._loaderUrl = param2;
         }
         var _loc3_:* = "";
         for(_loc4_ in param1)
         {
            if(_loc3_ != "")
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
         }
         trace("params: " + _loc3_);
         this._contentpath = param1.contentPath || "";
         if(!this._contentpath)
         {
            trace("nop");
            return;
         }
         this._logo = "dev";
         this.init(parseInt(param1.modelType),param1.model,param1.equipList || "",int(param1.ha) || -1,int(param1.hc) || -1,int(param1.fa) || -1,int(param1.sk) || -1,int(param1.fh) || -1,int(param1.fc) || -1);
         camera.lookAt(this.centerNode);
         singleRender();
      }
      
      private function externGetFacialColor() : int
      {
         try
         {
            return this.rootNode.facialcolor;
         }
         catch(ex:Error)
         {
            trace("[EXTERN] Could not get character: " + ex.message);
            trace(ex.getStackTrace());
         }
         return -1;
      }
      
      private function onLogoError(param1:Event) : void
      {
         this.loadDefaultLogo();
      }
      
      private function onMouseMove(param1:MouseEvent) : void
      {
         this.currentX = param1.stageX;
         this.currentY = param1.stageY;
      }
      
      private function externGetHairStyle() : int
      {
         try
         {
            return this.rootNode.hairstyle;
         }
         catch(ex:Error)
         {
            trace("[EXTERN] Could not get character: " + ex.message);
            trace(ex.getStackTrace());
         }
         return -1;
      }
      
      private function loop3D() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Boolean = false;
         var _loc3_:Number3D = null;
         if(this.rootNode.geometryLoaded && !this._initiated)
         {
            this.FullscreenButton.x = viewport.viewportWidth - 18;
            this.FullscreenButton.y = viewport.viewportHeight - 18;
            this.FullscreenButton.visible = true;
            _loc1_ = 1;
            _loc2_ = false;
            if(this._baseZoom != 0)
            {
               _loc2_ = true;
               _loc1_ = Number(this._zoom) / this._baseZoom;
            }
            this._baseZoom = int(Math.max(this.rootNode.boundingbox.x,this.rootNode.boundingbox.z,this.rootNode.boundingbox.y) * 1.8 * ((!this._fullscreen?viewport.viewportHeight:500) / viewport.viewportHeight));
            this._zoom = this._baseZoom * _loc1_;
            if(this._zoom < this.rootNode.boundingbox.y / 2)
            {
               this._zoom = this.rootNode.boundingbox.y / 2;
            }
            this.rootNode.x = -this.rootNode.center.x;
            this.rootNode.y = -this.rootNode.center.y;
            this.rootNode.z = -this.rootNode.center.z;
            if(this.rootNode.type == MOMModelType.ITEM)
            {
               if(!_loc2_)
               {
                  camera.x = 0;
                  camera.z = -this._zoom;
               }
            }
            else if(this.isPetWindow())
            {
               this._zoom = int(Math.min(Math.max(this.rootNode.boundingbox.y + this.rootNode.boundingbox.z,this.rootNode.boundingbox.x),1000));
               if(Math.round(this.rootNode.boundingbox.y) == 599)
               {
                  this._zoom = int(this.rootNode.boundingbox.y);
               }
               this._zoom = this._zoom * (300 / viewport.viewportWidth) * (5 / 3);
               camera.x = this._zoom * 0.75;
               camera.z = -this._zoom * 0.5;
               camera.y = this._zoom * 0.1;
            }
            else if(this._mode == 3)
            {
               this._zoom = int(Math.max(this.rootNode.boundingbox.x,this.rootNode.boundingbox.z,this.rootNode.boundingbox.y) * 2.5);
               camera.z = -this._zoom * 0.75;
               if(this.rootNode.race == MOMRace.HUMAN)
               {
                  if(this.rootNode.gender == MOMGender.MALE)
                  {
                     this._zoom = int(this.rootNode.boundingbox.y * 1.95);
                  }
                  else
                  {
                     this._zoom = int(this.rootNode.boundingbox.y * 2.1);
                  }
               }
               else if(this.rootNode.race == MOMRace.ORC)
               {
                  if(this.rootNode.gender == MOMGender.MALE)
                  {
                     this._zoom = int(this.rootNode.boundingbox.y * 2.2);
                  }
                  else
                  {
                     this._zoom = int(this.rootNode.boundingbox.y * 2);
                  }
               }
               else if(this.rootNode.race == MOMRace.DWARF)
               {
                  if(this.rootNode.gender == MOMGender.MALE)
                  {
                     this._zoom = int(this.rootNode.boundingbox.y * 2.2);
                  }
                  else
                  {
                     this._zoom = int(this.rootNode.boundingbox.y * 2.2);
                  }
               }
               else if(this.rootNode.race == MOMRace.NIGHTELF)
               {
                  if(this.rootNode.gender == MOMGender.MALE)
                  {
                     this._zoom = int(this.rootNode.boundingbox.y * 2);
                  }
                  else
                  {
                     this._zoom = int(this.rootNode.boundingbox.y * 2.1);
                  }
               }
               else if(this.rootNode.race == MOMRace.SCOURGE)
               {
                  this.rootNode.y = this.rootNode.y + this.rootNode.boundingbox.y * 0.05;
                  if(this.rootNode.gender == MOMGender.MALE)
                  {
                     this._zoom = int(this.rootNode.boundingbox.y * 1.9);
                  }
                  else
                  {
                     this._zoom = int(this.rootNode.boundingbox.y * 1.9);
                  }
               }
               else if(this.rootNode.race == MOMRace.TAUREN)
               {
                  if(this.rootNode.gender == MOMGender.MALE)
                  {
                     this._zoom = int(this.rootNode.boundingbox.y * 2.3);
                  }
                  else
                  {
                     this._zoom = int(this.rootNode.boundingbox.y * 2.2);
                  }
               }
               else if(this.rootNode.race == MOMRace.GNOME)
               {
                  if(this.rootNode.gender == MOMGender.MALE)
                  {
                     this._zoom = int(this.rootNode.boundingbox.y * 1.8);
                     this.rootNode.y = this.rootNode.y + this.rootNode.boundingbox.y * 0.1;
                  }
                  else
                  {
                     this._zoom = int(this.rootNode.boundingbox.y * 2.2);
                  }
               }
               else if(this.rootNode.race == MOMRace.TROLL)
               {
                  if(this.rootNode.gender == MOMGender.MALE)
                  {
                     this._zoom = int(this.rootNode.boundingbox.y * 2);
                  }
                  else
                  {
                     this._zoom = int(this.rootNode.boundingbox.y * 1.9);
                     this.rootNode.y = this.rootNode.y + this.rootNode.boundingbox.y * 0.05;
                  }
               }
               else if(this.rootNode.race == MOMRace.BLOODELF)
               {
                  if(this.rootNode.gender == MOMGender.MALE)
                  {
                     this._zoom = int(this.rootNode.boundingbox.y * 2);
                  }
                  else
                  {
                     this._zoom = int(this.rootNode.boundingbox.y * 2);
                  }
               }
               else if(this.rootNode.race == MOMRace.DRAENEI)
               {
                  if(this.rootNode.gender == MOMGender.MALE)
                  {
                     this._zoom = int(this.rootNode.boundingbox.y * 2.2);
                  }
                  else
                  {
                     this._zoom = int(this.rootNode.boundingbox.y * 2);
                  }
               }
            }
            camera.far = this._zoom * 2;
            camera.lookAt(this.centerNode);
            camera.moveBackward(this._zoom - camera.distanceTo(this.centerNode));
            this._initiated = true;
            singleRender();
            return;
         }
         if(this._dragging)
         {
            this.hThrow = this.currentX - this.previousX;
            this.vThrow = this.currentY - this.previousY;
            this.previousX = this.currentX;
            this.previousY = this.currentY;
         }
         if(this.hPush != 0)
         {
            this.hThrow = this.hPush;
         }
         if(this.vPush != 0)
         {
            this.vThrow = this.vPush;
         }
         if(this.zPush != 0)
         {
            this.zThrow = this.zPush;
         }
         if(this.hThrow || this.vThrow || this.zThrow || this._dragging)
         {
            if(Math.abs(this.vThrow) > 0.1)
            {
               _loc3_ = new Number3D(0,1,0);
               Matrix3D.rotateAxis(camera.transform,_loc3_);
               if(Math.abs(camera.y + Math.round(this.vThrow * (this._zoom / 100)) * _loc3_.y) < this._zoom - 1)
               {
                  camera.moveUp(Math.round(this.vThrow * (this._zoom / 100)));
               }
               this.vThrow = this.vThrow / 1.2;
            }
            else
            {
               this.vThrow = 0;
            }
            if(Math.abs(this.hThrow) > 0.1)
            {
               camera.moveLeft(Math.round(this.hThrow * (this._zoom / 100)));
               this.hThrow = this.hThrow / 1.2;
            }
            else
            {
               this.hThrow = 0;
            }
            if(Math.abs(this.zThrow) > 0.1)
            {
               this._zoom = this._zoom - this.zThrow;
               if(this._zoom < this.rootNode.boundingbox.y / 2)
               {
                  this._zoom = this.rootNode.boundingbox.y / 2;
               }
               camera.far = this._zoom * 2;
               this.zThrow = this.zThrow / 1.2;
            }
            else
            {
               this.zThrow = 0;
            }
            camera.lookAt(this.centerNode);
            camera.moveBackward(this._zoom - camera.distanceTo(this.centerNode));
            if(Math.abs(this.hThrow) > 0.1 || Math.abs(this.vThrow) > 0.1 || Math.abs(this.zThrow) > 0.1)
            {
               this.stageQualityLow();
               if(this._blur)
               {
                  this._blurFilter.blurX = Math.min(Math.abs(this.hThrow) * 0.25,25);
                  viewport.filters = [this._blurFilter];
               }
            }
            else if(!this._dragging)
            {
               if(this._blur)
               {
                  viewport.filters = [];
               }
               this.stageQualityHigh();
            }
            singleRender();
         }
      }
      
      public function init(param1:int, param2:String, param3:String, param4:int, param5:int, param6:int, param7:int, param8:int, param9:int) : void
      {
         var race:int = 0;
         var gender:int = 0;
         var i:int = 0;
         var pModelType:int = param1;
         var pModel:String = param2;
         var pEquipList:String = param3;
         var pHairStyle:int = param4;
         var pHairColor:int = param5;
         var pFaceType:int = param6;
         var pSkinColor:int = param7;
         var pFacial:int = param8;
         var pFacialColor:int = param9;
         this._touched = false;
         this._focus = false;
         this._initiated = false;
         this._zoom = 2000;
         this.init3D();
         this.init2D();
         addEventListener(Event.ADDED_TO_STAGE,this.initEvents);
         this.initExtern();
         try
         {
            if(pModelType > 0 && pModelType != MOMModelType.CHAR)
            {
               this.rootNode.load(pModelType,pModel);
            }
            else if(pModelType == MOMModelType.CHAR || pModelType == MOMModelType.HUMAN)
            {
               race = -1;
               gender = -1;
               i = 1;
               while(i < MOM.RACES.length)
               {
                  if(pModel.indexOf(MOM.RACES[i].toLowerCase()) == 0)
                  {
                     race = i;
                     break;
                  }
                  i++;
               }
               if(race != -1)
               {
                  if(pModel.indexOf("female") == MOM.RACES[race].length)
                  {
                     gender = MOMGender.FEMALE;
                  }
                  else if(pModel.indexOf("male") == MOM.RACES[race].length)
                  {
                     gender = MOMGender.MALE;
                  }
               }
               if(race != -1 && gender != -1)
               {
                  this.rootNode.skincolor = pSkinColor;
                  this.rootNode.facetype = pFaceType;
                  this.rootNode.hairstyle = pHairStyle;
                  this.rootNode.haircolor = pHairColor;
                  this.rootNode.facialfeature = pFacial;
                  this.rootNode.facialcolor = pFacialColor;
                  this.rootNode.setRaceGender(race,gender);
                  this.rootNode.load();
                  this.rootNode.attach(pEquipList);
               }
               else
               {
                  throw new Error("Invalid character model string");
               }
            }
            return;
         }
         catch(error:Error)
         {
            trace("An Error occurred: " + error.message + " (" + error.name + ")");
            LoadingText.text = "Loading Error.";
            LoadingText.visible = true;
            return;
         }
      }
      
      private function externSetHairColor(param1:int) : void
      {
         var val:int = param1;
         try
         {
            this.rootNode.haircolor = val;
            return;
         }
         catch(ex:Error)
         {
            trace("[EXTERN] Could not set character: " + ex.message);
            trace(ex.getStackTrace());
            return;
         }
      }
      
      private function externClearSlot(param1:int) : void
      {
         var pId:int = param1;
         try
         {
            this.rootNode.clearSlot(pId);
            return;
         }
         catch(ex:Error)
         {
            trace("[EXTERN] Could not clear slots: " + ex.message);
            trace(ex.getStackTrace());
            return;
         }
      }
      
      private function isMouseOverStage() : Boolean
      {
         return !(stage.mouseX < 0 || stage.mouseX > stage.width || (stage.mouseY < 0 || stage.mouseY > stage.height));
      }
      
      private function onLogoLoad(param1:Event) : void
      {
         var logoBitmap:BitmapData = null;
         var e:Event = param1;
         try
         {
            logoBitmap = Bitmap(e.target.content).bitmapData;
            this.LogoBR.graphics.beginBitmapFill(logoBitmap);
            this.LogoBR.graphics.drawRect(0,0,logoBitmap.width,logoBitmap.height);
            this.LogoBR.graphics.endFill();
            this.LogoBR.x = viewport.viewportWidth - (logoBitmap.width + 18);
            this.LogoBR.y = viewport.viewportHeight - (logoBitmap.height + 18);
            if(this._mode > 1 || this.isPetWindow())
            {
               this.LogoBR.visible = false;
            }
            addChild(this.LogoBR);
            return;
         }
         catch(ex:Error)
         {
            loadDefaultLogo();
            return;
         }
      }
      
      private function onFocus(param1:Event) : void
      {
         if(!this._focus && this._touched)
         {
            this._focus = true;
         }
      }
      
      private function externAttachList(param1:String) : void
      {
         var pList:String = param1;
         try
         {
            this.rootNode.attach(pList);
            return;
         }
         catch(ex:Error)
         {
            trace("[EXTERN] Could not attach items: " + ex.message);
            trace(ex.getStackTrace());
            return;
         }
      }
      
      private function onMouseUp(param1:MouseEvent) : void
      {
         this._dragging = false;
         if(this.vThrow == 0 && this.hThrow == 0 && this.zThrow == 0)
         {
            if(this._blur)
            {
               viewport.filters = [];
            }
            this.stageQualityHigh();
            singleRender();
         }
         if(!this.isMouseOverStage())
         {
            this.onBlur(param1);
         }
      }
      
      private function initEvents(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.initEvents);
         this.stageQualityLow();
         stage.doubleClickEnabled = true;
         stage.addEventListener(MouseEvent.DOUBLE_CLICK,this.onFullscreenClick);
         stage.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         stage.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         stage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         stage.addEventListener(MouseEvent.MOUSE_OVER,this.onFocus);
         stage.addEventListener(MouseEvent.MOUSE_OUT,this.onBlur);
         stage.addEventListener(Event.RESIZE,this.onResize);
         this.rootNode.addEventListener(MOMEvent.CHANGED,this.onChange);
         this.rootNode.addEventListener(MOMEvent.OPEN_FILE,this.onLoadOpen);
         this.rootNode.addEventListener(MOMEvent.ERROR,this.onMOMError);
         this.rootNode.addEventListener(FileLoadEvent.LOAD_PROGRESS,this.onLoadProgress);
         this.rootNode.addEventListener(FileLoadEvent.LOAD_ERROR,this.onLoadError);
         this.rootNode.addEventListener(FileLoadEvent.LOAD_COMPLETE,this.onLoad);
         addEventListener(Event.ENTER_FRAME,this.tick);
      }
      
      private function onLoadOpen(param1:Event) : void
      {
         if(this.halted)
         {
            return;
         }
         if(this._totalsize == 0)
         {
            this.LoadingText.text = "Loading ...";
            this.LoadingText.visible = true;
         }
      }
      
      private function init2D() : void
      {
         var loader:Loader = null;
         var pad:Number = 4;
         this.LogoBR = new MovieClip();
         this.LogoBR.name = "Logo";
         this.LogoBR.alpha = 0.8;
         var re:RegExp = /^http:\/\/.*\.(wowhead|allakhazam|thottbot)\.com\//i;
         if(this._loaderUrl == "" || !re.test(this._loaderUrl))
         {
            loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLogoLoad);
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onLogoError);
            try
            {
               loader.load(new URLRequest(this._contentpath + "badge.png"),new LoaderContext(true,null,null));
            }
            catch(ex:Error)
            {
               loadDefaultLogo();
            }
         }
         this.FullscreenBitmap = new this.FullscreenPNG();
         this.WindowBitmap = new this.WindowPNG();
         this.FullscreenButton = new SimpleButton(this.FullscreenBitmap,this.FullscreenBitmap,this.FullscreenBitmap,this.FullscreenBitmap);
         this.FullscreenButton.width = 16;
         this.FullscreenButton.height = 16;
         this.FullscreenButton.x = viewport.viewportWidth - 18;
         this.FullscreenButton.y = viewport.viewportHeight - 18;
         this.FullscreenButton.addEventListener(MouseEvent.CLICK,this.onFullscreenClick);
         this.FullscreenButton.visible = false;
         addChild(this.FullscreenButton);
         this.LoadingText = new TextField();
         this.LoadingText.name = "Loading";
         this.LoadingText.defaultTextFormat = new TextFormat("Verdana",11,16777215,true);
         this.LoadingText.width = viewport.viewportWidth - pad - this.LogoBR.width - pad;
         this.LoadingText.height = 20;
         this.LoadingText.selectable = false;
         this.LoadingText.multiline = true;
         this.LoadingText.antiAliasType = "advanced";
         this.LoadingText.text = "Loading ... ";
         this.LoadingText.x = pad;
         this.LoadingText.y = viewport.viewportHeight - this.LoadingText.height;
         this.LoadingText.visible = false;
         this.LoadingText.filters = [new GlowFilter(4278190080,0.8,6,6,8,1)];
         addChild(this.LoadingText);
      }
      
      private function stageQualityHigh() : void
      {
         if(!this.rootNode.done)
         {
            return;
         }
         stage.quality = "medium";
      }
      
      private function externSetSkinColor(param1:int) : void
      {
         var val:int = param1;
         try
         {
            this.rootNode.skincolor = val;
            return;
         }
         catch(ex:Error)
         {
            trace("[EXTERN] Could not set character: " + ex.message);
            trace(ex.getStackTrace());
            return;
         }
      }
      
      private function externSetHairStyle(param1:int) : void
      {
         var val:int = param1;
         try
         {
            this.rootNode.hairstyle = val;
            return;
         }
         catch(ex:Error)
         {
            trace("[EXTERN] Could not set character: " + ex.message);
            trace(ex.getStackTrace());
            return;
         }
      }
      
      private function onChange(param1:Event) : void
      {
         if(this._initiated)
         {
            singleRender();
         }
      }
      
      private function onLoad(param1:FileLoadEvent) : void
      {
         this.stageQualityHigh();
         singleRender();
         trace("Load complete. (" + this.rootNode.numChildren + " children)");
      }
      
      private function externSetFacialColor(param1:int) : void
      {
         var val:int = param1;
         try
         {
            this.rootNode.facialcolor = val;
            return;
         }
         catch(ex:Error)
         {
            trace("[EXTERN] Could not set character: " + ex.message);
            trace(ex.getStackTrace());
            return;
         }
      }
      
      private function stageQualityLow() : void
      {
         stage.quality = "low";
      }
      
      private function init3D() : void
      {
         this.rootNode = new MOM(this._contentpath,this);
         scene.addChild(this.rootNode);
      }
      
      private function onResize(param1:Event) : void
      {
         this.onChange(param1);
         if(!this.isPetWindow())
         {
            this.LogoBR.x = viewport.viewportWidth - this.LogoBR.width;
            this.LogoBR.y = viewport.viewportHeight - this.LogoBR.height;
            this.LogoBR.visible = true;
            this.FullscreenButton.x = viewport.viewportWidth - 18;
            this.FullscreenButton.y = viewport.viewportHeight - 18;
            this.FullscreenButton.visible = true;
         }
         else
         {
            this.LogoBR.visible = false;
         }
      }
      
      private function externSetFacial(param1:int) : void
      {
         var val:int = param1;
         try
         {
            this.rootNode.facialfeature = val;
            return;
         }
         catch(ex:Error)
         {
            trace("[EXTERN] Could not set character: " + ex.message);
            trace(ex.getStackTrace());
            return;
         }
      }
      
      private function externIsLoaded() : Boolean
      {
         try
         {
            return this.rootNode.geometryLoaded;
         }
         catch(ex:Error)
         {
            trace("[EXTERN] externIsLoaded: " + ex.message);
            trace(ex.getStackTrace());
         }
         return false;
      }
      
      private function externGetFacial() : int
      {
         try
         {
            return this.rootNode.facialfeature;
         }
         catch(ex:Error)
         {
            trace("[EXTERN] Could not get character: " + ex.message);
            trace(ex.getStackTrace());
         }
         return -1;
      }
      
      private function tick(param1:Event) : void
      {
         this.loop3D();
      }
      
      private function externToggleGeoset(param1:String) : void
      {
         var s:String = param1;
         try
         {
            this.rootNode.toggleGeoset(parseInt(s));
            return;
         }
         catch(ex:Error)
         {
            trace("[EXTERN] Could not set geoset: " + ex.message);
            trace(ex.getStackTrace());
            return;
         }
      }
      
      private function externSetAppearance(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : void
      {
         trace("externSetAppearance(" + param1,param2,param3,param4,param5,param6 + ")");
         this.externSetCharacter(-1,-1,param4,param3,param1,param2,param5,param6);
      }
      
      private function externSetCharacter(param1:int = 1, param2:int = 1, param3:int = -1, param4:int = -1, param5:int = -1, param6:int = -1, param7:int = -1, param8:int = -1) : void
      {
         var pRace:int = param1;
         var pGender:int = param2;
         var pSkinColor:int = param3;
         var pFaceType:int = param4;
         var pHairStyle:int = param5;
         var pHairColor:int = param6;
         var pFacial:int = param7;
         var pFacialColor:int = param8;
         try
         {
            this.rootNode.skincolor = pSkinColor;
            this.rootNode.facetype = pFaceType;
            this.rootNode.hairstyle = pHairStyle;
            this.rootNode.haircolor = pHairColor;
            this.rootNode.facialfeature = pFacial;
            this.rootNode.facialcolor = pFacialColor;
            if(pRace != -1 && pGender != -1)
            {
               this.rootNode.setRaceGender(pRace,pGender);
            }
            if(!this.rootNode.geometryLoaded)
            {
               this.rootNode.load();
            }
            return;
         }
         catch(ex:Error)
         {
            trace("[EXTERN] Could not set character: " + ex.message);
            trace(ex.getStackTrace());
            return;
         }
      }
      
      private function externClearSlots(param1:String) : void
      {
         var pList:String = param1;
         try
         {
            this.rootNode.clearSlots(pList.split(","));
            return;
         }
         catch(ex:Error)
         {
            trace("[EXTERN] Could not clear slots: " + ex.message);
            trace(ex.getStackTrace());
            return;
         }
      }
      
      private function externAttachSlot(param1:int, param2:int) : void
      {
         var pSlot:int = param1;
         var pId:int = param2;
         try
         {
            this.rootNode.attachArmor(pSlot,pId);
            return;
         }
         catch(ex:Error)
         {
            trace("[EXTERN] Could not attach item: " + ex.message);
            trace(ex.getStackTrace());
            return;
         }
      }
      
      private function externGetHairColor() : int
      {
         try
         {
            return this.rootNode.haircolor;
         }
         catch(ex:Error)
         {
            trace("[EXTERN] Could not get character: " + ex.message);
            trace(ex.getStackTrace());
         }
         return -1;
      }
      
      private function externToggleBlur(param1:String = "") : void
      {
         var mode:String = param1;
         try
         {
            if(mode == "")
            {
               mode = String(!this._blur);
            }
            this._blur = Boolean(mode);
            return;
         }
         catch(ex:Error)
         {
            trace("[EXTERN] Could not set blur: " + ex.message);
            trace(ex.getStackTrace());
            return;
         }
      }
      
      private function onFullscreenClick(param1:MouseEvent) : void
      {
         if(this._fullscreen)
         {
            this.FullscreenButton.upState = this.FullscreenBitmap;
            this.FullscreenButton.downState = this.FullscreenBitmap;
            this.FullscreenButton.overState = this.FullscreenBitmap;
            stage.displayState = StageDisplayState.NORMAL;
         }
         else
         {
            this.FullscreenButton.upState = this.WindowBitmap;
            this.FullscreenButton.downState = this.WindowBitmap;
            this.FullscreenButton.overState = this.WindowBitmap;
            stage.displayState = StageDisplayState.FULL_SCREEN;
         }
         this.LogoBR.x = viewport.viewportWidth - (this.LogoBR.width + 18);
         this.LogoBR.y = viewport.viewportHeight - (this.LogoBR.height + 18);
         this.FullscreenButton.x = viewport.viewportWidth - 18;
         this.FullscreenButton.y = viewport.viewportHeight - 18;
         this._fullscreen = !this._fullscreen;
         this._initiated = false;
         this.loop3D();
      }
      
      private function onLoadProgress(param1:FileLoadEvent) : void
      {
         if(this.halted)
         {
            return;
         }
         if(this._downloads[param1.file] == null)
         {
            this._downloads[param1.file] = 0;
            this._totalsize = this._totalsize + param1.bytesTotal;
         }
         this._progress = this._progress + (param1.bytesLoaded - this._downloads[param1.file]);
         this._downloads[param1.file] = param1.bytesLoaded;
         if(param1.bytesTotal == param1.bytesLoaded)
         {
            delete this._downloads[param1.file];
         }
         if(this._totalsize && this._progress / this._totalsize == 1)
         {
            this._progress = this._totalsize = 0;
            this.LoadingText.visible = false;
            this.LoadingText.text = "";
         }
         else
         {
            this.LoadingText.text = "Loading ... " + Math.round(this._progress / this._totalsize * 100) + "%";
            if(!this.LoadingText.visible)
            {
               this.LoadingText.visible = true;
            }
         }
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 37)
         {
            this.hPush = -10;
         }
         else if(param1.keyCode == 39)
         {
            this.hPush = 10;
         }
         else if(param1.keyCode == 40)
         {
            this.vPush = -5;
         }
         else if(param1.keyCode == 38)
         {
            this.vPush = 5;
         }
         else if(param1.keyCode == 65)
         {
            this.zPush = 25;
         }
         else if(param1.keyCode == 90)
         {
            this.zPush = -25;
         }
      }
      
      private function onMouseDown(param1:MouseEvent) : void
      {
         if(!this._touched)
         {
            this._touched = true;
         }
         this.onFocus(param1);
         this.previousX = param1.stageX;
         this.previousY = param1.stageY;
         this.stageQualityLow();
         this._dragging = true;
      }
      
      private function onKeyUp(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 37)
         {
            this.hPush = 0;
         }
         else if(param1.keyCode == 39)
         {
            this.hPush = 0;
         }
         else if(param1.keyCode == 40)
         {
            this.vPush = 0;
         }
         else if(param1.keyCode == 38)
         {
            this.vPush = 0;
         }
         else if(param1.keyCode == 65)
         {
            this.zPush = 0;
         }
         else if(param1.keyCode == 90)
         {
            this.zPush = 0;
         }
      }
      
      private function onMOMError(param1:Event) : void
      {
         this.LoadingText.text = "Loading Error.";
         this.LoadingText.visible = true;
         this.halted = true;
      }
      
      private function initExtern() : void
      {
         if(ExternalInterface.available)
         {
            try
            {
               ExternalInterface.addCallback("attachList",this.externAttachList);
               ExternalInterface.addCallback("attachSlot",this.externAttachSlot);
               ExternalInterface.addCallback("clearSlot",this.externClearSlot);
               ExternalInterface.addCallback("clearSlots",this.externClearSlots);
               ExternalInterface.addCallback("clearSlotsAll",this.externClearSlotsAll);
               ExternalInterface.addCallback("setAppearance",this.externSetAppearance);
               ExternalInterface.addCallback("setCharacter",this.externSetCharacter);
               ExternalInterface.addCallback("setHairStyle",this.externSetHairStyle);
               ExternalInterface.addCallback("setHairColor",this.externSetHairColor);
               ExternalInterface.addCallback("setFaceType",this.externSetFaceType);
               ExternalInterface.addCallback("setSkinColor",this.externSetSkinColor);
               ExternalInterface.addCallback("setFacialHairStyle",this.externSetFacial);
               ExternalInterface.addCallback("setFacialHairColor",this.externSetFacialColor);
               ExternalInterface.addCallback("getHairStyle",this.externGetHairStyle);
               ExternalInterface.addCallback("getHairColor",this.externGetHairColor);
               ExternalInterface.addCallback("getFaceType",this.externGetFaceType);
               ExternalInterface.addCallback("getSkinColor",this.externGetSkinColor);
               ExternalInterface.addCallback("getFacialHairStyle",this.externGetFacial);
               ExternalInterface.addCallback("getFacialHairColor",this.externGetFacialColor);
               ExternalInterface.addCallback("isLoaded",this.externIsLoaded);
               ExternalInterface.addCallback("toggleGeoset",this.externToggleGeoset);
               ExternalInterface.addCallback("toggleBlur",this.externToggleBlur);
               return;
            }
            catch(error:Error)
            {
               trace("An Error occurred: " + error.message + " (" + error.name + ")");
               LoadingText.text = "Loading Error.";
               LoadingText.visible = true;
               return;
            }
         }
      }
      
      private function loadDefaultLogo() : void
      {
         var _loc1_:BitmapData = (new this.ZAMLogo() as Bitmap).bitmapData;
         this.LogoBR.graphics.beginBitmapFill(_loc1_);
         this.LogoBR.graphics.drawRect(0,0,_loc1_.width,_loc1_.height);
         this.LogoBR.graphics.endFill();
         this.LogoBR.x = viewport.viewportWidth - _loc1_.width;
         this.LogoBR.y = viewport.viewportHeight - _loc1_.height;
         this.LogoBR.filters = [new GlowFilter(4278190080)];
         if(this._mode > 1 || this.isPetWindow())
         {
            this.LogoBR.visible = false;
         }
         addChild(this.LogoBR);
      }
      
      private function onLoadError(param1:FileLoadEvent) : void
      {
         trace(param1.message);
         this.LoadingText.text = "Loading Error.";
         this.LoadingText.visible = true;
      }
      
      private function externClearSlotsAll() : void
      {
         try
         {
            this.rootNode.clearSlotsAll();
            return;
         }
         catch(ex:Error)
         {
            trace("[EXTERN] Could not clear slots: " + ex.message);
            trace(ex.getStackTrace());
            return;
         }
      }
      
      private function isPetWindow() : Boolean
      {
         return false;
      }
      
      private function onBlur(param1:Event) : void
      {
         if(this._focus && !this._dragging)
         {
            this._focus = false;
            if(this.isPetWindow())
            {
               this._touched = false;
            }
         }
      }
      
      private function externGetSkinColor() : int
      {
         try
         {
            return this.rootNode.skincolor;
         }
         catch(ex:Error)
         {
            trace("[EXTERN] Could not get character: " + ex.message);
            trace(ex.getStackTrace());
         }
         return -1;
      }
      
      private function externGetFaceType() : int
      {
         try
         {
            return this.rootNode.facetype;
         }
         catch(ex:Error)
         {
            trace("[EXTERN] Could not get character: " + ex.message);
            trace(ex.getStackTrace());
         }
         return -1;
      }
      
      private function onMouseWheel(param1:MouseEvent) : void
      {
         if(this._focus || !this.isPetWindow())
         {
            this._touched = true;
            this.zThrow = param1.delta * (this._zoom / 100);
         }
      }
      
      private function externSetFaceType(param1:int) : void
      {
         var val:int = param1;
         try
         {
            this.rootNode.facetype = val;
            return;
         }
         catch(ex:Error)
         {
            trace("[EXTERN] Could not set character: " + ex.message);
            trace(ex.getStackTrace());
            return;
         }
      }
   }
}
