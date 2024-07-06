//Imports
import flixel.tweens.FlxTween.FlxTweenType;

function create(){
boyfriend.x = 92;
boyfriend.y = 127;

dad.x = -1315.5;
dad.y = 432.5;

gf.x = 413;
gf.y = 153;

    //act 3

    DUST = new FlxSprite().loadGraphic(Paths.image('stages/MushroomKingdom/allfinal/act3/act3'));
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
}


//Song Events
function stepHit() {
    switch (curStep) {
        case 2224:
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
    }
}


//head shit for act 3

function beatHit(){
    if (curBeat % 4 == 0){
        (FlxTween.tween(MarvinHead, {y: 0 + 30}, 0.1, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween)
        {
            (FlxTween.tween(MarvinHead, {y: 0}, 0.4, {ease: FlxEase.quadInOut}));
        }
    }));
    (FlxTween.tween(MarvinEyes, {y: 0 + 30}, 0.1, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween)
        {
            (FlxTween.tween(MarvinEyes, {y: 0}, 0.4, {ease: FlxEase.quadInOut}));
        }
    }));
    (FlxTween.tween(MarvinHead2, {y: 0 + 30}, 0.1, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween)
        {
            (FlxTween.tween(MarvinHead2, {y: 0}, 0.4, {ease: FlxEase.quadInOut}));
        }
    }));
    Marvin.playAnim("torso idle 1", true);  
}
}


function postUpdate(elapsed:Float) { 
    if (curCameraTarget == 0) {
        FlxTween.tween(MarvinEyes, {x: 0}, 1, {ease: FlxEase.linear});
    } else {
        FlxTween.tween(MarvinEyes, {x: 50}, 1, {ease: FlxEase.linear});
    }
  }