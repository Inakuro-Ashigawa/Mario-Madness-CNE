//imports
import GrandDadRunners;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

var gdRunners:FlxTypedGroup<GrandDadRunners>;
var gdRunners = new FlxTypedGroup();
var gdRunnerRandom:Array<Int> = [0, 1, 2, 3, 4, 5, 6, 7];
var cancelCameraMove:Bool = false;

function create(){
    	
    //postion 
    boyfriend.setPosition(1270, 310);
    gf.setPosition(500, 250);
    dad.setPosition(-200, 330);

    //stage yippie
    var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFF155FD9);
    bg.setGraphicSize(Std.int(bg.width * 10));
    bg.scrollFactor.set(0, 0);
    insert(0, bg);

    startbutton = new FlxSprite( 400, 1250).loadGraphic(Paths.image('stages/IrregularityIsle/dad7/start'));
    startbutton.scrollFactor.set(1, 1);
    startbutton.antialiasing = false;
    startbutton.setGraphicSize(Std.int(startbutton.width * 4));
    add(startbutton);

    thegang = new FlxSprite(gf.x - 70, gf.y + 110);
    thegang.frames = Paths.getSparrowAtlas('stages/IrregularityIsle/dad7/Grand_Dad_Girlfriend_Assets_gang');
    thegang.scrollFactor.set(1, 1);
    thegang.animation.addByPrefix('idle', 'funnygangIdle', 24, false);
    thegang.visible = false;
    insert(1, thegang);

    hamster = new FlxSprite(50, -1400).loadGraphic(Paths.image('stages/IrregularityIsle/dad7/Hamster'));
    hamster.scrollFactor.set(1, 1);
    hamster.setGraphicSize(Std.int(hamster.width * 0.8));

    title7 = new FlxSprite( -200, -1400).loadGraphic(Paths.image('stages/IrregularityIsle/dad7/gdtitle'));
    title7.scrollFactor.set(1, 1);
    title7.setGraphicSize(Std.int(title7.width * 0.8));
    add(title7);

    add(hamster);

}
function beatHit(){
    startbutton.visible = !startbutton.visible;
    thegang.animation.play('idle', true);

    FlxTween.tween(camHUD, {zoom: 1}, (1 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.elasticOut});
    FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom}, (1 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.elasticOut});
}
function events(event){
    if (event == "show"){
        thegang.visible = true;
        thegang.scale.x = 0.1;
        thegang.scale.y = 0.5;
        FlxTween.tween(camGame, {zoom: 0.7}, 0.25, {ease: FlxEase.backOut});
        FlxTween.tween(thegang.scale, {x: 1, y: 1}, 0.25, {ease: FlxEase.backOut});
    }
    if (event == "grand"){
        FlxTween.tween(hamster, {y: -1700}, 0.15, {ease: FlxEase.sineOut});
        FlxTween.tween(hamster, {y: -330}, 0.25, {startDelay: 0.15, ease: FlxEase.sineIn});
        FlxTween.tween(hamster, {x: -400}, 0.33, {
            onComplete: function(twn:FlxTween)
            {
                hamster.visible = false;
            }
        });
    }
}
function onCameraMove(e) if(cancelCameraMove) e.cancel();