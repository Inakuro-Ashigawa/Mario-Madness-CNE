
import hxvlc.openfl.Video;
import hxvlc.flixel.FlxVideoSprite;
import flixel.addons.display.FlxBackdrop;

var midsongVid:FlxVideoSprite;
var dembg:FlxBackdrop;
var underfloordemise,demFore1,demFore2,demFore3,demFore4,gordobondiola:FlxSprite;
var demLevel:FlxBackdrop;
var demGround:FlxBackdrop;
var underdemGround1:FlxBackdrop;
var underdemGround2:FlxBackdrop;
var underdembg:FlxBackdrop;
var underdemLevel:FlxBackdrop;
var whenyourered:FlxSprite;
var demColor:FlxSprite;
var underdemFore1:FlxSprite;
var underdemFore2:FlxSprite;
var demFlash:Bool = false;
var camEST = new FlxCamera();

var old2 = new CustomShader('VCR');
var old = new CustomShader('border');
var cancelCameraMove:Bool = false;

function onCameraMove(e) if(cancelCameraMove) e.cancel();

function createBackdrop(imagePath:String, scrollX:Float, scrollY:Float, velocityX:Float, offsetY:Float){
    var backdrop = new FlxBackdrop(Paths.image(imagePath), FlxAxes.X);
    backdrop.scrollFactor.set(scrollX, scrollY);
    backdrop.velocity.set(velocityX, 0);
    backdrop.y -= offsetY;
    insert(members.indexOf(dad), backdrop);
    return backdrop;
}

function setupBackdrops() {
    demColor = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    demColor.scrollFactor.set();
    insert(members.indexOf(dad), demColor);

    dembg = createBackdrop('stages/HellishHights/MX/demise/1/Demise_BG_BG2', 0.3, 0.3, 100, 500);

    demLevel = createBackdrop('stages/HellishHights/MX/demise/1/Demise_BG_BGCaca', 0.5, 0.5, 250, 300);

    floordemise = new FlxSprite(-800,300);
    floordemise.frames = Paths.getFrames('stages/HellishHights/mx/demise/1/Demise_BG_suelo');
    floordemise.scrollFactor.set(1,1);
    floordemise.animation.addByPrefix('idle', 'Floor', 60, true);
    floordemise.animation.play('idle');
    insert(members.indexOf(dad), floordemise);
    
    demGround = createBackdrop('stages/HellishHights/MX/demise/1/Demise_BG_BG1', 0.9, 0.9, 3200, -10);

    underdembg = createBackdrop('stages/HellishHights/MX/demise/2/Demise_BG2_Mountains', 0.3, 0.3, 100, 500);
    underdemLevel = createBackdrop('stages/HellishHights/MX/demise/2/Demise_BG2_BGLower', 0.5, 0.5, 250, 1400);
    underdemGround1 = createBackdrop('stages/HellishHights/MX/demise/2/Demise_BG2_BG1', 0.9, 0.9, 3200, 800);
    underdemGround2 = createBackdrop('stages/HellishHights/MX/demise/2/Demise_BG2_BG2', 0.9, 0.9, 3200, 800);

    underfloordemise = new FlxSprite(-800,300);
    underfloordemise.frames = Paths.getFrames('stages/HellishHights/mx/demise/2/Demise_BG2_suelo');
    underfloordemise.scrollFactor.set(1,1);
    underfloordemise.animation.addByPrefix('idle', 'Floor', 60, true);
    underfloordemise.animation.play('idle');
    insert(members.indexOf(dad), underfloordemise);

    underroofdemise = new FlxSprite(-800,-1050);
    underroofdemise.frames = Paths.getFrames('stages/HellishHights/mx/demise/2/Demise_BG2_techo');
    underroofdemise.scrollFactor.set(1,1);
    underroofdemise.animation.addByPrefix('idle', 'Celling', 60, true);
    underroofdemise.animation.play('idle');
    insert(members.indexOf(dad), underroofdemise);

    whenyourered = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFFD10000);
    whenyourered.setGraphicSize(Std.int(whenyourered.width * 10));
    whenyourered.alpha = 0;
    insert(members.indexOf(dad), whenyourered);

    underdembg.visible = false;
    underdemLevel.visible = false;
    underdemGround1.visible = false;
    underdemGround2.visible = false;
    underfloordemise.visible = false;
    underroofdemise.visible = false;
}
function create(){
    boyfriend.cameraOffset.x = 380;
    boyfriend.cameraOffset.y = -50;

    dad.cameraOffset.x = -1000;
    dad.cameraOffset.y = 0;

    old2.perspectiveOn = true; 
    old2.vignetteMoving =  true;
    camGame.addShader(old2);
    camGame.addShader(old);
    camHUD.addShader(old);

    setupBackdrops();

    
    demFore1 = new FlxSprite(-3800, 300).loadGraphic(Paths.image("stages/HellishHights/mx/demise/1/Demise_BG_Foreground1"));
    demFore2 = new FlxSprite( -3800, 3000).loadGraphic(Paths.image("stages/HellishHights/mx/demise/1/Demise_BG_Foreground2"));
    demFore3 = new FlxSprite(-1800, -1200).loadGraphic(Paths.image("stages/HellishHights/mx/demise/1/Demise_BG_Foreground3"));
    demFore4 = new FlxSprite(-3800, 300).loadGraphic(Paths.image("stages/HellishHights/mx/demise/1/Demise_BG_Foreground4"));

    demFore1.scrollFactor.set(1.3, 1.3);
    demFore2.scrollFactor.set(1.3, 1.3);
    demFore3.scrollFactor.set(1.3, 1.3);
    demFore4.scrollFactor.set(1.3, 1.3);


    underdemFore1 = new FlxSprite(-3800, 300).loadGraphic(Paths.image("stages/HellishHights/mx/demise/2/Demise_BG2_Foreground1"));
    underdemFore2 = new FlxSprite( -3800, 3000).loadGraphic(Paths.image("stages/HellishHights/mx/demise/2/Demise_BG2_Foreground1"));
    underdemFore1.scrollFactor.set(1.3, 1.3);
    underdemFore2.scrollFactor.set(1.3, 1.3);

    demisetran = new FlxSprite(-1600, 0).loadGraphic(Paths.image("stages/HellishHights/mx/demise/1/transition"));
    demisetran.cameras = [camEST];
    demisetran.scale.set(3, 1);
    add(demisetran);

    camEST.bgColor = 0;
    camEST.alpha = 1;
    FlxG.cameras.remove(camHUD, false);
    FlxG.cameras.add(camHUD, false);
    FlxG.cameras.add(camEST, false);

    midsongVid = new FlxVideoSprite();
    midsongVid.load(Assets.getPath(Paths.file("videos/demise_cutscene.mp4")));
    midsongVid.cameras = [camEST]; 
    midsongVid.pause();
    midsongVid.bitmap.volume = 0;
    insert(members.indexOf(dad), midsongVid);
    camGame.alpha = camHUD.alpha = midsongVid.alpha = 0.001;
    startFore(1);

    demcut1 = new FlxSprite(-1100, -250);
    demcut1.frames = Paths.getFrames('stages/HellishHights/mx/demise/cutscene/DemiseBF_Cutscene3');
    demcut1.animation.addByPrefix('idle', 'Bodies', 21, false); 
    add(demcut1);

    demcut2 = new FlxSprite(demcut1.x + 650, demcut1.y);
    demcut2.frames = Paths.getFrames('stages/HellishHights/mx/demise/cutscene/DemiseBF_Cutscene2');
    demcut2.animation.addByPrefix('idle', 'Bodies', 21, false);
    add(demcut2);

    demcut3 = new FlxSprite(demcut1.x + 1100, demcut1.y + 370);
    demcut3.frames = Paths.getFrames('stages/HellishHights/mx/demise/cutscene/DemiseBF_Cutscene1');
    demcut3.animation.addByPrefix('idle', 'BFheadcutscene', 21, false);
    add(demcut3);

    demcut4 = new FlxSprite(demcut1.x + 270, demcut1.y + 30);
    demcut4.frames = Paths.getFrames('stages/HellishHights/mx/demise/cutscene/DemiseBF_Cutscene4');
    demcut4.animation.addByPrefix('idle', 'GFHeadcutscene', 21, false);
   add(demcut4);

   demcut1.alpha = 0.000001;
   demcut2.alpha = 0.000001;
   demcut3.alpha = 0.000001;
   demcut4.alpha = 0.000001;
}
function postCreate(){
    maxhealth = 3;
    health = 3;

    add(demFore1);
    add(demFore2);
    add(demFore3);
    add(demFore4);

    gordobondiola = new FlxSprite(2200, -2900).loadGraphic(Paths.image("stages/HellishHights/mx/demise/cutscene/MXJump"));
    add(gordobondiola);

    add(underdemFore1);
    add(underdemFore2);

}

function startFore(lastSprite:Int){
    var coso:Int = FlxG.random.int(1, 4);
    var under:String = '';

    var foreSprites:Array<FlxSprite> = [demFore1, demFore2, demFore3, demFore4];
    var foreSprite:FlxSprite = foreSprites[coso - 1];

    if(underfloordemise.visible){
        coso = FlxG.random.int(1, 2);
        under = 'under';

        foreSprites = [underdemFore1,underdemFore2];
        foreSprite = foreSprites[coso - 1];
    }
    
    if(coso == lastSprite){
        startFore(coso);
    }
    else{

        if(FlxG.random.bool(50)){
            if(!underfloordemise.visible){
            if(coso != 3){
                foreSprite.x = -3800;
                FlxTween.tween(foreSprite, {x: 3800}, 1.3);
                new FlxTimer().start(0.5, function(tmr:FlxTimer)
                    {
                        startFore(coso);
                    });
            }else{
                foreSprite.x = -1800;
                FlxTween.tween(foreSprite, {x: 6800}, 1.3);
                new FlxTimer().start(0.5, function(tmr:FlxTimer)
                    {
                        startFore(coso);
                    });

            }
            }else{
                foreSprite.x = -3800;
                FlxTween.tween(foreSprite, {x: 3800}, 1.3);
                new FlxTimer().start(1, function(tmr:FlxTimer)
                    {
                        startFore(coso);
                    });
            }
        }
        else{
            new FlxTimer().start(0.5, function(tmr:FlxTimer)
                {
                    startFore(lastSprite);
                });
        }
    }
}

function onDadHit() if (health > 0.1)health -= .02;

var dadZoom = .4;
var bfZoom = .6;
var timere = 0;
function update(elapsed){
    iconOffset = 35;
    icoP1.flipX = true;
    icoP2.flipX = true;

	switch (curCameraTarget) {
		case 0:
			defaultCamZoom = dadZoom;
		case 1:
			defaultCamZoom = bfZoom;
	}
    timere += elapsed;
    old2.iTime = timere;

			demcut2.x = demcut1.x + 650;
			demcut3.x = demcut1.x + 1100;
			demcut4.x = demcut1.x + 270;

			demcut2.y = demcut1.y;
			demcut3.y = demcut1.y + 370;
			demcut4.y = demcut1.y + 30;


    if(demcut1.animation.frameIndex == 17 && demcut1.alpha == 1){
		FlxTween.tween(demGround, {alpha: 1}, 0.5);
	FlxTween.tween(demcut1, {y: -600, x: -200}, 5, {ease: FlxEase.quadInOut, onComplete: function(twn:FlxTween){
		FlxTween.tween(demcut1, {x: -300}, 2.5, {ease: FlxEase.quadInOut, type: 4});
		FlxTween.tween(demcut1, {y: -500}, 4, {ease: FlxEase.quadInOut, type: 4});
	  }});
	}
}
function onCountdown(event) event.cancel();

function postUpdate(elapsed){
    icoP1.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01) - iconOffset);
    icoP2.x = healthBar.x + healthBar.width - 40;
}
function onSongStart(){
	midsongVid.play();	
	FlxTween.tween(midsongVid, {alpha: 1}, 2, {ease: FlxEase.expoOut});					
  	new FlxTimer().start(14, function(tmr:FlxTimer){
		remove(midsongVid);
    		camGame.alpha = camHUD.alpha = 1;
	});
}
function onSubstateOpen(event) if (midsongVid != null && paused && midsongVid.alpha == 1) midsongVid.pause();
function onSubstateClose(event) if (midsongVid != null && paused && midsongVid.alpha == 1) midsongVid.resume();
function focusGained() if (midsongVid != null && !paused && midsongVid.alpha == 1) midsongVid.resume();

function events(event){
    if (event == "HA"){
        var hatext:FlxText = new FlxText(900, -270, 600, 'HA!', 120);
        hatext.setFormat(Paths.font("mariones.ttf"), 120, FlxColor.WHITE, "left");
        add(hatext);
        hatext.angle = FlxG.random.float(-20, 20);

        FlxTween.tween(hatext, {x: 500, y: ((hatext.angle * 20) - 270), alpha: 0}, 1, {ease: FlxEase.expoOut, onComplete: function(twn:FlxTween){
            remove(hatext);
        }});
    }
    if (event == "Under"){
        demisetran.x = -1600;
        FlxTween.tween(demisetran, {x: 2600}, 1.4);
        new FlxTimer().start(2 * (1 / (Conductor.bpm / 60)), function(tmr:FlxTimer){
            underdembg.visible = true;
            underdemLevel.visible =  true;
            underdemGround1.visible =  true;
            underdemGround2.visible = true;
            underfloordemise.visible = true;
            underroofdemise.visible = true;
            dembg.visible = false;
            demLevel.visible = false;
            floordemise.visible = false;
            demGround.visible = false;
            demFore1.visible = 	false;
            demFore2.visible = 	false;
            demFore3.visible = 	false;
            demFore4.visible = 	false;
        });
    }
    if (event == "above"){
	demisetran.x = -1600;
	FlxTween.tween(demisetran, {x: 2600}, 1.4);

	new FlxTimer().start(2 * (1 / (Conductor.bpm / 60)), function(tmr:FlxTimer){
		underdembg.visible = 	 false;
		underdemLevel.visible =    false;
		underdemGround1.visible =  false;
		underdemGround2.visible =  false;
		underfloordemise.visible = false;
		underroofdemise.visible =  false;
		dembg.visible = true;
		demLevel.visible = true;
		floordemise.visible = true;
		demGround.visible = true;
			
		demFore1.visible = true;
		demFore2.visible = true;
		demFore3.visible = true;
		demFore4.visible = true;
	});
    }
    if (event == "red"){
        dadZoom = .2;
        FlxTween.tween(whenyourered, {alpha: 1}, 1, {ease: FlxEase.quadOut});
        FlxTween.tween(underdemFore1, {alpha: 0}, 1, {ease: FlxEase.quadOut});
        FlxTween.tween(underdemFore2, {alpha: 0}, 1, {ease: FlxEase.quadOut});
        FlxTween.color(boyfriend, 1, FlxColor.WHITE, FlxColor.BLACK, {ease: FlxEase.quadOut});
        FlxTween.color(dad,	1, FlxColor.WHITE, FlxColor.BLACK, {ease: FlxEase.quadOut});
        new FlxTimer().start(1.03, function(tmr:FlxTimer)
        {
            FlxTween.tween(camGame, {zoom: 0.4}, 20.21);
        });
    }
    if (event == "redback"){
        FlxTween.tween(whenyourered, {alpha: 0}, 2, {ease: FlxEase.quadInOut});
        FlxTween.tween(underdemFore1, {alpha: 1}, 2, {ease: FlxEase.quadOut});
        FlxTween.tween(underdemFore2, {alpha: 1}, 2, {ease: FlxEase.quadOut});
        FlxTween.color(boyfriend, 	2, FlxColor.BLACK, FlxColor.WHITE, {ease: FlxEase.quadInOut});
        FlxTween.color(dad,	2, FlxColor.BLACK, FlxColor.WHITE, {ease: FlxEase.quadInOut});
        dadZoom = .6;
    }  
    if (event == "cut"){
		cancelCameraMove = true;
		boyfriend.alpha = 0;
		dad.alpha = 0;
	
   		demcut1.alpha = 1;
   		demcut2.alpha = 1;
   		demcut3.alpha = 1;
  		demcut4.alpha = 1;
	
		demcut1.animation.play('idle', true);
		demcut2.animation.play('idle', true);
		demcut3.animation.play('idle', true);
		demcut4.animation.play('idle', true);
	
		FlxTween.tween(floordemise, {alpha: 0}, 0.5);
		FlxTween.tween(demGround, {alpha: 0}, 0.5);
		FlxTween.tween(camHUD, {alpha: 0.1}, 0.5);
		FlxTween.tween(camGame, {zoom: 1.3}, 0.4, {ease:FlxEase.expoOut});
                defaultCamZoom = 1.3;
		FlxTween.tween(camFollow, {x: 1000, y: 500}, 0.4, {ease:FlxEase.expoOut});

		new FlxTimer().start((1 / (Conductor.bpm / 60)), function(tmr:FlxTimer){
			FlxTween.tween(camFollow, {x: 1500, y: 100}, 6, {ease:FlxEase.quadInOut});
                        defaultCamZoom = 1.3;
		});
	}	
    if (event == "colorCut"){
		FlxTween.tween(gordobondiola, {x: 1000, y: -900}, 1.85, {ease: FlxEase.expoIn});

		FlxTween.color(demcut1,	0.4, FlxColor.WHITE, 0xFF5E5E5E);
		FlxTween.color(demcut2,	0.4, FlxColor.WHITE, 0xFF5E5E5E);
		FlxTween.color(demcut3,	0.4, FlxColor.WHITE, 0xFF5E5E5E);
		FlxTween.color(demcut4,	0.4, FlxColor.WHITE, 0xFF5E5E5E);
		FlxTween.tween(camHUD, {alpha: 1}, 0.5);	
       }
   if(event == "EndPart"){
        floordemise.alpha = demGround.alpha = boyfriend.alpha = dad.alpha = 1;
        gordobondiola.alpha = 0.001;
   }
}