import com.greensock.TweenNano;
function init() {
	logo_mc._alpha = bg0._alpha = copy00._alpha = copy01._alpha = copy02._alpha = theMask._alpha = bordemask._alpha = pack._alpha = 0;
	logo_mc._visible = bg0._visible = copy00._visible = copy01._visible = copy02._visible = theMask._visible = bordemask._visible = pack._visible = false;
	despues._alpha = antes._alpha = bg1._alpha = copy10._alpha = copy11._alpha = botonMas._alpha = 0;
	despues._visible = antes._visible = bg1._visible = copy10._visible = copy11._visible = botonMas._visible = false;
	initFrame0();
}
function initFrame0() {
	logo_mc._alpha = bg0._alpha = copy00._alpha = copy01._alpha = copy02._alpha = theMask._alpha = despues._alpha = antes._alpha = 100;
	logo_mc._visible = bg0._visible = copy00._visible = copy01._visible = copy02._visible = theMask._visible = despues._visible = antes._visible = true;
	
	TweenNano.from(logo_mc, .4, {_alpha:0});
	//copys
	TweenNano.from(copy00, .4, {_alpha:0, _y:copy00._y-10, delay:.4});
	TweenNano.from(copy01, .4, { _alpha:0, _y:copy01._y - 10, delay:1.6 } );
	TweenNano.from(copy02, .4, { _alpha:0, _y:copy02._y - 10, delay:3 } );
	//
	TweenNano.from(antes, .8, { _alpha:0, delay:.4 } );
	setTimeout(salidaFrame0, 7000);
	var fromx:Number = theMask._x - theMask._width;
	TweenNano.from(theMask, 6, {_alpha:0, _x:fromx, delay:2});
	setTimeout(frame0MaskAnim, 2000, fromx);
}

function frame0MaskAnim(fromx) {
	bordemask._visible = true;
	bordemask._alpha = 100; 
	TweenNano.from(bordemask, 6, {_alpha:.2, _x:fromx});
}
function salidaFrame0() {
	antes._alpha = 0;
	antes._visible = false;
	
	TweenNano.to(copy00, .4, {_alpha:0});
	TweenNano.to(copy01, .4, {_alpha:0});
	TweenNano.to(copy02, .4, {_alpha:0});
	TweenNano.to(bg0, .8, {_alpha:0, delay:.4});
	TweenNano.to(despues, .8, {_alpha:0, onComplete:initFrame1});
}

function initFrame1() {
	bg1._visible = copy10._visible = copy11._visible = botonMas._visible = pack._visible = true;
	bg1._alpha = copy10._alpha = copy11._alpha = botonMas._alpha = pack._alpha = 100;
	
	TweenNano.from(bg1, .7, { _alpha:0} );
	TweenNano.from(copy10, .4, {_alpha:0, _y:copy10._y - 10, delay:.4});
	TweenNano.from(copy11, .4, { _alpha:0, _y:copy11._y - 10, delay:1 } );
	TweenNano.from(pack, 1, { _alpha:0, _y:pack._y + 30, delay:0 } );
	TweenNano.from(botonMas, .4, {_alpha:0, _x:botonMas._x - 10, delay:2});
}

stop();
init();