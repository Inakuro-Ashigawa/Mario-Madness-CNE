import flixel.effects.FlxFlicker;
import flixel.math.FlxPoint;
import Sys;
var canDoShit:Bool = false;

window.title = "Friday Night Funkin': Mario's Madness";

FlxG.camera.zoom = 1.1;


var camEnter = new FlxCamera();

function new() CoolUtil.playMenuSong();

var ntsc = new CustomShader("titleshaders/NTSCSFilter");
var bloom = new CustomShader("Bloom");
var staticShader = new CustomShader("titleshaders/TVStatic");
var hands:Array<FlxSprite> = [];

function create(){
    mouse = new FlxSprite().loadGraphic(Paths.image('cursor'));
    FlxG.mouse.load(mouse.pixels, 2);
    FlxG.mouse.useSystemCursor = false;

    FlxG.resizeWindow(700, 400);
    FlxG.resizeGame(700, 400);
    window.x = Std.int((window.width / 2));
    window.y = Std.int((window.height / 2));

    FlxG.cameras.add(camEnter, false);
	camEnter.bgColor = 0x00000000;

    FlxTween.tween(FlxG.camera, {zoom: 1}, 2, {ease: FlxEase.quartInOut}).onComplete = function(){canDoShit = true;};

    blackSprite = new FlxSprite().makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
    blackSprite.updateHitbox();
    blackSprite.screenCenter();

    estatica = new FlxSprite(-250);
    estatica.frames = Paths.getFrames('menus/mainmenu/estatica_uwu');
    estatica.animation.addByPrefix('idle', "Estatica papu", 15);
    estatica.animation.play('idle');
    estatica.antialiasing = false;
    estatica.color = FlxColor.RED;
    estatica.alpha = 0.25;
    add(estatica);

    floor = new FlxSprite().loadGraphic(Paths.image('menus/title/floor'));
    floor.scale.set(0.95, 0.95);
    floor.updateHitbox();
    floor.setPosition(-40.0567375886525, 360);
    add(floor);

    for (i in 0...2) {
        var hand:FlxSprite = new FlxSprite(96 + (601 * i), 125);
        hand.frames = Paths.getSparrowAtlas("menus/title/titleAssets");
        hand.animation.addByPrefix("idle", "Spookihand", 24, true);
        hand.animation.play("idle", true);
        hand.scale.set(0.75, 0.75);
        hand.updateHitbox();
        add(hand);

        hand.flipX = i == 1; // WHAT NO WAY!!

        hand.ID = i;
        hands.push(hand);
    }

    bf = new FlxSprite(303, 312);
    bf.frames = Paths.getSparrowAtlas("menus/title/titleAssets");
    bf.animation.addByPrefix("idle", "BF", 24, false);
    bf.animation.play("idle", true);
    bf.scale.set(0.75, 0.75);
    bf.updateHitbox();
    add(bf);

    gf = new FlxSprite(705, 230);
    gf.frames = Paths.getSparrowAtlas("menus/title/titleAssets");
    gf.animation.addByPrefix("idle", "GF", 24, false);
    gf.animation.play("idle", true);
    gf.scale.set(0.75, 0.75);
    gf.updateHitbox();
    add(gf);

    logoBl = new FlxSprite(0, 60).loadGraphic(Paths.image('menus/title/MMv2LogoFINAL'));
    logoBl.setGraphicSize(Std.int(logoBl.width * (0.295 * 0.9)));
    logoBl.updateHitbox();
    logoBl.screenCenter(FlxAxes.X);
    logoBl.cameras = [camEnter];
    add(logoBl);

    enterSprite = new FlxSprite(0, 560);
    enterSprite.frames = Paths.getSparrowAtlas("menus/title/enter");
    enterSprite.animation.addByPrefix("idle", "EnterLoop", 24, false);
    enterSprite.animation.addByPrefix("press", "EnterBegin", 24, false);
    enterSprite.animation.play("idle");
    enterSprite.cameras = [camEnter];
    enterSprite.updateHitbox();
    enterSprite.screenCenter(FlxAxes.X);
    enterSprite.x -= 2;
    add(enterSprite);

    curtain = new FlxSprite(0, -325).loadGraphic(Paths.image('menus/title/duh'));
    FlxTween.tween(curtain, {y: -650}, 1.75, {ease: FlxEase.sineOut});
    curtain.scale.set(1.6, 1.2);
    curtain.screenCenter(FlxAxes.X);
    curtain.cameras = [camEnter];
    add(curtain);

    blackSprite.cameras = [camEnter];
    add(blackSprite);

    ntsc.data.glitchAmount.value = [0.4, 0.4];
    FlxG.camera.addShader(ntsc);

    bloom.data.Size.value = [.1];
    //camEnter.addShader(bloom);

    
    (new FlxTimer()).start(Conductor.stepCrochet/1000 * 2, (_) -> {
        FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
        FlxG.sound.music.fadeIn((Conductor.stepCrochet/1000 * 16) * 2, 0, 1.2);

        FlxTween.tween(blackSprite, {alpha: 0}, Conductor.stepCrochet/1000 * 6, {onComplete: (_) -> {
            transitioning = false;

            blackSprite.alpha = 0.05;
            FlxFlicker.flicker(blackSprite, 999999999999);
        }});
        
        FlxTween.tween(curtain, {y: -682.501606766917}, Conductor.stepCrochet/1000 * 4, {ease: FlxEase.circOut, startDelay: (Conductor.stepCrochet/1000) / 8});
        FlxG.camera.zoom += 0.075;
        FlxTween.tween(FlxG.camera, {zoom: FlxG.camera.zoom - 0.075}, (Conductor.stepCrochet/1000 * 12), {ease: FlxEase.circOut});

        persistentUpdate = true;
    });
    Conductor.changeBPM(45.593);
}
var transitioning:Bool = true;
function update(){
    FlxG.camera.shake(.001, 9999999999999999);

    
    if (controls.ACCEPT && canDoShit) enterPressed();

    var currentBeat = (Conductor.songPosition / 1000) * (Conductor.bpm / 60);


    for (hand in hands) {
        if (hand != null) {
            hand.y = 125 + 20 * FlxMath.fastCos((currentBeat / 2) * Math.PI);
            hand.offset.x = 80.125 + FlxG.random.float(-3.5, 3.5);

            hand.angle = 10 * (hand.ID == 1 ? -1 : 1) * FlxMath.fastSin((currentBeat / 2) * Math.PI);
        }
    }

    ntsc.data.time.value = [Conductor.songPosition];

    if (bloom != null && !transitioning) {
        //bloom.data.Size.value = [.1 + (0.5 * FlxMath.fastSin(currentBeat * 2))];
    }
}
function getCenterWindowPoint(){
    return FlxPoint.get(
        window.x + (window.width / 2),
        window.y + (window.height / 2)
    );
}
function centerWindowOnPoint(?point:FlxPoint) {
    window.x = Std.int(point.x - (window.width / 2));
    window.y = Std.int(point.y - (window.height / 2));
}
function enterPressed(){
    transitioning = true;
    bloom.data.Size.value = [18 * 2];
    bloom.data.dim.value = [0.25];

    var twn1:NumTween;
    var twn2:NumTween;

    twn1 = FlxTween.num(18.0 * 2, 3.0, 1.5, {
        onUpdate: (_) -> {
            bloom.data.Size.value = [twn1.value];
        }
    });

    twn2 = FlxTween.num(0.25, 2.0, 1.5, {
        onUpdate: (_) -> {
            bloom.data.dim.value = [twn2.value];
        }
    });

    canDoShit = false;
    enterSprite.offset.set(127, 85);
    enterSprite.animation.play("press", true);

    CoolUtil.playMenuSFX(1);
    if (FlxG.save.data.flashingLights) camEnter.flash(0xB7FF0000);
    enterSprite.animation.finishCallback = (_) -> {enterSprite.visible = false;};

			new FlxTimer().start(Conductor.stepCrochet/1000 * 2, function(tmr:FlxTimer) {
				FlxTween.tween(curtain, {y: curtain.y - 40}, (Conductor.stepCrochet/1000), {
					ease: FlxEase.circInOut,
					onComplete: (_) -> {
						FlxTween.tween(curtain, {y: 3}, Conductor.stepCrochet/1000 * 4.6, {ease: FlxEase.quintOut, startDelay: 0.03});

						FlxFlicker.stopFlickering(blackSprite); 
						blackSprite.alpha = 0; blackSprite.visible = true;

						FlxTween.tween(blackSprite, {alpha: 1}, Conductor.stepCrochet/1000 * 2, {
							startDelay: 0.04,
							onComplete: (_) -> {
								FlxG.updateFramerate = 30; // Makes it smoother and consistant

								windowRes = FlxPoint.get(window.width, window.height);
                                windowPos = getCenterWindowPoint();
								startTime = Sys.time();
								
								windowTwn = FlxTween.tween(windowRes, {x: 1280, y: 720}, 0.3 * 4, {ease: FlxEase.circInOut, onUpdate: (_) -> {
									FlxG.resizeWindow(Std.int(windowRes.x), Std.int(windowRes.y));
									centerWindowOnPoint(windowPos);
									if ((Sys.time() - startTime) > 1.35) {
										windowTwn.cancel();
										completeWindowTwn();
									}
								}, onComplete: function(twn:FlxTween)
									{
										completeWindowTwn();
									}
								});

								FlxG.camera.visible = false;
								camEnter.visible = false;
							}
						});
					}
				});
			});
}
function completeWindowTwn(){
    FlxG.updateFramerate = Options.framerate;

    FlxG.resizeWindow(1280, 720);
    FlxG.resizeGame(1280, 720);
    centerWindowOnPoint(windowPos);
    
    windowPos.put(); windowPos.put();

    FlxG.mouse.visible = true;
    FlxG.switchState(new MainMenuState());
};