import flixel.addons.display.FlxBackdrop;
import flixel.ui.FlxBarFillDirection;
import flixel.text.FlxTextBorderStyle;
import flixel.text.FlxTextFormatMarkerPair;
import flixel.text.FlxTextFormat;
import flixel.text.FlxText.FlxTextAlign;
var topCam = new FlxCamera();
var botCam = new FlxCamera();
var cancelCameraMove:Bool = true;
var scrollcoords:Float = 200;

function create(){

    boyfriend.cameraOffset.y = dad.cameraOffset.y = 100;
    boyfriend.cameraOffset.x = dad.cameraOffset.x = 500;   
    boyfriend.scrollFactor.set(0.1, 0.1);
    dad.scrollFactor.set(0.1, 0.1);
    remove(dad);
    remove(boyfriend);


    //cam
	topCam = new FlxCamera(0, -600, 256, 192, .7);
	topCam.bgColor = 0xFF000000;
	botCam = new FlxCamera(0, -216, 256, 192, 1);
	botCam.bgColor = 0xFF000000;
		
		
    FlxG.cameras.remove(camHUD, false);
	FlxG.cameras.add(topCam);
	FlxG.cameras.add(botCam);
    FlxG.cameras.add(camHUD, false);

    bgH0 = new FlxSprite(0, -2.5 + scrollcoords).loadGraphic(Paths.image('stages/HellishHights/piracy/HallyBG2'));
    bgH0.scrollFactor.set(0,0);
    bgH0.scale.set(1.3, 1.3);
    bgH0.updateHitbox();
    bgH0.antialiasing = false;
    add(bgH0);

    add(dad);

    bgH1 = new FlxBackdrop(Paths.image('stages/HellishHights/piracy/HallyBG4'), FlxAxes.Y);
    bgH1.x = 240;
    bgH1.scale.set(1.3, 1.3);
    bgH1.updateHitbox();
    bgH1.scrollFactor.set();
    bgH1.velocity.set(0, 40);
    bgH1.antialiasing = false;
    add(bgH1);

/*
    bgH3 = new FlxSprite(240, -2.5 + scrollcoords).loadGraphic(Paths.image('stages/HellishHights/piracy/HallyBG3'));
    bgH3.scrollFactor.set(0,0);
    bgH3.scale.set(1.3, 1.3);
    bgH3.updateHitbox();
    bgH3.antialiasing = false;
    bgH3.alpha = 0.8;
    add(bgH3);

    bgH4 = new FlxSprite( 0, -2.5 + scrollcoords).loadGraphic(Paths.image('stages/HellishHights/piracy/HallyBG1'));
    bgH4.scrollFactor.set(0,0);
    bgH4.scale.set(1.3, 1.3);
    bgH4.updateHitbox();
    bgH4.antialiasing = false;
    add(bgH4);

    add(boyfriend);

    var bgbottom:FlxBackdrop = new FlxBackdrop(Paths.image('stages/HellishHights/piracy/bgbottom'), FlxAxes.X);
    bgbottom.scrollFactor.set(0, 0);
    bgbottom.velocity.set(40, 0);
    bgbottom.setGraphicSize(Std.int(bgbottom.width * 2.5));
    bgbottom.updateHitbox();
    bgbottom.x = 600;
    bgbottom.y = downscroll ? 360 : -120;
    bgbottom.antialiasing = false;
    bgbottom.cameras = [topCam];
    add(bgbottom);

    lifebar = new FlxSprite(-263, 400).loadGraphic(Paths.image('stages/HellishHights/piracy/bar'));
    lifebar.scrollFactor.set(0,0);
    lifebar.setGraphicSize(Std.int(lifebar.width * 2.71));
    lifebar.updateHitbox();
    lifebar.antialiasing = false;
    lifebar.visible = false;
    lifebar.cameras = [camHUD];
    add(lifebar);

    backing = new FlxSprite(7, downscroll ? 1200 : -690).loadGraphic(Paths.image('stages/HellishHights/piracy/paper'));
    backing.scrollFactor.set(1,1);
    backing.setGraphicSize(Std.int(backing.width * 1.9));
    backing.updateHitbox();
    backing.antialiasing = false;
    backing.cameras = [botCam];
    add(backing);

    //text shits
    thetext = new FlxText(backing.x + 30, backing.y + 69, 416, "sorry", 95);
    thetext.setFormat(Paths.font("arial-rounded-mt-bold.ttf"), 95, 0xBA888888, FlxTextAlign.CENTER);
    thetext.cameras = [botCam];
    add(thetext);
    thetext.y = backing.y + 125 - thetext.pixels.rect.height / 2;

    thetextC = new FlxText(backing.x + 30, backing.y + 69, 416, "criminal", 95);
    thetextC.setFormat(Paths.font("arial-rounded-mt-bold.ttf"), 95, 0xFFE58F8F, FlxTextAlign.CENTER);
    thetextC.visible = false;
    thetextC.cameras = [botCam];
    add(thetextC);

    canvas = new FlxSprite(backing.x, backing.y).makeGraphic(Std.int(backing.width), Std.int(backing.height), 0x00000000, true);
    canvas.cameras = [botCam];
    canvas.updateHitbox();
    canvas.visible = false;
    add(canvas);

    writeText = new FlxText(30, 500, 416, "00", 16);
    writeText.cameras = [botCam];
    writeText.color = FlxColor.BLACK;
    writeText.setFormat(Paths.font("BIOSNormal.ttf"), 28, FlxColor.BLACK, "center");
    writeText.visible = false;
    writeText.y = backing.y - 680;
    add(writeText);

    djStart = new FlxSprite(510, downscroll? 150 : 510).loadGraphic(Paths.image('stages/HellishHights/piracy/start'));
    djStart.scrollFactor.set(0,0);
    djStart.setGraphicSize(Std.int(djStart.width * 2));
    djStart.updateHitbox();
    djStart.antialiasing = false;

    djDone = new FlxSprite(160, downscroll? 150 : 510).loadGraphic(Paths.image('stages/HellishHights/piracy/Finish'));
    djDone.scrollFactor.set(0,0);
    djDone.setGraphicSize(Std.int(djDone.width * 2));
    djDone.updateHitbox();
    djDone.antialiasing = false;

    bfspot = new FlxSprite( 0, -2.5 + scrollcoords).loadGraphic(Paths.image('stages/HellishHights/piracy/bfspotlight'));
    bfspot.scrollFactor.set(0,0);
    bfspot.updateHitbox();
    bfspot.antialiasing = true;
    bfspot.alpha = 0;

    drawspot = new FlxSprite(-83, -100).loadGraphic(Paths.image('stages/HellishHights/piracy/spotlight'));
    drawspot.scrollFactor.set(0,0);
    drawspot.updateHitbox();
    drawspot.antialiasing = true;
    drawspot.cameras = [botCam];
    drawspot.alpha = 0;
    add(drawspot);
*/
}
function onCameraMove(e) if(cancelCameraMove) e.cancel();

function postCreate(){
    camHUD.x = 300;
    camFollow.x = 600;
    camFollow.y = -3000;
}