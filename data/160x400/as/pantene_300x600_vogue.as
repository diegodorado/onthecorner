import com.greensock.TweenNano;
function init() {
	logo_mc._alpha = copy1._alpha = boton_mc._alpha = packs_mc._alpha = copy0._alpha = courtney_mc._alpha = courtney_mc._alpha = nuevoAge._alpha = 0;
	logo_mc._visible = copy1._visible = boton_mc._visible = packs_mc._visible = copy0._visible = courtney_mc._visible = courtney_mc._visible = nuevoAge._visible = false;
	initFrame0();
}
function initFrame0() {
	logo_mc._visible = courtney_mc._visible = copy0._visible = true;
	logo_mc._alpha = courtney_mc._alpha = copy0._alpha = 100;
	
	TweenNano.from(logo_mc, .4, {_alpha:0});
	TweenNano.from(courtney_mc, 1.4, {_alpha:0, delay:.1});
	TweenNano.from(copy0, .8, {_alpha:0, _y:copy0._y-15, delay:.8});
	setTimeout(salidaFrame0, 4500);
}
function salidaFrame0() {
	TweenNano.to(courtney_mc, .8, {_alpha:0});
	TweenNano.to(copy0, .4, {_alpha:0, onComplete:initFrame1});
}

function initFrame1() {
	copy1._visible = packs_mc._visible = boton_mc._visible = nuevoAge._visible = true;
	copy1._alpha = packs_mc._alpha = boton_mc._alpha = nuevoAge._alpha = 100;
	TweenNano.from(boton_mc, .8, {_alpha:0, _x:boton_mc._x-15, delay:1.4});
	TweenNano.from(packs_mc, 1.2, { _alpha:0, onComplete:callbackFrame1 } );
	packs_mc.play();
	TweenNano.from(copy1, .6, {_alpha:0, _y:copy1._y-25, delay:.3});
	TweenNano.from(nuevoAge, .6, {_alpha:0, _y:nuevoAge._y-25});
}

stop();
init();