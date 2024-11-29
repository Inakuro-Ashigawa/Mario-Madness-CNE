var camEST = new FlxCamera();
var blackBarThingie,gflol:FlxSprite;
var cancelCameraMove:Bool = false;

function onCameraMove(e) if(cancelCameraMove) e.cancel();


function create(){
    camEST.bgColor = 0;
    camEST.alpha = 1;
    FlxG.cameras.remove(camHUD, false);
    FlxG.cameras.add(camHUD, false);
    FlxG.cameras.add(camEST, false);

    blackBarThingie = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    blackBarThingie.setGraphicSize(Std.int(blackBarThingie.width * 10));
    blackBarThingie.scrollFactor.set(0, 0);
    blackBarThingie.alpha = 1;
    blackBarThingie.cameras = [camEST];
    add(blackBarThingie);

    dad.playAnim("smoke hold");
    dad.animation.curAnim.pause();

    boyfriend.cameraOffset.x = 320;

    gflol = new FlxSprite(-400, 300);
    gflol.scrollFactor.set(1,1);
    gflol.frames = Paths.getSparrowAtlas('characters/ContentCosmos/ldo/GF_LDO');
    gflol.animation.addByIndices('danceleft', "ldo gf dance", [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
    gflol.animation.addByIndices('danceright', "ldo gf dance", [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
    gflol.animation.addByIndices('danceLeft-alt', "ldo gf dance annoyed", [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
    gflol.animation.addByIndices('danceRight-alt', "ldo gf dance annoyed", [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
    gflol.animation.addByPrefix('why', "ldo gf why", 24, false);
    gflol.alpha = 0.000001;
    add(gflol);

    gfwalk = new FlxSprite(-390, 280);
    gfwalk.scrollFactor.set(1,1);
    gfwalk.frames = Paths.getSparrowAtlas('stages/ContentCosmos/cityout/they-walkin');
    gfwalk.animation.addByPrefix('why', "ldo gf end dialogue", 21, false);
    
    gfspeak = new FlxSprite(-390, 640).loadGraphic(Paths.image('stages/ContentCosmos/cityout/stereo_still_image'));
    gfspeak.alpha = 0.000001;

    bfwalk = new FlxSprite(-13, 325);
    bfwalk.scrollFactor.set(1,1);
    bfwalk.frames = Paths.getSparrowAtlas('stages/ContentCosmos/cityout/they-walkin');
    bfwalk.animation.addByPrefix('why', "ldo bf end dialogue", 21, false);
    bfwalk.scale.set(1.1, 1.1);

    mrwalk = new FlxSprite(355, 248);
    mrwalk.scrollFactor.set(1,1);
    mrwalk.frames = Paths.getSparrowAtlas('stages/ContentCosmos/cityout/they-walkin');
    mrwalk.animation.addByPrefix('why', "ldo mario end dialogue", 21, false);

    lgwalk = new FlxSprite(796.5, 150);
    lgwalk.scrollFactor.set(1,1);
    lgwalk.frames = Paths.getSparrowAtlas('stages/ContentCosmos/cityout/they-walkin');
    lgwalk.animation.addByPrefix('why', "ldo luigi end dialogue", 21, false);

    gfwalk.alpha = 0.000001;
    bfwalk.alpha = 0.000001;
    mrwalk.alpha = 0.000001;
    lgwalk.alpha = 0.000001;
    add(gfspeak);
    add(lgwalk);
    add(mrwalk);
    add(bfwalk);
    add(gfwalk);

    //boyfriend.alpha = camHUD.alpha = 0.0001;
    gflol.animation.play('danceright',false);
}
function events(event){
    if (event == "Appear"){
        FlxTween.tween(camFollow, {x: 320, y: 450}, 2.4, {ease: FlxEase.cubeInOut});
        FlxTween.tween(FlxG.camera, {zoom: 0.7}, 2.4, {ease: FlxEase.cubeInOut});
        boyfriend.alpha = 1;
        gflol.alpha = 1;
        boyfriend.playAnim("singUP");
    }
    if (event == "moveNotes"){
        for (i in cpuStrums.members){
            FlxTween.tween(i, {alpha: i.alpha - 1,x: 999 + i.x }, 1, {ease: FlxEase.circOut});
        }
        for (i in playerStrums.members){
			FlxTween.tween(i, {x: i.x + 600}, 1, {ease: FlxEase.circOut});
		}
    }
    if (event == "kid"){
        cancelCameraMove = true;
        gflol.animation.play('why');
        FlxTween.tween(camFollow, {x: 320, y: 450}, .3, {ease: FlxEase.quadOut});

        new FlxTimer().start(1.4, function(tmr:FlxTimer){
            cancelCameraMove = false;
            dad.playAnim("idiot");
        });
    }

}
function postCreate(){
    healthBarBG.flipX = true;
    icoP1.flipX = true;
    icoP2.flipX = true;

    camGame.zoom = defaultCamZoom = FlxG.camera.zoom = .9;
    curCameraTarget = 0;
}
function onSongStart()
    FlxTween.tween(blackBarThingie, {alpha: 0}, 0.5, {startDelay: 1, ease: FlxEase.quadInOut});

function walk(){
    cancelCameraMove = true;
    FlxTween.tween(camFollow, {x: 760, y: 450}, 1.5, {ease: FlxEase.cubeInOut});
    FlxTween.tween(FlxG.camera, {zoom: 0.7}, 1.5, {ease: FlxEase.cubeInOut});
    FlxTween.tween(camGame, {zoom: 0.7}, 1.5, {ease: FlxEase.cubeInOut});
    FlxTween.tween(camHUD, {alpha: 0.00001}, 1.5, {ease: FlxEase.quadOut});
    defaultCamZoom = .7;

    lgwalk.alpha = bfwalk.alpha = gfwalk.alpha = mrwalk.alpha = 1;

    gflol.visible = boyfriend.visible = gf.visible = dad.visible = false;

    gfwalk.animation.play('why');
    bfwalk.animation.play('why');
    mrwalk.animation.play('why');
    lgwalk.animation.play('why');

    gfspeak.alpha = 1;

    FlxTween.tween(gfwalk, {y: gfwalk.y + 400, x: gfwalk.x + 2533}, 6, {startDelay: 7.71});
    FlxTween.tween(bfwalk, {y: bfwalk.y + 400, x: bfwalk.x + 2533}, 6, {startDelay: 7.85});
    FlxTween.tween(mrwalk, {y: mrwalk.y + 400, x: mrwalk.x + 2533}, 6, {startDelay: 6.19});
    FlxTween.tween(lgwalk, {y: lgwalk.y + 400, x: lgwalk.x + 2533}, 6, {startDelay: 9.14});
}
function beatHit(){
    if (gflol.animation.curAnim.finished || gflol.animation.curAnim.name == 'danceleft' || gflol.animation.curAnim.name == 'danceright')
    {
        if (gflol.animation.curAnim.name == 'danceleft')
        {
            gflol.animation.play('danceright');
        }
        else
        {
            gflol.animation.play('danceleft');
        }
    }
}