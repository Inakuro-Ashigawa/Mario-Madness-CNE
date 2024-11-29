import flixel.util.FlxTimer;

var canDodge:Bool = true;
public var timerdone,canJump:Bool = true;
public var camEST = new FlxCamera();
var imgwarb,bbfjump,imgwar:FlxSprite;
var enemyY:Float;

function events(shit){
    if (shit == "far"){
        canJump = false;
    }
}
function create() {
    var estatica = new FlxSprite();
    estatica.frames = Paths.getSparrowAtlas('modstuff/Mario_static');
    estatica.animation.addByPrefix('idle', "static play", 15);
    estatica.animation.play('idle');
    estatica.antialiasing = false;
    estatica.cameras = [camEST];
    estatica.alpha = 0.1;
    estatica.updateHitbox();
    estatica.screenCenter();
    add(estatica);

    imgwarb = new FlxSprite().loadGraphic(Paths.image('modstuff/cuidao0'));
    imgwarb.setGraphicSize(Std.int(imgwarb.width * 8));
    imgwarb.antialiasing = false;
    imgwarb.cameras = [camEST];
    imgwarb.visible = false;
    imgwarb.updateHitbox();
    imgwarb.screenCenter();
    add(imgwarb);
    
    imgwar = new FlxSprite().loadGraphic(Paths.image('modstuff/cuidao'));
    imgwar.setGraphicSize(Std.int(imgwar.width * 8));
    imgwar.antialiasing = false;
    imgwar.cameras = [camEST];
    imgwar.visible = false;
    imgwar.updateHitbox();
    imgwar.screenCenter();
    add(imgwar);

    bbfjump = new FlxSprite(1120, 185);
	bbfjump.frames = Paths.getFrames('characters/HellishHights/mx/MM_Boyfriend_Assets_jump');
    bbfjump.animation.addByPrefix('jump', "JUMP0", 30, false);
    bbfjump.animation.addByPrefix('jumpend', "JUMPLAND0", 24, false);
    bbfjump.antialiasing = true;
    bbfjump.visible = false;
    add(bbfjump);

    enemyY = dad.y;

    camEST.bgColor = 0;
    camEST.alpha = 1;
    FlxG.cameras.remove(camHUD, false);
    FlxG.cameras.add(camHUD, false);
    FlxG.cameras.add(camEST, false);
}
var jumpSound = FlxG.sound.play(Paths.sound('bfjump'), 1);
function bfJump() {
    if (!canDodge) return;
    canDodge = false;

    boyfriend.visible = false;
    bbfjump.visible = true;
    bbfjump.animation.play('jump');
    jumpSound.play();
    jumpSound.amplitude = 10;


    new FlxTimer().start(0.1, function(tmr:FlxTimer) {
        FlxTween.tween(bbfjump, {y: bbfjump.y - 250}, 0.3, {
            ease: FlxEase.expoOut,
            onComplete: function(twn:FlxTween) {
                FlxTween.tween(bbfjump, {y: bbfjump.y + 420}, 0.3, {
                    ease: FlxEase.expoIn,
                    onComplete: function(twn:FlxTween) {
                        bbfjump.x += 10;
                        bbfjump.y += 100;
                        bbfjump.animation.play('jumpend');
                    }
                });
            }
        });
    });

    new FlxTimer().start(0.83, function(tmr:FlxTimer) {
        boyfriend.visible = true;
        bbfjump.visible = false;
        bbfjump.y -= 270;
        bbfjump.x -= 10;
        inst.volume = 1;
        vocals.volume = 1;
        canDodge = true;
    });
}
function postUpdate() {
    if(FlxG.keys.justPressed.SPACE){
        bfJump();
        timerdone = false;
        new FlxTimer().start(1.23, function(tmr:FlxTimer){
            timerdone = true;
        });
    }
}
function onEvent(eventEvent) {
    if (eventEvent.event.name == 'MX salto') {
        for (i in 0...4) {
            new FlxTimer().start((1 / (Conductor.bpm / 60)) * i, function(tmr:FlxTimer) {
                switch(i) {
                    case 0:
                        imgwarb.visible = true;
                        imgwarb.scale.set(10, 10);
                        imgwarb.y += 50;
                        FlxTween.tween(imgwarb, {y: (FlxG.height - imgwarb.height) / 2}, (1 / (Conductor.bpm / 60)), {ease: FlxEase.expoOut});
                        FlxTween.tween(imgwarb.scale, {x: 8, y: 8}, (1 / (Conductor.bpm / 60)), {ease: FlxEase.elasticOut});
                        FlxTween.angle(imgwarb, 35, 0, (1 / (Conductor.bpm / 60)), {ease: FlxEase.elasticOut});
                    case 1:
                        imgwar.visible = true;
                        imgwarb.visible = false;
                        imgwar.scale.set(9, 9);
                        imgwar.color = 0xFFFFFFFF;
                        imgwar.alpha = 1;
                        FlxTween.tween(imgwar.scale, {x: 8, y: 8}, (1 / (Conductor.bpm / 60)), {ease: FlxEase.elasticOut});
                        FlxTween.angle(imgwar, -20, 0, (1 / (Conductor.bpm / 60)), {ease: FlxEase.elasticOut});
                    case 2:
                        FlxTween.tween(imgwar.scale, {x: 7, y: 7}, 0.5 * (1 / (Conductor.bpm / 60)), {ease: FlxEase.bounceOut});
                        FlxTween.color(imgwar, (1 / (Conductor.bpm / 60)), FlxColor.WHITE, 0xFF737373, {ease: FlxEase.circOut});
                    case 3:
                        FlxTween.tween(imgwar, {alpha: 0}, (1 / (Conductor.bpm / 60)));
                }
            });
            FlxG.sound.play(Paths.sound('warningmx'));

            var numberjump:Float = 800;
            dad.playAnim('singUP', true);
            FlxTween.tween(dad, {y: enemyY - numberjump}, 0.24, {
                startDelay: 0.24,
                ease: FlxEase.quadOut,
                onComplete: function(twn:FlxTween) {
                    dad.playAnim('singDOWN', true);
                    FlxTween.tween(dad, {y: enemyY}, 0.24, {
                        ease: FlxEase.quadIn,
                        onComplete: function(twn:FlxTween) {
                            camGame.shake(0.03, 0.2);
                            if (canDodge) {
                                boyfriend.playAnim('hurt', true);
                                var newhealth:Float = health - 1.2;
                                FlxTween.tween(this, {health: newhealth}, 0.2, {ease: FlxEase.quadOut});
                            }
                        }
                    });
                }
            });
        }
    }
}
