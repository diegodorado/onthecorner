import com.greensock.TweenNano;
function init() {
	logo_mc._alpha = bg0._alpha = copy0._alpha = elNuevoAge._alpha = bg1._alpha = copy11._alpha = 0;
	logo_mc._visible = bg0._visible = copy0._visible = elNuevoAge._visible = bg1._visible = copy11._visible = false;
	
	linea._alpha = copy12._alpha = bg2._alpha = copy21._alpha = pack._alpha = bg3._alpha = copy30._alpha = copy31._alpha = botonMas._alpha = 0;
	linea._visible = copy12._visible = bg2._visible = copy21._visible = pack._visible = bg3._visible = copy30._visible = copy31._visible = botonMas._visible = false;
	initFrame0();
}
function initFrame0() {
	logo_mc._alpha = bg0._alpha = copy0._alpha = 100;
	logo_mc._visible = bg0._visible = copy0._visible = true;
	
	TweenNano.from(logo_mc, .4, {_alpha:0});
	//copys
	TweenNano.from(copy0, .4, {_alpha:0, _y:copy0._y-10, delay:.4});
	TweenNano.from(bg0, .8, { _alpha:0, delay:0 } );
	
	setTimeout(salidaFrame0, 3000);
}
function salidaFrame0() {
	TweenNano.to(copy0, .3, {_alpha:0, onComplete:initFrame1});
	TweenNano.to(bg0, .8, {_alpha:0});
}


function initFrame1() {
	elNuevoAge._alpha = bg1._alpha = pack._alpha = 100;
	elNuevoAge._visible = bg1._visible = pack._visible =  true;
	TweenNano.from(elNuevoAge, .4, {_alpha:0, _y:elNuevoAge._y-10});
	TweenNano.from(bg1, 2, { _alpha:0, delay:0.3 } );
	TweenNano.from(pack, 8, {_y:-pack._height, _x:pack._x-90, delay:0});
	setTimeout(salidaFrame1, 2500);
}
function salidaFrame1() {
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
	TweenNano.to(copy11, .3, {_alpha:0, delay:.15});
	TweenNano.to(linea, .3, { _alpha:0, delay:.2 } );
	TweenNano.to(elNuevoAge, .5, { _xscale:82, _yscale:82, _x:529, _y:0 } );
	TweenNano.to(copy12, .3, {_alpha:0, delay:.25, onComplete:initFrame3});
}

function initFrame3() {
	bg2._alpha = copy21._alpha = botonMas._alpha = 100;
	bg2._visible = copy21._visible = botonMas._visible = true;
	
	TweenNano.from(copy21, .4, {_alpha:0, _y:copy21._y-10, delay:.4});
	TweenNano.from(bg2, .8, { _alpha:0, delay:0.1 } );
	TweenNano.from(botonMas, .4, {_alpha:0, _x:botonMas._x - 10, delay:2, onComplete:mostrarTiempo});
}

function mostrarTiempo() {
	trace(getTimer());
}

stop();
init();