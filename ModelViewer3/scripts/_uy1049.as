package
{
   import away3d.cameras.Camera3D;
   import away3d.containers.Scene3D;
   import away3d.containers.View3D;
   import away3d.core.base.Mesh;
   import away3d.core.render.IRenderer;
   import away3d.core.render.Renderer;
   import away3d.core.utils.Cast;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.filters.DropShadowFilter;
   import flash.geom.Matrix;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.system.Security;
   import flash.system.System;
   import flash.text.AntiAliasType;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.ui.ContextMenu;
   import flash.ui.ContextMenuItem;
   import flash.ui.Mouse;
   import flash.utils.getTimer;

   public class _uy1049 extends Sprite
   {
      public static var _ex830:Class = _uy1049__ex830;
      public static var loaded:Boolean = false;
      public static var _gm1176:Class = _uy1049__gm1176;
      public static var _mx832:Class = _uy1049__mx832;
      public static var _pj893:Class = _uy1049__pj893;
      public static var _tq844:Class = _uy1049__tq844;
      public static var _mx160:Number = 57.29578;
      public static var _ee1366:Class = _uy1049__ee1366;
      
      public static var _yd235:Class = _uy1049__yd235;
      
      public static var _xi50:int = 0;
      
      public static var _uw991:Class = _uy1049__uw991;
      
      public static var _na1287:Class = _uy1049__na1287;
      
      public static var _pd321:Class = _uy1049__pd321;
      
      public static var _wj502:Class = _uy1049__wj502;
      
      public static var _ra85:Class = _uy1049__ra85;
      
      public static var _ao367:Class = _uy1049__ao367;
      
      public static var _vr793:Class = _uy1049__vr793;
      
      public static var _mj237:int = 24;
      
      public static var _na460:Class = _uy1049__na460;
      
      public static var _kd1008:String;
      
      public static var _bw216:Class = _uy1049__bw216;
      
      public static var _sk609:int = 1;
      
      private static var _vv367:int = 240;
      
      public static var _un849:int = 0;
      
      public static var _ec502:Class = _uy1049__ec502;
      
      public static var _di927:int = 0;
      
      public static var _gk1266:Class = _uy1049__gk1266;
      
      public static var _ny1196:Class = _uy1049__ny1196;
      
      public static var _cl963:Class = _uy1049__cl963;
      
      public static var _ur546:Class = _uy1049__ur546;
      
      public static var _qp802:int = 208;
      
      public static var _wu659:Class = _uy1049__wu659;
      
      public static var _vv949:Class = _uy1049__vv949;
      
      public static var _dt494:String = "Loading...";
      
      public static var _mi738:Class = _uy1049__mi738;
      
      public static var _fe74:Class = _uy1049__fe74;
      
      public static var _kg1119:Class = _uy1049__kg1119;
      
      public static var _lx175:Class = _uy1049__lx175;
      
      public static var _gk1150:int = 216;
      
      public static var _ns1004:String = null;
      
      public static var _bm1164:Class = _uy1049__bm1164;
      
      public static var _io285:Class = _uy1049__io285;
      
      public static var _jv1004:Number = 0.2;
      
      public static var _yi735:Class = _uy1049__yi735;
      
      public static var _gb150:Number = -1.1;
      
      public static var _ct1313:int = int.MAX_VALUE;
      
      public static var _hd132:int = 336;
      
      public static var _xe578:Class = _uy1049__xe578;
      
      public static var _cy597:Class = _uy1049__cy597;
      
      public static var _pw1071:Class = _uy1049__pw1071;
      
      public static var _wv1127:Boolean = false;
      
      public static var _ku559:Number = 114.59;
      
      public static var _bk856:Class = _uy1049__bk856;
      
      public static var _yi1279:Class = _uy1049__yi1279;
      
      public static var _rq276:Class = _uy1049__rq276;
      
      public static var _lo931:Class = _uy1049__lo931;
      
      public static var _fi431:Class = _uy1049__fi431;
      
      private static var _br929:int = 60;
      
      public static var _mt624:Class = _uy1049__mt624;
      
      public static var _nw498:Class = _uy1049__nw498;
      
      public static var _vw814:TextField;
      
      public static var _se1258:Class = _uy1049__se1258;
      
      public static var _rg255:Class = _uy1049__rg255;
      
      public static var _tf685:Class = _uy1049__tf685;
      
      public static var _jq1348:Number = 0;
      
      public static var _jy1225:Number = -2;
      
      public static var _fb45:Class = _uy1049__fb45;
      
      public static var _na287:Class = _uy1049__na287;
      
      public static var _dx766:Class = _uy1049__dx766;
      
      public static var _va1045:Class = _uy1049__va1045;
      
      public static var _ci257:Boolean = false;
      
      private static var _rd1161:Number = 1;
      
      public static var _xf1224:int = 1;
      
      public static var _tr425:Class = _uy1049__tr425;
      
      public static var _ng157:Class = _uy1049__ng157;
      
      public static var _ei1096:int = 208;
      
      public static var _mu1014:Class = _uy1049__mu1014;
      
      public static var _ny105:int = -1;
      
      public static var _nb1256:Boolean = false;
      
      public static var _st141:Class = _uy1049__st141;
      
      public static var _lq116:Class = _uy1049__lq116;
      
      public static var _ah349:_kp1215;
      
      public static var _uo1157:String;
      
      public static var _nd462:Class = _uy1049__nd462;
      
      public static var _ty1242:Class = _uy1049__ty1242;
      
      public static var _sa313:Class = _uy1049__sa313;
      
      public static var _sd1383:Class = _uy1049__sd1383;
      
      public static var _en1111:Class = _uy1049__en1111;
      
      public static var _ms348:Class = _uy1049__ms348;
      
      public static var _sh1146:Class = _uy1049__sh1146;
      
      public static var _wp900:Number = -12;
      
      public static var _cx881:Class = _uy1049__cx881;
      
      public static var _cf339:Class = _uy1049__cf339;
      
      public static var _tq488:Class = _uy1049__tq488;
      
      public static var _mm1049:int = 0;
      
      public static var _is1127:int = 2;
      
      public static var _ga1265:int = 16;
      
      public static var _hj984:Number = 0.003;
      
      public static var _sv469:Class = _uy1049__sv469;
      
      public static var _og88:int = 0;
      
      public static var _mg1333:int = 0;
      
      public static var _uv1372:int = 1000;
      
      public static var _vw1363:Class = _uy1049__vw1363;
      
      public static var _ja764:Class = _uy1049__ja764;
      
      public static var _am1130:Class = _uy1049__am1130;
      
      public static var _hk284:int = 30000;
      
      public static var _bm1324:Number = 1;
      
      public static var _gw1310:Class = _uy1049__gw1310;
      
      public static var _kt737:int = _sk609;
      
      public static var _ci1061:Number = 600;
      
      public static var _kj1282:Class = _uy1049__kj1282;
      
      public static var _hi1359:Class = _uy1049__hi1359;
      
      public static var _dt423:Class = _uy1049__dt423;
      
      public static var _ir724:Class = _uy1049__ir724;
      
      public static var _dt542:Class = _uy1049__dt542;
      
      public static var _vw418:Class = _uy1049__vw418;
       
      
      public var _ft713:TextField;
      
      public var _sc1263:Bitmap;
      
      public var _tk1335:Boolean = false;
      
      public var _av781:Bitmap;
      
      public var _kc785:int = 1200;
      
      public var _rl439:Bitmap;
      
      public var _lh918:Boolean = false;
      
      public var _ac1326:_ak914;
      
      public var _xl958:Number;
      
      public var _yq1210:Bitmap;
      
      public var _rx405:SimpleButton;
      
      public var _vq453:_bd638;
      
      public var _wh203:_bd638;
      
      public var _kq1273:Bitmap;
      
      public var _ij358:int = 0;
      
      public var _rs1091:Number = 0.0;
      
      public var _md137:Bitmap;
      
      private var _ei1265:IRenderer;
      
      public var _dp547:Number = 0;
      
      public var _cb126:Bitmap;
      
      public var _lf407:Bitmap;
      
      public var _rw582:uint = 16777215;
      
      private var scene:Scene3D;
      
      public var _px711:Bitmap;
      
      public var _td1293:_gs89;
      
      public var _mt713:_ap1178;
      
      public var _gd1062:Bitmap;
      
      public var _di805:int = 0;
      
      public var _tn373:Bitmap;
      
      public var _ax884:Bitmap;
      
      public var _ea14:Bitmap;
      
      public var _um1051:Bitmap;
      
      public var _xj580:Bitmap;
      
      public var _he1185:Boolean = false;
      
      public var _id725:Number = 100;
      
      public var _nw802:Bitmap;
      
      public var _io608:Boolean = false;
      
      public var _mj838:Boolean = false;
      
      public var _sb154:Array;
      
      public var _or1402:SimpleButton;
      
      public var _cp665:Number = 0.0;
      
      public var _sa186:Sprite;
      
      public var _pe1362:Bitmap;
      
      public var _iv124:_bx752;
      
      public var _yy754:SimpleButton;
      
      public var _lj16:int = 0;
      
      public var _sw1410:String = null;
      
      public var _yl109:_pc1306;
      
      public var _ma918:Number;
      
      public var _fi565:BitmapData;
      
      public var _xt155:Bitmap;
      
      public var _ww743:Boolean = false;
      
      public var _kj51:int = 0;
      
      public var _nj1353:Boolean = false;
      
      public var _fa601:Bitmap;
      
      public var _sp553:Boolean = false;
      
      public var _il1124:Boolean = false;
      
      private var _fq296:IRenderer;
      
      public var _gs1188:String;
      
      public var _th635:_vq97;
      
      public var paused:Boolean = false;
      
      public var _cm298:Bitmap;
      
      public var _ov543:Bitmap;
      
      public var _gi1348:Number = 0.0;
      
      public var loadingBar:_pe804;
      
      public var _lh1025:_ap1178;
      
      public var _xm1303:Bitmap;
      
      public var _ug475:Bitmap;
      
      public var _tr1149:Bitmap;
      
      public var _bf749:Bitmap;
      
      public var _kg1282:Boolean = false;
      
      public var _oq91:Boolean = false;
      
      public var rotate:Number = 0.0;
      
      public var _qn310:Bitmap;
      
      public var _pc1316:Bitmap;
      
      public var scale:Number;
      
      public var _qd415:int = 0;
      
      public var stageWidth:int = 321;
      
      public var _kp570:Bitmap;
      
      public var _kn165:_bx752;
      
      public var _rh1184:Number = 100;
      
      public var _ek736:TextField;
      
      public var _fo1210:Bitmap;
      
      public var _fa511:Boolean = true;
      
      public var _uk735:Bitmap;
      
      private var _rg1394:Number;
      
      public var _uq285:Bitmap;
      
      public var _gx760:SimpleButton;
      
      public var _hx320:Number = 1.0;
      
      public var _fp1150:Boolean = false;
      
      public var _bb1238:Bitmap;
      
      public var _xb571:Sprite;
      
      public var _tk821:_bd638;
      
      public var _ap1323:Bitmap;
      
      public var _cs1104:Number = 0.0;
      
      public var _xf1386:Bitmap;
      
      public var _uc1291:Bitmap;
      
      public var _fa1088:Bitmap;
      
      private var _ya170:Boolean = false;
      
      public var stageHeight:int = 444;
      
      public var _gx659:Bitmap;
      
      public var _nb987:String = null;
      
      public var _fl535:Number = 1.0;
      
      public var _pm1194:int = -1;
      
      public var _ui1229:Number;
      
      public var _rc166:Bitmap;
      
      private var _ao692:Number;
      
      public var _ok11:Bitmap;
      
      public var _lv1358:ContextMenuItem;
      
      public var _is815:BitmapData;
      
      public var _ei117:Bitmap;
      
      private var _ol1093:Number = -122.5;
      
      public var _ic370:Bitmap;
      
      public var _bp233:Bitmap;
      
      public var _gj173:Boolean = false;
      
      public var _nu123:Boolean = false;
      
      public var _ho543:Number = 0.0;
      
      public var _xp992:Boolean = false;
      
      public var _so1024:Boolean = false;
      
      public var _xr932:Boolean = false;
      
      public var _eo90:String;
      
      public var _qt1122:_gs89;
      
      public var _yd352:_pc1306;
      
      public var _mt484:Boolean = false;
      
      public var _jt840:Boolean = false;
      
      public var _of813:Bitmap = null;
      
      public var _aa1050:ContextMenuItem;
      
      public var _de1189:int = 0;
      
      public var _oa138:Boolean = false;
      
      public var _nv596:Number;
      
      public var forwardButton:_bd638;
      
      public var _pp777:String = null;
      
      public var _sn1000:Sprite = null;
      
      public var _om92:int = 0;
      
      public var _xl1357:Bitmap;
      
      public var _mb876:int = 0;
      
      public var _sa64:Bitmap;
      
      public var _cr1002:Number = 50;
      
      public var _vy751:Boolean = false;
      
      public var _db960:Bitmap;
      
      public var _eb641:Bitmap;
      
      public var _nd623:Boolean = false;
      
      public var _bt516:Sprite;
      
      public var _ir778:Bitmap;
      
      public var _bk709:Number = 0.6;
      
      public var _xk1217:int = 0;
      
      public var _wr1342:Bitmap;
      
      public var _lk541:Bitmap;
      
      public var _tx1296:Number = 0.0;
      
      public var _yh872:int;
      
      public var _hy1050:ContextMenuItem;
      
      public var _ob1075:Bitmap;
      
      public var _mx400:Bitmap;
      
      public var _my619:_pc1306;
      
      private var view:View3D;
      
      public var _nm696:Array;
      
      public var _fe732:Bitmap;
      
      public var _mh80:_bd638;
      
      public var _cy1341:Bitmap;
      
      public var _br1077:Boolean = false;
      
      public var _fa379:Sprite;
      
      public var _ph969:Bitmap;
      
      public var _yg436:Bitmap;
      
      public var _vr1290:int = -1;
      
      public var _bx1001:Boolean;
      
      public var _ey27:int = 1600;
      
      public var _hc289:Bitmap;
      
      public var _ej281:_ke291;
      
      public var fullScreenButton:_bd638;
      
      public var _ud738:Bitmap;
      
      public var _as418:Bitmap;
      
      public var _aw1027:Boolean = false;
      
      public var _vt74:Number;
      
      public var _kj209:Bitmap;
      
      public var _yf480:Number;
      
      public var _bf176:Number = 0;
      
      public var _jh356:Boolean = false;
      
      public var _hj812:Bitmap;
      
      public var _ji689:_px688;
      
      public var _uo1367:TextField;
      
      public var _ys660:_ap1178;
      
      public var _uq924:_gf927;
      
      private var camera:Camera3D;
      
      public var model:_hg665;
      
      public var _ks1389:ContextMenuItem;
      
      public var _oy1063:String;
      
      public var character:String;
      
      private var _dc992:Number;
      
      public var _un423:Bitmap;
      
      public var timer:int = 0;
      
      public var _af1010:Bitmap;
      
      public var _md1222:Bitmap;
      
      public var _ik608:Bitmap;
      
      public var _wf672:Boolean = true;
      
      public var _aw812:Bitmap;
      
      public var _he1319:Number = 1.0;
      
      public var _ba873:Boolean = false;
      
      public var _kr1255:Bitmap;
      
      public var _ow1011:ContextMenuItem;
      
      public var _ix1397:Number = 2.0;
      
      private var _ky964:Number;
      
      public var _gf210:_pc1306;
      
      public var _pw37:Bitmap;
      
      public var _tl596:Number = 1.0;
      
      public var _vc262:Bitmap;
      
      public var _tt1216:_pc1306;
      
      public var _dk154:Number;
      
      public var _jx729:Bitmap;
      
      public var _ce85:Number;
      
      public var _xs316:Number;
      
      public var _is243:Number = 0;
      
      public var _jx610:Bitmap;
      
      public var dirty:Boolean = false;
      
      public var zoom:Number = 1.0;
      
      public var fullScreen:Boolean = false;
      
      public var _sj1329:SimpleButton;
      
      public var _in1348:Boolean = false;
      
      public var _es1065:_bx752;
      
      public var _bk213:Number;
      
      public var _mo573:Bitmap;
      
      public var _tq714:Boolean = false;
      
      public function _uy1049()
      {
         this._fq296 = Renderer.CORRECT_Z_ORDER;
         this._ei1265 = Renderer.BASIC;
         this._qt1122 = new _gs89(0,0,-1);
         this._td1293 = new _gs89(1,0,0);
         this.scale = _ci1061;
         super();
         this.init();
      }
      
      public static function _uy173() : int
      {
         return getTimer();
      }
      
      public function _wh541(param1:Event) : void
      {
         var _loc2_:XML = new XML(param1.target.data);
         if(_loc2_)
         {
            _tm178.init(_loc2_);
         }
         _wv1127 = true;
      }
      
      public function _cp17(param1:Event) : void
      {
         this._tk1335 = !this._tk1335;
         if(this._tk1335)
         {
            this._vq453._qq703 = this._vc262;
         }
         else
         {
            this._vq453._qq703 = this._fa601;
         }
         this._vq453.reset();
      }
      
      public function _pv71(param1:Event) : void
      {
         System.setClipboard(this._gs1188);
         this._ft713.visible = true;
      }
      
      public function _ri298(param1:_ke291) : void
      {
         var _loc9_:_bs710 = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:TextField = null;
         var _loc15_:TextField = null;
         var _loc16_:TextField = null;
         var _loc17_:TextField = null;
         var _loc18_:Bitmap = null;
         var _loc19_:Bitmap = null;
         var _loc20_:Bitmap = null;
         var _loc21_:Bitmap = null;
         var _loc22_:Bitmap = null;
         var _loc23_:Bitmap = null;
         var _loc24_:Bitmap = null;
         var _loc25_:Bitmap = null;
         var _loc26_:Array = null;
         var _loc27_:int = 0;
         var _loc29_:_vq97 = null;
         var _loc34_:int = 0;
         var _loc35_:_vq97 = null;
         var _loc37_:Mesh = null;
         var _loc38_:TextFormat = null;
         var _loc39_:TextField = null;
         var _loc40_:SimpleButton = null;
         var _loc41_:SimpleButton = null;
         var _loc42_:TextFormat = null;
         var _loc43_:TextFormat = null;
         var _loc44_:TextFormat = null;
         var _loc45_:TextField = null;
         var _loc46_:TextField = null;
         var _loc47_:int = 0;
         var _loc48_:TextField = null;
         this.model = param1._et516();
         this._nm696 = param1._vu576();
         this._sb154 = param1._ch1297();
         this._bx1001 = param1._tg728;
         this._dk154 = this._nv596 = param1._dk154;
         this._ui1229 = this._ce85 = param1._ui1229;
         this._xl958 = param1._kg1025;
         this._in1348 = param1._in1348;
         this._sp553 = param1._sp553;
         this._aw1027 = false;
         this._ww743 = false;
         if(this.model && this.model.meshes)
         {
            for each(_loc37_ in this.model.meshes)
            {
               if(_loc37_)
               {
                  this.scene.addChild(_loc37_);
               }
            }
         }
         this.dirty = true;
         this._xp992 = true;
         this._ij358 = _uv1372;
         this.paused = true;
         if(!_nb1256)
         {
            removeChild(this.loadingBar);
            this.loadingBar = null;
         }
         this._ej281.release();
         this._ej281 = null;
         this._sc1263 = new Bitmap(Cast.bitmap(_pw1071));
         this._cy1341 = new Bitmap(Cast.bitmap(_bw216));
         this._sa64 = new Bitmap(Cast.bitmap(_io285));
         this._bp233 = new Bitmap(Cast.bitmap(_na287));
         this._ov543 = new Bitmap(Cast.bitmap(_pj893));
         this._hc289 = new Bitmap(Cast.bitmap(_st141));
         this._xj580 = new Bitmap(Cast.bitmap(_sa313));
         this._mx400 = new Bitmap(Cast.bitmap(_cy597));
         this._rl439 = new Bitmap(Cast.bitmap(_uw991));
         this._lk541 = new Bitmap(Cast.bitmap(_nd462));
         this._ic370 = new Bitmap(Cast.bitmap(_vw418));
         this._rc166 = new Bitmap(Cast.bitmap(_dt542));
         this._as418 = new Bitmap(Cast.bitmap(_mu1014));
         this._gd1062 = new Bitmap(Cast.bitmap(_bk856));
         this._bf749 = new Bitmap(Cast.bitmap(_ur546));
         this._yq1210 = new Bitmap(Cast.bitmap(_dt423));
         this._pw37 = new Bitmap(Cast.bitmap(_rq276));
         this._eb641 = new Bitmap(Cast.bitmap(_ty1242));
         this._lf407 = new Bitmap(Cast.bitmap(_gw1310));
         this._aw812 = new Bitmap(Cast.bitmap(_vv949));
         this._af1010 = new Bitmap(Cast.bitmap(_rg255));
         this._uk735 = new Bitmap(Cast.bitmap(_kj1282));
         this._ei117 = new Bitmap(Cast.bitmap(_tq488));
         this._yg436 = new Bitmap(Cast.bitmap(_bm1164));
         this._pc1316 = new Bitmap(Cast.bitmap(_yi735));
         this._un423 = new Bitmap(Cast.bitmap(_se1258));
         this._ir778 = new Bitmap(Cast.bitmap(_en1111));
         this._tr1149 = new Bitmap(Cast.bitmap(_ny1196));
         this._fe732 = new Bitmap(Cast.bitmap(_fb45));
         this._gx659 = new Bitmap(Cast.bitmap(_yd235));
         this._wr1342 = new Bitmap(Cast.bitmap(_ja764));
         this._md1222 = new Bitmap(Cast.bitmap(_lq116));
         this._db960 = new Bitmap(Cast.bitmap(_ec502));
         this._jx610 = new Bitmap(Cast.bitmap(_ex830));
         this._ik608 = new Bitmap(Cast.bitmap(_vw1363));
         this._ph969 = new Bitmap(Cast.bitmap(_wj502));
         this._ph969 = new Bitmap(Cast.bitmap(_wj502));
         this._kq1273 = new Bitmap(Cast.bitmap(_pd321));
         this._ud738 = new Bitmap(Cast.bitmap(_mt624));
         if(!this._nj1353)
         {
            this._xl1357 = new Bitmap(Cast.bitmap(_cf339));
            this._cb126 = new Bitmap(Cast.bitmap(_fe74));
            this._kj209 = new Bitmap(Cast.bitmap(_cx881));
         }
         this._ax884 = new Bitmap(Cast.bitmap(_na1287));
         this._kp570 = new Bitmap(Cast.bitmap(_yi1279));
         this._tn373 = new Bitmap(Cast.bitmap(_sv469));
         this._cm298 = new Bitmap(Cast.bitmap(_am1130));
         this._mo573 = new Bitmap(Cast.bitmap(_ir724));
         this._fa1088 = new Bitmap(Cast.bitmap(_ao367));
         this._fa601 = new Bitmap(Cast.bitmap(_cl963));
         this._vc262 = new Bitmap(Cast.bitmap(_kg1119));
         this._qn310 = new Bitmap(Cast.bitmap(_hi1359));
         this._ok11 = new Bitmap(Cast.bitmap(_ng157));
         this._kr1255 = new Bitmap(Cast.bitmap(_lo931));
         this._xt155 = new Bitmap(Cast.bitmap(_ra85));
         this._um1051 = new Bitmap(Cast.bitmap(_tq844));
         this._ob1075 = new Bitmap(Cast.bitmap(_lx175));
         this._ug475 = new Bitmap(Cast.bitmap(_tr425));
         this._uc1291 = new Bitmap(Cast.bitmap(_na460));
         this._jx729 = new Bitmap(Cast.bitmap(_tf685));
         this._px711 = new Bitmap(Cast.bitmap(_mx832));
         this._ea14 = new Bitmap(Cast.bitmap(_wu659));
         this._fo1210 = new Bitmap(Cast.bitmap(_xe578));
         this._ap1323 = new Bitmap(Cast.bitmap(_nw498));
         this._sa186 = new _bx752(false,_qp802,_ei1096);
         this._bt516 = new _bx752(true,_hd132,_gk1150);
         this._sa186.visible = false;
         this._bt516.visible = false;
         var _loc2_:TextFormat = new TextFormat("calibri",18);
         var _loc3_:TextFormat = new TextFormat("calibri",24);
         var _loc4_:TextField = new TextField();
         _loc4_.width = this._bt516.width - 2 * _mj237;
         _loc4_.height = 40;
         _loc4_.textColor = 16771584;
         _loc4_.selectable = false;
         _loc4_.text = _tm178.get("backgroundHeader");
         _loc4_.setTextFormat(_loc3_);
         var _loc5_:TextField = new TextField();
         _loc5_.width = this._bt516.width - 2 * _mj237;
         _loc5_.height = 40;
         _loc5_.textColor = 16771584;
         _loc5_.selectable = false;
         _loc5_.text = _tm178.get("qualityHeader");
         _loc5_.setTextFormat(_loc3_);
         var _loc6_:TextField = new TextField();
         _loc6_.x = _ga1265;
         _loc6_.y = _ga1265 / 2;
         _loc6_.width = this._sa186.width - 2 * _ga1265;
         _loc6_.height = 30;
         _loc6_.textColor = 16771584;
         _loc6_.selectable = false;
         _loc6_.text = _tm178.get("equipmentHeader");
         _loc6_.setTextFormat(_loc2_);
         this._ys660 = new _ap1178();
         this._ys660._xx1191 = this._sp553;
         this._lh1025 = new _ap1178();
         this._lh1025._xx1191 = this._in1348;
         this._mt713 = new _ap1178();
         this._mt713._xx1191 = this._fa511;
         this._ys660.addEventListener(MouseEvent.MOUSE_DOWN,this._dy1356,false,0,true);
         this._lh1025.addEventListener(MouseEvent.MOUSE_DOWN,this._dy1356,false,0,true);
         this._mt713.addEventListener(MouseEvent.MOUSE_DOWN,this._dy1356,false,0,true);
         var _loc7_:Array = [_tm178.get("lowQuality"),_tm178.get("mediumQuality"),_tm178.get("highQuality")];
         this._tt1216 = new _pc1306(false,_loc7_,this._gq1185);
         this._tt1216.value = _kt737;
         this._yd352 = new _pc1306(true,_loc7_,this._gq1185);
         this._yd352.value = _kt737;
         var _loc8_:Array = [];
         for each(_loc9_ in this._sb154)
         {
            _loc8_.push(_tm178.get(_loc9_.name));
         }
         this._my619 = new _pc1306(true,_loc8_,this._oq210);
         this._my619.value = 0;
         this._ys660.x = _ga1265;
         this._lh1025.x = _ga1265;
         this._mt713.x = _ga1265;
         this._ys660.y = _loc6_.height + _ga1265 / 2;
         this._lh1025.y = this._ys660.y + this._ys660.height + 10;
         this._mt713.y = this._lh1025.y + this._lh1025.height + 10;
         _loc10_ = _qp802 - 4 * _ga1265 - this._ys660.width;
         _loc11_ = this._ys660.height;
         _loc12_ = 2 * _ga1265 + this._ys660.width;
         _loc13_ = this._ys660.y;
         _loc14_ = new TextField();
         _loc14_.x = _loc12_;
         _loc14_.y = _loc13_;
         _loc14_.width = _loc10_;
         _loc14_.height = _loc11_;
         _loc14_.textColor = 16777215;
         _loc14_.selectable = false;
         _loc14_.text = _tm178.get("showHelmet");
         _loc13_ = _loc13_ + (_loc11_ + 10);
         _loc15_ = new TextField();
         _loc15_.x = _loc12_;
         _loc15_.y = _loc13_;
         _loc15_.width = _loc10_;
         _loc15_.height = _loc11_;
         _loc15_.textColor = 16777215;
         _loc15_.selectable = false;
         _loc15_.text = _tm178.get("showCloak");
         _loc13_ = _loc13_ + (_loc11_ + 10);
         _loc16_ = new TextField();
         _loc16_.x = _loc12_;
         _loc16_.y = _loc13_;
         _loc16_.width = _loc10_;
         _loc16_.height = _loc11_;
         _loc16_.textColor = 16777215;
         _loc16_.selectable = false;
         _loc16_.text = _tm178.get("showTabard");
         _loc13_ = _loc13_ + (_loc11_ + 10);
         _loc17_ = new TextField();
         _loc17_.x = _ga1265;
         _loc17_.y = _loc13_;
         _loc17_.width = this._sa186.width - 2 * _ga1265;
         _loc17_.height = 24;
         _loc17_.textColor = 16771584;
         _loc17_.selectable = false;
         _loc17_.text = _tm178.get("qualityHeader");
         _loc17_.setTextFormat(_loc2_);
         _loc13_ = _loc13_ + (_loc17_.height + _ga1265 / 2);
         this._tt1216.x = (this._sa186.width - this._tt1216.width) / 2;
         this._tt1216.y = _loc13_;
         _loc4_.x = _mj237;
         _loc4_.y = _mj237 / 2;
         this._my619.x = (_hd132 - this._my619.width) / 2;
         this._my619.y = _loc4_.y + _loc4_.height;
         _loc5_.x = _mj237;
         _loc5_.y = this._my619.y + this._my619.height;
         this._yd352.x = (_hd132 - this._yd352.width) / 2;
         this._yd352.y = _loc5_.y + _loc5_.height;
         _loc18_ = new Bitmap(Cast.bitmap(_gk1266));
         _loc19_ = new Bitmap(Cast.bitmap(_ee1366));
         _loc20_ = new Bitmap(Cast.bitmap(_dx766));
         _loc21_ = new Bitmap(Cast.bitmap(_fi431));
         _loc22_ = new Bitmap(Cast.bitmap(_ms348));
         _loc23_ = new Bitmap(Cast.bitmap(_va1045));
         _loc24_ = new Bitmap(Cast.bitmap(_gm1176));
         _loc25_ = new Bitmap(Cast.bitmap(_sd1383));
         _loc26_ = [_loc18_,_loc19_,_loc20_,_loc21_,_loc22_,_loc23_,_loc24_,_loc25_];
         this._ac1326 = new _ak914(_loc26_,120);
         _loc27_ = this.stageHeight - 40;
         this._yy754 = new SimpleButton();
         this._yy754.x = 46;
         this._yy754.y = _loc27_;
         this._yy754.upState = this._yy754.hitTestState = this._ir778;
         this._yy754.downState = this._fe732;
         this._yy754.overState = this._tr1149;
         this._wh203 = new _bd638(this._ph969,this._kq1273,this._ud738,this._ph969,this._lk541,this._ic370,this._rc166,this._lk541);
         this.forwardButton = new _bd638(this._db960,this._jx610,this._ik608,this._db960,this._xj580,this._mx400,this._rl439,this._xj580);
         this._rx405 = new SimpleButton();
         this._rx405.upState = this._rx405.hitTestState = this._ax884;
         this._rx405.downState = this._tn373;
         this._rx405.overState = this._kp570;
         if(!this._nj1353)
         {
            this._or1402 = new SimpleButton();
            if(this._bx1001)
            {
               this._or1402.upState = this._or1402.hitTestState = this._xl1357;
               this._or1402.downState = this._kj209;
               this._or1402.overState = this._cb126;
            }
            else
            {
               this._or1402.upState = this._or1402.downState = this._or1402.overState = this._or1402.hitTestState = new Bitmap(Cast.bitmap(_vr793));
            }
         }
         this.fullScreenButton = new _bd638(this._cm298,this._mo573,this._fa1088,this._cm298,this._lf407,this._aw812,this._af1010,this._lf407);
         this._vq453 = new _bd638(this._fa601,this._vc262,this._qn310,this._fa601,this._uk735,this._ei117,this._yg436,this._uk735);
         this._sj1329 = new SimpleButton();
         this._sj1329.x = this.stageWidth - 10 - this._uc1291.width;
         this._sj1329.y = 10;
         this._sj1329.upState = this._sj1329.downState = this._sj1329.overState = this._sj1329.hitTestState = this._uc1291;
         this._gx760 = new SimpleButton();
         this._gx760.x = this.stageWidth - 10 - this._uc1291.width;
         this._gx760.y = 20 + this._uc1291.height;
         this._gx760.upState = this._gx760.downState = this._gx760.overState = this._gx760.hitTestState = this._ea14;
         this._tk821 = new _bd638(this._ok11,this._kr1255,this._xt155,this._ok11,this._as418,this._gd1062,this._bf749,this._as418);
         this._mh80 = new _bd638(this._um1051,this._ob1075,this._ug475,this._um1051,this._yq1210,this._pw37,this._eb641,this._yq1210);
         this._uq924 = new _gf927(160,32,this._nm696);
         var _loc28_:Array = [];
         for each(_loc29_ in this._nm696)
         {
            _loc28_.push(_tm178.get(_loc29_.name));
         }
         this._yl109 = new _pc1306(true,_loc28_,this._io860);
         this._gf210 = new _pc1306(false,_loc28_,this._io860);
         if(this.character)
         {
            this._uo1367 = new TextField();
            this._uo1367.text = this.character;
            this._uo1367.width = _vv367;
            this._uo1367.height = _br929;
            this._uo1367.antiAliasType = AntiAliasType.ADVANCED;
            _loc38_ = new TextFormat("calibri",36,16770048,false,false,false,null,null,"center");
            this._uo1367.setTextFormat(_loc38_);
            this._uo1367.selectable = false;
            this._ek736 = new TextField();
            this._ek736.text = this.character;
            this._ek736.width = _vv367;
            this._ek736.height = _br929;
            _loc38_ = new TextFormat("calibri",36,0,false,false,false,null,null,"center");
            this._ek736.setTextFormat(_loc38_);
         }
         this._ji689 = new _px688(false,60,60);
         this._ji689._ay708(this);
         addChild(this._yy754);
         addChild(this.forwardButton);
         addChild(this._wh203);
         if(!this._nj1353)
         {
            addChild(this._or1402);
         }
         addChild(this.fullScreenButton);
         addChild(this._vq453);
         addChild(this._sj1329);
         addChild(this._gx760);
         addChild(this._tk821);
         addChild(this._mh80);
         addChild(this._gf210);
         addChild(this._yl109);
         addChild(this._sa186);
         addChild(this._bt516);
         addChild(this._ji689);
         this._lo467(-1);
         this._yy754.addEventListener(MouseEvent.CLICK,this._vx302);
         this.forwardButton.addEventListener(MouseEvent.MOUSE_DOWN,this._yl1177);
         this._wh203.addEventListener(MouseEvent.MOUSE_DOWN,this._ka1372);
         this.fullScreenButton.addEventListener(MouseEvent.CLICK,this._sv1085);
         this._vq453.addEventListener(MouseEvent.CLICK,this._cp17);
         this._tk821.addEventListener(MouseEvent.MOUSE_DOWN,this._ph492);
         this._mh80.addEventListener(MouseEvent.MOUSE_DOWN,this._yd156);
         this._sj1329.addEventListener(MouseEvent.MOUSE_DOWN,this._ky965);
         this._gx760.addEventListener(MouseEvent.MOUSE_DOWN,this._mt1369);
         if(!this._nj1353)
         {
            if(this._bx1001)
            {
               this._or1402.addEventListener(MouseEvent.MOUSE_DOWN,this._fo1097);
            }
            else
            {
               _loc39_ = new TextField();
               _loc39_.x = 10;
               _loc39_.y = 7;
               _loc39_.width = 96;
               _loc39_.text = _tm178.get("loginToPose");
               _loc39_.wordWrap = true;
               _loc39_.selectable = false;
               _loc39_.textColor = 16777215;
               _loc39_.height = _loc39_.textHeight + 10;
               this._iv124 = new _bx752(false,112,_loc39_.textHeight + 14);
               this._iv124.addChild(_loc39_);
               addChild(this._iv124);
               this._iv124.visible = false;
               this._or1402.addEventListener(MouseEvent.MOUSE_OVER,this._kl933,false,0,true);
               this._or1402.addEventListener(MouseEvent.MOUSE_OUT,this._du1191,false,0,true);
            }
         }
         var _loc30_:int = 300;
         if(this._gs1188)
         {
            _loc40_ = _tu1192._up1270((_loc30_ - 40) / 3,_tm178.get("copy"));
            _loc41_ = _tu1192._up1270((_loc30_ - 40) / 3,_tm178.get("close"));
            _loc42_ = new TextFormat("calibri",12,0,false,false,false,null,null,"left");
            _loc43_ = new TextFormat("calibri",12,16777215,false,false,false,null,null,"left");
            _loc44_ = new TextFormat("calibri",12,16771584,false,false,false,null,null,"center");
            _loc45_ = new TextField();
            _loc45_.width = _loc30_ - 40;
            _loc45_.x = 20;
            _loc45_.multiline = true;
            _loc45_.wordWrap = true;
            _loc45_.text = this._gs1188;
            _loc45_.selectable = true;
            _loc45_.backgroundColor = 16777215;
            _loc45_.setTextFormat(_loc42_);
            _loc45_.height = _loc45_.textHeight + 4;
            _loc45_.border = true;
            _loc45_.background = true;
            _loc46_ = new TextField();
            _loc46_.width = _loc30_ - 40;
            _loc46_.x = 20;
            _loc46_.multiline = true;
            _loc46_.wordWrap = true;
            _loc46_.text = _tm178.get("embedDescription");
            _loc46_.selectable = false;
            _loc46_.setTextFormat(_loc43_);
            _loc46_.height = _loc46_.textHeight + 4;
            this._ft713 = new TextField();
            this._ft713.width = _loc30_;
            this._ft713.x = 0;
            this._ft713.text = _tm178.get("embedCopied");
            this._ft713.selectable = false;
            this._ft713.setTextFormat(_loc44_);
            this._ft713.height = this._ft713.textHeight + 4;
            this._kn165 = new _bx752(false,_loc30_,40 + _loc45_.height + this._ft713.height + _loc46_.height + _loc40_.height);
            this._kn165.addChild(_loc45_);
            this._kn165.addChild(_loc46_);
            this._kn165.addChild(this._ft713);
            this._kn165.addChild(_loc40_);
            this._kn165.addChild(_loc41_);
            _loc47_ = (this._kn165.height - _loc45_.height - _loc46_.height - this._ft713.height - _loc40_.height) / 3;
            _loc46_.y = _loc47_;
            _loc45_.y = _loc46_.y + _loc46_.height + _loc47_;
            this._ft713.y = _loc45_.y + _loc45_.height;
            _loc40_.x = (_loc30_ - _loc40_.width * 2) / 3;
            _loc40_.y = this._ft713.y + this._ft713.height;
            _loc41_.x = _loc40_.x + _loc40_.width + (_loc30_ - _loc40_.width * 2) / 3;
            _loc41_.y = this._ft713.y + this._ft713.height;
            addChild(this._kn165);
            this._kn165.visible = false;
            addChild(this._rx405);
            _loc40_.addEventListener(MouseEvent.MOUSE_UP,this._pv71,false,0,true);
            _loc41_.addEventListener(MouseEvent.MOUSE_UP,this._ok1026,false,0,true);
            this._rx405.addEventListener(MouseEvent.MOUSE_DOWN,this._ok1026,false,0,true);
            _loc48_ = new TextField();
            _loc48_.x = 10;
            _loc48_.y = 7;
            _loc48_.width = 96;
            _loc48_.text = _tm178.get("embedTooltip");
            _loc48_.wordWrap = true;
            _loc48_.selectable = false;
            _loc48_.textColor = 16777215;
            _loc48_.height = _loc48_.textHeight + 10;
            this._es1065 = new _bx752(false,112,_loc48_.textHeight + 14);
            this._es1065.addChild(_loc48_);
            addChild(this._es1065);
            this._es1065.visible = false;
            this._rx405.addEventListener(MouseEvent.MOUSE_OVER,this._od1067,false,0,true);
            this._rx405.addEventListener(MouseEvent.MOUSE_OUT,this._nx476,false,0,true);
         }
         this._sa186.addChild(_loc6_);
         this._sa186.addChild(this._ys660);
         this._sa186.addChild(this._lh1025);
         this._sa186.addChild(this._mt713);
         this._sa186.addChild(_loc14_);
         this._sa186.addChild(_loc15_);
         this._sa186.addChild(_loc16_);
         this._sa186.addChild(_loc17_);
         this._sa186.addChild(this._tt1216);
         this._bt516.addChild(_loc4_);
         this._bt516.addChild(this._my619);
         this._bt516.addChild(_loc5_);
         this._bt516.addChild(this._yd352);
         this._dj74(false);
         this._xo389(false);
         var _loc31_:_vq97 = null;
         var _loc32_:int = 0;
         var _loc33_:int = 0;
         this._mb876 = 0;
         var _loc36_:Boolean = false;
         if(_ny105 >= 0)
         {
            _loc34_ = 0;
            while(_loc34_ < this._nm696.length)
            {
               _loc35_ = this._nm696[_loc34_];
               if(_loc35_.id == _ny105)
               {
                  _loc31_ = _loc35_;
                  _loc36_ = true;
                  break;
               }
               _loc34_++;
            }
         }
         if(!_loc31_)
         {
            _loc34_ = 0;
            while(_loc34_ < this._nm696.length)
            {
               _loc35_ = this._nm696[_loc34_];
               if(_loc35_._vc35)
               {
                  _loc31_ = _loc35_;
                  break;
               }
               _loc34_++;
            }
         }
         if(!_loc31_)
         {
            _loc34_ = 0;
            _loc31_ = this._nm696[0];
         }
         if(_loc31_)
         {
            if(!_loc36_)
            {
               _loc32_ = _loc31_.subId;
               _loc33_ = _loc31_.timer;
               this.rotate = _loc31_.rotation;
               this._gi1348 = _loc31_._un503;
               this._cp665 = _loc31_._bu1230;
               this.zoom = _loc31_.zoom;
            }
            else
            {
               _loc32_ = this._lj16;
               _loc33_ = this._xk1217;
            }
         }
         this._mb876 = _loc34_;
         this._px741(this.rotate,this.scale,this._vt74,this._yf480,this._xs316);
         this._yl109.value = this._mb876;
         this._gf210.value = this._mb876;
         this.timer = _loc33_;
         this._th635 = null;
         this._dn885(_loc31_,_loc32_,_loc33_);
         if(this._so1024)
         {
            this._cp17(null);
         }
         this.onResize(null);
         loaded = true;
      }
      
      private function _np377() : void
      {
         this.zoom = _jv1004;
         this._tl596 = this.zoom;
         this._ma918 = _gb150;
         this.rotate = 0;
         this._dk154 = 1.15;
         this._nv596 = 1.15;
         this._ui1229 = 1.75;
         this._ce85 = 1.75;
         this._xl958 = 1;
         this._bk213 = _jy1225;
         this._yf480 = this._dk154;
         this._xs316 = this._nv596;
         this._vt74 = _wp900;
         this.scale = _ci1061;
         this.scene = new Scene3D();
         this.camera = new Camera3D({
            "zoom":_xf1224,
            "focus":1600,
            "x":0,
            "y":0,
            "z":0
         });
         _ah349 = new _kp1215();
         this._px741(this.rotate,this.scale,this._vt74,this._yf480,this._xs316);
         this.view = new View3D({
            "scene":this.scene,
            "camera":this.camera,
            "stats":true
         });
         this.view.x = this.stageWidth / 2;
         this.view.y = this.stageHeight / 2;
         addChild(this.view);
         this.timer = 0;
         this._yh872 = getTimer();
      }
      
      public function _ph492(param1:Event) : void
      {
         this._xp992 = true;
         this._gj173 = true;
      }
      
      public function _fc1195() : void
      {
         if(!this.fullScreen)
         {
            this._ji689.update(this._gi1348,this._cp665);
            this.view.x = int(this.stageWidth / 2 + this._gi1348 * this._rh1184);
            this.view.y = int(this.stageHeight / 2 + this._cp665 * this._id725);
         }
      }
      
      private function _lo467(param1:Number) : void
      {
         this._rs1091 = this._rs1091 + param1;
         this._rs1091 = Math.max(0,Math.min(1,this._rs1091));
         this._yy754.alpha = this._rs1091;
         this.forwardButton.alpha = this._rs1091;
         this._wh203.alpha = this._rs1091;
         if(this._or1402)
         {
            this._or1402.alpha = this._rs1091;
         }
         this._rx405.alpha = this._rs1091;
         this.fullScreenButton.alpha = this._rs1091;
         this._vq453.alpha = this._rs1091;
         this._sj1329.alpha = this._rs1091;
         this._gx760.alpha = this._rs1091;
         this._tk821.alpha = this._rs1091;
         this._mh80.alpha = this._rs1091;
         this._gf210.alpha = this._rs1091;
         this._ji689.alpha = this._rs1091;
         if(this._fa379)
         {
            this._fa379.alpha = this._rs1091 * this._tx1296;
         }
      }
      
      private function _cx126(param1:Number) : void
      {
         this._tx1296 = Math.max(0,Math.min(1,this._tx1296 + param1));
         this._fa379.alpha = this._rs1091 * this._tx1296;
         if(this._tx1296 == 0 && this._fa379.visible)
         {
            this._fa379.visible = false;
         }
         if(this._tx1296 > 0 && !this._fa379.visible)
         {
            this._fa379.visible = true;
         }
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc6_:int = 0;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc2_:int = getTimer();
         if(this._fp1150)
         {
            return;
         }
         var _loc3_:int = _loc2_ - this._yh872;
         _loc3_ = Math.max(30,Math.min(250,_loc3_));
         var _loc4_:int = !!this.paused?0:int(_loc3_);
         if(!loaded)
         {
            if(this.loadingBar._ki798(this._ej281._wy114(),_loc3_))
            {
               this._ri298(this._ej281);
            }
            return;
         }
         if(!this.paused)
         {
            this._de1189 = this._de1189 + _loc3_;
            if(this._de1189 >= _hk284)
            {
               this._je462();
            }
         }
         if(this._il1124)
         {
            this._ac1326.update(_loc3_);
         }
         var _loc5_:Boolean = !this._xr932 || this._nd623;
         if(!this.fullScreen)
         {
            if(_loc5_ && this._rs1091 > 0)
            {
               this._lo467(-_loc3_ * _hj984);
            }
            else if(!_loc5_ && this._rs1091 < 1)
            {
               this._lo467(_loc3_ * _hj984);
            }
         }
         if(this._tx1296 > 0 && !this._tk1335)
         {
            this._cx126(-_loc3_ * _hj984);
         }
         else if(this._tx1296 < 1 && this._tk1335)
         {
            this._cx126(_loc3_ * _hj984);
         }
         if(this._ho543 > 0 && !this._nd623)
         {
            this._jf50(-_loc3_ * 2 * _hj984);
         }
         else if(this._ho543 < 1 && this._nd623)
         {
            this._jf50(_loc3_ * 2 * _hj984);
         }
         if(this._aw1027 || this._jh356)
         {
            _loc4_ = 8 * _loc3_ / 50;
            this.dirty = true;
            this._jh356 = false;
         }
         else if(this._ww743 || this._jt840)
         {
            _loc4_ = -8 * _loc3_ / 50;
            this.dirty = true;
            this._jt840 = false;
         }
         this.timer = this.timer + _loc4_;
         this._yh872 = _loc2_;
         if(this._oq91 && !this.fullScreen)
         {
            _loc7_ = this._gi1348;
            _loc8_ = this._cp665;
            this._gi1348 = this._gi1348 + -(this._kj51 - mouseX) / this._rh1184;
            this._cp665 = this._cp665 + -(this._qd415 - mouseY) / this._id725;
            this._gi1348 = Math.max(Math.min(1,this._gi1348),-1);
            this._cp665 = Math.max(Math.min(1,this._cp665),-1);
            this._kj51 = mouseX;
            this._qd415 = mouseY;
            if(_loc7_ != this._gi1348 || _loc8_ != this._cp665)
            {
               this._fc1195();
               this.dirty = true;
            }
            this._xp992 = true;
            this._ij358 = 0;
         }
         if(this.zoom < this._tl596)
         {
            this._fy1287(_loc3_ * 0.0013);
         }
         else if(this.zoom > this._tl596)
         {
            this._fy1287(_loc3_ * -0.0013);
         }
         if(this._ya170 && this._rg1394 != mouseX)
         {
            this.rotate = this.rotate + (this._rg1394 - mouseX) * 0.75;
            this._px741(this.rotate,this.scale,this._vt74,this._yf480,this._xs316);
            this._rg1394 = mouseX;
         }
         else if(this._gj173)
         {
            this._fl535 = this._fl535 + _loc3_ * 0.005;
            this._fl535 = Math.min(3,this._fl535);
         }
         else if(this._nu123)
         {
            this._fl535 = this._fl535 - _loc3_ * 0.005;
            this._fl535 = Math.max(-3,this._fl535);
         }
         else if(this._fl535 < 0)
         {
            this._fl535 = Math.min(0,this._fl535 + _loc3_ * 0.016);
         }
         else if(this._fl535 > 0)
         {
            this._fl535 = Math.max(0,this._fl535 - _loc3_ * 0.016);
         }
         if(this._fl535 != 0)
         {
            this.rotate = this.rotate + this._fl535 * 0.15 * _loc3_;
            if(this.rotate > 360)
            {
               this.rotate = this.rotate - 360;
            }
            if(this.rotate < 0)
            {
               this.rotate = this.rotate + 360;
            }
            this._px741(this.rotate,this.scale,this._vt74,this._yf480,this._xs316);
            this.dirty = true;
         }
         if(this.model != null && (!this.paused || this.dirty) && !_nb1256)
         {
            this.model.update(_loc4_,_ah349);
         }
         if(this.zoom == this._tl596 && this._fl535 == 0 && this._xp992 && !this._ya170 && this.paused)
         {
            this._ij358 = this._ij358 + _loc3_;
         }
         else
         {
            this._ij358 = 0;
         }
         if(this._ij358 >= _uv1372)
         {
            this.dirty = true;
            this._lh918 = true;
            this._xp992 = false;
            this._ij358 = 0;
         }
         if((!this.paused || this.dirty) && !_nb1256)
         {
            if(this._lh918 && this.paused)
            {
               if(this.view.renderer != this._fq296)
               {
                  this.view.renderer = this._fq296;
               }
            }
            else if(this.view.renderer != this._ei1265)
            {
               this.view.renderer = this._ei1265;
            }
            this.view.render();
            this._lh918 = false;
            this.dirty = false;
            if(this._tq714)
            {
               this.view.visible = true;
               this._tq714 = false;
            }
         }
      }
      
      public function _so794(param1:Boolean = false) : void
      {
         var _loc2_:Object = null;
         _loc2_ = {
            "cape":(!!this._in1348?1:0),
            "helm":(!!this._sp553?1:0),
            "tabard":(!!this._fa511?1:0),
            "_iq942":this._th635.id,
            "dx":this._gi1348,
            "dy":this._cp665,
            "zoom":this.zoom,
            "rotate":this.rotate,
            "_nx192":this._pp777,
            "timer":this.model._he452,
            "subAnim":this.model._wy1288,
            "options":param1
         };
         ExternalInterface.call("buildModelViewer",_loc2_);
      }
      
      private function _ee256(param1:MouseEvent) : void
      {
         this._he1185 = false;
         if(this._kg1282 || this._mt484)
         {
            this._tl596 = this.zoom;
         }
         this._gj173 = false;
         this._nu123 = false;
         this._kg1282 = false;
         this._mt484 = false;
         this._aw1027 = false;
         this._ww743 = false;
         this._ya170 = false;
         if(this._ji689)
         {
            this._ji689._fm521 = false;
         }
         Mouse.show();
      }
      
      private function _kx1272() : void
      {
      }
      
      public function _px741(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : void
      {
         _ex1172._tl295 = param2;
         param4 = -param4;
         param5 = -param5;
         var _loc6_:Number = 0;
         if(param3 != 0)
         {
            _loc6_ = Math.atan((param4 - param5) / param3) * _mx160;
         }
         var _loc7_:_vc586 = _vc586._bs429(this._qt1122,-90 + param1);
         var _loc8_:_vc586 = _vc586._bs429(this._td1293,-_loc6_);
         var _loc9_:_gs89 = new _gs89(param2,param2,param2);
         _ah349._km648();
         _ah349.scale(_loc9_);
         _ah349.rotate(_loc8_);
         _ah349.translate(new _gs89(0,param3,param4));
         _ah349.rotate(_loc7_);
         this.dirty = true;
      }
      
      public function _rd34(param1:String) : void
      {
      }
      
      public function _hp908(param1:_xy565) : void
      {
         var _loc2_:BitmapData = param1.getBitmap(false);
         var _loc3_:BitmapData = param1.getBitmap(true);
         addChild(new Bitmap(_loc3_));
         var _loc4_:Bitmap = new Bitmap(_loc2_);
         _loc4_.x = 100;
         addChild(_loc4_);
      }
      
      private function _le464(param1:Event) : void
      {
         _kt737 = _mm1049;
      }
      
      public function _th867(param1:Event) : void
      {
         this._xb571 = new Sprite();
         this._xb571.graphics.beginFill(0,0);
         this._xb571.graphics.drawRect(0,0,this.stageWidth,this.stageHeight);
         this._xb571.graphics.endFill();
         this.loadingBar.visible = true;
         addChildAt(this._xb571,0);
         this._xb571.addEventListener(MouseEvent.MOUSE_DOWN,this._vm699);
      }
      
      private function _td149(param1:KeyboardEvent) : void
      {
      }
      
      private function init() : void
      {
         this._gq1365();
         this._np377();
         this._nt569();
         this._ve963();
         this._kx1272();
         this._tp1274();
      }
      
      private function _vv955(param1:Event) : void
      {
         this.paused = true;
      }
      
      public function _io860(param1:int) : void
      {
         var _loc2_:_vq97 = null;
         if(!this.model || this._fp1150)
         {
            return;
         }
         this._gf210.value = param1;
         this._yl109.value = param1;
         this.timer = 0;
         this._mb876 = param1;
         if(this._mb876 >= this._nm696.length)
         {
            this._mb876 = 0;
         }
         _loc2_ = this._nm696[this._mb876];
         this._dn885(_loc2_);
         if(this.paused)
         {
            this._vx302(null);
         }
      }
      
      private function _nt569() : void
      {
      }
      
      private function _fy1287(param1:Number) : void
      {
         if(this.fullScreen)
         {
            return;
         }
         if(this.zoom < this._tl596 && this.zoom + param1 >= this._tl596 || this.zoom > this._tl596 && this.zoom + param1 <= this._tl596)
         {
            this.zoom = this._tl596;
         }
         else
         {
            this.zoom = this.zoom + param1;
         }
         this.zoom = Math.min(_bm1324,Math.max(_jq1348,this.zoom));
         var _loc2_:Number = 1 - this.zoom;
         var _loc3_:Number = this.zoom * this.zoom;
         var _loc4_:Number = 1 - _loc3_;
         this._vt74 = _wp900 * _loc2_ + _jy1225 * this.zoom;
         this._yf480 = this._dk154 * _loc4_ + this._ui1229 * _loc3_;
         this._xs316 = this._nv596 * _loc4_ + this._ce85 * _loc3_;
         this._px741(this.rotate,this.scale,this._vt74,this._yf480,this._xs316);
         this.dirty = true;
      }
      
      public function startAnimation(param1:_vq97, param2:int = -1, param3:int = 0) : void
      {
         if(!param1)
         {
            return;
         }
         this.model._mq392(this.scene);
         if(param1._iy29 == "melee")
         {
            this.model._nt652("melee",this.scene);
         }
         else if(param1._iy29 == "ranged")
         {
            this.model._nt652("ranged",this.scene);
         }
         this.model._mg538(param1.id);
         if(param2 >= 0)
         {
            this.model._uo746(param2);
         }
         this._th635 = param1;
         this.model._he452 = param3;
      }
      
      private function _vi587(param1:Event) : void
      {
         this._cm417();
      }
      
      private function _fl866(param1:Loader = null) : void
      {
         var _loc2_:Number = NaN;
         var _loc4_:BitmapData = null;
         var _loc5_:int = 0;
         var _loc6_:Matrix = null;
         if(!this.fullScreen || !param1 && !this._sn1000)
         {
            return;
         }
         this._tq714 = true;
         if(this._sn1000 && contains(this._sn1000))
         {
            removeChild(this._sn1000);
            removeEventListener(MouseEvent.MOUSE_DOWN,this._vm699);
         }
         if(param1)
         {
            _loc4_ = new BitmapData(this.stageWidth,this.stageHeight,false,0);
            this._hx320 = this.stageHeight / param1.height;
            _loc5_ = (this.stageWidth - this._hx320 * param1.width) / 2;
            _loc6_ = null;
            if(_loc2_ != 1)
            {
               _loc6_ = new Matrix(this._hx320,0,0,this._hx320,_loc5_,0);
            }
            _loc4_.draw(param1,_loc6_,null,null,null,true);
            this._sn1000 = new Sprite();
            this._sn1000.graphics.beginBitmapFill(_loc4_);
            this._sn1000.graphics.drawRect(0,0,this.stageWidth,this.stageHeight);
            this._sn1000.graphics.endFill();
            if(param1.width != this._ey27 || param1.height != this._kc785)
            {
               this._ey27 = param1.width;
               this._kc785 = param1.height;
               this._xo389(true);
            }
            param1.unload();
         }
         _loc2_ = this._hx320;
         this._sn1000.x = 0;
         this._sn1000.y = 0;
         this._vt74 = _wp900;
         this._yf480 = this._dk154;
         this._xs316 = this._nv596;
         this.scale = _ci1061;
         this._px741(this.rotate,this.scale,this._vt74,this._yf480,this._xs316);
         addChildAt(this._sn1000,0);
         this._sn1000.addEventListener(MouseEvent.MOUSE_DOWN,this._vm699);
         var _loc3_:Number = _loc2_ * this._he1319;
         this.view.scaleX = _loc3_;
         this.view.scaleY = _loc3_;
         this.view.x = this.stageWidth / 2 + this._bf176 * _loc3_;
         this.view.y = this.stageHeight / 2 + this._dp547 * _loc3_;
         this.view.filters = null;
      }
      
      private function _hk131(param1:Object) : void
      {
         var _loc3_:Number = NaN;
         var _loc2_:Number = 0;
         if(param1 is MouseEvent)
         {
            _loc2_ = param1.delta;
         }
         else
         {
            _loc2_ = (param1 as Number) * 3;
         }
         if(!this.fullScreen && _loc2_ != 0)
         {
            _loc3_ = this._tl596;
            this._tl596 = this._tl596 + _loc2_ * 0.033;
            this._tl596 = Math.min(1,Math.max(0,this._tl596));
            if(this._tl596 != _loc3_)
            {
               this._xp992 = true;
            }
         }
      }
      
      private function _gq1365() : void
      {
         stage.scaleMode = "noScale";
         stage.align = "TL";
         Security.allowDomain("*");
         if(_ci257)
         {
            _vw814 = new TextField();
            _vw814.textColor = 16777215;
            _vw814.x = 0;
            _vw814.width = 400;
            _vw814.y = 60;
            _vw814.multiline = true;
            addChild(_vw814);
            _vw814.text = "debug";
         }
      }
      
      private function _sq1178(param1:Event) : void
      {
         this._xr932 = false;
      }
      
      private function _cd387() : void
      {
         this._oq91 = false;
      }
      
      private function _mf150(param1:Event) : void
      {
         var _loc2_:LoaderInfo = null;
         var _loc3_:Loader = param1.target.loader;
         if(param1.target.url != this._oy1063)
         {
            _loc3_.unloadAndStop();
            return;
         }
         var _loc4_:BitmapData = new BitmapData(_loc3_.width,_loc3_.height,true,0);
         _loc4_.draw(_loc3_);
         this._uq285 = new Bitmap(_loc4_);
         if(this.fullScreen)
         {
            if(!contains(this._uq285))
            {
               addChildAt(this._uq285,2);
            }
            this._uq285.x = this._om92;
            this._uq285.y = 0;
         }
      }
      
      public function _mu405(param1:_xy565) : void
      {
      }
      
      private function _tp279(param1:Event) : void
      {
         this._cd387();
      }
      
      public function _ok1026(param1:Event) : void
      {
         if(this._tk1335)
         {
            this._cp17(null);
         }
         this._nd623 = !this._nd623;
         if(this._nd623)
         {
            this._ft713.visible = false;
            if(!this.paused)
            {
               this._vy751 = true;
               this.paused = true;
            }
         }
         else
         {
            if(this.paused && this._vy751)
            {
               this.paused = false;
            }
            this._vy751 = false;
         }
      }
      
      public function _od1067(param1:Event) : void
      {
         this._es1065.visible = true;
      }
      
      private function _jf50(param1:Number) : void
      {
         this._ho543 = Math.max(0,Math.min(1,this._ho543 + param1));
         this._kn165.alpha = this._ho543;
         if(this._ho543 == 0 && this._kn165.visible)
         {
            this._kn165.visible = false;
         }
         if(this._ho543 > 0 && !this._kn165.visible)
         {
            this._kn165.visible = true;
         }
      }
      
      private function _xf1278(param1:Event) : void
      {
         this._ks402();
      }
      
      private function _je462() : void
      {
         if(loaded && !this.paused)
         {
            this.paused = true;
            this._oa138 = true;
         }
      }
      
      private function _ks402() : void
      {
         this._he1185 = true;
         if(this.fullScreen)
         {
            return;
         }
         this._kj51 = mouseX;
         this._qd415 = mouseY;
         this._oq91 = true;
      }
      
      public function _qy242(param1:Event) : void
      {
         _wv1127 = true;
      }
      
      public function _gq1185(param1:int) : void
      {
         if(this._fp1150)
         {
            return;
         }
         if(_kt737 != param1)
         {
            this._tq714 = true;
            this._xp992 = true;
            _kt737 = param1;
            if(this.fullScreen)
            {
               this._sv1085(null);
            }
            if(ExternalInterface.available)
            {
               ExternalInterface.call("set_3d_quality","" + param1);
               this._so794();
            }
         }
      }
      
      private function stopAll() : void
      {
         this._fp1150 = true;
      }
      
      private function _kv710(param1:Event) : void
      {
         var _loc2_:LoaderInfo = null;
         var _loc3_:Loader = param1.target.loader;
         if(param1.target.url != this._sw1410)
         {
            _loc3_.unloadAndStop();
            return;
         }
         this._cm417();
         this._fl866(_loc3_);
      }
      
      public function _yq661(param1:Event) : void
      {
         var _loc2_:Loader = param1.target.loader;
         var _loc3_:BitmapData = new BitmapData(_loc2_.width,_loc2_.height,false,0);
         _loc3_.draw(_loc2_);
         this._xb571 = new Sprite();
         this._xb571.graphics.beginBitmapFill(_loc3_);
         this._xb571.graphics.drawRect(0,0,_loc3_.width,_loc3_.height);
         this._xb571.graphics.endFill();
         this.loadingBar.visible = true;
         _loc2_.unload();
         addChildAt(this._xb571,0);
         this._xb571.addEventListener(MouseEvent.MOUSE_DOWN,this._vm699);
      }
      
      private function _gd414() : void
      {
         if(loaded && this._oa138 && this.paused)
         {
            this.paused = false;
         }
         this._oa138 = false;
      }
      
      public function _kl933(param1:Event) : void
      {
         this._iv124.visible = true;
      }
      
      public function _dj48(param1:Event) : void
      {
         this._uq924.visible = !this._uq924.visible;
         if(this._uq924.visible)
         {
            this._uq924.alpha = 0.8;
         }
      }
      
      public function _vx302(param1:Event) : void
      {
         this.paused = !this.paused;
         this._oa138 = false;
         this._xp992 = true;
         this._md314();
      }
      
      public function _du1191(param1:Event) : void
      {
         this._iv124.visible = false;
      }
      
      private function _tp1274() : void
      {
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.view.mouseChildren = false;
         this.view.mouseEnabled = true;
         this.view.doubleClickEnabled = true;
         this.view.addEventListener(MouseEvent.MOUSE_DOWN,this._vm699);
         stage.addEventListener(MouseEvent.MOUSE_UP,this._ee256);
         stage.addEventListener(MouseEvent.MOUSE_MOVE,this._ho1124);
         stage.addEventListener(Event.MOUSE_LEAVE,this._ff1174);
         stage.addEventListener(Event.RESIZE,this.onResize);
         this.onResize(null);
         var _loc1_:ContextMenu = new ContextMenu();
         _loc1_.hideBuiltInItems();
         contextMenu = _loc1_;
         if(ExternalInterface.available)
         {
            ExternalInterface.addCallback("js_mousewheel",this._hk131);
            ExternalInterface.addCallback("rightClick",this._ks402);
            ExternalInterface.addCallback("rightClickRelease",this._cd387);
            ExternalInterface.addCallback("stopall",this.stopAll);
            ExternalInterface.addCallback("sleep",this._je462);
            ExternalInterface.addCallback("wakeUp",this._gd414);
         }
         else
         {
            stage.addEventListener(MouseEvent.MOUSE_WHEEL,this._hk131);
         }
      }
      
      public function _oj1063(param1:_vq97) : void
      {
         if(!_nb1256 || this._vr1290 < 0 || !param1 || param1.id != this._vr1290)
         {
            return;
         }
         _nb1256 = false;
         this.startAnimation(param1,this._pm1194,this._di805);
         this.dirty = true;
         this.view.visible = true;
         this._cm417();
         if(this.loadingBar)
         {
            removeChild(this.loadingBar);
            this.loadingBar = null;
         }
      }
      
      public function _yd156(param1:Event) : void
      {
         this._xp992 = true;
         this._nu123 = true;
      }
      
      private function _ve963() : void
      {
         var _loc1_:* = null;
         var _loc2_:String = null;
         var _loc9_:URLLoader = null;
         var _loc10_:BitmapData = null;
         var _loc11_:Loader = null;
         var _loc3_:Object = LoaderInfo(this.root.loaderInfo).parameters;
         var _loc4_:String = "";
         var _loc5_:String = "";
         var _loc6_:String = null;
         for(_loc1_ in _loc3_)
         {
            _loc2_ = String(_loc3_[_loc1_]);
            if(_loc1_ == "character")
            {
               this.character = _loc2_;
            }
            else if(_loc1_ == "realm")
            {
               this._eo90 = _loc2_;
            }
            else if(_loc1_ == "infoServer")
            {
               _kd1008 = _loc2_;
            }
            else if(_loc1_ == "fileServer")
            {
               _uo1157 = _loc2_;
            }
            else if(_loc1_ == "bg")
            {
               this._pp777 = _loc2_;
            }
            else if(_loc1_ == "bgColor")
            {
               this._rw582 = uint(_loc2_);
            }
            else if(_loc1_ == "cape")
            {
               this._mj838 = true;
               this._in1348 = int(_loc2_) != 0;
            }
            else if(_loc1_ == "tabard")
            {
               this._br1077 = true;
               this._fa511 = int(_loc2_) != 0;
            }
            else if(_loc1_ == "helm")
            {
               this._ba873 = true;
               this._sp553 = int(_loc2_) != 0;
            }
            else if(_loc1_ == "quality")
            {
               _kt737 = int(_loc2_);
               if(_kt737 < _mm1049 || _kt737 > _is1127)
               {
                  _kt737 = _sk609;
               }
            }
            else if(_loc1_ == "loadingtxt")
            {
               _dt494 = _loc2_;
            }
            else if(_loc1_ == "strings")
            {
               _ns1004 = _loc2_;
            }
            else if(_loc1_ == "anim")
            {
               _ny105 = int(_loc2_);
            }
            else if(_loc1_ == "subAnim")
            {
               this._lj16 = int(_loc2_);
            }
            else if(_loc1_ == "timer")
            {
               this._xk1217 = int(_loc2_);
            }
            else if(_loc1_ == "rotate")
            {
               this.rotate = Number(_loc2_);
            }
            else if(_loc1_ == "zoom")
            {
               this.zoom = Number(_loc2_);
            }
            else if(_loc1_ == "dx")
            {
               this._gi1348 = Number(_loc2_);
            }
            else if(_loc1_ == "dy")
            {
               this._cp665 = Number(_loc2_);
            }
            else if(_loc1_ == "options")
            {
               this._so1024 = Boolean(_loc2_);
            }
            else if(_loc1_ == "embedded")
            {
               this._nj1353 = Boolean(_loc2_);
            }
            else if(_loc1_ == "embedlink")
            {
               this._gs1188 = _loc2_;
            }
            else if(_loc1_ == "modelUrl")
            {
               _loc6_ = _loc2_;
            }
            else if(_loc1_ == "logoImg")
            {
               this._oy1063 = _loc2_;
            }
         }
         this._ej281 = new _ke291(this.character,this._eo90,_kd1008,_uo1157,_loc6_,this._mj838,this._in1348,this._br1077,this._fa511,this._ba873,this._sp553);
         if(_ns1004)
         {
            _loc9_ = new URLLoader();
            _loc9_.addEventListener(Event.COMPLETE,this._wh541,false,0,false);
            _loc9_.addEventListener(IOErrorEvent.IO_ERROR,this._qy242,false,0,false);
            _loc9_.addEventListener(IOErrorEvent.NETWORK_ERROR,this._qy242,false,0,false);
            _loc9_.load(new URLRequest(_ns1004));
         }
         else
         {
            _wv1127 = true;
         }
         this._ej281._qg81(this);
         this._ej281.load();
         var _loc7_:DropShadowFilter = new DropShadowFilter();
         _loc7_.color = 0;
         _loc7_.blurY = 19;
         _loc7_.blurX = 19;
         _loc7_.angle = 120;
         _loc7_.alpha = 0.75;
         _loc7_.distance = 4;
         var _loc8_:Array = new Array(_loc7_);
         this.loadingBar = new _pe804(_dt494);
         this.loadingBar.x = (this.stageWidth - this.loadingBar._dg1098()) / 2;
         this.loadingBar.y = (this.stageHeight - this.loadingBar._ta1349()) / 2;
         this.loadingBar.visible = false;
         this.loadingBar.filters = _loc8_;
         addChild(this.loadingBar);
         if(!this._pp777)
         {
            _loc10_ = Cast.bitmap(_sh1146);
            this._xb571 = new Sprite();
            this._xb571.graphics.beginBitmapFill(_loc10_);
            this._xb571.graphics.drawRect(0,0,_loc10_.width,_loc10_.height);
            this._xb571.graphics.endFill();
            this.loadingBar.visible = true;
         }
         else if(this._pp777 != "none")
         {
            _loc11_ = new Loader();
            _loc11_.contentLoaderInfo.addEventListener(Event.COMPLETE,this._yq661,false,0,false);
            _loc11_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this._th867,false,0,false);
            _loc11_.contentLoaderInfo.addEventListener(ErrorEvent.ERROR,this._th867,false,0,false);
            _loc11_.contentLoaderInfo.addEventListener(IOErrorEvent.NETWORK_ERROR,this._th867,false,0,false);
            _loc11_.load(new URLRequest(this._pp777));
         }
         else
         {
            this._xb571 = new Sprite();
            this._xb571.graphics.beginFill(this._rw582);
            this._xb571.graphics.drawRect(0,0,this.stageWidth,this.stageHeight);
            this._xb571.graphics.endFill();
            this.loadingBar.visible = true;
         }
      }
      
      private function _vm699(param1:MouseEvent) : void
      {
         this._he1185 = true;
         Mouse.hide();
         this._oq91 = false;
         this._rg1394 = mouseX;
         this._ky964 = mouseY;
         this._ya170 = true;
         this._xp992 = true;
         if(this._ji689)
         {
            this._ji689._fm521 = true;
         }
         if(this._tk1335)
         {
            this._cp17(null);
         }
         if(this._nd623)
         {
            this._ok1026(null);
         }
      }
      
      private function _dj74(param1:Boolean) : void
      {
         this.forwardButton.resize(param1);
         this._wh203.resize(param1);
         this.fullScreenButton.resize(param1);
         this._tk821.resize(param1);
         this._mh80.resize(param1);
         this._vq453.resize(param1);
         if(param1)
         {
            if(!this.paused)
            {
               this._yy754.upState = this._yy754.hitTestState = this._bp233;
               this._yy754.downState = this._hc289;
               this._yy754.overState = this._ov543;
            }
            else
            {
               this._yy754.upState = this._yy754.hitTestState = this._sc1263;
               this._yy754.downState = this._sa64;
               this._yy754.overState = this._cy1341;
            }
         }
         else if(!this.paused)
         {
            this._yy754.upState = this._yy754.hitTestState = this._gx659;
            this._yy754.downState = this._md1222;
            this._yy754.overState = this._wr1342;
         }
         else
         {
            this._yy754.upState = this._yy754.hitTestState = this._ir778;
            this._yy754.downState = this._fe732;
            this._yy754.overState = this._tr1149;
         }
      }
      
      private function _ps1194(param1:Event) : void
      {
         this.paused = false;
      }
      
      private function _lm504() : void
      {
         this._il1124 = true;
         if(!contains(this._ac1326))
         {
            addChildAt(this._ac1326,numChildren);
         }
         this._ac1326.x = (this.stageWidth - this._ac1326.width) / 2;
         this._ac1326.y = (this.stageHeight - this._ac1326.height) / 2;
      }
      
      private function _ff1174(param1:Event) : void
      {
         this._xr932 = false;
      }
      
      public function _fo1097(param1:Event) : void
      {
         if(!this._th635)
         {
            return;
         }
         var _loc2_:Object = {
            "rot":this.rotate,
            "z":this.zoom,
            "a":this._th635.id,
            "timer":this.model._he452,
            "subId":this.model._wy1288,
            "panx":this._gi1348,
            "pany":this._cp665
         };
         if(ExternalInterface.available)
         {
            ExternalInterface.call("pose_save",_loc2_);
         }
      }
      
      public function _nx476(param1:Event) : void
      {
         this._es1065.visible = false;
      }
      
      private function _ho1124(param1:MouseEvent) : void
      {
         this._de1189 = 0;
         if(this._oa138)
         {
            this._gd414();
         }
         this._xr932 = true;
      }
      
      public function _sl11(param1:Number, param2:Number) : void
      {
         this._gi1348 = param1;
         this._cp665 = param2;
         this._fc1195();
         this._xp992 = true;
         this._ij358 = 0;
         this.dirty = true;
      }
      
      private function _xo389(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Loader = null;
         if(param1)
         {
            _loc3_ = this.stageHeight / this._kc785;
            _loc4_ = int(_loc3_ * this._ey27);
            _loc5_ = (this.stageWidth - _loc4_) / 2;
            this._om92 = _loc5_;
            this._fa379 = this._bt516;
            _loc6_ = this._yl109.width;
            _loc7_ = (_loc6_ - this._vq453.width - this.forwardButton.width - this._yy754.width - this._wh203.width) / 3;
            this._sj1329.visible = false;
            this._gx760.visible = false;
            if(this._uo1367)
            {
               addChild(this._ek736);
               addChild(this._uo1367);
               this._uo1367.x = (this.stageWidth - _vv367) / 2;
               this._uo1367.y = 7 * this.stageHeight / 8;
               this._ek736.x = this._uo1367.x + 2;
               this._ek736.y = this._uo1367.y + 2;
            }
            this._tk821.x = this.stageWidth / 2 - this._mh80.width - 5;
            this._tk821.y = this.stageHeight * 31 / 32 - this._tk821.height;
            this._mh80.x = this.stageWidth / 2 + 5;
            this._mh80.y = this.stageHeight * 31 / 32 - this._tk821.height;
            this.fullScreenButton.x = _loc5_ + _loc4_ * 31 / 32 - this.fullScreenButton.width;
            this.fullScreenButton.y = this.stageHeight / 32;
            this._rx405.visible = false;
            if(this._or1402)
            {
               this._or1402.visible = false;
            }
            addChildAt(this._pc1316,1);
            this._pc1316.x = _loc5_ + _loc4_ * 31 / 32 - this._pc1316.width + 10;
            this._pc1316.y = this.stageHeight * 31 / 32 - this._pc1316.height + 10;
            this._yl109.visible = true;
            this._gf210.visible = false;
            this._yl109.x = this._pc1316.x + 30;
            this._yl109.y = this._pc1316.y + 18;
            _loc2_ = this._pc1316.y + this._yl109.height + 20;
            this._wh203.x = this._yl109.x;
            this._wh203.y = _loc2_;
            this._yy754.x = this._wh203.x + this._wh203.width + _loc7_;
            this._yy754.y = _loc2_;
            this.forwardButton.x = this._yy754.x + this._yy754.width + _loc7_;
            this.forwardButton.y = _loc2_;
            this._vq453.x = this.forwardButton.x + this.forwardButton.width + _loc7_;
            this._vq453.y = _loc2_;
            if(this._uq285)
            {
               if(!contains(this._uq285))
               {
                  addChildAt(this._uq285,2);
               }
               this._uq285.x = this._om92;
               this._uq285.y = 0;
            }
            else if(!this._io608 && this._oy1063)
            {
               this._io608 = true;
               _loc8_ = new Loader();
               _loc8_.contentLoaderInfo.addEventListener(Event.COMPLETE,this._mf150,false,0,false);
               _loc8_.load(new URLRequest(this._oy1063));
            }
            this._bt516.x = int(this._pc1316.x);
            this._bt516.y = int(this._pc1316.y - this._bt516.height);
         }
         else
         {
            this._fa379 = this._sa186;
            if(contains(this._pc1316))
            {
               removeChild(this._pc1316);
            }
            if(this._uq285 && contains(this._uq285))
            {
               removeChild(this._uq285);
            }
            if(contains(this._un423))
            {
               removeChild(this._un423);
            }
            if(this._uo1367 && contains(this._uo1367))
            {
               removeChild(this._uo1367);
               removeChild(this._ek736);
            }
            _loc2_ = this.stageHeight - 38;
            this._sj1329.visible = true;
            this._gx760.visible = true;
            this._sj1329.x = 2 + this._tk821.width - 3;
            this._sj1329.y = 2;
            this._gx760.x = this._sj1329.x;
            this._gx760.y = this._sj1329.y + this._sj1329.height;
            this._tk821.x = 2;
            this._tk821.y = this._sj1329.y + this._sj1329.height / 2;
            this._mh80.x = this._tk821.x + this._tk821.width + this._sj1329.width - 6;
            this._mh80.y = this._tk821.y;
            this.fullScreenButton.x = this.stageWidth - this.fullScreenButton.width - 4;
            this.fullScreenButton.y = 4;
            if(!this._nj1353)
            {
               this._or1402.visible = true;
               this._or1402.x = this.fullScreenButton.x;
               this._or1402.y = this.fullScreenButton.y + this.fullScreenButton.height + 4;
               this._rx405.visible = true;
               this._rx405.x = this.fullScreenButton.x;
               this._rx405.y = this._or1402.y + this._or1402.height + 4;
            }
            else
            {
               this._rx405.visible = true;
               this._rx405.x = this.fullScreenButton.x;
               this._rx405.y = this.fullScreenButton.y + this.fullScreenButton.height + 4;
            }
            if(this._iv124)
            {
               this._iv124.x = this._or1402.x - this._iv124.width;
               this._iv124.y = this._or1402.y - int((this._iv124.height - this._or1402.height) / 2);
               this._iv124.y = Math.max(4,this._iv124.y);
            }
            if(this._es1065)
            {
               this._es1065.x = this._rx405.x - this._es1065.width;
               this._es1065.y = this._rx405.y - int((this._es1065.height - this._rx405.height) / 2);
               this._es1065.y = Math.max(4,this._es1065.y);
            }
            if(this._kn165)
            {
               this._kn165.x = (this.stageWidth - this._kn165.width) / 2;
               this._kn165.y = (this.stageHeight - this._kn165.height) / 2;
            }
            this._wh203.x = 1;
            this._wh203.y = _loc2_;
            this._yy754.x = -1 + this._wh203.x + this._wh203.width;
            this._yy754.y = _loc2_;
            this.forwardButton.x = -1 + this._yy754.x + this._yy754.width;
            this.forwardButton.y = _loc2_;
            this._vq453.x = -1 + this.forwardButton.x + this.forwardButton.width;
            this._vq453.y = _loc2_;
            this._yl109.visible = false;
            this._gf210.visible = true;
            this._gf210.x = this.stageWidth - this._gf210.width;
            this._gf210.y = _loc2_ + 3;
            this._sa186.x = int(this.stageWidth - this._fa379.width - 4);
            this._sa186.y = int(_loc2_ - this._fa379.height);
            this._ji689.x = -2;
            this._ji689.y = this.stageHeight - 102;
         }
      }
      
      public function _sv1085(param1:Event) : void
      {
         var _loc2_:BitmapData = null;
         if(stage.displayState == "normal")
         {
            stage.displayState = "fullScreen";
         }
         else
         {
            stage.displayState = "normal";
         }
      }
      
      public function _dn885(param1:_vq97, param2:int = -1, param3:int = 0) : void
      {
         var _loc4_:int = 0;
         var _loc5_:_be715 = null;
         if(!this.model || !param1)
         {
            return;
         }
         _loc4_ = param1.id;
         if(this.model._cr1245[_loc4_])
         {
            this.startAnimation(param1,param2,param3);
            this.dirty = true;
         }
         else
         {
            _nb1256 = true;
            this._vr1290 = param1.id;
            this._pm1194 = param2;
            this._di805 = param3;
            this._th635 = null;
            _loc5_ = _be715._ty159(this.model,param1,this.model._uv798);
            this.view.visible = false;
            this._lm504();
            _loc5_._qg81(this);
            _loc5_.load();
         }
      }
      
      private function onResize(param1:Event) : void
      {
         var _loc2_:Loader = null;
         var _loc3_:DropShadowFilter = null;
         var _loc4_:Array = null;
         var _loc5_:Number = NaN;
         this.view.visible = false;
         this._tq714 = false;
         if(!this.paused && this._yy754)
         {
            this._vx302(null);
         }
         this.stageWidth = stage.stageWidth;
         this.stageHeight = stage.stageHeight;
         if(this.loadingBar)
         {
            this.loadingBar.x = (this.stageWidth - this.loadingBar._dg1098()) / 2;
            this.loadingBar.y = (this.stageHeight - this.loadingBar._ta1349()) / 2;
         }
         this._xp992 = true;
         this._tl596 = this.zoom;
         this._fl535 = 0;
         this._ya170 = false;
         this._oq91 = false;
         if(stage.displayState == "fullScreen")
         {
            this.fullScreen = true;
            if(contains(this._xb571))
            {
               this._xb571.removeEventListener(MouseEvent.MOUSE_DOWN,this._vm699);
               removeChild(this._xb571);
            }
            if(this._sn1000)
            {
               this._fl866();
            }
            else
            {
               this._bf176 = this._sb154[0].dx;
               this._dp547 = this._nv596 * this._ol1093 + this._sb154[0].dy;
               this._he1319 = this._sb154[0].scale;
               this._lm504();
               _loc2_ = new Loader();
               _loc2_.contentLoaderInfo.addEventListener(Event.COMPLETE,this._kv710,false,0,true);
               _loc2_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this._vi587,false,0,true);
               _loc2_.contentLoaderInfo.addEventListener(ErrorEvent.ERROR,this._vi587,false,0,true);
               _loc2_.contentLoaderInfo.addEventListener(IOErrorEvent.NETWORK_ERROR,this._vi587,false,0,true);
               _loc2_.load(new URLRequest(this._sb154[0]._rl419()));
               this._sw1410 = this._sb154[0]._rl419();
            }
            this._dj74(true);
            this._xo389(true);
            this._lo467(1);
         }
         else
         {
            this.fullScreen = false;
            this.view.scaleX = 1;
            this.view.scaleY = 1;
            this.view.scaleX = this._xl958;
            this.view.scaleY = this._xl958;
            this.scale = _ci1061;
            this._fy1287(0);
            this._px741(this.rotate,this.scale,this._vt74,this._yf480,this._xs316);
            _loc3_ = new DropShadowFilter();
            _loc3_.color = 0;
            _loc3_.blurY = 19;
            _loc3_.blurX = 19;
            _loc3_.angle = 120;
            _loc3_.alpha = 0.75;
            _loc3_.distance = 4;
            _loc4_ = new Array(_loc3_);
            if(this._sn1000 && contains(this._sn1000))
            {
               this._sn1000.removeEventListener(MouseEvent.MOUSE_DOWN,this._vm699);
               removeChild(this._sn1000);
            }
            if(this._xb571 && !contains(this._xb571))
            {
               addChildAt(this._xb571,0);
               this._xb571.addEventListener(MouseEvent.MOUSE_DOWN,this._vm699);
            }
            this._xb571.scaleX = this._xb571.scaleY = 1;
            if(this._xb571.width != this.stageWidth)
            {
               _loc5_ = this.stageWidth / this._xb571.width;
               this._xb571.scaleX = _loc5_;
               this._xb571.scaleY = _loc5_;
            }
            if(loaded)
            {
               this._dj74(false);
               this._xo389(false);
            }
            this._tq714 = true;
         }
         if(loaded)
         {
            if(this._tk1335)
            {
               this._cp17(null);
            }
            this._sa186.visible = false;
            this._bt516.visible = false;
            this._tx1296 = 0;
            this.dirty = true;
         }
         if(this.view && this._ji689)
         {
            this._fc1195();
            this._ji689.visible = !this.fullScreen;
         }
      }
      
      public function _dy1356(param1:MouseEvent) : void
      {
         if(this._fp1150)
         {
            return;
         }
         this._sp553 = this._ys660._xx1191;
         this._in1348 = this._lh1025._xx1191;
         this._fa511 = this._mt713._xx1191;
         if(ExternalInterface.available)
         {
            this._so794();
         }
      }
      
      private function _po1206(param1:Event) : void
      {
         _kt737 = _is1127;
      }
      
      public function _ky965(param1:Event) : void
      {
         if(this._tl596 < 1)
         {
            this._xp992 = true;
            this._kg1282 = true;
            this._tl596 = 1;
         }
      }
      
      public function _md314() : void
      {
         if(this.fullScreen)
         {
            if(this.paused)
            {
               this._yy754.upState = this._yy754.hitTestState = this._sc1263;
               this._yy754.downState = this._sa64;
               this._yy754.overState = this._cy1341;
            }
            else
            {
               this._yy754.upState = this._yy754.hitTestState = this._bp233;
               this._yy754.downState = this._hc289;
               this._yy754.overState = this._ov543;
            }
         }
         else if(this.paused)
         {
            this._yy754.upState = this._yy754.hitTestState = this._ir778;
            this._yy754.downState = this._fe732;
            this._yy754.overState = this._tr1149;
         }
         else
         {
            this._yy754.upState = this._yy754.hitTestState = this._gx659;
            this._yy754.downState = this._md1222;
            this._yy754.overState = this._wr1342;
         }
      }
      
      public function _oq210(param1:int) : void
      {
         var _loc2_:Loader = null;
         if(this._fp1150)
         {
            return;
         }
         if(param1 >= this._sb154.length)
         {
            return;
         }
         this._dp547 = this._nv596 * this._ol1093 + this._sb154[0].dy;
         this._he1319 = this._sb154[0].scale;
         this._lm504();
         _loc2_ = new Loader();
         _loc2_.contentLoaderInfo.addEventListener(Event.COMPLETE,this._kv710,false,0,true);
         _loc2_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this._vi587,false,0,true);
         _loc2_.contentLoaderInfo.addEventListener(ErrorEvent.ERROR,this._vi587,false,0,true);
         _loc2_.contentLoaderInfo.addEventListener(IOErrorEvent.NETWORK_ERROR,this._vi587,false,0,true);
         _loc2_.load(new URLRequest(this._sb154[param1]._rl419()));
         this._sw1410 = this._sb154[param1]._rl419();
         this.view.visible = false;
      }
      
      public function _yl1177(param1:Event) : void
      {
         this.paused = true;
         this._aw1027 = true;
         this._jh356 = true;
         this._md314();
      }
      
      private function _cm417() : void
      {
         this._il1124 = false;
         if(contains(this._ac1326))
         {
            removeChild(this._ac1326);
         }
      }

      public function _mt1369(param1:Event) : void
      {
         if(this._tl596 > 0)
         {
            this._xp992 = true;
            this._mt484 = true;
            this._tl596 = 0;
         }
      }

      public function _ka1372(param1:Event) : void
      {
         this.paused = true;
         this._ww743 = true;
         this._jt840 = true;
         this._md314();
      }
   }
}
