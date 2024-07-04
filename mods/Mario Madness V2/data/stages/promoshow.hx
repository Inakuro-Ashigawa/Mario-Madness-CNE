var camEst:FlxCamera;

defaultcamZoom = .8;

function create(){
    //cameras
    camEst = new FlxCamera();
	camEst.bgColor = 0;
    FlxG.cameras.remove(camHUD, false);
    FlxG.cameras.add(camEst, false);
	FlxG.cameras.add(camHUD, false);

    //postions
    boyfriend.setPosition(285, 375);
    boyfriend.cameraOffset.x = 504;
    boyfriend.cameraOffset.y = -142;
    gf.setPosition(100, 350);
    dad.setPosition(1150, 64);

    promoBGSad = new FlxSprite(0, 19);
    promoBGSad.frames = Paths.getFrames('stages/ClassifiedCastle/promo/promobg');
    promoBGSad.animation.addByPrefix('idle', 'bg depression', 24, true);
    promoBGSad.animation.play('idle');
    insert(0, promoBGSad);

    promoBG = new FlxSprite(0, 19);
    promoBG.frames = Paths.getFrames('stages/ClassifiedCastle/promo/promobg');
    promoBG.animation.addByPrefix('idle', 'bg normal', 24, true);
    promoBG.animation.play('idle');
    insert(1, promoBG);

    promoDesk = new FlxSprite(740, 552);
    promoDesk.frames = Paths.getFrames('stages/ClassifiedCastle/promo/promodesk');
    promoDesk.animation.addByPrefix('stat', 'Promario desk static', 24, true);
    promoDesk.animation.addByPrefix('luigi', 'Promario desk luigi', 24, true);
    promoDesk.animation.addByPrefix('flash', 'Promario desk flash', 24, false);
    add(promoDesk);

    darkFloor = new FlxSprite(600, 800).loadGraphic(Paths.image('stages/ClassifiedCastle/promo/wood floor'));
    insert(2, darkFloor);

    bgLuigi = new FlxSprite(200, 275);
    bgLuigi.frames = Paths.getFrames('stages/ClassifiedCastle/promo/promo_luigi');
    bgLuigi.animation.addByPrefix('idle', 'luigi idle right', 24, false);
    bgLuigi.animation.addByPrefix('idle-alt', 'luigi idle left', 24, false);
    add(bgLuigi);

    bgPeach = new FlxSprite(1225, 225);
    bgPeach.frames = Paths.getFrames('stages/ClassifiedCastle/promo/promo_peach');
    bgPeach.animation.addByPrefix('idle', 'peach idle right', 24, false);
    bgPeach.animation.addByPrefix('idle-alt', 'peach idle left', 24, false);
    add(bgPeach);

    
    blackBarThingie = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    blackBarThingie.setGraphicSize(Std.int(blackBarThingie.width * 10));
    blackBarThingie.alpha = 0;
    blackBarThingie.cameras = [camEst];
    add(blackBarThingie);

    tvTransition = new FlxSprite(0,0);
    tvTransition.frames = Paths.getFrames('stages/ClassifiedCastle/promo/tv_trans');
    tvTransition.animation.addByPrefix('dothething', 'transition', 24, false);
    tvTransition.cameras = [camEst];
    tvTransition.visible = false;
    add(tvTransition);

    stanlines = new FlxSprite(550, 500);
    stanlines.frames = Paths.getFrames('stages/ClassifiedCastle/promo/stanley_lines');
    stanlines.animation.addByIndices('line1', 'lines', [0], "", 24, true);
    stanlines.animation.addByIndices('line2', 'lines', [1], "", 24, true);
    stanlines.animation.addByIndices('line3', 'lines', [2], "", 24, true);
    stanlines.animation.addByIndices('line4', 'lines', [3], "", 24, true);
    stanlines.animation.addByIndices('line5', 'lines', [4], "", 24, true);
    stanlines.animation.addByIndices('line6', 'lines', [5], "", 24, true);
    stanlines.animation.addByIndices('line7', 'lines', [6], "", 24, true);
    stanlines.animation.addByIndices('line8', 'lines', [7], "", 24, true);

    bgLuigi.alpha = promoBGSad.alpha = darkFloor.alpha = stanlines.alpha = bgPeach.alpha = 0;
}
function events(event){
    if (event == "sad"){
        promoDesk.animation.play('flash');
        dad.playAnim("depression", true);
        dad.idleSuffix = '-alt';
        new FlxTimer().start(0.3, function(tmr:FlxTimer)
        {
            promoDesk.animation.play('luigi');
            new FlxTimer().start(0.8, function(tmr:FlxTimer)
            {
                promoBGSad.alpha = 1;
                FlxTween.tween(promoBG, {alpha: 0}, 1, {ease: FlxEase.quadInOut});
            });
        });
    }
    if (event == "black"){
        tvTransition.animation.play('dothething');
        tvTransition.visible = true;
        new FlxTimer().start(0.08, function(tmr:FlxTimer)
        {
            blackBarThingie.alpha = 1;
            camHUD.alpha = 0;
        });
    }
}
function back(){
    gf.alpha = boyfriend.alpha = promoDesk.alpha = promoBGSad.alpha = promoBG.alpha = 0.001;
    darkFloor.alpha = 1;

    defaultCamZoom = 0.7;

    add(stanlines);
    stanlines.alpha = 0;

    if (health > 1)
    {
        health = 1;
    }

    dad.x = 697;
    dad.y = 195;

    FlxTween.tween(blackBarThingie, {alpha: 0}, 4, {ease: FlxEase.quadInOut});
    FlxTween.tween(camHUD, {alpha: 1}, 4, {ease: FlxEase.quadInOut});
}