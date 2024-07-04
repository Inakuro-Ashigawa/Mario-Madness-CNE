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

    Pipe = new FlxSprite().loadGraphic(Paths.image("stages/MushroomKingdom/allfinal/act3/Act3_bfpipe"));
    insert(1, Pipe);
    Pipe.y = 610;
    Pipe.x = -100;

    MarvinEyes = new FunkinSprite(0,0, Paths.image("stages/MushroomKingdom/allfinal/act3/Act3_Ultra_Pupils"));
    XMLUtil.addAnimToSprite(MarvinEyes, {name: "ultra pupils", anim: "ultra pupils", fps: 24, animType: "none", indices: [], x: 376, y: -200, forced: true});
    insert(1, MarvinEyes);
    MarvinEyes.playAnim("ultra pupils", true);  

    MarvinHead = new FunkinSprite(0,0, Paths.image("stages/MushroomKingdom/allfinal/act3/Act3_Ultra_M_Head"));
    XMLUtil.addAnimToSprite(MarvinHead, {name: "ultra m static head", anim: "ultra m static head", fps: 24, animType: "none", indices: [], x: 570, y: 100, forced: true});
    insert(1, MarvinHead);
    MarvinHead.playAnim("ultra m static head", true);  
    MarvinHead.scale.set(1.1, 1.1);
    
    Marvin = new FunkinSprite(0,0, Paths.image("stages/MushroomKingdom/allfinal/act3/Act3_Ultra_M"));
    XMLUtil.addAnimToSprite(Marvin, {name: "torso idle 1", anim: "torso idle 1", fps: 24, animType: "none", indices: [], x: 1030, y: 0, forced: true});
    insert(1, Marvin);
    Marvin.scale.x = 1.3;
    Marvin.scale.y = 1.3;

    MarvinHand = new FlxSprite().loadGraphic(Paths.image("stages/MushroomKingdom/allfinal/act3/Act3_Ultra_Arm"));
    insert(1, MarvinHand);
    MarvinHand.y = 610;
    MarvinHand.x = -100;
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

        case 2272:
            FlxTween.tween(dad, {y: -100}, 2, {ease: FlxEase.linear});

            FlxTween.tween(camGame, {zoom: 0.58}, 0.7, {ease: FlxEase.linear, onComplete: function(tween:FlxTween){defaultCamZoom = 0.58;}});

        case 2976:
            FlxTween.tween(camGame, {zoom: 1}, 65, {ease: FlxEase.linear, onComplete: function(tween:FlxTween){defaultCamZoom = 1;}});

            MarvinHead.x = -570;
            MarvinHead.y = -100;
            MarvinHead.animation.addByPrefix('ultra m lyrics 1', "ultra m lyrics 1", 24);
            MarvinHead.playAnim("ultra m lyrics 1", true);  
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