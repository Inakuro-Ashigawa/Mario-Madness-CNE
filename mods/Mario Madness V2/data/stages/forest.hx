//peach would be fucked - Mlaofmd

static var isCameraOnForcedPos:Bool = false;

var casa = 300;

var dadZoom:Int = 1;
var bfZoom:Int = 1;

var faropapu:FlxSprite;
var whiteShit:FlxSprite;
var trueno:FlxSprite;
var seaweed1:FlxSprite;
var seaweed2:FlxSprite;
var lospapus:FlxSprite;
var atrasarboleda:FlxSprite;
var aas:FlxSprite;
var seaweed3:FlxSprite;
var sopapo:FlxSprite;
var casa0:FlxSprite;
var casa1:FlxSprite;
var casa2:FlxSprite;
var s3:FlxSprite;
var s2:FlxSprite;
var glitch0:FlxSprite;
var glitch1:FlxSprite;
var glitch2:FlxSprite;
var glitch3:FlxSprite;
var cososuelo:FlxSprite;
var leaf0:FlxSprite;
var leaf1:FlxSprite;
var leaf2:FlxSprite;
var bola0:FlxSprite;
var bola1:FlxSprite;
var lluvia:FlxSprite;
var fogred:FlxSprite;
var fresco:FlxSprite;

var eventTweens = [];
var extraTween = [];
var eventTimers = [];

function create() {
	camEst = new FlxCamera();
    camEst.bgColor = 0x00000000;
    FlxG.cameras.add(camEst, false);

    remove(boyfriend);
    bfcape = new Character(boyfriend.x, boyfriend.y, "bfihy", true);
    bfcape.playAnim("Capeanim");
    add(bfcape);
    add(boyfriend);

    strumLines.members[3].characters[0].visible = false;

	faropapu = new FlxSprite(-1200, -500, Paths.image('stages/Woodland-of-Lies/Coronation/FondoFondo'));
    faropapu.antialiasing = true;
    faropapu.scrollFactor.set(0.5, 0.5);
    faropapu.updateHitbox();
    insert(0, faropapu);

    whiteShit = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    whiteShit.setGraphicSize(Std.int(whiteShit.width * 10));
    whiteShit.alpha = 0;
    insert(1, whiteShit);

    trueno = new FlxSprite(180, -600);
    trueno.frames = Paths.getSparrowAtlas('stages/Woodland-of-Lies/Coronation/Coronation_Peach_misc_Assets');
    trueno.animation.addByPrefix('rayo', 'AAARayo', 24, false);
    trueno.scrollFactor.set(0.7, 0.7);
    trueno.antialiasing = true;
    trueno.visible = false;
    insert(2, trueno);

    seaweed1 = new FlxSprite(520, -50);
    seaweed1.frames = Paths.getSparrowAtlas('stages/Woodland-of-Lies/Coronation/Coronation_Peach_misc_Assets');
    seaweed1.animation.addByPrefix('i', 'Leave0', 24, true);
    seaweed1.antialiasing = true;
    seaweed1.visible = false;
    seaweed1.color = 0xFFB8837F;
    seaweed1.scale.set(1.2, 1.2);
    seaweed1.updateHitbox();
    insert(3, seaweed1);

    seaweed2 = new FlxSprite(1420, -150);
    seaweed2.frames = Paths.getSparrowAtlas('stages/Woodland-of-Lies/Coronation/Coronation_Peach_misc_Assets');
    seaweed2.animation.addByPrefix('i', 'Leave0', 24, true);
    seaweed2.antialiasing = true;
    seaweed2.visible = false;
    seaweed2.color = 0xFFB8837F;
    seaweed2.scale.set(1.2, 1.2);
    seaweed2.updateHitbox();
    insert(4, seaweed2);

    lospapus = new FlxSprite(-1200, -500, Paths.image('stages/Woodland-of-Lies/Coronation/Arboles'));
    lospapus.antialiasing = true;
    lospapus.scrollFactor.set(1, 1);
    lospapus.updateHitbox();
    insert(5, lospapus);

    atrasarboleda = new FlxSprite(-1200, -500, Paths.image('stages/Woodland-of-Lies/Coronation/AtrasArboles'));
    atrasarboleda.antialiasing = true;
    atrasarboleda.scrollFactor.set(1, 1);
    atrasarboleda.updateHitbox();
    insert(6, atrasarboleda);

    aas = new FlxSprite(-1200, -500, Paths.image('stages/Woodland-of-Lies/Coronation/asdas'));
    aas.antialiasing = true;
    aas.scrollFactor.set(1, 1);
    aas.updateHitbox();
    insert(7, aas);

    seaweed3 = new FlxSprite(1420, -150);
    seaweed3.frames = Paths.getSparrowAtlas('stages/Woodland-of-Lies/Coronation/Coronation_Peach_misc_Assets');
    seaweed3.animation.addByPrefix('i', 'Leave0', 24, true);
    seaweed3.antialiasing = true;
    seaweed3.visible = false;
    seaweed3.color = 0xFFB8837F;
    seaweed3.scale.set(1.2, 1.2);
    seaweed3.updateHitbox();
    insert(8, seaweed3);

    sopapo = new FlxSprite(-1200, -500, Paths.image('stages/Woodland-of-Lies/Coronation/Stage'));
    sopapo.antialiasing = true;
    sopapo.scrollFactor.set(1, 1);
    sopapo.updateHitbox();
    insert(9, sopapo);

    casa0 = new FlxSprite(-1200, casa + -2800, Paths.image('stages/Woodland-of-Lies/Coronation/BGforBG'));
    casa0.antialiasing = true;
    casa0.scrollFactor.set(0.5, 0.5);
    casa0.updateHitbox();
    casa0.visible = false;
    insert(10, casa0);

    casa1 = new FlxSprite(-1200, casa + -4800, Paths.image('stages/Woodland-of-Lies/Coronation/TreeHouse'));
    casa1.antialiasing = true;
    casa1.updateHitbox();
    insert(11, casa1);

    casa2 = new FlxSprite(400, casa + -3600);
    casa2.frames = Paths.getSparrowAtlas('stages/Woodland-of-Lies/Coronation/CoroDay_DeadMario');
    casa2.animation.addByPrefix('idle', "DeadMario", 24, false);
    casa2.antialiasing = true;
    insert(12, casa2);

    var nerve0 = new FlxSprite(-400, casa + -2500, Paths.image('stages/Woodland-of-Lies/Coronation/thenerve'));
    nerve0.antialiasing = true;
    insert(13, nerve0);

    var nerve1 = new FlxSprite(400, casa + -2500, Paths.image('stages/Woodland-of-Lies/Coronation/thenerve'));
    nerve1.antialiasing = true;
    insert(14, nerve1);

    var nerve2 = new FlxSprite(800, casa + -2500, Paths.image('stages/Woodland-of-Lies/Coronation/thenerve'));
    nerve2.antialiasing = true;
    insert(15, nerve2);

    var nerve3 = new FlxSprite(2400, casa + -2500, Paths.image('stages/Woodland-of-Lies/Coronation/thenerve'));
    nerve3.antialiasing = true;
    insert(16, nerve3);

    var nerve4 = new FlxSprite(0, casa + -2500, Paths.image('stages/Woodland-of-Lies/Coronation/thenerve'));
    nerve4.antialiasing = true;
    insert(17, nerve4);

    var nerve5 = new FlxSprite(600, casa + -2500, Paths.image('stages/Woodland-of-Lies/Coronation/thenerve'));
    nerve5.antialiasing = true;
    insert(18, nerve5);

    //TWEENS NERVSSSS

    FlxTween.tween(nerve0, {y: -5000}, 4.5, {type: 2, loopDelay: 0.2});
    FlxTween.tween(nerve1, {y: -5000}, 4, {type: 2, loopDelay: 0.3});
    FlxTween.tween(nerve2, {y: -5000}, 3, {type: 2, loopDelay: 0.6});
    FlxTween.tween(nerve3, {y: -5000}, 3, {type: 2, loopDelay: 0.5});
    FlxTween.tween(nerve4, {y: -5000}, 4, {type: 2, loopDelay: 0.4});
    FlxTween.tween(nerve5, {y: -5000}, 3, {type: 2, loopDelay: 0.2});

    FlxTween.tween(nerve0, {x: -450}, 0.4, {type: 4});
    FlxTween.tween(nerve1, {x: 350}, 0.2, {type: 4});
    FlxTween.tween(nerve2, {x: 850}, 0.3, {type: 4});
    FlxTween.tween(nerve3, {x: 250}, 3.5, {type: 4});
    FlxTween.tween(nerve4, {x: 50}, 0.3, {type: 4});
    FlxTween.tween(nerve5, {x: 750}, 0.45, {type: 4});

    s3 = new FlxSprite(-1200, casa + -4500, Paths.image('stages/Woodland-of-Lies/Coronation/TransitionTop'));
    s3.scrollFactor.set(1.3, 1.3);
    s3.updateHitbox();
    insert(19, s3);

    s2 = new FlxSprite(-1200, casa + -2500, Paths.image('stages/Woodland-of-Lies/Coronation/TransitionBottom'));
    s2.scrollFactor.set(1.3, 1.3);
    s2.updateHitbox();
    insert(20, s2);

    // PIBBY GLITCHESSSSSSS

    glitch0 = new FlxSprite(400, 200);
    glitch0.frames = Paths.getSparrowAtlas('stages/Woodland-of-Lies/Coronation/Coronation_Peach_misc_Assets');
    glitch0.animation.addByPrefix('i', "glitch2", 24, true);
    glitch0.antialiasing = true;
    glitch0.visible = false;
    glitch0.scrollFactor.set(1.3, 1.3);
    glitch0.color = 0xFFB8837F;
    glitch0.scale.set(2, 2);
    glitch0.updateHitbox();
    add(glitch0);

    glitch1 = new FlxSprite(1500, 400);
    glitch1.frames = Paths.getSparrowAtlas('stages/Woodland-of-Lies/Coronation/Coronation_Peach_misc_Assets');
    glitch1.animation.addByPrefix('idle', "glitch2", 16, true);
    glitch1.animation.play('idle');
    glitch1.antialiasing = true;
    glitch1.visible = false;
    glitch1.color = 0xFFB8837F;
    glitch1.scale.set(4, 3);
    glitch1.updateHitbox();
    add(glitch1);

    glitch2 = new FlxSprite(-500, 600);
    glitch2.frames = Paths.getSparrowAtlas('stages/Woodland-of-Lies/Coronation/Coronation_Peach_misc_Assets');
    glitch2.animation.addByPrefix('idle', "glitchcausa", 20, true);
    glitch2.animation.play('idle');
    glitch2.scrollFactor.set(1.1, 1.1);
    glitch2.antialiasing = true;
    glitch2.visible = false;
    glitch2.color = 0xFFB8837F;
    glitch2.scale.set(2, 6);
    glitch2.updateHitbox();
   	add(glitch2);

    glitch3 = new FlxSprite(-200, 1200);
    glitch3.frames = Paths.getSparrowAtlas('stages/Woodland-of-Lies/Coronation/Coronation_Peach_misc_Assets');
    glitch3.animation.addByPrefix('idle', "glitchcausa", 15, true);
    glitch3.animation.play('idle');
    glitch3.scrollFactor.set(1.2, 1.2);
    glitch3.antialiasing = true;
    glitch3.visible = false;
    glitch3.color = 0xFFB8837F;
    glitch3.scale.set(5, 3);
    glitch3.updateHitbox();
    add(glitch3);

    cososuelo = new FlxSprite(1700, 400);
    cososuelo.frames = Paths.getSparrowAtlas('stages/Woodland-of-Lies/Coronation/Coronation_Peach_misc_Assets');
    cososuelo.animation.addByPrefix('i', "har", 24, true);
    cososuelo.antialiasing = true;
    cososuelo.visible = false;
    cososuelo.color = 0xFFB8837F;
    cososuelo.scale.set(2.5, 2.5);
    cososuelo.updateHitbox();
    add(cososuelo);

    leaf0 = new FlxSprite(0, -700);
    leaf0.frames = Paths.getSparrowAtlas('stages/Woodland-of-Lies/Coronation/Coronation_Peach_misc_Assets');
    leaf0.animation.addByPrefix('i', "Leavehar", 24, true);
    leaf0.antialiasing = true;
    leaf0.scrollFactor.set(1.3, 1);
    leaf0.visible = false;
    leaf0.scale.set(1.5, 1.5);
    leaf0.updateHitbox();
    add(leaf0);

    leaf1 = new FlxSprite(-400, -700);
    leaf1.frames = Paths.getSparrowAtlas('stages/Woodland-of-Lies/Coronation/Coronation_Peach_misc_Assets');
    leaf1.animation.addByPrefix('i', "Leavehar", 24, true);
    leaf1.antialiasing = true;
    leaf1.scrollFactor.set(1.3, 1);
    leaf1.visible = false;
    leaf1.scale.set(1.5, 1.5);
    leaf1.updateHitbox();
    add(leaf1);

    leaf2 = new FlxSprite(600, -700);
    leaf2.frames = Paths.getSparrowAtlas('stages/Woodland-of-Lies/Coronation/Coronation_Peach_misc_Assets');
    leaf2.animation.addByPrefix('i', "Leavehar", 24, true);
    leaf2.antialiasing = true;
    leaf2.scrollFactor.set(1.3, 1);
    leaf2.visible = false;
    leaf2.scale.set(1.5, 1.5);
    leaf2.updateHitbox();
    add(leaf2);

    FlxTween.tween(leaf0, {y: 1500, x: leaf0.x + 500}, 1.3, {type: 2, loopDelay: 0.3});
    FlxTween.tween(leaf1, {y: 1500, x: leaf1.x + 500}, 1, {type: 2});
    FlxTween.tween(leaf2, {y: 1500, x: leaf2.x + 500}, 1, {type: 2, loopDelay: 0.6});

    bola0 = new FlxSprite(1000, -700);
    bola0.frames = Paths.getSparrowAtlas('stages/Woodland-of-Lies/Coronation/Coronation_Peach_misc_Assets');
    bola0.animation.addByPrefix('i', "bobol", 24, true);
    bola0.antialiasing = true;
    bola0.scrollFactor.set(1.3, 1.3);
    bola0.visible = false;
    bola0.scale.set(1.5, 1.5);
    bola0.updateHitbox();
    add(bola0);

    bola1 = new FlxSprite(300, -700);
    bola1.frames = Paths.getSparrowAtlas('stages/Woodland-of-Lies/Coronation/Coronation_Peach_misc_Assets');
    bola1.animation.addByPrefix('i', "bobol", 24, true);
    bola1.antialiasing = true;
    bola1.scrollFactor.set(1.3, 1.3);
    bola1.visible = false;
    bola1.scale.set(1.5, 1.5);
    bola1.updateHitbox();
    add(bola1);

    FlxTween.tween(bola0, {x: 1100}, 0.5, {ease: FlxEase.quadInOut, type: 4});
    FlxTween.tween(bola1, {x: 400}, 0.5, {ease: FlxEase.quadInOut, type: 4});
    FlxTween.tween(bola0, {y: 1500}, 4, {type: 2, loopDelay: 1});
    FlxTween.tween(bola1, {y: 1500}, 4, {type: 2, loopDelay: 0.6});

    lluvia = new FlxSprite(-170, 50);
    lluvia.frames = Paths.getSparrowAtlas('stages/Woodland-of-Lies/betamansion/old/Beta_Luigi_Rain_V1');
    lluvia.animation.addByPrefix('i', "RainLuigi", 24, true);
    lluvia.setGraphicSize(Std.int(lluvia.width * 1.7));
    lluvia.alpha = 0.6;
    lluvia.visible = false;
    lluvia.antialiasing = true;
    lluvia.cameras = [camEst];
    insert(21, lluvia);

    fogred = new FlxSprite().loadGraphic(Paths.image('modstuff/232'));
    fogred.antialiasing = true;
    fogred.cameras = [camEst];
    fogred.alpha = 0;
    fogred.screenCenter();
    insert(22, fogred);

    fresco = new FlxSprite(180, -740);
    fresco.frames = Paths.getSparrowAtlas('characters/Woodland-of-Lies/coranation/Coronation_Peach_Dialogue2');
    fresco.animation.addByPrefix('llevar', "Peach", 24, false);
    fresco.antialiasing = true;
    fresco.color = 0xFF93ADB5;
    fresco.alpha = 0;
    add(fresco);

    camHUD.alpha = 0;
    return;
}

function onCameraMove(event) {
    if (isCameraOnForcedPos && !event.cancelled) {
        event.position.set(camFollow.x, camFollow.y);
    }
    switch (curCameraTarget) {
        case 0:
            defaultCamZoom = dadZoom;
        case 1:
            defaultCamZoom = bfZoom;
    }
}

var dadPosX;
var dadPosY;

var dadDialPosX;
var dadDialPosY;

function postCreate() {
	isCameraOnForcedPos = true;
	var colornew:Int = 0xFF93ADB5;
	dad.color = colornew;
    strumLines.members[3].characters[0].color = colornew; // peach dialogue
    gf.color = colornew;
    boyfriend.color = colornew;

    dadPosY = dad.y;
    dadPosX = dad.x;

    dadDialPosY = strumLines.members[3].characters[0].y;
    dadDialPosX = strumLines.members[3].characters[0].x;

    camFollow.setPosition(1020, 750);
    FlxG.camera.snapToTarget();
    return;
}

function canbefly() {
	extraTween.push(FlxTween.tween(dad, {x: dadPosX - 220}, 4, {ease: FlxEase.quadInOut, type: 4}));
    extraTween.push(FlxTween.tween(dad, {y: dadPosY + 100}, 1.4, {ease: FlxEase.quadInOut, type: 4}));

    extraTween.push(FlxTween.tween(strumLines.members[3].characters[0], {x: dadDialPosX - 220}, 4, {ease: FlxEase.quadInOut, type: 4}));
    extraTween.push(FlxTween.tween(strumLines.members[3].characters[0], {y: dadDialPosY + 100}, 1.4, {ease: FlxEase.quadInOut, type: 4}));
}

function focusToTheBitch() {
	isCameraOnForcedPos = true;

    FlxTween.tween(camGame, {zoom: 0.8}, 1.5, {ease:FlxEase.cubeInOut});
    FlxTween.tween(camFollow, {x: 220, y: 150}, 1.5, {ease:FlxEase.cubeInOut});
}

function letsStartThisShit() {
	isCameraOnForcedPos = false;
	dadZoom = 0.6;
	bfZoom = 0.45;
	boyfriend.cameraOffset.set(-400);	
	FlxTween.tween(camHUD, {alpha: 1}, 0.5, {ease: FlxEase.quadInOut});
}

function rainappear() {
	lluvia.visible = true;
	lluvia.animation.play('i');
}

function zoom1() {
	bfZoom = 0.5;
}

function zoom2() {
	bfZoom = 0.6;
}

function zoom3() {
	bfZoom = 0.7;
}

function HUDbye() {
	FlxTween.tween(camHUD, {alpha: 0}, 0.5, {ease: FlxEase.quadInOut});
}

function talk() {
	strumLines.members[3].characters[0].visible = true;
    dad.visible = false;
}