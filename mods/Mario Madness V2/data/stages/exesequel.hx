//all of this is my ass code, stop snoping monkey lover 123 - Inakuro 
import flixel.effects.FlxFlicker;

var dadZoom:Float = .5;
var bfZoom:Float = .7;
var __timer:Float = 0;
var peachCuts:FlxSprite;
var iconGF:FlxSprite;
var yoshi = null;
var cancelCameraMove:Bool = false;

var float:Bool = false;

function postCreate(){
    
    yoshi = strumLines.members[3].characters[0];

    remove(yoshi);
    insert(members.indexOf(SS_midplatforms), yoshi);
    fireR.flipX = true;

    peachCuts = new FlxSprite(-160, -100);
    peachCuts.scrollFactor.set(1,1);
    peachCuts.frames = Paths.getSparrowAtlas('stages/MushroomKingdom/exesequel/Peach_EXE_death');
    peachCuts.animation.addByPrefix('floats', "PeachFalling1", 24, true);
    peachCuts.animation.addByPrefix('fall', "PeachFalling2", 24, false);
    peachCuts.animation.addByPrefix('dies', "PeachDIES", 24, false);
    peachCuts.alpha = 0.000001;
    add(peachCuts);


    //yeah dont ask....
    boyfriend.cameraOffset.y = 30;
    dad.cameraOffset.y = 30;
    yoshi.scrollFactor.set(.55,.55);
    

    //john dick icon
    iconGF = new FlxSprite().loadGraphic(Paths.image('icons/SS_Koopa'));
    iconGF.width = iconGF.width / 2;
    iconGF.loadGraphic(Paths.image('icons/SS_Koopa'), true, Math.floor(iconGF.width), Math.floor(iconGF.height));
    iconGF.animation.add("win", [0], 10, true);
    iconGF.animation.add("lose", [1], 10, true);
    iconGF.cameras = [camHUD];

    dad.forceIsOnScreen = true;
}
function beathit(curBeat){
    if (curBeat % 2 == 0){
        starmanGF.animation.play('danceRight', true);
    }
    else{
        starmanGF.animation.play('danceLeft', true);
    }
}
function update(elapsed:Float){
   
       switch (curCameraTarget){
           case 0: defaultCamZoom = dadZoom;
           case 1: defaultCamZoom = bfZoom;
       }
       __timer += elapsed;
       if (float){
            gf.x = (100* -2*Math.sin(__timer));
            gf.y = (1 +10*Math.cos(__timer));
       }
       iconGF.x = iconP2.x - 70;
       iconGF.scale.set(iconP1.scale.x, iconP1.scale.y);

        if(health > 1.6){
            iconGF.animation.play('lose');
        }else{
            iconGF.animation.play('win');
        }
    }
//events but better than before lmao
function JohnDickApper(){
    add(iconGF);
    iconGF.y = (!downscroll ? 820 : -150);
    FlxTween.tween(iconGF, {y: iconP2.y - (!downscroll ? 35 : -15)}, 3, {ease: FlxEase.expoOut});

    FlxTween.tween(gf, {y: 0}, 3, {ease: FlxEase.expoOut, onComplete: function(twn:FlxTween)
    {
		FlxTween.tween(gf, {y: gf.y - 80}, 2, {ease: FlxEase.quadInOut, type: 4});
    }});
    FlxTween.tween(gf, {x: gf.x - 100}, 3, {ease: FlxEase.quadInOut, type: 4});
} 
function zoomoutBF(){
    bfZoom = .5;
}
function basezoom(){
    bfZoom = .7;
    dadZoom = .5; 
}
function zoom(){
    cancelCameraMove = true;
    //FlxTween.tween(camFollow, {y: -3404, x: 589}, 5, {ease: FlxEase.linear});
    FlxTween.tween(camFollow, {x: 999, y: 450}, .6, {ease: FlxEase.quadInOut});
    FlxTween.tween(camGame, {zoom: 0.4}, 1.5, {ease: FlxEase.quadInOut});
}
function back(){
    new FlxTimer().start(1, function(tmr:FlxTimer)
    {
        cancelCameraMove = false;
    });
}
//when John Dick leaves & Yoshi slams down
function leave(){
    yoshi = strumLines.members[3].characters[0];
    yoshi.scrollFactor.set(0.55, 0.55);
    yoshi.x = 685;
    yoshi.y = -1200;
    FlxTween.tween(iconGF, {y: (!downscroll ? 820 : -150)}, 1.5, {ease: FlxEase.expoIn});
    FlxTween.tween(gf, {x: 3500}, 1.5, {ease: FlxEase.quadInOut});
    FlxTween.tween(gf, {y: -400}, 1.5, {ease: FlxEase.cubeIn, onComplete: function(twn:FlxTween)
        {
            gf.alpha = 0.0001;
            yoshi.playAnim("prepow", true);
            FlxTween.tween(yoshi, {y: 20}, 0.20, {onComplete: function(twn:FlxTween)
                {
                    cancelCameraMove = true;
                    FlxTween.tween(camFollow, {x: 550, y: 250}, 1.25, {startDelay: 0.25, ease: FlxEase.quadInOut});
                    FlxTween.tween(camGame, {zoom: 0.65}, 1.5, {ease: FlxEase.quadInOut});
                    yoshi.playAnim("pow");
                    dad.playAnim("xd");
                    camGame.shake(0.8, 0.02);
                    pow.alpha = 0;
                    FlxTween.tween(camHUD, {alpha: 0.001}, 1.25, {ease: FlxEase.quadInOut});
                    FlxTween.tween(dad, {y: 1500}, 0.6, {ease:FlxEase.quadIn, onComplete: function(twn:FlxTween)
                        {
                            dad.x = dad.x;
                            dad.y = dad.y;
                            dad.alpha = 0.0001;
                        }});
                }});
        }});
}
//when peach Floats and lands
function peach(){
    peachCuts.x = -2000;
    peachCuts.y = -700;
    peachCuts.alpha = 1;
    peachCuts.animation.play('floats');
    iconGF.y = iconP2.y - (!downscroll ? 35 : -15);
    iconGF.loadGraphic(Paths.image('icons/yoshi_exe'), true, Math.floor(iconGF.width), Math.floor(iconGF.height));
    iconGF.animation.add("win", [0], 10, true);
    iconGF.animation.add("lose", [1], 10, true);

    FlxTween.tween(peachCuts, {y: -380}, 1.25, {ease: FlxEase.quadInOut});
    FlxTween.tween(camHUD, {alpha: 1}, 1.25, {ease: FlxEase.quadInOut});
    FlxTween.tween(peachCuts, {x: -250}, 1.5, {ease: FlxEase.backOut, onComplete: function(twn:FlxTween)
        {
            FlxTween.tween(peachCuts, {y: -200}, 0.4, {startDelay: 0.1, ease: FlxEase.backIn, onComplete: function(twn:FlxTween)
                {
                    peachCuts.animation.play('fall');
                    FlxTween.tween(gf, {y: -400}, 1.5, {ease: FlxEase.cubeIn, onComplete: function(twn:FlxTween)
                        {

                        }});
                    new FlxTimer().start(0.8, function(tmr:FlxTimer)
                        {
                            peachCuts.alpha = 0.0001;
                            dad.alpha = 1;
                        });
                }});
        }});
}
//when the cam goes back to boyfriend after mario falls lmao!!
function bfcamTween(){
    cancelCameraMove = true;
    FlxTween.tween(camFollow, {x: boyfriend.getMidpoint().x - 100, y: boyfriend.getMidpoint().y + 300} , .6, {ease: FlxEase.quadInOut});
    FlxTween.tween(camGame, {zoom: bfZoom}, 1.5, {ease: FlxEase.quadInOut, onComplete: function(twn:FlxTween)
    {
        cancelCameraMove = false;
    }});
}
//when peach dies
function camDead(){
    cancelCameraMove = true;
    FlxTween.tween(camFollow, {x: dad.getMidpoint().x , y: dad.getMidpoint().y} , 2.5, {ease: FlxEase.quadInOut});
}
function deadlady(){
    new FlxTimer().start(1.875, function(tmr:FlxTimer)
        {

            dad.alpha = 0.0001;
            peachCuts.alpha  = 1;
            peachCuts.animation.play('dies');
            yoshi.playAnim("duro");
            peachCuts.x = -500;
            peachCuts.y = -275;

            new FlxTimer().start(2.5, function(tmr:FlxTimer)
                {
                    FlxFlicker.flicker(peachCuts, 2, 0.12, false);
                });
        });
}
//when yoshi dies lmao
function deadYo(){
    dadZoom = 0.6;
    bfZoom = 0.6;
    yoshi.playAnim("death", true);
    FlxTween.tween(iconGF, {alpha: 0}, 0.75, {ease: FlxEase.expoIn});
    new FlxTimer().start(2.0833, function(tmr:FlxTimer)
    {
        yoshi.alpha = 0;
    });
}
//when mario jumps back to the stage after falling into the lava 
function jumpman(){
    dad.alpha = 1;
    dad.playAnim("jump");
    dad.x -= 800;
    dad.y += 1200;
    defaultCamZoom = 0.5;
    FlxTween.tween(camGame, {zoom: 0.5}, 0.5, {ease: FlxEase.quadInOut});
    FlxTween.tween(dad, {x: dad.x + 800}, .95, {startDelay: 0.8, ease: FlxEase.linear});
    FlxTween.tween(dad, {y: dad.y - 2200}, 0.6, {startDelay: 0.8, ease: FlxEase.quadOut, onComplete: function(twn:FlxTween)
        {
            dad.playAnim("fall");
            FlxTween.tween(dad, {y: dad.y + 1100}, 0.35, {ease: FlxEase.quadIn, onComplete: function(twn:FlxTween)
                {
                    dad.playAnim("singDOWN");
                    cancelCameraMove = false;
                }});
        }});
}
function nuuhu(){
    dad.alpha = 0.0001;
}
//when mario yells
function funnyending(){
    FlxTween.tween(camFollow, {x: 550}, 1, {ease: FlxEase.expoOut});
    FlxTween.tween(camFollow, {y: 250}, 1, {ease: FlxEase.expoOut});

    FlxTween.tween(dad, {alpha: 0}, 2, {startDelay: 1.875});
    FlxTween.tween(camHUD, 	{alpha: 0}, 2, {startDelay: 1.875});

    FlxTween.tween(timeBarBG,{alpha: 0}, 0.5);
    FlxTween.tween(timeBar,{alpha: 0}, 0.5);
    FlxTween.tween(timeTxt,{alpha: 0}, 0.5);
    FlxTween.tween(healthOverlay,{alpha: 0}, 0.5);
    FlxTween.tween(icoP1,{alpha: 0}, 0.5);
    FlxTween.tween(icoP2,{alpha: 0}, 0.5);
    FlxTween.tween(SS_floor,{alpha: 0}, 0.5);
    FlxTween.tween(pow,{alpha: 0}, 0.5);
    FlxTween.tween(SS_farplatforms,{alpha: 0}, 0.5);
    FlxTween.tween(SS_midplatforms,{alpha: 0}, 0.5);
    FlxTween.tween(fireL,{alpha: 0}, 0.5);
    FlxTween.tween(fireR,{alpha: 0}, 0.5);
    FlxTween.tween(SS_sky,{alpha: 0}, 0.5);
    FlxTween.tween(SS_castle,{alpha: 0}, 0.5);

    new FlxTimer().start(.3, function(tmr:FlxTimer)
    {
        dad.playAnim("end");
        defaultCamZoom = 0.7;
        FlxTween.tween(camGame, {zoom: 0.7}, 3, {ease: FlxEase.linear});
        
        boyfriend.visible = false;
        //platform2.visible = false;
        camGame.flash(FlxColor.RED, 0.5);
        camGame.shake(3.8, 0.01);
    });
}
function onCameraMove(e) if(cancelCameraMove) e.cancel();
