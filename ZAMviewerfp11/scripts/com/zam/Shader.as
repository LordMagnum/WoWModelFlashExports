package com.zam
{
   import com.adobe.utils.AGALMiniAssembler;
   import flash.display3D.Context3D;
   import flash.display3D.Program3D;
   import flash.utils.ByteArray;
   
   public class Shader
   {
       
      
      protected var _viewer:Viewer;
      
      protected var _program:Program3D = null;
      
      protected var _code:String = "";
      
      public function Shader(param1:Viewer)
      {
         super();
         this._viewer = param1;
      }
      
      public function get viewer() : Viewer
      {
         return this._viewer;
      }
      
      public function get camera() : Camera
      {
         return this._viewer.camera;
      }
      
      public function get context() : Context3D
      {
         return this._viewer.context;
      }
      
      public function get program() : Program3D
      {
         if(this._program == null)
         {
            this.upload();
         }
         return this._program;
      }
      
      protected function _vertexShader() : void
      {
      }
      
      protected function _fragmentShader() : void
      {
      }
      
      protected function op(param1:String) : void
      {
         this._code = this._code + (param1 + "\n");
      }
      
      protected function upload() : void
      {
         var assembler:AGALMiniAssembler = new AGALMiniAssembler(false);
         this._code = "";
         this._vertexShader();
         assembler.assemble("vertex",this._code);
         if(assembler.error)
         {
            return;
         }
         var vertexBytecode:ByteArray = assembler.agalcode;
         this._code = "";
         this._fragmentShader();
         assembler.assemble("fragment",this._code);
         if(assembler.error)
         {
            return;
         }
         var fragmentBytecode:ByteArray = assembler.agalcode;
         if(this._program != null)
         {
            this._program.dispose();
         }
         this._program = this.context.createProgram();
         try
         {
            this._program.upload(vertexBytecode,fragmentBytecode);
            return;
         }
         catch(err:Error)
         {
            return;
         }
      }
   }
}
