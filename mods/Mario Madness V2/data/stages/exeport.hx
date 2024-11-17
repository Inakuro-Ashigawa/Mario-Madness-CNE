import hxvlc.openfl.Video;
import hxvlc.flixel.FlxVideoSprite;
var blackBarThingie:FlxSprite;
var old2 = new CustomShader('VCR');
var old = new CustomShader('border');
var extraTimers:Array<FlxTimer> = [];

var midsongVid:FlxVideoSprite;
function create(){
    dad.x = 100;
    dad.y = 100;
    gf.x = 700;
    gf.y = 100;

    turnevil = new FlxSprite(-500, -1000);
	turnevil.frames = Paths.getFrames('stages/HellishHights/mx/MX_Transformation_Assets');
    turnevil.setGraphicSize(Std.int(turnevil.width * 0.5));
    turnevil.alpha = 0.00001;
    turnevil.animation.addByPrefix('laugh', "MX Transformation", 24, false);
    turnevil.animation.finishCallback = function (n:String) {
        dad.alpha = boyfriend.alpha = gf.alpha = fullbg.alpha = bgfloor.alpha = toad.alpha = LuCasBody.alpha = luigiempa.alpha = creepyCloud.alpha = creppyleaf.alpha = 1;
        turnevil.alpha = 0;
        FlxG.camera.flash(FlxColor.BLACK, 0.5);
        dadZoom = .3;
        bfZoom = .5;

        dad.x = -234;
        dad.y = 221;
        gf.x = 717.5;
        gf.y = -66;
    }
    gf.alpha = 1;
    add(turnevil);
    old2.perspectiveOn = true; 
    old2.vignetteMoving =  true;
    camGame.addShader(old2);
    camGame.addShader(old);
    camHUD.addShader(old);

    camEST.addShader(old2);
    camEST.addShader(old);
				
    blackBarThingie = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    blackBarThingie.setGraphicSize(Std.int(blackBarThingie.width * 10));
    blackBarThingie.scrollFactor.set(0, 0);
    blackBarThingie.alpha = 0;
    blackBarThingie.cameras = [camEST];
    add(blackBarThingie);

    mxLaughNEW = new FlxSprite();
	mxLaughNEW.frames = Paths.getFrames('stages/HellishHights/mx/MX_Dialogue_Asseta');
    mxLaughNEW.animation.addByPrefix('freddyfazbear', "Innocence", 32, false);
    mxLaughNEW.alpha = 0.000001;
    mxLaughNEW.cameras = [camEST];
    mxLaughNEW.updateHitbox();
    mxLaughNEW.screenCenter();
    add(mxLaughNEW);

    midsongVid = new FlxVideoSprite();
    midsongVid.load(Assets.getPath(Paths.file("videos/powerdownscene.mp4")));
	midsongVid.cameras = [camHUD];
	midsongVid.pause();
	midsongVid.bitmap.volume = 0;
	midsongVid.alpha = 0.0001;
    insert(members.indexOf(dad), midsongVid);
}
//pauses video
function onSubstateOpen(event) if (midsongVid != null && paused && midsongVid.alpha == 1) midsongVid.pause();
function onSubstateClose(event) if (midsongVid != null && paused && midsongVid.alpha == 1) midsongVid.resume();
function focusGained() if (midsongVid != null && !paused && midsongVid.alpha == 1) midsongVid.resume();

function events(shit){
    if (shit =="MiddleCamera"){
        dad.cameraOffset.x = 360; 
        dad.cameraOffset.y = 0; 
        dadZoom = .5;   
    }
    if (shit == "trans"){
        turnevil.alpha = 1;
        dad.alpha = boyfriend.alpha = gf.alpha = BGGG.alpha = MXBG1_3.alpha = 0;
        turnevil.animation.play('laugh');
    }
    if (shit == "far"){
        FlxTween.tween(blackBarThingie, {alpha: 1}, 1, {onComplete: function(twn:FlxTween){
                mxLaughNEW.y = 200;
                mxLaughNEW.scale.set(0.8, 0.8);
                FlxTween.tween(mxLaughNEW.scale, {x: 1, y: 1}, 1.3, {startDelay: 1, ease: FlxEase.cubeOut});
                FlxTween.tween(mxLaughNEW, {y: 80}, 1.3, {startDelay: 1, ease: FlxEase.cubeOut});
                FlxTween.tween(mxLaughNEW, {alpha: 1}, 0.3, {startDelay: 1, ease: FlxEase.quadInOut});
                new FlxTimer().start(0.375, function(tmr:FlxTimer){
                    mxLaughNEW.animation.play('freddyfazbear');
                });
                new FlxTimer().start(3.5, function(tmr:FlxTimer){
                    midsongVid.play();
                    midsongVid.alpha = 1;
                });
                new FlxTimer().start(5.3, function(tmr:FlxTimer){
                    remove(midsongVid);
                    blackBarThingie.alpha = mxLaughNEW.alpha = gf.alpha = 0;
                    FlxG.camera.flash(FlxColor.RED, 0.5);
                });
            }
        });
    }
    if (shit == "ending"){
        FlxTween.tween(blackBarThingie, {alpha: 1}, 2, {ease: FlxEase.quadInOut});
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
function beatHit(){
    if (curBeat % 1 == 0){
        creepyCloud.animation.play('idle', true);
        if(FlxG.random.int(1, 35) == 1){
            if(creppyleaf.animation.curAnim.name != 'blink')
                for (timer in extraTimers){
                    timer.cancel();
                }
                creppyleaf.animation.play('blink', true);
                extraTimers.push(new FlxTimer().start(0.75, function(tmr:FlxTimer){
                    creppyleaf.animation.play('idle', true);
                }));
        }
    }
}