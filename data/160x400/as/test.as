import flash.external.*;

var btn:MovieClip = createButton();

btn.onPress = function() {
  ExternalInterface.call("pantene.click");
}

function createButton():MovieClip {
    var depth:Number = this.getNextHighestDepth();
    var mc:MovieClip = this.createEmptyMovieClip("mc_" + depth, depth);

    mc.beginFill(0, 0);
    mc.lineTo(0, 400);
    mc.lineTo(160, 400);
    mc.lineTo(160, 0);
    mc.lineTo(0, 0);

    return mc;
}