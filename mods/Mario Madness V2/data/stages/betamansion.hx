import flixel.tweens.FlxTween.FlxTweenType;

var camEST = new FlxCamera();

importScript("data/modchart/Modchart");

introLength = 0;
function onCountdown(event) event.cancel(); 

function onSongStart(){
    cpuStrums.forEach(function(strums) strums.alpha = 1);
    playerStrums.forEach(function(strums) strums.alpha = 0);
    camHUD.alpha = 0;
    camStrums.alpha = 0;
    camNotes.alpha = 0;
}

function create(){
    var dir = 'stages/Woodland-of-Lies/betamansion/';
    camEST.bgColor = 0;
    camEST.alpha = 1;
    FlxG.cameras.remove(camHUD, false);
    FlxG.cameras.add(camHUD, false);
    FlxG.cameras.add(camEST, false);

    skybox = new FlxSprite(-1200, -800).loadGraphic(Paths.image(dir + 'Skybox'));
    skybox.scrollFactor.set(0.2, 0.2);
	skybox(1, skybox);

    backBG = new FlxSprite(-1200, -800).loadGraphic(Paths.image(dir + 'BackBG'));
    backBG.scrollFactor.set(0.8, 0.8);
	insert(2, backBG);

    fireL = new FlxSprite(-320, -630);
    fireL.frames = Paths.getSparrowAtlas(dir + 'Alone_Fire');
    fireL.animation.addByPrefix('idle', 'fire', 24);
    insert(4, fireL);

    fireR = new FlxSprite(1270, -630);
    fireR.frames = Paths.getSparrowAtlas(dir + 'Alone_Fire');
    fireR.animation.addByPrefix('idle', 'fire', 24);
    fireR.flipX = true;
    insert(5, fireR);

    fireL.animation.play('idle', true);
    fireR.animation.play('idle', true);

    frontBG = new FlxSprite(-1200, -800).loadGraphic(Paths.image(dir + 'FrontBG'));
	insert(6, frontBG);

    //health = 2;

    if(FlxG.save.data.flashingLights){
        bfHang = new FlxSprite(700, -100);
        bfHang.alpha = 0;
        bfHang.frames = Paths.getSparrowAtlas('modstuff/Beta_Bf_Hang');
	    bfHang.animation.addByPrefix('idle', "BFHang", 24);
        bfHang.cameras = [camEST];
        add(bfHang);
    }

    rainFall = new FlxSprite(-170, 50);
    rainFall.alpha = 0;
    rainFall.scale.set(1.7, 1.7);
    rainFall.cameras = [camEST];
    rainFall.frames = Paths.getSparrowAtlas( dir + 'old/Beta_Luigi_Rain_V1');
	rainFall.animation.addByPrefix('idle', "RainLuigi", 24);
    rainFall.animation.play('idle', true);
    add(rainFall);

    blackBarThingie = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
	blackBarThingie.scrollFactor.set(0, 0);
    blackBarThingie.cameras = [camEST];
	blackBarThingie.alpha = 1;
	add(blackBarThingie);

    boyfriend.alpha = 0;
    strumLines.members[3].characters[0].alpha = 0;

    fog = new FlxSprite(0, 0).loadGraphic(Paths.image('modstuff/126'));
    fog.alpha = 0.8;
    fog.cameras = [camEST];
    insert(1, fog);

    FlxTween.tween(boyfriend, {y: boyfriend.y - 20}, 3, {ease: FlxEase.quadInOut, type: FlxTweenType.PINGPONG});
    FlxTween.tween(boyfriend, {x: boyfriend.x + 40}, 5, {ease: FlxEase.quadInOut, type: FlxTweenType.PINGPONG});

    FlxTween.tween(strumLines.members[3].characters[0], {y: strumLines.members[3].characters[0].y + 40}, 2, {startDelay: 0.2, ease: FlxEase.quadInOut, type: FlxTween.PINGPONG});
	FlxTween.tween(strumLines.members[3].characters[0], {x: strumLines.members[3].characters[0].x - 20}, 4, {startDelay: 0.2, ease: FlxEase.quadInOut, type: FlxTween.PINGPONG});

    strumLines.members[2].characters[0].scale.set(0.2, 0.2);
	strumLines.members[2].characters[0].scrollFactor.set(0.8, 0.8);
	strumLines.members[2].characters[0].alpha = 0;
	strumLines.members[2].characters[0].x = 310;
	strumLines.members[2].characters[0].y = -360;

    remove(boyfriend, false);
    insert(10, boyfriend);
}

function beatHit(curBeat){
    switch(curBeat){
        case 2:
            FlxTween.tween(blackBarThingie, {alpha: 0.5}, 5);
            playerStrums.forEach(function(strums) strums.alpha = 0);
        case 8:
            defaultCamZoom = 0.9;
            FlxTween.tween(camStrums, {alpha: 0.5}, 0.5);
            FlxTween.tween(camNotes, {alpha: 0.5}, 0.5);
            FlxTween.tween(camSustains, {alpha: 0.5}, 0.5);

        case 40:
            if(FlxG.save.data.flashingLights){
                FlxG.camera.flash(FlxColor.WHITE, 1);
                bfHang.alpha = 1;
                bfHang.animation.play('idle');
                FlxTween.tween(bfHang, {alpha: 0}, 2, {ease: FlxEase.quadOut});
            }
            defaultCamZoom = 0.75;
            FlxTween.tween(camStrums, {alpha: 1}, 1);
            FlxTween.tween(camNotes, {alpha: 1}, 1);
            FlxTween.tween(camSustains, {alpha: 1}, 1);
        case 41:
            FlxTween.tween(rainFall, {alpha: 0.6}, 5);
            FlxTween.tween(blackBarThingie, {alpha: 0}, 5);
        case 44:
            FlxTween.tween(boyfriend, {alpha: 0.9}, 2, {ease: FlxEase.quadOut});
            FlxTween.tween(strumLines.members[3].characters[0], {alpha: 0.9}, 2, {ease: FlxEase.quadOut});
        case 48:
            FlxTween.tween(camHUD, {alpha: 1}, 2, {ease: FlxEase.linear});
            playerStrums.forEach(function(strums){
                FlxTween.tween(strums, {alpha: 0.75}, 2, {ease: FlxEase.linear});
            });
        case 112:
            defaultCamZoom = 0.6;
        case 120:
            defaultCamZoom = 0.5;
        case 280:
            defaultCamZoom = 0.7;
        case 312:
            defaultCamZoom = 0.8;
        case 341:
            FlxTween.tween(camGame, {zoom: 0.65}, 2, {ease: FlxEase.quadInOut});
        case 343:
            FlxTween.tween(strumLines.members[2].characters[0], {alpha: 0.9}, 2, {ease: FlxEase.quadOut});
            FlxTween.tween(strumLines.members[2].characters[0].scale, {x: 1, y: 1}, 3, {ease: FlxEase.quadOut});
            FlxTween.tween(strumLines.members[2].characters[0].scrollFactor, {x: 0.95, y: 0.95}, 3, {ease: FlxEase.quadOut});
            FlxTween.tween(strumLines.members[2].characters[0], {x: 630, y: -420}, 1.5, {ease: FlxEase.quadInOut, onComplete: function(){
                FlxTween.tween(strumLines.members[2].characters[0], {x: 600, y:  -360}, 1.5, {ease: FlxEase.quadInOut, onComplete: function(){
                    FlxTween.tween(strumLines.members[2].characters[0], {x: strumLines.members[2].characters[0].x - 550}, 5, {ease: FlxEase.quadInOut, type: FlxTweenType.PINGPONG});
                    FlxTween.tween(strumLines.members[2].characters[0], {y: strumLines.members[2].characters[0].y + 100}, 1.75, {ease: FlxEase.quadInOut, type: FlxTweenType.PINGPONG});
                }});
            }});
            defaultCamZoom = 0.55;
        case 372:
            FlxTween.tween(strumLines.members[2].characters[0], {y: -900}, 1.75, {ease: FlxEase.cubeIn});
			FlxTween.tween(strumLines.members[2].characters[0], {alpha: 0}, 1.75, {ease: FlxEase.cubeIn});
        case 376:
            defaultCamZoom = 0.6;
        case 404:
            defaultCamZoom = 0.8;
        case 405:
            defaultCamZoom = 0.9;
        case 406:
            defaultCamZoom = 1;
        case 407:
            defaultCamZoom = 1.1;
        case 408:
            defaultCamZoom = 0.9;
            if(FlxG.save.data.flashingLights){
                FlxG.camera.flash(FlxColor.WHITE, 1);
            }
            blackBarThingie.alpha = 0.5;
            FlxTween.tween(camHUD, {alpha: 0}, 2);
        case 416:
            FlxTween.tween(strumLines.members[3].characters[0],      {alpha: 0}, 2.4);
			FlxTween.tween(boyfriend, {alpha: 0}, 2.4);
        case 448:
            defaultCamZoom = 1;
        case 452:
            defaultCamZoom = 0.95;
        case 466:
            FlxTween.tween(blackBarThingie, {alpha: 1}, 2);
            defaultCamZoom = 0.8;
    }
}

function stepHit(curStep){
    switch(curStep){
        case 1698:
            defaultCamZoom = 1;
        case 1730:
            defaultCamZoom = 1.05;
        case 1762:
            defaultCamZoom = 1.1;
    }
}

function onEvent(e){
	switch (e.event.name) {
		case 'Psych Events':
			var value1:String = e.event.params[1];
			var value2:String = e.event.params[2];
			var flValue1:Null<Float> = Std.parseFloat(value1);
			var flValue2:Null<Float> = Std.parseFloat(value2);
			if (Math.isNaN(flValue1)) flValue1 = null;
			if (Math.isNaN(flValue2)) flValue2 = null;
			switch (e.event.params[0]) {
				case 'Camera Follow Pos':
					if (flValue1 != null || flValue2 != null) {
						move = true;
					}else if(flValue1 == null && flValue2 == null) {
						move = false;
					}
			}
		}
}

function onPostNoteCreation(_) {
    if(_.strumLineID == 1){
        _.note.alpha = 0.75;
        if (_.note.isSustainNote){
            _.note.alpha = 0.5;
            _.note.angle = 40;
        }
    }
}

/*  Code for the rain:

    rain = new FlxSprite(0, 0);
    rain.frames = Paths.getSparrowAtlas('stages/Woodland-of-Lies/betamansion/gota');
	rain.animation.addByPrefix('rain', 'rain', 12, true);
    rain.animation.play('rain');
    rain.alpha = 0.4;

    rain.x = FlxG.random.float(0, 1270);
	rain.y = FlxG.random.float(600, 1000);

    insert(5, rain);
    FlxTween.tween(rain, {alpha: 0}, 2, {startDelay: 0.3, onComplete: function(twn:FlxTween){
		remove(rain, false);
        rain.destroy();
    }});
*/