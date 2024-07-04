import LavaParticle;
import flixel.effects.particles.FlxEmitter.FlxEmitterMode;
import flixel.effects.particles.FlxEmitter.FlxTypedEmitter;
var camxoffset:Float = -400;
var camyoffset:Float = 0;
var dadxoffset:Float = 10;
var dadyoffset:Float = -100;
var lavaEmitter:FlxTypedEmitter;
var cancelCameraMove:Bool = false;
defaultCamZoom = .7;

function onCameraMove(e) if(cancelCameraMove) e.cancel();

function create(){

    remove(gf);
    remove(boyfriend);

    gf.scrollFactor.set(1,1);
    boyfriend.cameraOffset = FlxPoint.weak(camxoffset, camyoffset);
    dad.cameraOffset = FlxPoint.weak(dadxoffset, dadyoffset);
    
    bg = new FlxSprite(-960, -700).loadGraphic(Paths.image("stages/Woodland-of-Lies/IHY/Ladrillos y ventanas"));
    bg.scrollFactor.set(0.6, 0.6);
    insert(0, bg);

    eyelessboo = new FlxSprite(-500, 233);
    eyelessboo.scrollFactor.set(0.8,0.8);
    eyelessboo.frames = Paths.getFrames('stages/Woodland-of-Lies/IHY/Luigi_HY_BG_Assetss');
    eyelessboo.animation.addByPrefix('idle', 'GhostIdle', 24, true);
    eyelessboo.flipX = true;
    insert(1, eyelessboo);
    
    eyelessboo2 = new FlxSprite(1500, 33);
    eyelessboo2.scrollFactor.set(0.8,0.8);
    eyelessboo2.frames = Paths.getFrames('stages/Woodland-of-Lies/IHY/Luigi_HY_BG_Assetss');
    eyelessboo2.animation.addByPrefix('idle', 'GhostIdle', 24, true);
    insert(1, eyelessboo2);
    
    eyelessboo3 = new FlxSprite(1450, 333);
    eyelessboo3.scrollFactor.set(0.8,0.8);
    eyelessboo3.frames = Paths.getFrames('stages/Woodland-of-Lies/IHY/Luigi_HY_BG_Assetss');
    eyelessboo3.animation.addByPrefix('idle', 'GhostIdle', 24, true);
    insert(1, eyelessboo3);

    blueMario = new FlxSprite(100, 352);
    blueMario.frames = Paths.getFrames('stages/Woodland-of-Lies/IHY/Luigi_HY_BG_Assetss');
    blueMario.animation.addByPrefix('hey', 'MarioIntro', 24, false);
    blueMario.animation.addByPrefix('dance', 'MarioIdle', 24, false);

    blueMario2 = new FlxSprite(1360, 352);
    blueMario2.frames = Paths.getFrames('stages/Woodland-of-Lies/IHY/Luigi_HY_BG_Assetss');
    blueMario2.animation.addByPrefix('hey', 'MarioIntro', 24, false);
    blueMario2.animation.addByPrefix('dance', 'MarioIdle', 24, false);
    
    eyelessboo.alpha = eyelessboo2.alpha = eyelessboo3.alpha = blueMario.alpha = blueMario2.alpha = 0;

    puenteHate = new FlxSprite(-1360, -680).loadGraphic(Paths.image("stages/Woodland-of-Lies/IHY/Puente Roto"));
    insert(5, gf);
    insert(6, blueMario2);
    insert(4, blueMario);
    insert(4, puenteHate);

    bfcape = new Character(boyfriend.x, boyfriend.y, "bfihy", true);
    bfcape.playAnim("Capeanim");
    add(bfcape);
    add(boyfriend);
}
function postCreate(){
    brimstone = new FlxSprite(260, 280).loadGraphic(Paths.image("stages/Woodland-of-Lies/IHY/asset_deg"));
    brimstone.screenCenter();
    brimstone.cameras = [camHUD];
    brimstone.setGraphicSize(Std.int(brimstone.width * 4));
    add(brimstone);

    ihyLava = new FlxSprite(-18, 790);
    ihyLava.frames = Paths.getSparrowAtlas('modstuff/Luigi_IHY_Background_Assets_Lava');
    ihyLava.animation.addByPrefix('idle', "Lava", 12);
    ihyLava.animation.play('idle');
    ihyLava.cameras = [camHUD];
    ihyLava.setGraphicSize(Std.int(ihyLava.width * 1.3));
    ihyLava.updateHitbox();
    add(ihyLava);


}
function onPlayerMiss() bfcape.playAnim("CapeanimMISS"); // Probably a better way to do this but this works for now

function beatHit(curBeat){
    bfcape.playAnim("Capeanim");
    FlxTween.tween(brimstone, {alpha: 0.6, y:brimstone + 100}, 0.5, {ease: FlxEase.quadInOut, type: 4});
    if (curBeat >= 320 && curBeat % 2 == 0)
    {
        blueMario.animation.play('dance', false);
        blueMario.offset.x = -55;
    }
    if (curBeat >= 330 && curBeat % 2 == 0)
    {
        blueMario2.animation.play('dance', false);  
        blueMario2.offset.x = -55;
    }
    if (curBeat % 8 == 0)
    {
        eyelessboo.animation.play('idle');
        eyelessboo2.animation.play('idle');
        eyelessboo3.animation.play('idle');
    }
}
function events(eventName){
    if (eventName == "boo"){
        FlxTween.tween(eyelessboo, {alpha: 1, x: -300}, 2, {ease: FlxEase.expoOut});
        FlxTween.tween(eyelessboo2, {alpha: 1, x: 1300}, 3, {ease: FlxEase.expoOut});
        FlxTween.tween(eyelessboo3, {alpha: 1, x: 1250}, 2.5, {ease: FlxEase.expoOut});
    }
    if (eventName == "mario1"){
        
        new FlxTimer().start(0.1, function(tmr:FlxTimer)
        {
            blueMario.alpha = 1;
        });
        blueMario.animation.play('hey', false);
    }
    if (eventName == "mario2"){
        new FlxTimer().start(0.1, function(tmr:FlxTimer)
        {
            blueMario2.alpha = 1;
        });
        blueMario2.animation.play('hey', false);
    }
    if (eventName == "black"){
        camGame.alpha = camHUD.alpha = 0.001;
    }
    if (eventName == "zoom"){
        defaultCamZoom = .6;
        dad.danceOnBeat = false;
    }
    if (eventName == "fade"){
        FlxTween.tween(camHUD, {alpha: 0.001}, 1);
    }
    if (eventName == "jump"){
        bfcape.alpha = 0.00001;
        boyfriend.animation.play('prejump', true);
    }
    if (eventName == "spin"){
        boyfriend.animation.play('spin', true);
        FlxTween.tween(boyfriend, {y: -100}, 0.2, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween)
            {
                FlxTween.tween(boyfriend, {y: 60}, 0.2, {ease: FlxEase.quadIn});
            }});

        FlxTween.tween(camGame, {zoom: 1.3}, 7);

        FlxTween.tween(boyfriend, {x: 50}, 0.4, {onComplete: function(twn:FlxTween)
            {
                boyfriend.animation.play('attack', true);
                dad.animation.play('fall', true);
                cancelCameraMove = true;
                camGame.shake(0.15, 0.007);

                FlxTween.tween(dad, {x: -1600}, 1.5);
                FlxTween.tween(dad, {angle: -67}, 1.5, {ease: FlxEase.quadOut});
                FlxTween.tween(dad, {y: -300}, 0.6, {ease: FlxEase.cubeOut, onComplete: function(twn:FlxTween)
                    {
                        FlxTween.tween(dad, {y: 1900}, 0.9, {ease: FlxEase.quadIn});
                        new FlxTimer().start(0.19, function(tmr:FlxTimer)
                            {
                                bfcape.alpha = 1;
                                bfcape.x = 0;
                            });
                    }});
            }});
        
                
            new FlxTimer().start((7 * (1 / (Conductor.bpm / 60))), function(tmr:FlxTimer)
                {
                    dad.animation.play('hand', true);
                    dad.setPosition(-1200, 500);
                    dad.angle = 0;
                    FlxTween.tween(dad, {y: 800}, 2, {startDelay: 0.3, onComplete: function(twn:FlxTween)
                        {
                            dad.visible = false;
                        }});
                });
    }
}
