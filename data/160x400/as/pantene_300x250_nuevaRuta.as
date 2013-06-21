import com.greensock.TweenNano;
function init() {
	logo_mc._alpha = bg0._alpha = copy0._alpha = elNuevoAge._alpha = bg1._alpha = 0;
	logo_mc._visible = bg0._visible = copy0._visible = elNuevoAge._visible = bg1._visible = false;
	
	copy30._alpha = copy31._alpha = botonMas._alpha = bg3._alpha = 0;
	copy30._visible = copy31._visible = botonMas._visible = bg3._visible = false;
	initFrame0();
}
function initFrame0() {
	logo_mc._alpha = bg0._alpha = copy0._alpha = 100;
	logo_mc._visible = bg0._visible = copy0._visible = true;
	
	TweenNano.from(logo_mc, .4, {_alpha:0});
	//copys
	TweenNano.from(copy0, .4, {_alpha:0, _y:copy0._y-10, delay:.4});
	TweenNano.from(bg0, .8, { _alpha:0, delay:0 } );
	
	setTimeout(salidaFrame0, 4000);
}
function salidaFrame0() {
	TweenNano.to(copy0, .2, {_alpha:0, onComplete:initFrame1});
	TweenNano.to(bg0, .7, {_alpha:0});
}


function initFrame1() {
	elNuevoAge._alpha = bg1._alpha = 100;
	elNuevoAge._visible = bg1._visible = true;
	TweenNano.from(elNuevoAge, .4, {_alpha:0, _y:elNuevoAge._y-10, delay:.2});
	TweenNano.from(bg1, .8, { _alpha:0, delay:0.3 } );
	setTimeout(salidaFrame1, 3500);
}
function salidaFrame1() {
	TweenNano.to(bg1, .8, { _alpha:0} );
	TweenNano.to(elNuevoAge, .4, { _alpha:0} );
	setTimeout(initFrame4, 200);
}

function initFrame4() {
	bg3._visible = copy30._visible = copy31._visible = botonMas._visible =true;
	bg3._alpha = copy30._alpha = copy31._alpha = botonMas._alpha = 100;
	
	TweenNano.from(bg3, .4, { _alpha:0, onComplete: showAnimFinal} );
	TweenNano.from(copy30, .4, {_alpha:0, _y:copy30._y - 10, delay:.4});
	TweenNano.from(copy31, .4, { _alpha:0, _y:copy31._y - 10, delay:1 } );
	TweenNano.from(botonMas, .4, {_alpha:0, _x:botonMas._x - 10, delay:2, onComplete:mostrarTiempo});
}

function showAnimFinal() {
	bg3.play();
}

function mostrarTiempo() {
	trace(getTimer());
}

stop();
init();