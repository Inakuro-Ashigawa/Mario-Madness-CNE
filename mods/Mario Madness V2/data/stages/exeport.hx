var old = new CustomShader('border');
var old2 = new CustomShader('VCR');

function create(){
    turnevil = new FlxSprite(-500, -1000);
	turnevil.frames = Paths.getFrames('stages/HellishHights/mx/MX_Transformation_Assets');
    turnevil.setGraphicSize(Std.int(turnevil.width * 0.5));
    turnevil.alpha = 0.00001;
    turnevil.animation.addByPrefix('laugh', "MX Transformation", 24, false);
    turnevil.animation.finishCallback = function (n:String) {
        dad.alpha = boyfriend.alpha = fullbg.alpha = bgfloor.alpha = toad.alpha = luigibody.alpha = luigiempa.alpha = 1;
        turnevil.alpha = 0;
        FlxG.camera.flash(FlxColor.BLACK, 0.5);
        dadZoom = .4;
        bfZoom = .5;
    }
    gf.alpha = 0;
    add(turnevil);
    old2.perspectiveOn = true; 
    old2.vignetteMoving =  true;
    camGame.addShader(old2);
    camGame.addShader(old);
    camHUD.addShader(old);

    camEST.addShader(old2);
    camEST.addShader(old);
}
function events(shit){
    if (shit == "trans"){
        turnevil.alpha = 0.9;
        dad.alpha = boyfriend.alpha = BGGG.alpha = MXBG1_3.alpha = 0;
        turnevil.animation.play('laugh');
        FlxTween.tween(turnevil, {alpha: 0.3}, (0.5 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.quadOut});
    }
}
var dadZoom = .6;
var bfZoom = .6;
var timere = 0;
function update(elapsed:Float) {
	switch (curCameraTarget) {
		case 0:
			defaultCamZoom = dadZoom;
		case 1:
			defaultCamZoom = bfZoom;
	}
    timere += elapsed;
    old2.iTime = timere;
}