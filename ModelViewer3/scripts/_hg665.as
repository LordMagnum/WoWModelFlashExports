package
{
   import away3d.containers.Scene3D;
   import away3d.core.base.Face;
   import away3d.core.base.Mesh;
   import away3d.materials.BitmapMaterial;
   import away3d.materials.CompositeMaterial;
   import away3d.materials.ILayerMaterial;
   import away3d.materials.ITriangleMaterial;
   import away3d.materials.TransformBitmapMaterial;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.geom.ColorTransform;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class _hg665
   {
      
      public static var _lg679:Array = new Array(60,61,62,64,65,66,67,68,69,70,73,74,75,76,77,78,89,80,81,82,83,84,96,97,98,99,100,101,102,103,104,113,119,120,123,128,129,133,134,185,186,195);
       
      
      public var active:Boolean = true;
      
      public var _sg291:Array;
      
      public var _go868:Array;
      
      public var _qh394:int = 0;
      
      public var _gd117:int;
      
      public var materialDictionary:Dictionary;
      
      public var _ou1181:Array;
      
      public var attachment:_du1292;
      
      public var _wh712:Array;
      
      public var _aj586:int;
      
      public var materials:Array;
      
      public var _rv866:Array;
      
      public var _dt291:Array;
      
      public var _sl1117:Boolean = false;
      
      public var _pw1380:int;
      
      public var _ti178:String;
      
      public var _st654:Array;
      
      public var _uu348:Array;
      
      public var meshes:Array;
      
      public var _uv798:String;
      
      public var _so1284:Array;
      
      public var _gy438:Vector.<_ex1172>;
      
      public var _fj1017:Array;
      
      public var _cr1245:Array;
      
      public var _la1406:int = 0;
      
      public var _tk257:Array;
      
      public var colors:Array;
      
      public var header:_df421;
      
      public var _hj211:Array;
      
      public var _ow1382:Array;
      
      public var _nm696:Array;
      
      public var _aa337:int;
      
      public var _nh1322:Array;
      
      public var _mk1056:Array;
      
      public var attachments:Array;
      
      public var _he452:int;
      
      public var _ft1167:Array;
      
      public var _tw245:Array;
      
      public var _is807:int;
      
      public var _kc483:Array;
      
      public var _rt1094:int;
      
      public var _sf352:Array;
      
      public var _wy1288:int = 0;
      
      public var _rc843:Mesh;
      
      public var _dh1237:Array;
      
      public var _lp341:int;
      
      public var _go854:Array;
      
      public var _un480:Array;
      
      public var vertices:Array;
      
      public var _ss897:Dictionary;
      
      public function _hg665(param1:ByteArray, param2:ByteArray = null)
      {
         this._so1284 = [];
         this._nh1322 = [];
         this.materialDictionary = new Dictionary();
         super();
         this.header = new _df421(param1);
         this._nm696 = _wl552._ds135(param1,this.header._nm696);
         this._gy438 = _wl552._pf456(param1,this.header._gy438);
         this._st654 = _wl552._xv388(param1,this.header._kj1244);
         this.vertices = _wl552._eb595(param1,this.header.vertices);
         this.attachments = _wl552._fy1311(param1,this.header.attachments);
         this._ou1181 = _wl552._cg1012(param1,this.header.textures);
         this._ft1167 = _wl552._xv388(param1,this.header._gu635);
         this._un480 = _wl552._gh1379(param1,this.header.materials);
         this._fj1017 = _wl552._ec191(param1,this.header._sg1148);
         this._fj1017 = _wl552._ec191(param1,this.header._sg1148);
         this.colors = _wl552._yj684(param1,this.header.colors,this);
         this._cr1245 = [];
         var _loc3_:int = 0;
         while(_loc3_ < this._ft1167.length)
         {
            this._cr1245[_loc3_] = false;
            _loc3_++;
         }
         this._kc483 = _wl552._nw119(param1,this.header._kc483);
         this._go854 = _wl552._nw119(param1,this.header._go854);
         this._hj211 = _wl552._nw119(param1,this.header._hj211);
         this._sg291 = _wl552._nw119(param1,this.header._sg291);
         this._uu348 = _wl552._nw119(param1,this.header._uu348);
         if((this.header.flags & _md341._tp1328) != 0)
         {
            this._sf352 = _wl552._nw119(param1,this.header._sf352);
         }
         if(param2 != null)
         {
            this._ld46(param2);
         }
         this._rc843 = new Mesh();
         this.meshes = [];
         this.meshes.push(this._rc843);
         this._ai693(0,param1);
         this._la487(0,param1);
         this.attachment = null;
         this._tk257 = [];
         this._ss897 = new Dictionary();
         this._mk1056 = [];
         this._aa337 = -1;
         this._lp341 = -1;
      }
      
      public function _aw1027() : void
      {
         this._he452 = this._he452 + 10;
      }
      
      public function _wm1212() : void
      {
         this._la1406++;
         while(true)
         {
            if(this._la1406 >= this._ft1167.length)
            {
               this._la1406 = 0;
               continue;
            }
            if(this._ft1167[this._la1406] < 0)
            {
               this._la1406++;
               continue;
            }
            break;
         }
         this._mg538(this._ft1167[this._la1406]);
      }
      
      public function _uo746(param1:int) : void
      {
         var _loc2_:int = this._ft1167[this._la1406];
         var _loc3_:int = 0;
         while(_loc3_ < param1 && this._nm696[_loc2_]._le375 != _md341._qi1135)
         {
            _loc2_ = this._nm696[_loc2_]._le375;
            _loc3_++;
         }
         this._qh394 = _loc2_;
      }
      
      public function getBitmap(param1:_iq662, param2:Array, param3:Boolean) : BitmapData
      {
         if(param1 == null)
         {
            return null;
         }
         if(param1.type == 0)
         {
            return this._fp1142(param1._aj418,param3);
         }
         if(param2 != null && param2[param1.type])
         {
            return param2[param1.type].getBitmap(param3);
         }
         return null;
      }
      
      public function hide(param1:Scene3D) : void
      {
         var _loc2_:Mesh = null;
         this.active = false;
         for each(_loc2_ in this.meshes)
         {
            param1.removeChild(_loc2_);
         }
      }
      
      public function _kh1192(param1:Array) : Boolean
      {
         var _loc2_:_yy607 = null;
         for each(_loc2_ in param1)
         {
            if(_loc2_._ta834 == 0)
            {
               return true;
            }
         }
         return false;
      }
      
      public function attach(param1:_cd1218) : void
      {
         var _loc4_:_du1292 = null;
         var _loc5_:Mesh = null;
         var _loc2_:_hg665 = param1._am1119();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:Array = param1._hp1175();
         _loc2_._is654(_loc3_);
         for each(_loc4_ in this.attachments)
         {
            if(_loc4_._by1186 == param1._tp240)
            {
               _loc2_.attachment = _loc4_;
               break;
            }
         }
         this._tk257.push(_loc2_);
         for each(_loc5_ in _loc2_.meshes)
         {
            this.meshes.push(_loc5_);
         }
      }
      
      public function _mq392(param1:Scene3D) : void
      {
         var _loc2_:_ex1172 = null;
         var _loc3_:_hg665 = null;
         for each(_loc2_ in this._gy438)
         {
            _loc2_._bf499 = -1;
         }
         for each(_loc3_ in this._tk257)
         {
            if(_loc3_._ti178 == "melee" || _loc3_._ti178 == "ranged")
            {
               _loc3_.hide(param1);
            }
         }
      }
      
      public function _mg538(param1:int) : void
      {
         var _loc3_:_nm1047 = null;
         this._la1406 = param1;
         if(param1 < 0 || param1 >= this._ft1167.length || this._ft1167[param1] < 0)
         {
            this._qh394 = this._ft1167[0];
         }
         else
         {
            this._qh394 = this._ft1167[this._la1406];
         }
         this._rt1094 = 0;
         var _loc2_:int = this._qh394;
         while(_loc2_ != _md341._qi1135)
         {
            _loc3_ = this._nm696[_loc2_];
            this._rt1094++;
            _loc2_ = _loc3_._le375;
         }
         this._wy1288 = 0;
         this._he452 = 0;
      }
      
      public function _fp1142(param1:String, param2:Boolean) : BitmapData
      {
         var _loc4_:String = null;
         var _loc5_:_xy565 = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._so1284.length)
         {
            _loc4_ = this._so1284[_loc3_];
            if(_loc4_.localeCompare(param1) == 0)
            {
               _loc5_ = this._nh1322[_loc3_];
               return _loc5_.getBitmap(param2);
            }
            _loc3_++;
         }
         return null;
      }
      
      public function _fq402(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:int = this._ft1167[param1];
         var _loc5_:int = param2;
         while(_loc5_ <= param3)
         {
            if(_loc5_ < this._st654.length && this._st654[_loc5_] >= 0)
            {
               this._gy438[this._st654[_loc5_]]._bf499 = _loc4_;
            }
            _loc5_++;
         }
      }
      
      public function _me1162(param1:_pg792) : void
      {
         var _loc2_:int = 0;
         _loc2_ = param1._yx150;
         while(_loc2_ < param1._yx150 + param1._tf1408)
         {
            this.vertices[this._wh712[_loc2_]]._rn255++;
            _loc2_++;
         }
      }
      
      public function _cx47(param1:String, param2:_xy565) : void
      {
         this._ss897[param1] = param2;
         this._so1284.push(param1);
         this._nh1322.push(param2);
      }
      
      public function _tm1411(param1:_pg792) : void
      {
         var _loc2_:int = param1._yx150;
         while(_loc2_ < param1._yx150 + param1._tf1408)
         {
            this.vertices[this._wh712[_loc2_]]._rn255--;
            _loc2_++;
         }
      }
      
      public function _la487(param1:int, param2:ByteArray) : void
      {
         var _loc3_:_nm1047 = null;
         var _loc4_:int = this._ft1167[param1];
         if(_loc4_ < 0 || _loc4_ >= this._nm696.length)
         {
            return;
         }
         while(true)
         {
            _loc3_ = this._nm696[_loc4_];
            this._ai693(_loc4_,param2);
            if(_loc3_._le375 == _md341._qi1135)
            {
               break;
            }
            _loc4_ = _loc3_._le375;
         }
         this._cr1245[param1] = true;
      }
      
      public function _ai693(param1:int, param2:ByteArray) : void
      {
         var _loc3_:_ex1172 = null;
         for each(_loc3_ in this._gy438)
         {
            _loc3_._la487(param1,param2);
         }
      }
      
      public function _ck599(param1:_yy607) : int
      {
         if(this._sf352 != null)
         {
            return this._sf352[param1.shader];
         }
         var _loc2_:int = this._un480[param1._jo928].blendMode;
         return _loc2_ == 0?1:0;
      }
      
      public function _ul1137(param1:_yy607, param2:Array, param3:Boolean = false) : ILayerMaterial
      {
         var _loc8_:BitmapData = null;
         var _loc17_:BitmapData = null;
         var _loc18_:TransformBitmapMaterial = null;
         var _loc19_:CompositeMaterial = null;
         if(param1 == null)
         {
            return null;
         }
         var _loc4_:_iq662 = this._ou1181[this._go854[param1._qi1054]];
         var _loc5_:_le493 = this._un480[param1._jo928];
         var _loc6_:int = _loc5_.blendMode;
         var _loc7_:int = _loc5_.flags;
         if(_loc6_ == 0)
         {
            _loc8_ = this.getBitmap(_loc4_,param2,false);
         }
         else
         {
            _loc8_ = this.getBitmap(_loc4_,param2,true);
         }
         if(_loc8_ == null)
         {
            return null;
         }
         var _loc9_:String = this._cn238(param1,_loc5_,_loc4_);
         var _loc10_:ILayerMaterial = this.materialDictionary[_loc9_];
         if(_loc10_ != null)
         {
            return _loc10_;
         }
         var _loc11_:int = this._uu348[param1._iv1023];
         var _loc12_:String = null;
         var _loc13_:ColorTransform = null;
         var _loc14_:BitmapMaterial = null;
         var _loc15_:_rn1037 = null;
         if(_loc11_ != _md341._qi1135)
         {
            _loc15_ = this._fj1017[_loc11_];
         }
         else if(param3 && param1._ta834 > 0)
         {
         }
         if(_loc6_ == 4)
         {
            if(_uy1049._kt737 == _uy1049._mm1049)
            {
               return null;
            }
            _loc12_ = BlendMode.ADD;
         }
         else if(_loc6_ == 5)
         {
            if(_uy1049._kt737 == _uy1049._mm1049)
            {
               return null;
            }
            _loc12_ = BlendMode.MULTIPLY;
         }
         else if(_loc6_ == 6)
         {
            if(_uy1049._kt737 == _uy1049._mm1049)
            {
               return null;
            }
            _loc13_ = new ColorTransform(2,2,2);
            _loc12_ = BlendMode.MULTIPLY;
         }
         if(_loc13_)
         {
            _loc17_ = new BitmapData(_loc8_.width,_loc8_.height,true,16777215);
            _loc17_.draw(_loc8_,null,_loc13_);
            _loc8_ = _loc17_;
         }
         if(_loc15_)
         {
            _loc18_ = new TransformBitmapMaterial(_loc8_);
            _loc15_.addMaterial(_loc18_);
            if((_loc4_.flags & _iq662._lx401) != 0)
            {
               _loc18_.repeat = true;
            }
            _loc14_ = _loc18_;
         }
         else
         {
            _loc14_ = new BitmapMaterial(_loc8_);
         }
         _loc14_.smooth = true;
         _loc14_.precision = 0;
         var _loc16_:ILayerMaterial = _loc14_;
         if(_loc12_ != null)
         {
            _loc19_ = new CompositeMaterial();
            _loc14_.blendMode = _loc12_;
            _loc19_.blendMode = _loc12_;
            _loc19_.addMaterial(_loc14_);
            _loc16_ = _loc19_;
         }
         if((_loc7_ & 0) != 0)
         {
            _loc14_.repeat = true;
         }
         return _loc16_;
      }
      
      public function _gg1157(param1:_pg792, param2:Array, param3:Array) : void
      {
         var _loc7_:Mesh = null;
         var _loc10_:_nx958 = null;
         var _loc11_:_nx958 = null;
         var _loc12_:_nx958 = null;
         var _loc13_:Face = null;
         if(param1 == null)
         {
            return;
         }
         var _loc4_:ITriangleMaterial = this._bm1206(param2,param3);
         var _loc5_:_yy607 = param2[0];
         var _loc6_:_le493 = this._un480[_loc5_._jo928];
         if(_loc4_ == null)
         {
            return;
         }
         var _loc8_:* = _loc5_._nx1273 != _md341._qi1135;
         if(!_loc8_)
         {
            _loc7_ = this._rc843;
         }
         else
         {
            _loc7_ = new Mesh();
         }
         var _loc9_:int = param1._yx150;
         while(_loc9_ < param1._yx150 + param1._tf1408)
         {
            _loc10_ = this.vertices[this._wh712[_loc9_]];
            _loc11_ = this.vertices[this._wh712[_loc9_ + 1]];
            _loc12_ = this.vertices[this._wh712[_loc9_ + 2]];
            _loc10_.active = true;
            _loc11_.active = true;
            _loc12_.active = true;
            _loc13_ = new Face(_loc10_.vertex,_loc11_.vertex,_loc12_.vertex,_loc4_,_loc10_.uv,_loc11_.uv,_loc12_.uv);
            _loc7_.addFace(_loc13_);
            _loc9_ = _loc9_ + 3;
         }
         if(_loc6_._lf10())
         {
            _loc9_ = param1._yx150;
            while(_loc9_ < param1._yx150 + param1._tf1408)
            {
               _loc12_ = this.vertices[this._wh712[_loc9_]];
               _loc11_ = this.vertices[this._wh712[_loc9_ + 1]];
               _loc10_ = this.vertices[this._wh712[_loc9_ + 2]];
               _loc10_.active = true;
               _loc11_.active = true;
               _loc12_.active = true;
               _loc13_ = new Face(_loc10_.vertex,_loc11_.vertex,_loc12_.vertex,_loc4_,_loc10_.uv,_loc11_.uv,_loc12_.uv);
               _loc7_.addFace(_loc13_);
               _loc9_ = _loc9_ + 3;
            }
         }
         this._me1162(param1);
         if(_loc5_._nx1273 != _md341._qi1135)
         {
            this.colors[_loc5_._nx1273]._gg1157(param1,_loc7_);
         }
         if(_loc8_)
         {
            this.meshes.push(_loc7_);
         }
      }
      
      public function update(param1:int, param2:_kp1215 = null) : void
      {
         var _loc5_:_kp594 = null;
         var _loc6_:_ex1172 = null;
         var _loc7_:_ex1172 = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:_nx958 = null;
         var _loc11_:_hg665 = null;
         var _loc12_:_rn1037 = null;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:_nm1047 = null;
         var _loc17_:_du1292 = null;
         var _loc18_:_ex1172 = null;
         var _loc19_:_kp1215 = null;
         if(!this.active)
         {
            return;
         }
         var _loc3_:_nm1047 = this._nm696[this._qh394];
         var _loc4_:int = _loc3_.duration;
         if(param1 != 0)
         {
            this._pw1380 = this._pw1380 + param1;
            if(this._lp341 >= 0)
            {
               this._aj586 = this._aj586 + param1;
               if(this._aj586 >= this._is807)
               {
                  this._qh394 = this._lp341;
                  this._lp341 = -1;
                  this._he452 = 0;
               }
               else if(this._aj586 <= 0)
               {
                  this._lp341 = -1;
                  this._he452 = _loc4_ - 1;
               }
            }
            else
            {
               this._he452 = this._he452 + param1;
               if(this._he452 > _loc4_)
               {
                  this._wy1288 = 0;
                  if(this._rt1094 > 1)
                  {
                     _loc13_ = Math.random() * 32267;
                     _loc14_ = this._ft1167[this._la1406];
                     while(this._nm696[_loc14_]._le375 != _md341._qi1135)
                     {
                        _loc15_ = this._nm696[_loc14_]._mo920;
                        if(_loc13_ <= _loc15_)
                        {
                           break;
                        }
                        this._wy1288++;
                        _loc13_ = _loc13_ - _loc15_;
                        _loc14_ = this._nm696[_loc14_]._le375;
                     }
                     if(_loc3_._rr101 > 0 && _loc14_ != this._qh394)
                     {
                        this._lp341 = _loc14_;
                        this._aj586 = 0;
                        this._is807 = _loc3_._rr101;
                     }
                     else
                     {
                        this._qh394 = _loc14_;
                     }
                  }
                  this._he452 = 0;
               }
               else if(this._he452 < 0)
               {
                  this._wy1288 = 0;
                  if(this._rt1094 > 1)
                  {
                     _loc13_ = Math.random() * 32267;
                     _loc14_ = this._ft1167[this._la1406];
                     while(this._nm696[_loc14_]._le375 != _md341._qi1135)
                     {
                        _loc15_ = this._nm696[_loc14_]._mo920;
                        if(_loc13_ <= _loc15_)
                        {
                           break;
                        }
                        this._wy1288++;
                        _loc13_ = _loc13_ - _loc15_;
                        _loc14_ = this._nm696[_loc14_]._le375;
                     }
                     _loc16_ = this._nm696[_loc14_];
                     if(_loc16_._rr101 > 0 && _loc14_ != this._qh394)
                     {
                        this._lp341 = this._qh394;
                        this._aj586 = _loc16_._rr101 + this._he452;
                        this._is807 = _loc16_._rr101;
                        this._qh394 = _loc14_;
                     }
                     else
                     {
                        this._qh394 = _loc14_;
                        this._he452 = _loc16_.duration + this._he452;
                     }
                  }
                  else
                  {
                     this._he452 = _loc4_ + this._he452;
                  }
               }
            }
         }
         for each(_loc5_ in this.colors)
         {
            _loc5_.update(this._pw1380,this._qh394);
         }
         for each(_loc6_ in this._gy438)
         {
            _loc6_.reset();
         }
         for each(_loc7_ in this._gy438)
         {
            _loc7_.animate(this._gy438,this._qh394,this._he452,param2,this._lp341,this._aj586,this._is807,param1 >= 0);
         }
         _loc8_ = Number.MAX_VALUE;
         _loc9_ = Number.MIN_VALUE;
         for each(_loc10_ in this.vertices)
         {
            if(_loc10_.active)
            {
               _loc10_._oh897(this._gy438);
               if(_loc10_.position.z > _loc9_)
               {
                  _loc9_ = _loc10_.position.z;
               }
               if(_loc10_.position.z < _loc8_)
               {
                  _loc8_ = _loc10_.position.z;
               }
            }
         }
         for each(_loc11_ in this._tk257)
         {
            _loc17_ = _loc11_.attachment;
            if(_loc17_ == null)
            {
               trace("ack, null!!!");
               _loc11_.update(param1,null);
            }
            else
            {
               _loc18_ = this._gy438[_loc11_.attachment._nq395];
               _loc19_ = new _kp1215();
               _loc19_.copy(_loc18_._jl938);
               _loc19_.translate(_loc17_.position);
               _loc11_.update(param1,_loc19_);
            }
         }
         for each(_loc12_ in this._fj1017)
         {
            _loc12_.updateMaterials(this._pw1380);
         }
      }
      
      public function cleanUp() : void
      {
         this.materials = null;
         this._ss897 = null;
      }
      
      public function _cn238(param1:_yy607, param2:_le493, param3:_iq662) : String
      {
         var _loc4_:String = null;
         if(param3.type == 0)
         {
            _loc4_ = param3._aj418;
         }
         else
         {
            _loc4_ = String(param3.type);
         }
         _loc4_ = _loc4_ + param2.blendMode;
         _loc4_ = _loc4_ + param1._iv1023;
         return _loc4_;
      }
      
      public function _ld46(param1:ByteArray) : void
      {
         var _loc7_:int = 0;
         param1.position = 4;
         var _loc2_:_jk827 = new _jk827(param1);
         var _loc3_:_jk827 = new _jk827(param1);
         var _loc4_:_jk827 = new _jk827(param1);
         var _loc5_:_jk827 = new _jk827(param1);
         var _loc6_:_jk827 = new _jk827(param1);
         this._rv866 = _wl552._xv388(param1,_loc2_);
         this._go868 = _wl552._xv388(param1,_loc3_);
         this._dt291 = _wl552._cl1313(param1,_loc5_);
         this._ow1382 = _wl552._ij663(param1,_loc6_);
         this._wh712 = [];
         _loc7_ = 0;
         while(_loc7_ < _loc3_.length)
         {
            this._wh712[_loc7_] = this._rv866[this._go868[_loc7_]];
            _loc7_++;
         }
      }
      
      public function _nt652(param1:String, param2:Scene3D) : void
      {
         var _loc3_:_hg665 = null;
         for each(_loc3_ in this._tk257)
         {
            if(_loc3_._ti178 == param1)
            {
               _loc3_.show(param2);
            }
            if(_loc3_._gd117 == _md341._uh402)
            {
               this._fq402(_md341._wm920,_md341._mk790,_md341._mb1246);
            }
            else if(_loc3_._gd117 == _md341._aw974)
            {
               this._fq402(_md341._wm920,_md341._xn408,_md341._nk834);
            }
         }
      }
      
      public function _bm1206(param1:Array, param2:Array) : ITriangleMaterial
      {
         var _loc6_:ILayerMaterial = null;
         var _loc7_:_yy607 = null;
         var _loc8_:ILayerMaterial = null;
         if(param1.length == 1 || _uy1049._kt737 < _uy1049._is1127)
         {
            return this._ul1137(param1[0],param2) as ITriangleMaterial;
         }
         var _loc3_:CompositeMaterial = new CompositeMaterial();
         var _loc4_:Array = [];
         var _loc5_:int = 0;
         while(_loc5_ < 2)
         {
            _loc7_ = param1[_loc5_];
            _loc8_ = this._ul1137(_loc7_,param2);
            if(_loc8_ != null)
            {
               _loc4_.push(_loc8_);
            }
            _loc5_++;
         }
         if(_loc4_.length == 0)
         {
            return null;
         }
         if(_loc4_.length == 1)
         {
            return _loc4_[0];
         }
         for each(_loc6_ in _loc4_)
         {
            _loc3_.addMaterial(_loc6_);
         }
         return _loc3_;
      }
      
      public function _is654(param1:Array) : void
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this._ow1382.length)
         {
            if(this._ow1382[_loc2_]._ta834 == 0)
            {
               _loc3_ = [];
               _loc3_[0] = this._ow1382[_loc2_];
               _loc4_ = _loc2_ + 1;
               while(_loc4_ < this._ow1382.length)
               {
                  if(this._ow1382[_loc4_]._ta834 == 0)
                  {
                     break;
                  }
                  _loc3_[_loc4_ - _loc2_] = this._ow1382[_loc4_];
                  _loc4_++;
               }
               this._gg1157(this._dt291[this._ow1382[_loc2_]._va606],_loc3_,param1);
            }
            _loc2_++;
         }
      }
      
      public function show(param1:Scene3D) : void
      {
         var _loc2_:Mesh = null;
         this.active = true;
         for each(_loc2_ in this.meshes)
         {
            param1.addChild(_loc2_);
         }
      }
      
      public function _tg39(param1:int, param2:Array) : void
      {
         var _loc3_:int = 0;
         var _loc4_:_pg792 = null;
         var _loc5_:Array = null;
         var _loc6_:_yy607 = null;
         _loc3_ = 0;
         while(_loc3_ < this._dt291.length)
         {
            _loc4_ = this._dt291[_loc3_];
            if(_loc4_.id == param1)
            {
               _loc5_ = [];
               for each(_loc6_ in this._ow1382)
               {
                  if(_loc6_._va606 == _loc3_)
                  {
                     _loc5_[_loc6_._ta834] = _loc6_;
                  }
               }
               this._gg1157(_loc4_,_loc5_,param2);
            }
            _loc3_++;
         }
      }
   }
}
