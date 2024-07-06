importScript("data/modchart/Modchart");
importScript("data/modchart/NoteCameras");

function mod1(){
    for (camera in [camNotes, camSustains, camStrums]){
        camera.angle = 5;
        FlxTween.tween(camera, {x: camera.x + 320, angle: 0}, (Conductor.stepCrochet * 8) / 1000, {ease: FlxEase.backOut});
    }

    for (lol in 0...4){
        tweenStrumAlpha(0, lol, 1, 8, FlxEase.backOut);
        tweenStrumAlpha(1, lol, 0.0001, 8, FlxEase.backOut);
    }
}
function mod2(){
    for (camera in [camNotes, camSustains, camStrums]){
        camera.angle = 5;
        FlxTween.tween(camera, {x: camera.x - 660, angle: 0}, (Conductor.stepCrochet * 8) / 1000, {ease: FlxEase.backOut});
    }

    for (lol in 0...4){
        tweenStrumAlpha(1, lol, 1, 8, FlxEase.backOut);
        tweenStrumAlpha(0, lol, 0.0001, 8, FlxEase.backOut);
    }
}