var oldFX:CustomShader = null;
var oldTV:CustomShader = null;
var fullTimer:Float = 0;
var dadZoom:Float = .7;
var bfZoom:Float = .9;
defaultCamZoom = .7;

function postCreate(){

    dad.alpha = dad.scale.x = dad.scale.y = 0;
    dad.setPosition(250, 100);
    boyfriend.setPosition(470, 190);

    bgwario = new FlxSprite(180, 100);
    bgwario.frames = Paths.getFrames('stages/Woodland-of-Lies/war/wea_mala_ctm');
    bgwario.animation.addByPrefix('idle', 'fondo instancia 1', 24, true);
    bgwario.setGraphicSize(Std.int(bgwario.width * 2.4));
    insert(0, bgwario);
    
    bftors = new FlxSprite(490, 780);
    bftors.frames = Paths.getFrames('characters/Woodland-of-Lies/war/apparitionbf/BFRUNNING_backlegs');
    bftors.animation.addByPrefix('idle', 'back0', 48, true);

    bfext = new FlxSprite(440, 730);
    bfext.frames = Paths.getFrames('characters/Woodland-of-Lies/war/apparitionbf/BFRUNNING_frontlegs');
    bfext.animation.addByPrefix('idle', 'front0', 48, true);
    insert(1, bftors);
    insert(2, bfext);

    bgwario.animation.play('idle');
    bftors.animation.play('idle');
    bfext.animation.play('idle');
}
function comIN(){
    FlxTween.tween(dad, {alpha: 1}, 1, {ease: FlxEase.quadInOut});
    FlxTween.tween(dad.scale, {x: 1.2, y: 1.2}, 1, {ease: FlxEase.quadInOut});
}
function update(elapsed:Float){
    switch (curCameraTarget){
        case 0: defaultCamZoom = dadZoom;
        case 1: defaultCamZoom = bfZoom;
    }
}