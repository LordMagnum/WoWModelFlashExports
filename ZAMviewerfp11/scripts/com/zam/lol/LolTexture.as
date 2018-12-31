package com.zam.lol
{
   import com.zam.Viewer;
   import com.zam.ZamTexture;
   
   public class LolTexture extends ZamTexture
   {
       
      
      public function LolTexture(param1:Viewer, param2:String)
      {
         super(param1,"textures/" + param2);
      }
   }
}
