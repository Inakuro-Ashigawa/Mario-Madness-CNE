//Imports
import flixel.tweens.FlxTween.FlxTweenType;
import flixel.addons.display.FlxBackdrop;

var camOther:FlxCamera;

var act2Cam:Bool = false;

function postCreate(){
    var lg2 = new Character(200, 670, "lg2", false);
    insert(12, lg2);
    lg2.scrollFactor.set(0.9, 0.9);
    cpuStrums.characters.push(lg2);
    lg2c = strumLines.members[0].characters[1];

    var w4r = new Character(-370, 910, "w4r", true);
    insert(13, w4r);
    w4r.scrollFactor.set(0.9, 0.9);
    cpuStrums.characters.push(w4r);
    w4rc = strumLines.members[0].characters[2];

    var y0shi = new Character(850, 1000, "y0shi", false);
    insert(14, y0shi);
    y0shi.scrollFactor.set(0.9, 0.9);
    cpuStrums.characters.push(y0shi);
    y0shic = strumLines.members[0].characters[3];
}

function create(){
    camOther = new FlxCamera(0, 0, 1280, 720);
    camOther.bgColor = FlxColor.TRANSPARENT;
    FlxG.cameras.add(camOther, false);

    boyfriend.x = 92;
    boyfriend.y = 127;

    dad.x = -1315.5;
    dad.y = 432.5;

    playerStrums.characters[1].x = 413;
    playerStrums.characters[1].y = 153;

    //act 2

    act2Stat = new FlxSprite(-70, -360).loadGraphic(Paths.image('stages/MushroomKingdom/allfinal/act2/act2_static'));
	act2Stat.frames = Paths.getSparrowAtlas('stages/MushroomKingdom/allfinal/act2/act2_static');
	act2Stat.animation.addByPrefix('idle', 'act2stat', 24, true);
    act2Stat.scrollFactor.set(0.2, 0.2);
	act2Stat.scale.set(1.75, 1.75);
	insert(0, act2Stat);

    act2Stat.animation.play('idle', true);

    act2WhiteFlash = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
	act2WhiteFlash.setGraphicSize((act2Stat.width * 10));
	act2WhiteFlash.alpha = 0;
	insert(1, act2WhiteFlash);

    act2Sky = new FlxBackdrop(Paths.image('stages/MushroomKingdom/allfinal/act2/act2_scroll1'));
	act2Sky.scrollFactor.set(0.3, 0.3);
	act2Sky.velocity.x = 100;
	act2Sky.y = -300;
	act2Sky.x = -500;
	insert(3, act2Sky);

    act2BFPipe = new FlxSprite(-630, -80).loadGraphic(Paths.image('stages/MushroomKingdom/allfinal/act2/act2_pipes_lgbf'));
	act2BFPipe.scale.set(1.2, 1.2);
	insert(20, act2BFPipe);

    act2PipesFar = new FlxSprite(-500, -270).loadGraphic(Paths.image('stages/MushroomKingdom/allfinal/act2/act2_pipes_far'));
    act2PipesFar.scrollFactor.set(0.6, 0.6);
	insert(4, act2PipesFar);

    act2Gradient = new FlxSprite(-500, -425).loadGraphic(Paths.image('stages/MushroomKingdom/allfinal/act2/act2_abyss_gradient'));
    act2Gradient.scrollFactor.set(0.6, 0.6);
	insert(5, act2Gradient);

    act2PipesMiddle = new FlxSprite(-500, -300).loadGraphic(Paths.image('stages/MushroomKingdom/allfinal/act2/act2_pipes_middle'));
    act2PipesMiddle.scrollFactor.set(0.7, 0.7);
	insert(6, act2PipesMiddle);

    act2PipesClose = new FlxSprite(-500, -320).loadGraphic(Paths.image('stages/MushroomKingdom/allfinal/act2/act2_pipes_close'));
    act2PipesClose.scrollFactor.set(0.8, 0.8);
	insert(7, act2PipesClose);

    act2Fog = new FlxSprite(0, 0).loadGraphic(Paths.image('stages/MushroomKingdom/allfinal/act2/act2'));
	act2Fog.cameras = [camOther];
	add(act2Fog);

    act2LPipe = new FlxSprite(-600, 440).loadGraphic(Paths.image('stages/MushroomKingdom/allfinal/act2/act2_pipes_lgbf'));
    act2LPipe.scrollFactor.set(0.9, 0.9);
	insert(9, act2LPipe);

    act2WPipe = new FlxSprite(-1040, 540).loadGraphic(Paths.image('stages/MushroomKingdom/allfinal/act2/act2_pipes_lgbf'));
    act2WPipe.scrollFactor.set(0.95, 0.95);
	insert(10, act2WPipe);

    act2YPipe = new FlxSprite(-240, 540).loadGraphic(Paths.image('stages/MushroomKingdom/allfinal/act2/act2_pipes_lgbf'));
    act2YPipe.scrollFactor.set(0.95, 0.95);
    act2YPipe.flipX = true;
	insert(11, act2YPipe);

    //act 3

    /*DUST = new FlxSprite().loadGraphic(Paths.image('stages/MushroomKingdom/allfinal/act3/act3'));
    insert(0, DUST);
    DUST.cameras = [camHUD];

    Spotlight = new FlxSprite().loadGraphic(Paths.image("stages/MushroomKingdom/allfinal/act3/act3Spotlight"));
    add(Spotlight);
    Spotlight.y = -800;
    Spotlight.x = -1700;
    Spotlight.scale.set(1.3, 1);
    Spotlight.forceIsOnScreen = true;

    Pipe = new FlxSprite().loadGraphic(Paths.image("stages/MushroomKingdom/allfinal/act3/Act3_bfpipe"));
    insert(1, Pipe);
    Pipe.y = 610;
    Pipe.x = -100;
    Pipe.forceIsOnScreen = true;

    MarvinEyes = new FunkinSprite(0,0, Paths.image("stages/MushroomKingdom/allfinal/act3/Act3_Ultra_Pupils"));
    XMLUtil.addAnimToSprite(MarvinEyes, {name: "ultra pupils", anim: "ultra pupils", fps: 24, animType: "none", indices: [], x: 376, y: -200, forced: true});
    insert(1, MarvinEyes);
    MarvinEyes.playAnim("ultra pupils", true); 
    MarvinEyes.forceIsOnScreen = true; 

    MarvinHead2 = new FunkinSprite(0,0, Paths.image("stages/MushroomKingdom/allfinal/act3/Act3_Ultra_M_Head2"));
    XMLUtil.addAnimToSprite(MarvinHead2, {name: "ultra m lyrics 2", anim: "ultra m lyrics 2", fps: 24, animType: "none", indices: [], x: 570, y: 100, forced: true});
    XMLUtil.addAnimToSprite(MarvinHead2, {name: "ultra m head laugh", anim: "ultra m head laugh", fps: 24, animType: "none", indices: [], x: 570, y: 100, forced: true});
    insert(1, MarvinHead2);  
    MarvinHead2.alpha = 0;
    MarvinHead2.scale.set(1.1, 1.1);
    MarvinHead2.forceIsOnScreen = true;

    MarvinHead = new FunkinSprite(0,0, Paths.image("stages/MushroomKingdom/allfinal/act3/Act3_Ultra_M_Head"));
    XMLUtil.addAnimToSprite(MarvinHead, {name: "ultra m static head", anim: "ultra m static head", fps: 24, animType: "none", indices: [], x: 570, y: 100, forced: true});
    XMLUtil.addAnimToSprite(MarvinHead, {name: "ultra m lyrics 1", anim: "ultra m lyrics 1", fps: 24, animType: "none", indices: [], x: 570, y: 100, forced: true});
    insert(1, MarvinHead);
    MarvinHead.playAnim("ultra m static head", true);  
    MarvinHead.scale.set(1.1, 1.1);
    MarvinHead.forceIsOnScreen = true;
    
    Marvin = new FunkinSprite(0,0, Paths.image("stages/MushroomKingdom/allfinal/act3/Act3_Ultra_M"));
    XMLUtil.addAnimToSprite(Marvin, {name: "torso idle 1", anim: "torso idle 1", fps: 24, animType: "none", indices: [], x: 1030, y: 0, forced: true});
    XMLUtil.addAnimToSprite(Marvin, {name: "torso change pose", anim: "torso change pose", fps: 24, animType: "none", indices: [], x: 1030, y: 0, forced: true});
    insert(1, Marvin);
    Marvin.scale.x = 1.3;
    Marvin.scale.y = 1.3;
    Marvin.forceIsOnScreen = true;

    MarvinHand = new FlxSprite().loadGraphic(Paths.image("stages/MushroomKingdom/allfinal/act3/Act3_Ultra_Arm"));
    insert(1, MarvinHand);
    MarvinHand.y = -700;
    MarvinHand.x = -1400;
    MarvinHand.forceIsOnScreen = true;
    */
}


//Song Events
function stepHit() {
    switch (curStep) {
        /*case 2224:
            FlxTween.tween(boyfriend, {alpha:0}, 0.4, {ease: FlxEase.linear});
            FlxTween.tween(dad, {alpha:0}, 0.4, {ease: FlxEase.linear});
            FlxTween.tween(gf, {alpha:0}, 0.4, {ease: FlxEase.linear});

        case 2240:
            //RESET

            boyfriend.x = 92;
            boyfriend.y = 127;

            dad.x = -1315.5;
            dad.y = 432.5;

            boyfriend.alpha = 0;

            gf.alpha = 0;

            dad.alpha = 0;
            dad.y = -500;

            FlxTween.tween(boyfriend, {alpha:1}, 1, {ease: FlxEase.linear});
            FlxTween.tween(dad, {alpha:1}, 1, {ease: FlxEase.linear});

            FlxTween.tween(camGame, {zoom: 1}, 0.1, {ease: FlxEase.linear, onComplete: function(tween:FlxTween){defaultCamZoom = 1;}});

        case 2260:
            FlxTween.tween(Spotlight, {alpha:0}, 3, {ease: FlxEase.linear});  

        case 2272:
            FlxTween.tween(dad, {y: -100}, 2, {ease: FlxEase.linear});

            FlxTween.tween(camGame, {zoom: 0.58}, 0.7, {ease: FlxEase.linear, onComplete: function(tween:FlxTween){defaultCamZoom = 0.58;}});

        case 2976:
            FlxTween.tween(camGame, {zoom: 1}, 65, {ease: FlxEase.linear, onComplete: function(tween:FlxTween){defaultCamZoom = 1;}});
            MarvinHead.playAnim("ultra m lyrics 1", true);  

        case 3100:
            FlxTween.tween(MarvinEyes, {alpha:0}, 0.2, {ease: FlxEase.linear});  

        case 3232:
            remove(MarvinHead, true);
            MarvinHead2.alpha = 1;
            MarvinHead2.playAnim("ultra m lyrics 2", true);  
            Marvin.playAnim("torso change pose", true); 

        case 3485:
            MarvinHead2.playAnim("ultra m head laugh", true); 
            FlxTween.cancelTweensOf(camGame);
            FlxTween.tween(camGame, {zoom: 0.4}, 0.4, {ease: FlxEase.bounceInOut, onComplete: function(tween:FlxTween){defaultCamZoom = 0.6;}});
            
        case 3481:
            FlxTween.cancelTweensOf(MarvinHead2);

            FlxTween.tween(DUST, {alpha:0}, 1, {ease: FlxEase.linear});  

        case 3485:
            FlxTween.tween(camGame, {zoom: 3}, 0.6, {ease: FlxEase.easeInElastic, onComplete: function(tween:FlxTween){defaultCamZoom = 3;}});

        case 3504:
            remove(Pipe, true);
            remove(MarvinEyes, true);
            remove(Marvin, true);
            remove(MarvinHand, true);
            remove(MarvinHead2, true);
            remove(Spotlight, true);
            remove(DUST, true);
        */
    }
}


//head shit for act 3

function beatHit(){
/*
    if (curBeat % 4 == 0){
        (FlxTween.tween(MarvinHead, {y: 0 + 30}, 0.1, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween){
            (FlxTween.tween(MarvinHead, {y: 0}, 0.4, {ease: FlxEase.quadInOut}));
        }
    }));
        (FlxTween.tween(MarvinEyes, {y: 0 + 30}, 0.1, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween){
            (FlxTween.tween(MarvinEyes, {y: 0}, 0.4, {ease: FlxEase.quadInOut}));
        }
    }));
        (FlxTween.tween(MarvinHead2, {y: 0 + 30}, 0.1, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween){
            (FlxTween.tween(MarvinHead2, {y: 0}, 0.4, {ease: FlxEase.quadInOut}));
        }
    }));
    Marvin.playAnim("torso idle 1", true);  
    }
    */
    switch(curBeat){
        case 264:
            dad.x = 320;
			dad.y = -130;
            boyfriend.x += 175;
			dad.scrollFactor.set(0.5, 0.5);
            remove(dad, false);
            remove(boyfriend, false);
            insert(4, dad);
            insert(30, boyfriend);
            defaultCamZoom = 2;
            act2Cam = true;
            remove(playerStrums.characters[1]);
        case 396:
            act2Sky.velocity.x = 0;
            FlxTween.tween(lg2c, {y: lg2c.y - 800}, 2, {ease: FlxEase.circOut});
			FlxTween.tween(act2LPipe, {y: act2LPipe.y - 800}, 2, {ease: FlxEase.circOut});
        case 400:
            dad.alpha = 0;
        case 411:
            FlxTween.tween(w4rc, {y: w4rc.y - 800}, 2, {ease: FlxEase.circOut});
			FlxTween.tween(act2WPipe, {y: act2WPipe.y - 800}, 2, {ease: FlxEase.circOut});

		case 396 | 400 | 404 | 408 | 412 | 416 | 420 | 424 | 426 | 427:
            if (FlxG.save.data.flashingLights){
				act2WhiteFlash.alpha = 1;
				FlxTween.tween(act2WhiteFlash, {alpha: 0}, 0.35, {ease: FlxEase.quadInOut});
			}
            FlxTween.tween(act2Sky, {x: act2Sky.x - 75}, 0.35, {ease: FlxEase.quadOut});
        case 428:
            if (FlxG.save.data.flashingLights){
				act2WhiteFlash.alpha = 1;
				FlxTween.tween(act2WhiteFlash, {alpha: 0}, 0.35, {ease: FlxEase.quadInOut});
			}
            act2Sky.velocity.x = -200;
            FlxTween.tween(y0shic, {y: y0shic.y - 800}, 2, {ease: FlxEase.circOut});
			FlxTween.tween(act2YPipe, {y: act2YPipe.y - 800}, 2, {ease: FlxEase.circOut});

        

    }


}


function postUpdate(elapsed:Float) { 
    /*
    if (curCameraTarget == 0) {
        FlxTween.tween(MarvinEyes, {x: 0}, 1, {ease: FlxEase.linear});
    } else {
        FlxTween.tween(MarvinEyes, {x: 50}, 1, {ease: FlxEase.linear});
    }
        */
}

function stageSwitchSections(curStageSwitch:Int){
    switch(curStageSwitch){

    }
}

function onCameraMove(event){
    if(act2Cam){
        switch(curCameraTarget){
            case 0:
                defaultCamZoom = 0.7;
            case 1:
                defaultCamZoom = 0.8;
        }
    }
}