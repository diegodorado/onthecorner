import com.greensock.TweenNano;
function init() {
	copy21._alpha = botonMas._alpha = logo_mc._alpha = holder_video._alpha = bgVideo._alpha = 0;
	copy21._visible = botonMas._visible = logo_mc._visible = holder_video._visible = bgVideo._visible = false;
	initFrame0();
}
function initFrame0() {
	copy21._alpha = botonMas._alpha = logo_mc._alpha = holder_video._alpha = bgVideo._alpha = 100;
	copy21._visible = botonMas._visible = logo_mc._visible = holder_video._visible = bgVideo._visible = true;
	
	var delay = 0;
	TweenNano.from(copy21, .4, { _alpha:0, delay:delay } );
	
	delay += .2;
	TweenNano.from(holder_video, .4, { _alpha:0, delay:delay } );
	
	delay += .2;
	TweenNano.from(bgVideo, .4, { _alpha:0, delay:delay } );
	
	delay += .2;
	TweenNano.from(botonMas, .4, { _alpha:0, delay:delay } );
	
	delay += .2;
	TweenNano.from(logo_mc, .4, { _alpha:0, delay:delay } );
}
init();
stop();