import flixel.FlxG;
import flixel.util.FlxTimer;
var VCRBorder = new CustomShader("VCRBorder", 130);
var evilStatic = new CustomShader("TVStatic", 130);
var oldTVShader = new CustomShader("OldTVShader", 130);
var greyscale = new CustomShader("greyscale", 130);
var worldGreyscale = new CustomShader("worldGreyscale", 130);
var bloom = new CustomShader("Bloom", 130);
bloom.data.Size.value = [1, 1];
bloom.data.dim.value = [.75, .75];

// ok i have an idea but this is GOING TO SUCK
// the idea sucked so im not gonna do the timer
// if anyone else can figure it out then well awesome

// note size = 17x17
// strum size = 7x12

// gonna use the paranoia way thanks whoever did it
var noteSize:Float = 6;
function onNoteCreation(event) {
	event.cancel();

	var note = event.note;
	if (event.note.isSustainNote) {
		note.loadGraphic(Paths.image('game/notes/GB_NOTE_assetsENDS'), true, 7, 12);
		note.animation.add("hold", [event.strumID]);
		note.animation.add("holdend", [4 + event.strumID]);
	}else{
		note.loadGraphic(Paths.image('game/notes/GB_NOTE_assets'), true, 17, 17);
		note.animation.add("scroll", [4 + event.strumID]);
	}
	note.scale.set(noteSize, noteSize);
	note.updateHitbox();
}

function onStrumCreation(event) {
	event.cancel();

	var strum = event.strum;
	strum.loadGraphic(Paths.image('game/notes/GB_NOTE_assets'), true, 17, 17);
	strum.animation.add("static", [event.strumID]);
	strum.animation.add("pressed", [4 + event.strumID, 8 + event.strumID], 12, false);
	strum.animation.add("confirm", [12 + event.strumID, 16 + event.strumID], 24, false);

	strum.updateHitbox();

    strum.scale.set(noteSize, noteSize);
}


function onPostNoteCreation(event) {  
    var note = event.note;
    // fixes sustain note's x offset
    if (note.isSustainNote)
        note.frameOffset.x -= note.frameWidth / 4; 
}

function postCreate(){
    for (shader in [worldGreyscale, oldTVShader, VCRBorder, evilStatic, bloom])
        FlxG.camera.addShader(shader);

    camHUD.addShader(greyscale);

    // just bars idk
    blackBarThingie = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    blackBarThingie.setGraphicSize(Std.int(blackBarThingie.width * 10));
    blackBarThingie.alpha = 0;
    add(blackBarThingie);
    //making my evil black sprite for the flashy
    black = new FlxSprite(0, 0);
	black.makeGraphic(100, 100, FlxColor.BLACK);
	black.scale.set(1000, 1000);
	add(black);
	black.alpha = 0;

    healthBar.createFilledBar(FlxColor.fromRGB(255, 255, 255), FlxColor.fromRGB(255, 255, 255));
    healthBar.updateFilledBar();
    healthBar.updateBar();

    timeBar.createFilledBar(0xFFFFFFFF, 0xFF000000); 
    timeBar.numDivisions = 800;

    for (i in [timeBar, timeBarBG, timeTxt, botplayTxt,hudTxt])
        i.color = FlxColor.WHITE;
    
}

function events(event){
    if (event == "gf"){
        FlxTween.tween(gf, {y: gf.y - 450}, 1, {ease: FlxEase.quadOut});
    };
    if (event == "fadeHUD"){
        FlxTween.tween(camHUD, {alpha: 0.1}, 1.2, {ease: FlxEase.quadOut});
    };
    if (event == "cameraTween"){
        FlxTween.tween(camGame, {zoom: (camGame.zoom += 0.3)}, 3, {ease: FlxEase.quadOut});
    };
    if (event == "returnHUD"){
        camHUD.alpha = 1;
    };
    if (event == "glitchLaugh"){
        new FlxTimer().start(0.3, ()->{ FlxTween.tween(camHUD, {alpha: 1}, 0.35, {ease: FlxEase.quadOut}); }); 
        FlxTween.tween(camHUD, {alpha: 0.1}, 0.35, {ease: FlxEase.quadOut});
    };
    // i know i could've done a different method but this is the best cuz
    // its technically also the fastest
    if (event == "flashBlack"){
        black.alpha = 1;
    };
    if (event == "flashOff"){
        black.alpha = 0;
    }
}

function evilMode() {
    for (obj in [blocks, land, ocean, castle])
        obj.alpha = 0;
    for (evilobj in [blocksEvil, oceanEvil, landEvil, castleEvil])
        evilobj.alpha = 1;
    staticBg.alpha = 0.2;
}