import funkin.backend.system.framerate.Framerate;
import flixel.effects.FlxFlicker;

var staticShader, ntsc:CustomShader = null;

//this is Syurps code!!

function postCreate(){
    FlxTween.tween(Framerate.offset, {y: pathBG.height + 5}, .75, {ease: FlxEase.elasticOut});

    for (option in main.members)
        if (option.desc == "Modify mod options here")
            main.members.remove(option);

    FlxG.sound.playMusic(Paths.music('options'));

    staticThingy = new FlxSprite(0, 0);
	staticThingy.frames = Paths.getSparrowAtlas('modstuff/estatica_uwu');
    staticThingy.animation.addByPrefix('idle', "Estatica papu", 15);
	staticThingy.animation.play('idle');
    staticThingy.color = FlxColor.RED;
    staticThingy.screenCenter();
	staticThingy.scrollFactor.set();
    insert(1, staticThingy);

    blackSprite = new FlxSprite().makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
    blackSprite.alpha = 0.05;
    FlxFlicker.flicker(blackSprite, 999999999999);
    add(blackSprite);

    staticShader = new CustomShader("TVStatic");
    staticShader.data.strengthMulti.value = [1, 1];
    FlxG.camera.addShader(staticShader);

    ntsc = new CustomShader("NTSCGlitch");
    FlxG.camera.addShader(ntsc);
}

function update(){
    FlxG.camera.shake(0.00085, 999999999999);

    if (ntsc != null)
        ntsc.uFrame = Conductor.songPosition;
    if (staticShader != null)
        staticShader.iTime = Conductor.songPosition;
}