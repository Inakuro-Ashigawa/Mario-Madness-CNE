import flixel.tweens.FlxTween.FlxTweenType;
var angel:CustomShader = null;

introLength = 0;
function onCountdown(event) event.cancel();

function create(){
    fog = new FlxSprite(0, 0).loadGraphic(Paths.image('modstuff/126'));
    fog.alpha = 0.8;
    fog.cameras = [camHUD];
    insert(1, fog);

    boyfriend.alpha = 0;
    gf.alpha = 0;

    FlxTween.tween(boyfriend, {y: boyfriend.y - 20}, 3, {ease: FlxEase.quadInOut, type: FlxTween.PINGPONG});
    FlxTween.tween(boyfriend, {x: boyfriend.x + 40}, 5, {ease: FlxEase.quadInOut, type: FlxTween.PINGPONG});

    FlxTween.tween(gf, {y: gf.y + 40}, 2, {startDelay: 0.2, ease: FlxEase.quadInOut, type: FlxTween.PINGPONG});
	FlxTween.tween(gf, {x: gf.x - 20}, 4, {startDelay: 0.2, ease: FlxEase.quadInOut, type: FlxTween.PINGPONG});

    angel = new CustomShader("angel");
    angel.data.pixel.value = [0.5, 0.5];
    angel.data.stronk.value = [0, 0];

    camGame.addShader(angel);
    camHUD.addShader(angel);
}

function update(elapsed){
    angel.data.iTime.value = [Conductor.songPosition / 1000];
}