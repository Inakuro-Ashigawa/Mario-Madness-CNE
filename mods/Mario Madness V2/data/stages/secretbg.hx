//Mlaofmd was here

static var isCameraOnForcedPos:Bool = false;

var blackScreen:FlxSprite;

//bg shits
var skyBox:FlxSprite;
var backTrees:FlxSprite;
var floorField:FlxSprite;

var frontTrees:FlxSprite;

//mechs shits
var explosionBOM:FlxSprite;
var secretWarning:FlxSprite;

var bulletCounter:Int = 0;
var bulletTimer:Int = 0;

//its skips countdown, rip
introLength = 0;
function onCountdown(event) 
    event.cancel();

//camera shits lol
function onCameraMove(event) {
    if (isCameraOnForcedPos && !event.cancelled) {
        event.position.set(camFollow.x, camFollow.y);
    }
}

function create() {
    introCam = new FlxCamera();
    introCam.bgColor = 0x00000000;
    FlxG.cameras.add(introCam, false);

    camHUD.alpha = 0;

    blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    blackScreen.setGraphicSize(Std.int(blackScreen.width * 10));
    blackScreen.scrollFactor.set(0, 0);
    blackScreen.visible = true;
    blackScreen.cameras = [introCam];
    add(blackScreen);

    skyBox = new FlxSprite(-1300, -600).loadGraphic(Paths.image('stages/ContentCosmos/secret/SkyBox'));
    skyBox.scrollFactor.set(0.4, 0.4);
    skyBox.setGraphicSize(Std.int(skyBox.width * 0.85));
    skyBox.antialiasing = true;
    insert(0, skyBox);

    backTrees = new FlxSprite(-1300, -600).loadGraphic(Paths.image('stages/ContentCosmos/secret/BackTrees'));
    backTrees.scrollFactor.set(0.8, 0.8);
    backTrees.setGraphicSize(Std.int(backTrees.width * 0.85));
    backTrees.antialiasing = true;
    insert(1, backTrees);

    floorField = new FlxSprite(-1300, -600).loadGraphic(Paths.image('stages/ContentCosmos/secret/WallAndFloor'));
    floorField.setGraphicSize(Std.int(floorField.width * 0.85));
    floorField.antialiasing = true;
    insert(2, floorField);

    frontTrees = new FlxSprite(-1300, -700).loadGraphic(Paths.image('stages/ContentCosmos/secret/BushesForeground'));
    frontTrees.scrollFactor.set(1.4, 1.4);
    frontTrees.antialiasing = true;
    add(frontTrees);

    explosionBOM = new FlxSprite(250, -290);
    explosionBOM.frames = Paths.getSparrowAtlas('stages/ContentCosmos/secret/SECRETEXPLOSION');
    explosionBOM.animation.addByPrefix('BOOM', '1', 35, false);
    explosionBOM.alpha = 0;
    explosionBOM.setGraphicSize(Std.int(explosionBOM.width * 1.5));
    explosionBOM.updateHitbox();
    add(explosionBOM);

    secretWarning = new FlxSprite();
    secretWarning.frames = Paths.getSparrowAtlas('stages/ContentCosmos/secret/BulletBill_Warning');
    secretWarning.animation.addByPrefix('loop', 'warning', 24, true);
    secretWarning.animation.addByPrefix('bye', 'blow away', 24, false);
    secretWarning.animation.play('loop');
    secretWarning.cameras = [camHUD];
    secretWarning.screenCenter();
    secretWarning.x += 200;
    secretWarning.visible = false;
    add(secretWarning);
}

function onSongStart(){
    FlxTween.tween(blackScreen, {alpha: 0}, 0.5, {startDelay: 1, ease: FlxEase.quadInOut});
    isCameraOnForcedPos = true;
    camFollow.x = 220;
    camFollow.y = -390;
    FlxG.camera.snapToTarget();
}

function stepHit(curStep) {
    switch(curStep){
        case 16:
            FlxTween.tween(camFollow, {y: 380}, 4, {ease: FlxEase.quadInOut});
            FlxTween.tween(camGame, {zoom: 1.2}, (22.5 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.quadInOut});
        case 108:
            FlxTween.tween(camGame, {zoom: 1.3}, 1, {startDelay: (0.5 * (1 / (Conductor.bpm / 60))), ease: FlxEase.backOut});
        case 120:
            FlxTween.tween(camGame, {zoom: 0.8}, (2 * (1 / (Conductor.bpm / 60))), { ease: FlxEase.quadIn});
        case 124:
            FlxTween.tween(camHUD, {alpha: 1}, 0.5, {ease: FlxEase.quadInOut});
        case 128:
            isCameraOnForcedPos = false;
        case 148:
            secretWarning.visible = true;
            secretWarning.y -= 800;
            FlxTween.tween(secretWarning, {y: secretWarning.y + 800}, 1.5, {ease: FlxEase.quadOut});
        case 176:
            secretWarning.animation.play('bye', true);
            secretWarning.x -= 470;
        case 256:
            defaultCamZoom = 0.8;
        case 288:
            defaultCamZoom = 0.75;
        case 320:
            defaultCamZoom = 0.6;
        case 512:
            defaultCamZoom = 0.9;
        case 576:
            defaultCamZoom = 1;
        case 704:
            defaultCamZoom = 0.6;
        case 864:
            defaultCamZoom = 0.7;
        case 896:
            defaultCamZoom = 0.5;
        case 960:
            defaultCamZoom = 0.8;
        case 1040:
            defaultCamZoom = 0.9;
        case 1056:
            defaultCamZoom = 1;
        case 1072:
            defaultCamZoom = 1.1;
        case 1088:
            defaultCamZoom = 0.6;
        case 1152:
            defaultCamZoom = 0.7;
        case 1216:
            FlxTween.tween(camHUD, {alpha: 0}, 0.5, {ease: FlxEase.quadInOut});
            defaultCamZoom = 0.8;
        case 1232:
            isCameraOnForcedPos = true;
            FlxTween.tween(camFollow, {x: 1020, y: 550}, (2 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.quadIn});
            FlxTween.tween(camGame, {zoom: 1}, 0.3, {ease: FlxEase.quadOut});
            defaultCamZoom = 1;
        case 1240:
            defaultCamZoom = 0.6;
            FlxTween.tween(camFollow, {y: 50}, (1 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.quadOut});
            isCameraOnForcedPos = true;
            explosionBOM.alpha = 1;
            explosionBOM.animation.play('BOOM');
        case 1244:
            blackScreen.alpha = 1;
    }
}

// now NOTE SHITS

function onNoteHit(e) {
    if (e.noteType == "Bullet Bill" || e.noteType == "Bullet2"){
        bulletCounter += 1;
        if(bulletCounter >= 2){
            bulletCounter = 0;
            
            var x = playerStrums.members[e.note.noteData].x;
            var y = playerStrums.members[e.note.noteData].y;
            var spl = new FlxSprite(x,y);
            spl.frames = Paths.getSparrowAtlas('stages/ContentCosmos/secret/BulletBillMario_NOTE_assets');
            spl.animation.addByPrefix('boom', 'notesplash', 24, false);
            spl.antialiasing = true;
            spl.offset.x += 460;
            spl.offset.y += 350;
            spl.camera = camHUD;
            if (downscroll){
                spl.flipY = true;
                spl.offset.y -= 450;
            }
            spl.animation.play('boom', true);
            spl.animation.finishCallback = (_) -> {
                remove(spl);
            }
            add(spl);

            FlxG.sound.play(Paths.sound('SHbullethit'), 0.6);
        }
    }
    return;
}

function onPlayerMiss(e) {
    if (e.noteType == 'Bullet Bill'){
        bulletTimer = 1;
    }
    return;
}

function update(elapsed){
    if (bulletTimer > 0){
        bulletTimer -= 1 * (60);
        if (bulletTimer <= 0){
            bulletTimer = -1;
            health = health - 1;
            FlxG.sound.play(Paths.sound('SHbulletmiss'), 0.5);
            var whiteSquare:FlxSprite = new FlxSprite().makeGraphic(Std.int(iconP1.width / 2), Std.int(iconP1.height / 2), FlxColor.WHITE);
            whiteSquare.cameras = [camHUD];
            whiteSquare.setPosition(iconP1.x + 60, iconP1.y + 30);
            add(whiteSquare);

            new FlxTimer().start(0.05, function(tmr:FlxTimer)
                {
                    whiteSquare.destroy();
                    iconP1.color = 0x000000;
                    whiteSquare.visible = true;
                    new FlxTimer().start(0.05, function(tmr:FlxTimer)
                        {
                            iconP1.color = 0xFFFFFF;
                        });
                });
        }
    }
    return;
}