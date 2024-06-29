import BGSprite;

function create(){
    dad.playAnim("smoke");
    dad.animation.curAnim.pause();

    sky = new FlxSprite(-200, -1000).loadGraphic(Paths.image('stages/ContentCosmos/cityout/skyL'));
    sky.scrollFactor.set(0.7, 0.8);
    insert(0, sky);

    citybg = new FlxSprite(400, -200).loadGraphic(Paths.image('stages/ContentCosmos/cityout/buildings far'));
    citybg.scrollFactor.set(0.7, 0.8);
    insert(1, citybg);

    cityplus = new FlxSprite(600, 100).loadGraphic(Paths.image('stages/ContentCosmos/cityout/road plus building'));
    cityplus.scrollFactor.set(0.8, 1);
    insert(2, cityplus);

    lightsky = new FlxSprite(800, -500).loadGraphic(Paths.image('stages/ContentCosmos/cityout/corner sky overlay'));
    lightsky.scrollFactor.set(0.8, 0.8);
    insert(3, lightsky);

    wall = new FlxSprite( -950, -450).loadGraphic(Paths.image('stages/ContentCosmos/cityout/buildingSide'));
    wall.scrollFactor.set(1, 1);
    insert(4, wall);


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

    lightWall = new FlxSprite(-800, -550).loadGraphic(Paths.image('stages/ContentCosmos/cityout/Overlay All'));
    lightWall.scrollFactor.set(1.2,1.2);
}
function walk(){
    //FlxTween.tween(camFollowPos, {x: DAD_CAM_X, y: DAD_CAM_Y}, 1.5, {ease: FlxEase.quadOut}));
    mrwalk.alpha = 1;
    dad.visible = false;

    gfwalk.alpha = 1;
    gflol.visible = false;

    bfwalk.alpha = 1;
    boyfriend.visible = false;

    lgwalk.alpha = 1;
    gf.visible = false;

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