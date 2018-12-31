package
{
   import com.zam.Viewer;
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class Main extends Sprite
   {
       
      
      public function Main()
      {
         super();
         stage.align = "TL";
         stage.scaleMode = "noScale";
         Security.allowDomain("*");
         var _loc1_:Viewer = new Viewer(stage.loaderInfo.parameters,root.loaderInfo.url);
         addChild(_loc1_);
      }
   }
}
