import flixel.tweens.FlxTween.FlxTweenType;
//yashers code!
var path = "stages/MushroomKingdom/iam/";
var camxoffset:Float = -70; //-100
var camyoffset:Float = -100;
var dadxoffset:Float = -270; //-100
var dadyoffset:Float = 100;
var camBR = null;

var mosaic:CustomShader = null;
var mosaicTween:NumTween;
var camTween:NumTween;
var camxoffset:Float = -70; //-100
var camyoffset:Float = -100;
var dadxoffset:Float = -270; //-100
var dadyoffset:Float = 100;

function postCreate(){
    FlxG.cameras.add(camBR = new HudCamera(), false);
    camBR.bgColor = 0;
    defaultCamZoom = 0.5;

    mosaic = new CustomShader("mosaicShader");
    mosaic.data.uBlocksize.value = [0.1,0.1];
    camGame.addShader(mosaic);
    
    boyfriend.cameraOffset = FlxPoint.weak(camxoffset, camyoffset);
    dad.cameraOffset = FlxPoint.weak(dadxoffset, dadyoffset);

    dark = new FlxSprite(-1000, -850).loadGraphic(Paths.image(path + "dark"));
    dark.scrollFactor.set();
    dark.alpha = 0.8;
    dark.screenCenter();
    dark.cameras = [camHUD];
    dark.antialiasing = true;
    add(dark);

    smoke = new FlxSprite(-1000, -850).loadGraphic(Paths.image(path + "smoke"));
    smoke.scrollFactor.set();
    smoke.alpha = 0.8;
    smoke.screenCenter();
    smoke.cameras = [camHUD];
    smoke.antialiasing = true;
    smoke.alpha = 0.00001;
    add(smoke);
}
function beatHit(curBeat) {
    switch (curBeat) {
        case 268:
            defaultCamZoom = 0.45;
        case 270:
            FlxTween.tween(FlxG.camera, {zoom: 0.6}, 0.42, {ease: FlxEase.sineInOut});
            defaultCamZoom = 0.6;
        case 304:
            defaultCamZoom = 0.5;
        case 340:
            dark.cameras = [camBR];
            dad.playAnim("laugh");
            camHUD.alpha = 0.0001;
            defaultCamZoom = 0.6;
        case 344:
            defaultCamZoom = 0.45;
        case 355:
            dark.cameras = [camHUD];
            camHUD.alpha = 1;
            defaultCamZoom = 0.5;
        case 484:
            defaultCamZoom = 0.65;
        case 488:
            defaultCamZoom = 0.7;
        case 492:
            defaultCamZoom = 0.75;
        case 496:
            defaultCamZoom = 0.8;
        case 500:
            defaultCamZoom = 0.6;
        case 504:
            defaultCamZoom = 0.55;
        case 508:
            defaultCamZoom = 0.5;
        case 512:
            defaultCamZoom = 0.45;
        case 516:
            FlxTween.tween(fireL, {y: -800}, 20, {ease: FlxEase.quadInOut});
            FlxTween.tween(fireR, {y: -800}, 20, {ease: FlxEase.quadInOut});
            FlxTween.tween(smoke, {alpha: 1}, 15);
            dad.playAnim("laugh");
            defaultCamZoom = 0.75;
       case 517:
             FlxTween.tween(FlxG.camera, {zoom: 0.7}, 13, {ease: FlxEase.sineInOut});
             FlxTween.tween(camGame, {zoom: 0.7}, 13, {ease: FlxEase.sineInOut});
             defaultCamZoom = 0.7;
        case 583:
            mosaicTween = FlxTween.num(0.1, 80, 5, {ease: FlxEase.circInOut, onUpdate: (_) -> {
                mosaic.data.uBlocksize.value = [mosaicTween.value, mosaicTween.value];
            }});
        case 590:
            camTween = FlxTween.num(1, 0.0001, 1, {ease: FlxEase.sineInOut, onUpdate: (_) -> {
                camGame.alpha = camTween.value;
            }});
        case 595:
            camTween = FlxTween.num(1, 0.0001, 1, {ease: FlxEase.sineInOut, onUpdate: (_) -> {
                camHUD.alpha = camTween.value;
            }});
    }
}