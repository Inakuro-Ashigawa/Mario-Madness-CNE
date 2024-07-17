import flixel.tweens.FlxTween.FlxTweenType;
var angel:CustomShader = null;

importScript("data/modchart/NoteCameras");

var camEST = new FlxCamera();

introLength = 0;
function onCountdown(event) event.cancel(); 

function create(){
    camEST.bgColor = 0;
    camEST.alpha = 1;
    FlxG.cameras.remove(camHUD, false);
    FlxG.cameras.add(camHUD, false);
    FlxG.cameras.add(camEST, false);

    if(FlxG.save.data.flashingLights){
        bfHang = new FlxSprite(700, -100).loadGraphic(Paths.image('modstuff/Beta_Bf_Hang'));
        bfHang.alpha = 0;
        bfHang.frames = Paths.getSparrowAtlas('modstuff/Beta_Bf_Hang');
	    bfHang.animation.addByPrefix('idle', "BFHang", 24);
        bfHang.cameras = [camEST];
        add(bfHang);
    }

    blackBarThingie = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
	blackBarThingie.scrollFactor.set(0, 0);
    blackBarThingie.cameras = [camEST];
	blackBarThingie.alpha = 1;
	add(blackBarThingie);

    fog = new FlxSprite(0, 0).loadGraphic(Paths.image('modstuff/126'));
    fog.alpha = 0.8;
    fog.cameras = [camEST];
    insert(1, fog);

    boyfriend.alpha = 0;
    gf.alpha = 0;

    rainFall = new FlxSprite(-170, 50).loadGraphic(Paths.image('stages/Woodland-of-Lies/betamansion/old/Beta_Luigi_Rain_V1'));
    rainFall.alpha = 0;
    rainFall.scale.set(1.7, 1.7);
    rainFall.cameras = [camEST];
    rainFall.frames = Paths.getSparrowAtlas('stages/Woodland-of-Lies/betamansion/old/Beta_Luigi_Rain_V1');
	rainFall.animation.addByPrefix('idle', "RainLuigi", 24);
    rainFall.animation.play('idle', true);
    add(rainFall);

    FlxTween.tween(boyfriend, {y: boyfriend.y - 20}, 3, {ease: FlxEase.quadInOut, type: FlxTween.PINGPONG});
    FlxTween.tween(boyfriend, {x: boyfriend.x + 40}, 5, {ease: FlxEase.quadInOut, type: FlxTween.PINGPONG});

    FlxTween.tween(gf, {y: gf.y + 40}, 2, {startDelay: 0.2, ease: FlxEase.quadInOut, type: FlxTween.PINGPONG});
	FlxTween.tween(gf, {x: gf.x - 20}, 4, {startDelay: 0.2, ease: FlxEase.quadInOut, type: FlxTween.PINGPONG});

    angel = new CustomShader("angel");
    angel.data.pixel.value = [0.5, 0.5];
    angel.data.stronk.value = [0, 0];
    angel.data.iTime.value = [0.0];

    //camGame.addShader(angel);
    //camHUD.addShader(angel);
}

function update(elapsed){
    angel.data.iTime.value = [Conductor.songPosition / 1000];
}

function beatHit(curBeat){
    switch(curBeat){
        case 2:
            FlxTween.tween(blackBarThingie, {alpha: 0}, 5);
        case 40:
            if(FlxG.save.data.flashingLights){
                FlxG.camera.flash(FlxColor.WHITE, 1);
                bfHang.alpha = 1;
                bfHang.animation.play('idle');
                FlxTween.tween(bfHang, {alpha: 0}, 2, {ease: FlxEase.quadOut});
            }
        case 41:
            FlxTween.tween(rainFall, {alpha: 0.6}, 5);
    }
}

/*  Code for the rain:

    rain = new FlxSprite(0, 0).loadGraphic(Paths.image('stages/Woodland-of-Lies/betamansion/gota'));
    rain.frames = Paths.getSparrowAtlas('stages/Woodland-of-Lies/betamansion/gota');
	rain.animation.addByPrefix('rain', 'rain', 12, true);
    rain.animation.play('rain');
    rain.alpha = 0.4;

    rain.x = FlxG.random.float(0, 1270);
	rain.y = FlxG.random.float(600, 1000);

    insert(5, rain);
    FlxTween.tween(rain, {alpha: 0}, 2, {startDelay: 0.3, onComplete: function(twn:FlxTween){
		rain.destroy();
    }});
*/