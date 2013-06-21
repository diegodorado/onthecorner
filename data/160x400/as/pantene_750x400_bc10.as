import com.greensock.TweenNano;
function init() {
	legales_mc._alpha = copy20._alpha = logo_mc._alpha = bg0._alpha = copy0._alpha = elNuevoAge._alpha = bg1._alpha = 0;
	legales_mc._visible = copy20._visible = logo_mc._visible = bg0._visible = copy0._visible = elNuevoAge._visible = bg1._visible = false;
	
	bg2._alpha = copy21._alpha = pack._alpha = bg3._alpha = copy30._alpha = copy31._alpha = botonMas._alpha = 0;
	bg2._visible = copy21._visible = pack._visible = bg3._visible = copy30._visible = copy31._visible = botonMas._visible = false;
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
	elNuevoAge._alpha = bg1._alpha = 100;
	elNuevoAge._visible = bg1._visible = true;
	TweenNano.from(elNuevoAge, .4, {_alpha:0, _y:elNuevoAge._y-10, delay:.2});
	TweenNano.from(bg1, .5, {_alpha:0});
	setTimeout(salidaFrame1, 2500);
}

function playAnim() {
	pack.play();
}
function salidaFrame1() {
	TweenNano.to(elNuevoAge, .4, { _alpha:0 } );
	setTimeout(initFrame3, 200);
}

function initFrame3() {
	pack._alpha = legales_mc._alpha = copy20._alpha = copy21._alpha = botonMas._alpha = 100;
	pack._visible =  legales_mc._visible = copy20._visible = copy21._visible = botonMas._visible = true;
	
	TweenNano.from(copy21, .4, {_alpha:0, _y:copy21._y-10, delay:.4});
	TweenNano.from(copy20, .4, {_alpha:0, _y:copy20._y-10, delay:.4});
	TweenNano.from(legales_mc, .8, { _alpha:0, delay:1 } );
	TweenNano.from(botonMas, .4, {_alpha:0, _x:botonMas._x - 10, delay:2, onComplete:mostrarTiempo});
}

function mostrarTiempo() {
	trace(getTimer());
}

stop();
init();