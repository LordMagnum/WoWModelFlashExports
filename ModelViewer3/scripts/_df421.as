package
{
   import flash.utils.ByteArray;
   
   public class _df421
   {
       
      
      public var _oo657:_jk827;
      
      public var _qo1316:_jk827;
      
      public var _uu348:_jk827;
      
      public var _vq1303:_jk827;
      
      public var flags:int;
      
      public var name:_jk827;
      
      public var _tn877:_jk827;
      
      public var _hj211:_jk827;
      
      public var _sg1148:_jk827;
      
      public var _rm489:_jk827;
      
      public var _ea1125:_jk827;
      
      public var materials:_jk827;
      
      public var attachments:_jk827;
      
      public var _nm696:_jk827;
      
      public var textures:_jk827;
      
      public var _yf1189:int;
      
      public var _cu907:int;
      
      public var _jt738:_jk827;
      
      public var _kc483:_jk827;
      
      public var _sf352:_jk827;
      
      public var version:int;
      
      public var _gu353:_jk827;
      
      public var _kj1244:_jk827;
      
      public var _gy438:_jk827;
      
      public var _gu635:_jk827;
      
      public var _hx1196:_jk827;
      
      public var _fl222:_jk827;
      
      public var _go854:_jk827;
      
      public var _sg291:_jk827;
      
      public var vertices:_jk827;
      
      public var _ur1351:_jk827;
      
      public var cameras:_jk827;
      
      public var _li993:_jk827;
      
      public var colors:_jk827;
      
      public function _df421(param1:ByteArray)
      {
         super();
         this._yf1189 = param1.readInt();
         this.version = param1.readInt();
         this.name = new _jk827(param1);
         this.flags = param1.readInt();
         this._li993 = new _jk827(param1);
         this._nm696 = new _jk827(param1);
         this._gu635 = new _jk827(param1);
         this._gy438 = new _jk827(param1);
         this._kj1244 = new _jk827(param1);
         this.vertices = new _jk827(param1);
         this._cu907 = param1.readInt();
         this.colors = new _jk827(param1);
         this.textures = new _jk827(param1);
         this._gu353 = new _jk827(param1);
         this._sg1148 = new _jk827(param1);
         this._ur1351 = new _jk827(param1);
         this.materials = new _jk827(param1);
         this._kc483 = new _jk827(param1);
         this._go854 = new _jk827(param1);
         this._hj211 = new _jk827(param1);
         this._sg291 = new _jk827(param1);
         this._uu348 = new _jk827(param1);
         param1.position = param1.position + 56;
         this._fl222 = new _jk827(param1);
         this._jt738 = new _jk827(param1);
         this._ea1125 = new _jk827(param1);
         this.attachments = new _jk827(param1);
         this._oo657 = new _jk827(param1);
         this._vq1303 = new _jk827(param1);
         this._tn877 = new _jk827(param1);
         this.cameras = new _jk827(param1);
         this._rm489 = new _jk827(param1);
         this._qo1316 = new _jk827(param1);
         this._hx1196 = new _jk827(param1);
         this._sf352 = new _jk827(param1);
      }
   }
}
