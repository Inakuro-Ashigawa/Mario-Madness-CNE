import openfl.geom.Rectangle;
import openfl.text.TextFormat;
import flixel.text.FlxTextBorderStyle;
import flixel.ui.FlxBar;
import flixel.FlxG;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import flixel.math.FlxPoint;
import openfl.events.KeyboardEvent;
import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.ui.Keyboard;
import openfl.system.System;
import openfl.text.TextFormat;
import openfl.Lib;
import flixel.FlxG;
import funkin.options.Options;


var colouredBar = (dad != null && dad.xml != null && dad.xml.exists("color")) ? CoolUtil.getColorFromDynamic(dad.xml.get("color")) : 0xFFFFFFFF;
var sicks:Int = 0;
var goods:Int = 0;
var bads:Int = 0;
var shits:Int = 0;
public var timeBarBG:FlxSprite;
public var healthOverlay:FlxSprite;
public var timeBar:FlxBar;
public var timeTxt:FlxText; 
public var hudTxt:FlxText;
public var luigiLogo:FlxSprite;
var hudTxtTween:FlxTween;
var ratingFC:String = "FC";
public var botplayTxt:FlxText;
public var botplaySine:Float = 0;
var ratingStuff:Array<Dynamic> = [
    ['F', 0.2],
    ['E', 0.4],
    ['D', 0.5],
    ['C', 0.6],
    ['B', 0.69],
    ['A', 0.7],
    ['A+', 0.8],
    ['S', 0.9],
    ['S+', 1],
    ['SS+', 1]
];



function getRating(accuracy:Float):String {
    if (accuracy < 0) {
        return "?";
    }
    for (rating in ratingStuff) {
        if (accuracy < rating[1]) {
            return rating[0];
        }
    }
    return ratingStuff[ratingStuff.length - 1][0];
}

function create() {
    timeTxt = new FlxText(0, 19, 400, "X:XX", 22);
    timeTxt.setFormat(Paths.font("Mario2.ttf"), 22, 0xFFf42626, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    timeTxt.antialiasing = true;
    timeTxt.scrollFactor.set();
    timeTxt.alpha = 0;
    if(FlxG.save.data.callLuigi)
        timeTxt.color = 0xFF25cd49;
    else
        timeTxt.color = 0xFFF42626;
    timeTxt.borderColor = 0xFF000000;
    timeTxt.borderSize = 2;
    timeTxt.screenCenter(FlxAxes.X);

    hudTxt = new FlxText(0, 685, FlxG.width, "Score: 0      Misses: 0      Rating: ?");
    hudTxt.setFormat(Paths.font("Mario2.ttf"), 15, 0xFFf42626, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    hudTxt.borderSize = 1.25;
    if(FlxG.save.data.callLuigi)
        hudTxt.color = 0xFF25cd49;
    else
        hudTxt.color = 0xFFF42626;
    hudTxt.antialiasing = true;
    hudTxt.scrollFactor.set();
    hudTxt.screenCenter(FlxAxes.X);

    botplayTxt = new FlxText(400, 83, FlxG.width - 800, "BOTPLAY", 32);
    botplayTxt.setFormat(Paths.font("Mario2.ttf"), 32, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    botplayTxt.scrollFactor.set();
    botplayTxt.borderSize = 1.25;
    if(FlxG.save.data.callLuigi)
        botplayTxt.color = 0xFF25cd49;
    else
        botplayTxt.color = 0xFFF42626;
    botplayTxt.alpha = 0;
    botplayTxt.cameras = [camHUD];

    timeBarBG = new FlxSprite();
    timeBarBG.x = timeTxt.x;
    timeBarBG.y = timeTxt.y + (timeTxt.height / 4);
    timeBarBG.alpha = 0;
    timeBarBG.scrollFactor.set();
    timeBarBG.color = FlxColor.BLACK;
    timeBarBG.loadGraphic(Paths.image("misc/psychTimeBar"));

    timeBar = new FlxBar(timeBarBG.x + 4, timeBarBG.y + 4, FlxBar.FILL_LEFT_TO_RIGHT, Std.int(timeBarBG.width - 8), Std.int(timeBarBG.height - 8), Conductor, 'songPosition', 0, 1);
    timeBar.scrollFactor.set();
    timeBar.createFilledBar(0xFF000000,0xFFf42626);
    if (FlxG.save.data.colouredBar) {
        timeBar.createFilledBar(0xFF000000, colouredBar);
    }
    if(FlxG.save.data.callLuigi)
        timeBar.createFilledBar(0xFF000000, 0xFF25cd49);
    else
        timeBar.createFilledBar(0xFF000000, 0xFFF42626);
    timeBar.numDivisions = 400;
    timeBar.alpha = 0;
    timeBar.value = Conductor.songPosition / Conductor.songDuration;
    timeBar.unbounded = true;
    add(timeBarBG);
    add(timeBar);
    add(timeTxt);

    timeBarBG.x = timeBar.x - 4;
    timeBarBG.y = timeBar.y - 4;

    hudTxt.cameras = [camHUD];
    timeBar.cameras = [camHUD];
    timeBarBG.cameras = [camHUD];
    timeTxt.cameras = [camHUD];

    var plus:String = '';
    if(PlayState.SONG.meta.name == 'paranoia') plus = 'V';
    //if(curStage == 'landstage') plus = 'GB';
    //if(curStage == 'endstage') plus = 'End';
    //if(curStage == 'somari') plus = 'S';

    luigiLogo = new FlxSprite(400, timeBarBG.y + 55);
    luigiLogo.loadGraphic(Paths.image('modstuff/luigi/luigi' + plus));
    luigiLogo.scrollFactor.set();
    luigiLogo.scale.set(0.3, 0.3);
    luigiLogo.updateHitbox();
    luigiLogo.screenCenter(FlxAxes.X);
    luigiLogo.cameras = [camHUD];
    luigiLogo.y = timeBarBG.y + 40;
    luigiLogo.visible = FlxG.save.data.callLuigi;
    add(luigiLogo);
    if(PlayState.SONG.meta.name == 'paranoia'){
        luigiLogo.antialiasing = false;
        var thesize:Float = 4;
        if(PlayState.SONG.meta.name == 'paranoia'){
            thesize = 3.5;
            for (strumLine in strumLines.members)
                    luigiLogo.y = strumLine.y - 30;
        } 
        luigiLogo.scale.set(thesize, thesize);
        luigiLogo.updateHitbox();
        luigiLogo.x -= 50;
    }
    PauseSubState.script = 'data/scripts/MMPause';

}

function onSongStart() for (i in [timeBar, timeBarBG, timeTxt, botplayTxt]) FlxTween.tween(i, {alpha: 1}, 0.5, {ease: FlxEase.circOut});

function update(elapsed:Float) {
    if (inst != null && timeBar != null && timeBar.max != inst.length) timeBar.setRange(0, Math.max(1, inst.length));

    if (inst != null && timeTxt != null) {
        var timeRemaining = Std.int((inst.length - Conductor.songPosition) / 1000);
        var seconds = CoolUtil.addZeros(Std.string(timeRemaining % 60), 2);
        var minutes = Std.int(timeRemaining / 60);
        timeTxt.text = minutes + ":" + seconds;
    }

    var acc = FlxMath.roundDecimal(Math.max(accuracy, 0) * 100, 2);
    var rating:String = getRating(accuracy);
    if (songScore > 0 || acc > 0 || misses > 0) hudTxt.text = "Score: " + songScore + "    Misses: " + misses +  "    Rating: " + rating + " (" + acc + "%)";
}

function onPlayerHit(event) {
    if (event.note.isSustainNote) return;

    if(hudTxtTween != null) hudTxtTween.cancel();
    hudTxt.scale.x = hudTxt.scale.y = 1.075;
    hudTxtTween = FlxTween.tween(hudTxt.scale, {x: 1, y: 1}, 0.2, {onComplete: function(twn:FlxTween) {hudTxtTween = null;}});

    switch (event.rating) {
        case "sick": sicks++;
        case "good": goods++;
        case "bad": bads++;
        case "shit": shits++;
    }

    ratingFC = 'Clear';

    if(misses < 1) {
		if (bads > 0 || shits > 0) ratingFC = 'FC';
		else if (goods > 0) ratingFC = 'GFC';
		else if (sicks > 0) ratingFC = 'SFC';
	}
	else if (misses < 10) ratingFC = 'SDCB';
}

function postCreate() {
    if(FlxG.save.data.callLuigi){
        healthBarBG.loadGraphic(Paths.image("game/healthbars/healthBarNEWluigi"));
    }else{
        healthBarBG.loadGraphic(Paths.image("game/hud/Mario Madness/healthBarBG"));
    }
    healthBarBG.screenCenter(FlxAxes.X);
    healthBarBG.y = healthBar.y - 21;
    if(downscroll) healthBarBG.y = 0.11 * FlxG.height;
    healthBarBG.scrollFactor.set();
    remove(healthBar);
    insert(members.indexOf(healthBarBG), healthBar);
    insert(members.indexOf(icoP1), healthBarBG);

    for (i in [missesTxt, accuracyTxt, scoreTxt]) i.visible = false;

    if (downscroll) hudTxt.y = healthBarBG.y - 58;


    insert(members.indexOf(icoP1), hudTxt);

    healthBar.y = FlxG.height * 0.89;

    iconP1.y = healthBar.y - 75;
    iconP2.y = iconP1.y;

    if (!downscroll)  hudTxt.y = healthBarBG.y + 38;
    
    if (FlxG.save.data.showBar) for (i in [timeTxt, timeBar, timeBarBG]) i.visible = false;
    
    if (FlxG.save.data.showTxt) hudTxt.visible = false;
}

function onNoteCreation(event) {
    if(FlxG.save.data.callLuigi)
        event.noteSprite = 'game/notes/Mario Madness/Luigidefault';
    else
        event.noteSprite = 'game/notes/Mario Madness/Mariodefault';
}

function onStrumCreation(event) {
    if(FlxG.save.data.callLuigi)
        event.sprite = 'game/notes/Mario Madness/Luigidefault';
    else
        event.sprite = 'game/notes/Mario Madness/Mariodefault';
}