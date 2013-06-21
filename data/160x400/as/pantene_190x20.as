import com.greensock.TweenNano;
function init() {
	logo_mc._alpha = copy01._alpha = copy02._alpha = copy03._alpha = copy04._alpha = copy05._alpha = copy06._alpha = copy07._alpha = copy08._alpha = copy09._alpha = 0;
	logo_mc._visible = copy01._visible = copy02._visible = copy03._visible = copy04._visible = copy05._visible = copy06._visible = copy07._visible = copy08._visible = copy09._visible = true;
	initFrame0();
}
function initFrame0() {
	logo_mc._alpha = copy01._alpha = copy02._alpha = copy03._alpha = copy04._alpha = copy05._alpha = copy06._alpha = copy07._alpha = copy08._alpha = copy09._alpha = 100;
	logo_mc._visible = copy01._visible = copy02._visible = copy03._visible = copy04._visible = copy05._visible = copy06._visible = copy07._visible = copy08._visible = copy09._visible = true;
	
	var delay = 0;
	TweenNano.from(logo_mc, .4, { _alpha:0, delay:delay } );
	delay += 1.6;
	TweenNano.to(logo_mc, .4, { _alpha:0, delay:delay, overwrite:false } );
	
	delay += .2;
	TweenNano.from(copy00, .4, { _alpha:0, delay:delay } );
	delay += 1.6;
	TweenNano.to(copy00, .4, { _alpha:0, delay:delay, overwrite:false } );
	
	delay += .2;
	TweenNano.from(copy01, .4, { _alpha:0, delay:delay } );
	delay += 1.6;
	TweenNano.to(copy01, .4, { _alpha:0, delay:delay, overwrite:false } );
	
	delay += .2;
	TweenNano.from(copy02, .4, { _alpha:0, delay:delay } );
	delay += 1;
	TweenNano.to(copy02, .4, { _alpha:0, delay:delay, overwrite:false } );
	
	delay += .2;
	TweenNano.from(copy03, .4, { _alpha:0, delay:delay } );
	delay += 1;
	TweenNano.to(copy03, .4, { _alpha:0, delay:delay, overwrite:false } );
	
	delay += .2;
	TweenNano.from(copy04, .4, { _alpha:0, delay:delay } );
	delay += 1;
	TweenNano.to(copy04, .4, { _alpha:0, delay:delay, overwrite:false } );
	
	delay += .8;
	TweenNano.from(copy05, .4, { _alpha:0, delay:delay } );
	delay += 1.6;
	TweenNano.to(copy05, .4, { _alpha:0, delay:delay, overwrite:false } );
	
	delay += .2;
	TweenNano.from(copy06, .4, { _alpha:0, delay:delay } );
	delay += 1.6;
	TweenNano.to(copy06, .4, { _alpha:0, delay:delay, overwrite:false } );
	
	delay += .2;
	TweenNano.from(copy07, .4, { _alpha:0, delay:delay } );
	delay += 1.3;
	TweenNano.to(copy07, .4, { _alpha:0, delay:delay, overwrite:false } );
	
	delay += 1;
	TweenNano.from(copy08, .4, { _alpha:0, delay:delay } );
	delay += .2;
	TweenNano.from(copy09, .4, { _alpha:0, delay:delay } );
}
init();