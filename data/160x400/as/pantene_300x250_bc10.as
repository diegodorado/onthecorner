import com.greensock.TweenNano;
function init() {
	logo_mc._alpha = bg0._alpha = copy0._alpha = elNuevoAge._alpha = bg1._alpha = copy11._alpha = 0;
	logo_mc._visible = bg0._visible = copy0._visible = elNuevoAge._visible = bg1._visible = copy11._visible = false;
	
	linea._alpha = copy12._alpha = bg2._alpha = copy20._alpha = copy21._alpha = pack._alpha = bg3._alpha = copy30._alpha = copy31._alpha = botonMas._alpha = 0;
	linea._visible = copy12._visible = bg2._visible = copy20._visible = copy21._visible = pack._visible = bg3._visible = copy30._visible = copy31._visible = botonMas._visible = false;
	initFrame0();
}
function initFrame0() {
	logo_mc._alpha = bg0._alpha = copy0._alpha = 100;
	logo_mc._visible = bg0._visible = copy0._visible = true;
	
	TweenNano.from(logo_mc, .4, {_alpha:0});
	//copys
	TweenNano.from(copy0, .4, {_alpha:0, _y:copy0._y-10, delay:.4});
	TweenNano.from(bg0, .8, { _alpha:0, delay:0 } );
	
	setTimeout(salidaFrame0, 3500);
}
function salidaFrame0() {
	TweenNano.to(copy0, .3, {_alpha:0, onComplete:initFrame1});
	TweenNano.to(bg0, .8, {_alpha:0});
}


function initFrame1() {
	elNuevoAge._alpha = bg1._alpha = 100;
	elNuevoAge._visible = bg1._visible = true;
	TweenNano.from(elNuevoAge, .4, {_alpha:0, _y:elNuevoAge._y-10});
	TweenNano.from(bg1, .8, { _alpha:0, delay:0.3 } );
	setTimeout(salidaFrame1, 2500);
}
function salidaFrame1() {
	TweenNano.to(elNuevoAge, .4, { _xscale:57.415, _yscale:57.415, _x:96, _y:20} );
	setTimeout(initFrame2, 200);
}


function initFrame2() {
	copy11._alpha = linea._alpha = copy12._alpha = 100;
	copy11._visible = linea._visible = copy12._visible = true;
	
	TweenNano.from(copy11, .4, {_alpha:0, _y:copy11._y-10, delay:.3});
	TweenNano.from(linea, .4, { _xscale:0, delay:.4 } );
	TweenNano.from(copy12, .4, { _alpha:0, _y:copy12._y - 10, delay:.7 } );
	setTimeout(salidaFrame2, 4000);
}
function salidaFrame2() {
	TweenNano.to(elNuevoAge, .3, {_alpha:0});
	TweenNano.to(copy11, .3, {_alpha:0, delay:.15});
	TweenNano.to(linea, .3, {_alpha:0, delay:.2});
	TweenNano.to(copy12, .3, {_alpha:0, delay:.25, onComplete:initFrame3});
	TweenNano.to(bg1, .8, {_alpha:0});
}

function initFrame3() {
	bg2._alpha = copy20._alpha = copy21._alpha = pack._alpha = botonMas._alpha = 100;
	bg2._visible = copy20._visible = copy21._visible = pack._visible = botonMas._visible = true;
	
	TweenNano.from(copy20, .4, {_alpha:0, _y:copy20._y-10, delay:.2});
	TweenNano.from(copy21, .4, {_alpha:0, _y:copy21._y-10, delay:.4});
	TweenNano.from(pack, .8, {_alpha:0, _y:pack._y+50, delay:.6});
	TweenNano.from(bg2, .8, { _alpha:0, delay:0.1 } );
	TweenNano.from(botonMas, .4, {_alpha:0, _x:botonMas._x - 10, delay:2, onComplete:mostrarTiempo});
	trace('mireda');
}

function mostrarTiempo() {
  
	trace(getTimer());
}

stop();
//init();