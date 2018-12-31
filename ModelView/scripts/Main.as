package
{
   import com.zam.Viewer;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.system.Security;
   
   public class Main extends Sprite
   {
       
      
      private var ZAMLogo:Class;
      
      public function Main()
      {
         var _loc3_:BitmapData = null;
         var _loc4_:MovieClip = null;
         this.ZAMLogo = Main_ZAMLogo;
         super();
         stage.quality = "low";
         stage.align = "TL";
         stage.scaleMode = "noScale";
         Security.allowDomain("*");
         var _loc1_:RegExp = /^http:\/\/.*\.(wowhead|allakhazam|thottbot)\.com\//i;
         if(!_loc1_.test(root.loaderInfo.url) && false)
         {
            trace("BUSTED");
            _loc3_ = (new this.ZAMLogo() as Bitmap).bitmapData;
            _loc4_ = new MovieClip();
            _loc4_.graphics.beginBitmapFill(_loc3_);
            _loc4_.graphics.drawRect(0,0,_loc3_.width,_loc3_.height);
            _loc4_.graphics.endFill();
            _loc4_.x = stage.stageWidth / 2 - _loc3_.width / 2;
            _loc4_.y = stage.stageHeight / 2 - _loc3_.height / 2;
            _loc4_.buttonMode = true;
            _loc4_.addEventListener("mouseDown",this.onLogoClick);
            addChild(_loc4_);
            return;
         }
         var _loc2_:Viewer = new Viewer(loaderInfo.parameters,root.loaderInfo.url);
         addChild(_loc2_);
      }
      
      private function onLogoClick(param1:Event) : void
      {
         navigateToURL(new URLRequest("http://www.zam.com"),"_self");
      }
   }
}
