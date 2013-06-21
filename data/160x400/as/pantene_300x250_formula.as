import com.greensock.TweenNano;
function init() {
	logo_mc._alpha = bg0._alpha = copy0._alpha = copy1._alpha = copy2._alpha = bg2._alpha = 0;
	logo_mc._visible = bg0._visible = copy0._visible = copy1._visible = copy2._visible = bg2._visible = false;
	copy30._alpha = copy31._alpha = botonMas._alpha = 0;
	copy30._visible = copy31._visible = botonMas._visible = false;
	initFrame0();
}
function initFrame0() {
	logo_mc._alpha = bg0._alpha = copy0._alpha = 100;
	logo_mc._visible = bg0._visible = copy0._visible = true;
	
	TweenNano.from(logo_mc, .4, {_alpha:0});
	//copys
	TweenNano.from(copy0, .4, {_alpha:0, _y:copy0._y-10, delay:.4});
	TweenNano.from(bg0,.8, { _alpha:0, delay:0 } );
	setTimeout(salidaFrame0, 2700);
}
function salidaFrame0() {
	TweenNano.to(copy0, .4, {_alpha:0, _y:copy0._y+10, onComplete:initFrame1});
}


function initFrame1() {
	copy1._alpha = 100;
	copy1._visible = true;
	TweenNano.from(copy1, .4, {_alpha:0, _y:copy1._y-10});
	setTimeout(salidaFrame1, 2700);
}
function salidaFrame1() {
	TweenNano.to(copy1, .4, { _alpha:0, _y:copy1._y+10, onComplete:initFrame2} );
}


function initFrame2() {
	copy2._alpha = 100;
	copy2._visible = true;
	
	TweenNano.from(copy2, .4, {_alpha:0, _y:copy2._y-10});
	setTimeout(salidaFrame2, 3100);
}
function salidaFrame2() {
	TweenNano.to(bg0,.8, { _alpha:0 } );
	TweenNano.to(copy2, .4, { _alpha:0, _y:copy2._y+10, onComplete:initFrame4} );
}

function initFrame4() {
	bg2._visible = copy30._visible = copy31._visible = botonMas._visible =true;
	bg2._alpha = copy30._alpha = copy31._alpha = botonMas._alpha = 100;
	
	TweenNano.from(bg2, .4, { _alpha:0, onComplete: showAnimFinal} );
	TweenNano.from(copy30, .4, {_alpha:0, _y:copy10._y - 10, delay:.4});
	TweenNano.from(copy31, .4, { _alpha:0, _y:copy11._y - 10, delay:1 } );
	TweenNano.from(botonMas, .4, {_alpha:0, _x:botonMas._x - 10, delay:2, onComplete:mostrarTiempo});
}

function showAnimFinal() {
	bg2.play();
}

function mostrarTiempo() {
	trace(getTimer());
}

stop();
init();