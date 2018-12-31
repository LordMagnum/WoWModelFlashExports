package com.zam
{
   import com.zam.gw2.Gw2Model;
   import com.zam.lol.LolMesh;
   import com.zam.tor.TorMesh;
   import com.zam.wow.WowModel;
   import flash.display.Bitmap;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.display.StageDisplayState;
   import flash.display3D.Context3D;
   import flash.events.Event;
   import flash.events.FullScreenEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.getTimer;
   
   public class Viewer extends Sprite
   {
      
      public static const VIEWER_TOR:int = 1;
      
      public static const VIEWER_WOW:int = 2;
      
      public static const VIEWER_LOL:int = 3;
      
      public static const VIEWER_GW2:int = 4;
       
      
      private var _context:Context3D;
      
      private var _fullscreen:Boolean;
      
      private var _viewerType:int;
      
      private var _contentPath:String;
      
      private var _modelType:int;
      
      private var _model:String;
      
      private var _params:Object;
      
      private var _thisFrameTime:int;
      
      private var _lastFrameTime:int;
      
      private var _delta:Number;
      
      private var _camera:Camera;
      
      private var _mesh:Mesh;
      
      private var _background:IBackground;
      
      private var _mousePrevX:int = -1;
      
      private var _mousePrevY:int = -1;
      
      private var _mouseCurrX:int = 0;
      
      private var _mouseCurrY:int = 0;
      
      private var _mouseDown:Boolean = false;
      
      private var _mouseControlDown:Boolean = false;
      
      private var _momentumX:Number = 0;
      
      private var _momentumY:Number = 0;
      
      private var _turnX:Number = 0;
      
      private var _turnY:Number = 0;
      
      private var _statusText:String = "";
      
      private var _lockStatus:Boolean = false;
      
      private var _init:Boolean;
      
      private var _loadingFiles:Object;
      
      private var StatusText:TextField;
      
      private var FullscreenButton:SimpleButton;
      
      private var WindowPNG:Class;
      
      private var FullscreenPNG:Class;
      
      private var LolkingPNG:Class;
      
      private var GuildheadPNG:Class;
      
      private var WindowBitmap:Bitmap;
      
      private var FullscreenBitmap:Bitmap;
      
      private var LolkingBitmap:Bitmap;
      
      private var GuildheadBitmap:Bitmap;
      
      private var LabelLink:TextField;
      
      public function Viewer(param1:Object = null, param2:String = "")
      {
         this.WindowPNG = Viewer_WindowPNG;
         this.FullscreenPNG = Viewer_FullscreenPNG;
         this.LolkingPNG = Viewer_LolkingPNG;
         this.GuildheadPNG = Viewer_GuildheadPNG;
         super();
         this._params = param1;
         this._loadingFiles = new Object();
         this._viewerType = int(parseInt(param1.viewerType)) || int(VIEWER_WOW);
         this._contentPath = param1.contentPath || "http://static.wowhead.com/modelviewer/";
         this._modelType = parseInt(param1.modelType);
         this._model = param1.model;
         addEventListener(Event.ADDED_TO_STAGE,this.init);
      }
      
      public function get context() : Context3D
      {
         return this._context;
      }
      
      public function get camera() : Camera
      {
         return this._camera;
      }
      
      public function get contentPath() : String
      {
         return this._contentPath;
      }
      
      public function get time() : int
      {
         return this._thisFrameTime;
      }
      
      public function get type() : int
      {
         return this._viewerType;
      }
      
      public function set statusText(param1:String) : void
      {
         if(this._lockStatus)
         {
            return;
         }
         this._statusText = param1;
         if(this.StatusText != null)
         {
            this.StatusText.text = param1;
         }
      }
      
      public function init(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.init);
         if(stage.stage3Ds.length > 0)
         {
            stage.stage3Ds[0].addEventListener(Event.CONTEXT3D_CREATE,this.initStage3D);
            stage.stage3Ds[0].requestContext3D();
         }
         else
         {
            this.statusText = "No 3D support available :(";
            this._lockStatus = true;
         }
         this.initStage();
         this.initEvents();
         this.initExternalApi();
         this._lastFrameTime = getTimer();
      }
      
      public function initStage3D(param1:Event) : void
      {
         this._context = stage.stage3Ds[0].context3D;
         this._context.configureBackBuffer(stage.stageWidth,stage.stageHeight,!!this._params.cutout?0:2,true);
         if(!this._init)
         {
            this._camera = new Camera(this);
            if(this._viewerType == VIEWER_TOR)
            {
               this._mesh = new TorMesh(this._contentPath,this,this._params);
               this._mesh.load(this._modelType,this._model);
            }
            else if(this._viewerType == VIEWER_WOW)
            {
               this._mesh = new WowModel(this._contentPath,this,this._params);
               this._mesh.load(this._modelType,this._model);
            }
            else if(this._viewerType == VIEWER_LOL)
            {
               this._mesh = new LolMesh(this._contentPath,this,this._params);
               this._mesh.load(this._modelType,this._model);
            }
            else if(this._viewerType == VIEWER_GW2)
            {
               this._mesh = new Gw2Model(this._contentPath,this,this._params);
               this._mesh.load(this._modelType,this._model);
            }
            if(!this._params.cutout)
            {
               if(this._viewerType == VIEWER_LOL)
               {
                  this.LolkingBitmap = new this.LolkingPNG();
                  this._background = new EmbeddedBackground(this,this.LolkingBitmap);
               }
               else if(this._viewerType == VIEWER_GW2)
               {
                  this.GuildheadBitmap = new this.GuildheadPNG();
                  this._background = new EmbeddedBackground(this,this.GuildheadBitmap);
               }
               else if(this._params.background)
               {
                  this._background = new Background(this,this._params.background);
               }
            }
            if(ExternalInterface.available)
            {
               this._mesh.registerExternalInterface();
            }
         }
         else
         {
            this._mesh.refresh();
            if(this._background)
            {
               this._background.refresh();
            }
         }
         this._init = true;
      }
      
      public function initStage() : void
      {
         var _loc1_:String = null;
         this.FullscreenBitmap = new this.FullscreenPNG();
         this.WindowBitmap = new this.WindowPNG();
         this.FullscreenButton = new SimpleButton(this.FullscreenBitmap,this.FullscreenBitmap,this.FullscreenBitmap,this.FullscreenBitmap);
         this.FullscreenButton.width = 16;
         this.FullscreenButton.height = 16;
         this.FullscreenButton.x = stage.stageWidth - 21;
         this.FullscreenButton.y = 5;
         this.FullscreenButton.addEventListener(MouseEvent.CLICK,this.onFullscreenClick);
         this.FullscreenButton.visible = false;
         addChild(this.FullscreenButton);
         this.StatusText = new TextField();
         this.StatusText.name = "Loading";
         this.StatusText.defaultTextFormat = new TextFormat("Verdana",11,16777215,true);
         this.StatusText.width = stage.stageWidth - 8;
         this.StatusText.height = 20;
         this.StatusText.selectable = false;
         this.StatusText.multiline = true;
         this.StatusText.antiAliasType = "advanced";
         this.StatusText.text = this._statusText;
         this.StatusText.x = 4;
         this.StatusText.y = stage.stageHeight - this.StatusText.height;
         this.StatusText.visible = true;
         this.StatusText.filters = [new GlowFilter(4278190080,0.8,6,6,8,1)];
         addChild(this.StatusText);
         this.LabelLink = new TextField();
         this.LabelLink.width = stage.stageWidth - 8;
         this.LabelLink.height = 20;
         this.LabelLink.selectable = false;
         this.LabelLink.multiline = true;
         this.LabelLink.antiAliasType = "advanced";
         this.LabelLink.x = 4;
         this.LabelLink.y = stage.stageHeight - this.LabelLink.height;
         this.LabelLink.visible = true;
         this.LabelLink.filters = [new GlowFilter(4278190080,0.8,6,6,8,1)];
         if(this._params.link)
         {
            if(this._params.label)
            {
               _loc1_ = this._params.label;
            }
            else
            {
               _loc1_ = this._params.link;
            }
            this.LabelLink.htmlText = "<p align=\"right\"><font color=\"#c0c0c0\" face=\"Verdana\"><b><a href=\"" + this._params.link + "\" target=\"_blank\">" + _loc1_ + "</a></b></font></p>";
         }
         addChild(this.LabelLink);
      }
      
      public function initEvents() : void
      {
         stage.doubleClickEnabled = true;
         stage.addEventListener(MouseEvent.DOUBLE_CLICK,this.onFullscreenClick);
         stage.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         stage.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         stage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         stage.addEventListener(Event.RESIZE,this.onResize);
         stage.addEventListener(FullScreenEvent.FULL_SCREEN,this.onFullscreen);
         addEventListener(FileLoadEvent.LOAD_START,this.onLoadStart);
         addEventListener(FileLoadEvent.LOAD_COMPLETE,this.onLoadComplete);
         addEventListener(FileLoadEvent.LOAD_PROGRESS,this.onLoadProgress);
         addEventListener(FileLoadEvent.LOAD_ERROR,this.onLoadError);
         addEventListener(FileLoadEvent.LOAD_SECURITY_ERROR,this.onLoadError);
         addEventListener(Event.ENTER_FRAME,this.onRender);
      }
      
      public function initExternalApi() : void
      {
      }
      
      private function onRender(param1:Event) : void
      {
         if(!this._context)
         {
            return;
         }
         this._thisFrameTime = getTimer();
         this._delta = (this._thisFrameTime - this._lastFrameTime) / 1000;
         if(this._params.cutout)
         {
            this._context.clear(1,0,1);
         }
         else if(this._viewerType == VIEWER_GW2)
         {
            this._context.clear(0.055,0.047,0.039,1);
         }
         else
         {
            this._context.clear(0.1,0.1,0.1,1);
         }
         var _loc2_:int = this._mouseCurrX - this._mousePrevX;
         var _loc3_:int = this._mouseCurrY - this._mousePrevY;
         this._mousePrevX = this._mouseCurrX;
         this._mousePrevY = this._mouseCurrY;
         if(this._mouseControlDown)
         {
            this._camera.translate(0,_loc3_,_loc2_);
         }
         else if(this._mouseDown)
         {
            this._momentumX = _loc2_;
            this._momentumY = _loc3_;
         }
         else
         {
            this._momentumY = 0;
            if(Math.abs(this._momentumX) > 0.25)
            {
               this._momentumX = this._momentumX * 0.85;
            }
            else
            {
               this._momentumX = 0;
            }
         }
         if(this._momentumX != 0 || this._momentumY != 0)
         {
            this._camera.rotate(Math.PI * 2 * (this._momentumX / stage.stageWidth),Math.PI * 2 * (this._momentumY / stage.stageHeight));
         }
         else if(this._turnX != 0 || this._turnY != 0)
         {
            this._camera.rotate(Math.PI * 2 * (this._turnX / stage.stageWidth),Math.PI * 2 * (this._turnY / stage.stageHeight));
         }
         if(this._background)
         {
            this._background.render();
         }
         if(this._mesh)
         {
            this._mesh.update(this._delta);
            this._mesh.render(this._delta);
         }
         this._context.present();
         this._lastFrameTime = this._thisFrameTime;
      }
      
      private function onMouseDown(param1:MouseEvent) : void
      {
         if(param1.ctrlKey)
         {
            this._mouseControlDown = true;
         }
         else
         {
            this._mouseDown = true;
         }
      }
      
      private function onMouseUp(param1:MouseEvent) : void
      {
         this._mouseDown = this._mouseControlDown = false;
      }
      
      private function onMouseMove(param1:MouseEvent) : void
      {
         if(this._mousePrevX == -1)
         {
            this._mousePrevX = param1.stageX;
            this._mousePrevY = param1.stageY;
         }
         this._mouseCurrX = param1.stageX;
         this._mouseCurrY = param1.stageY;
      }
      
      private function onMouseWheel(param1:MouseEvent) : void
      {
         this._camera.translate(param1.delta > 0?Number(1):Number(-1),0,0);
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 37)
         {
            this._turnX = -7;
         }
         else if(param1.keyCode == 39)
         {
            this._turnX = 7;
         }
         else if(param1.keyCode == 40)
         {
            this._turnY = -7;
         }
         else if(param1.keyCode == 38)
         {
            this._turnY = 7;
         }
         else if(param1.keyCode == 65)
         {
            this._camera.translate(1,0,0);
         }
         else if(param1.keyCode == 90)
         {
            this._camera.translate(-1,0,0);
         }
      }
      
      private function onKeyUp(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 37)
         {
            this._turnX = 0;
         }
         else if(param1.keyCode == 39)
         {
            this._turnX = 0;
         }
         else if(param1.keyCode == 40)
         {
            this._turnY = 0;
         }
         else if(param1.keyCode == 38)
         {
            this._turnY = 0;
         }
      }
      
      private function onResize(param1:Event) : void
      {
         this.FullscreenButton.x = stage.stageWidth - 21;
         this.FullscreenButton.y = 5;
         this.FullscreenButton.visible = true;
         this.StatusText.y = stage.stageHeight - this.StatusText.height;
         this.LabelLink.y = stage.stageHeight - this.LabelLink.height;
         stage.stage3Ds[0].requestContext3D();
      }
      
      private function onFullscreen(param1:FullScreenEvent) : void
      {
         if(param1.fullScreen)
         {
            this.FullscreenButton.upState = this.WindowBitmap;
            this.FullscreenButton.downState = this.WindowBitmap;
            this.FullscreenButton.overState = this.WindowBitmap;
            this._fullscreen = true;
         }
         else
         {
            this.FullscreenButton.upState = this.FullscreenBitmap;
            this.FullscreenButton.downState = this.FullscreenBitmap;
            this.FullscreenButton.overState = this.FullscreenBitmap;
            this._fullscreen = false;
         }
         this.FullscreenButton.x = stage.stageWidth - 21;
         this.FullscreenButton.y = 5;
         this.StatusText.y = stage.stageHeight - this.StatusText.height;
         this.LabelLink.y = stage.stageHeight - this.LabelLink.height;
      }
      
      private function onFullscreenClick(param1:MouseEvent) : void
      {
         if(this._fullscreen)
         {
            stage.displayState = StageDisplayState.NORMAL;
         }
         else
         {
            stage.displayState = StageDisplayState.FULL_SCREEN;
         }
      }
      
      private function onLoadStart(param1:FileLoadEvent) : void
      {
         this._loadingFiles[param1.url] = [param1.currentBytes,param1.totalBytes];
         this.updateLoadingStatus();
      }
      
      private function onLoadComplete(param1:FileLoadEvent) : void
      {
         delete this._loadingFiles[param1.url];
         this.updateLoadingStatus();
      }
      
      private function onLoadProgress(param1:FileLoadEvent) : void
      {
         this._loadingFiles[param1.url] = [param1.currentBytes,param1.totalBytes];
         this.updateLoadingStatus();
      }
      
      private function onLoadError(param1:FileLoadEvent) : void
      {
         this.statusText = "Loading error :(";
         this._lockStatus = true;
      }
      
      private function updateLoadingStatus() : void
      {
         var _loc3_:* = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         for(_loc3_ in this._loadingFiles)
         {
            _loc1_ = _loc1_ + this._loadingFiles[_loc3_][0];
            _loc2_ = _loc2_ + this._loadingFiles[_loc3_][1];
         }
         if(_loc1_ != _loc2_)
         {
            this.statusText = "Loading... (" + Math.ceil(_loc1_ / _loc2_ * 100) + "%)";
         }
         else
         {
            this.statusText = "";
         }
      }
   }
}
