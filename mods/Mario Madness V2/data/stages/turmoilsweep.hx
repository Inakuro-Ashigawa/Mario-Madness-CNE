introLength = 0;
var camEST = new FlxCamera();
var dadCamZoom:Int = 0.9;
var bfCamZoom:Int = 0.9;
var cancelCameraMove:Bool = false;
var exampleTween:FlxTween;
var blackBarThingie:FlxSprite;

function onCountdown(event) event.cancel();

function create(){
    foreground1 = new FlxSprite(-1300, -350).loadGraphic(Paths.image('stages/Woodland-of-Lies/course/TreeLeaves'));
    foreground1.scrollFactor.set(1.9,1.9);
    add(foreground1);

    foreground2 = new FlxSprite(-1300, -350).loadGraphic(Paths.image('stages/Woodland-of-Lies/course/TreesForeground'));
    foreground2.scrollFactor.set(1.4,1.4);
    add(foreground2);

    fog = new FlxSprite(0, 0).loadGraphic(Paths.image('stages/Woodland-of-Lies/course/126'));
    fog.cameras = [camEST];
    fog.screenCenter();
    add(fog);

    blackBarThingie = new FlxSprite().makeSolid(FlxG.width, FlxG.height, FlxColor.BLACK);
    blackBarThingie.setGraphicSize(Std.int(blackBarThingie.width + 1000));
    blackBarThingie.scrollFactor.set(0, 0);
    blackBarThingie.screenCenter();
    add(blackBarThingie);

    cameraMovementEnabled = false;
    
    camEST.bgColor = 0;
    camEST.alpha = 1;
    FlxG.cameras.remove(camHUD, false);
    FlxG.cameras.add(camHUD, false);
    FlxG.cameras.add(camEST, false);
    camHUD.alpha = 0.000000000001;
}

//health Drain lol - Inakuro
function onDadHit(note:NoteHitEvent) {
{if (health > 0.1) {health -= 0.015;}}}

function onCameraMove(e) if(cancelCameraMove) e.cancel();

function move(){
    cancelCameraMove = true;
    FlxTween.tween(camFollow, {x: 520}, 0.42, {ease: FlxEase.cubeIn});
    FlxTween.tween(camFollow, {y: 500}, 0.42, {ease: FlxEase.cubeIn});
    new FlxTimer().start(.6, function(tmr:FlxTimer)
    {  
        defaultCamZoom = .8;
    });
    new FlxTimer().start(2, function(tmr:FlxTimer)
    {    
        cancelCameraMove = false; 
        defaultCamZoom = .6;   
    });
}

//zoom out
function movebegnning(){
    cancelCameraMove = true;
    FlxTween.tween(camGame, {zoom: 1}, 5, {ease: FlxEase.cubeInOut});  
    FlxTween.tween(camFollow, {x: 1100}, 0.00001, {ease: FlxEase.cubeIn});
}  
function hudback(){
    FlxTween.tween(camHUD, {alpha: 1}, 0.5, {ease: FlxEase.quadInOut});
}
function move1(){
    cancelCameraMove = true;
    defaultCamZoom = 0.9;
    FlxTween.tween(camGame, {zoom: 0.9}, 6.4, {ease: FlxEase.cubeInOut});
    FlxTween.tween(camFollow, {x: 300}, 5, {ease: FlxEase.cubeInOut});
    new FlxTimer().start(7, function(tmr:FlxTimer)
    {   
     defaultCamZoom = 0.9;
     cancelCameraMove = false;
    });
}  
function camzoom1(){
    defaultCamZoom = .7;
}
function onSongStart(){
    FlxTween.tween(blackBarThingie, {alpha: 0}, 3.8, {startDelay: 1.8, ease: FlxEase.quadInOut});
}