import com.greensock.TweenNano;
function init() {
	copy0._alpha = pack._alpha = copy00._alpha = copy01._alpha = copy02._alpha = copy03._alpha = legales_mc._alpha = 0;
	bg0._visible = pack._visible = copy00._visible = copy01._visible = copy02._visible = copy03._visible = legales_mc._visible = false;
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
	pack._alpha = copy00._alpha = copy01._alpha = copy02._alpha = copy03._alpha = legales_mc._alpha = 100;
	pack._visible = copy00._visible = copy01._visible =  copy02._visible = copy03._visible = legales_mc._visible = true;
	TweenNano.from(pack, .6, {_alpha:0});
	TweenNano.from(copy00, .3, { _alpha:0, delay:0.3 } );
	TweenNano.from(copy01, .6, { _alpha:0, delay:0.6 } );
	TweenNano.from(copy02, .5, { _alpha:0, delay:2.5, _y:copy02._y-10 } );
	TweenNano.from(copy03, .5, { _alpha:0, delay:3.5, _x:copy03._x - 20 } );
	TweenNano.from(legales_mc, .4, { _alpha:0, delay:3.5, onComplete:salidaFrame1 } );
}
function salidaFrame1() {
	trace("tt: " + getTimer());
}

stop();
init();