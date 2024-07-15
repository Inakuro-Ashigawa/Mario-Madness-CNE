import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import funkin.menus.MainMenuState;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import funkin.options.OptionsMenu;
import funkin.menus.ModSwitchMenu;
import funkin.editors.EditorPicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.input.keyboard.FlxKey;
import flixel.input.mouse.FlxMouse;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.tweens.misc.NumTween;
import flixel.util.FlxColor;
import flixel.util.FlxSave;
import flixel.util.FlxTimer;
import haxe.io.Path;
import lime.app.Application;
import lime.graphics.Image;
import openfl.Lib;
import openfl.filters.ShaderFilter;
import openfl.ui.Mouse;
import sys.FileSystem;
import sys.io.File;
import StringTools;
var warpcoso:String = 'warpzone';

var bgFP:FlxSprite;
var fondo11:FlxBackdrop;
var bgAm:Int = 0;
var estatica:FlxSprite;
var tornado:FlxSprite;
var submenu:FlxSprite;
var fog:FlxSprite;
var saveSign:FlxSprite;
var beatSign:FlxSprite;

var typin:String = ''; // for the secrets....
var codeClearTimer:Float = 0;
var canselectshit:Bool = true;

var ntsc:CustomShader = null;
var bloom:CustomShader = null;

var menuInfo:Array<{group:Null<FlxTypedGroup<FlxSprite>>, choices:Array<String>, res:FlxPoint, scroll:FlxPoint}> = [
    {
        group: null,
        choices: ["Patch"],
        res: FlxPoint.get(555, 88.05),
        scroll: FlxPoint.get(1, .7)
    },
    {
        group: null,
        choices: ["MainGame"],
        res: FlxPoint.get(271, 275.5),
        scroll: FlxPoint.get(1.4, .95)
    },
    {
        group: null,
        choices: ["Options", "Credits"],
        res: FlxPoint.get(390, 131.05),
        scroll: FlxPoint.get(1, .7)
    }
];

// level => [FlxPoint.get(postion.x, postion.y), menu items gap]
// -1 on the postion means it will screen center that axes
var menuLevelPostions = [
    0 => [FlxPoint.get(1280 / 1.85, 5), 0],
    1 => [FlxPoint.get(1280 / 2.62, 170), 10],
    2 => [FlxPoint.get((1280 / 6.6) + 0.05, 520), 40]
];

var currentLevel:Int = 1;
var curSelected:Int = 0;
var varWEHOVERING:Bool = false;

var corners:Array<FlxSprite> = [];
var curButton:FlxSprite = null;

var menuItems:FlxTypedGroup<FlxSprite>;
var menuItems = new FlxTypedGroup();

var cornerOffset:NumTween;

var stars:FlxTypedGroup<FlxSprite>;
var stars = new FlxTypedGroup();
var starData:Array = [];

var bloom:BloomShader;
var ntsc:NTSCGlitch;

var selectedSomethin:Bool = false;
var canSelectSomethin:Bool = false;
var smOpen:Bool = false;
var showMsg:Int = 0;
var beat:Bool = false;

var lerpCamZoom:Bool = false;
var camZoomMulti:Float = 1;

function create() {


    if(FlxG.sound.music == null){
        FlxG.sound.playMusic(Paths.music('freakyMenu'));
    }else{
    if (!FlxG.sound.music.playing || FlxG.sound.music.length != 177230) //XDDDDDDDDDDDDDDDDDDD
        {
            FlxG.sound.playMusic(Paths.music('freakyMenu'));
            FlxG.sound.music.play(true, 27706);
        }
    }
    persistentUpdate = persistentDraw = true;


    menuInfo[1].choices.insert(1, "Freeplay");
    menuLevelPostions[1][0].x -= 149.75;
    
    menuInfo[1].choices.insert(1, "WarpZone");
    menuLevelPostions[1][0].x -= 149.75;



    fondo11 = new FlxBackdrop(Paths.image(('menus/mainmenu/bgs/bg1')), FlxAxes.X);
    add(fondo11);

    bgFP = new FlxSprite(0, 0).loadGraphic(Paths.image('modstuff/freeplay/HUD_Freeplay_2'));
    bgFP.scale.set(1.4, 1.4);
    bgFP.updateHitbox();
    bgFP.screenCenter();
    bgFP.alpha = 0;
    bgFP.scrollFactor.set(0, 0);
    bgFP.color = 0x00FF0000;
    add(bgFP);

    estatica = new FlxSprite();
    estatica.frames = Paths.getSparrowAtlas('modstuff/estatica_uwu');
    estatica.animation.addByPrefix('idle', "Estatica papu", 15);
    estatica.animation.play('idle');
    estatica.antialiasing = false;
    estatica.color = FlxColor.RED;
    estatica.alpha = 0.7;
    estatica.scrollFactor.set();
    estatica.updateHitbox();
    add(estatica);

    fog = new FlxSprite().loadGraphic(Paths.image('modstuff/126'));
    fog.alpha = 0.9;
    fog.scrollFactor.set();
    fog.updateHitbox();
    fog.screenCenter();
    add(fog);

    tornado = new FlxSprite(2280, -90);
    tornado.frames = Paths.getSparrowAtlas('modstuff/adios');
    tornado.animation.addByPrefix('idle', "adios pose", 4);
    tornado.animation.play('idle');
    tornado.scrollFactor.set();
    tornado.setGraphicSize(Std.int(tornado.width * 45));
    tornado.visible = true;
    tornado.antialiasing = false;
    tornado.updateHitbox();
    add(tornado);

    reloadBG();

    for (info in menuInfo)
		{
			var levelIdx = menuInfo.indexOf(info);

			if (info.choices == [])
				continue;

			info.group = new FlxTypedSpriteGroup();
			info.group.scrollFactor.set(info.scroll.x, info.scroll.y);

			for (choice in info.choices) {
				var menuIdx = info.choices.indexOf(choice);

				var button:FlxSprite = new FlxSprite();
				button.frames = Paths.getSparrowAtlas("menus/mainmenu/MM_Menu_Assets");
				button.animation.addByPrefix("idle", choice + "Normal", 30, true); // Selected
				button.animation.addByPrefix("selected", choice + "Selected", 30, true); // Selected
				button.animation.play("idle");
				

				button.updateHitbox();
				button.setPosition((button.width * menuIdx) + (menuLevelPostions[levelIdx][1] * menuIdx), 0);

				button.ID = menuIdx;
				info.group.add(button);
			}

			add(info.group);

			var pos:FlxPoint = menuLevelPostions[levelIdx][0];

			if (pos.x == -1)
				info.group.screenCenter(FlxAxes.X);
			else
				info.group.x = pos.x;

			if (pos.y == -1)
				info.group.screenCenter(FlxAxes.Y);
			else
				info.group.y = pos.y;

			pos.put();
		}

		for (i in 1...5) {
			var corner:FlxSprite = new FlxSprite();
			corner.frames = Paths.getSparrowAtlas("menus/mainmenu/MM_Menu_Assets");
			corner.animation.addByPrefix("idle", 'Corner' + i, 24);
			corner.animation.play("idle");

			corner.updateHitbox();
			corner.visible = false;
			corner.ID = i - 1;

			add(corner);

			corners.push(corner);
		}

		cornerOffset = FlxTween.num(0, 7.5, 1.5, {
			ease: FlxEase.circInOut,
			type: 4,
			onUpdate: (_) -> {
				for (corner in corners) {
					if (corner != null) {
						switch (corner.ID) {
							case 0:
								corner.offset.set(cornerOffset.value, cornerOffset.value);
							case 1:
								corner.offset.set(-cornerOffset.value, cornerOffset.value);
							case 2:
								corner.offset.set(cornerOffset.value, -cornerOffset.value);
							case 3:
								corner.offset.set(-cornerOffset.value, -cornerOffset.value);
						}
					}
				}
			}
		});
		submenu = new FlxSprite(50, 570);
		submenu.frames = Paths.getSparrowAtlas('modstuff/cuadro');

		submenu.animation.addByPrefix('oculto', "cuadro hide", 20, false);
		submenu.animation.addByPrefix('abrir', "cuadro abrir", 20, false); // abrir sin la flauta
		submenu.animation.addByPrefix('abrirF', "cuadro Fabrir", 20, false); // abrir con la flauta
		submenu.animation.addByPrefix('cerrar', "cuadro cerrar", 20, false);

		submenu.animation.play('oculto');
		submenu.scrollFactor.set();
		submenu.setGraphicSize(Std.int(submenu.width * 5));
		submenu.visible = true;
		submenu.antialiasing = false;
		submenu.updateHitbox();
		add(submenu);


        menuGroups = [for (info in menuInfo) info.group];

		changeItem();

		FlxG.camera.zoom += 0.1;

		FlxTween.tween(FlxG.camera, {zoom: 1}, 1.3, {ease: FlxEase.circInOut});
		if (showMsg == 0) (new FlxTimer()).start(0.6, function (t:FlxTimer) {canSelectSomethin = lerpCamZoom = true;});

        ntsc = new CustomShader("NTSCGlitch");
        ntsc.data.glitchAmount.value = [0.4, 0.4];
        FlxG.camera.addShader(ntsc);
    
        bloom = new CustomShader("Bloom");
        bloom.data.Size.value = [1, 1];
        bloom.data.dim.value = [.5, .5];
        FlxG.camera.addShader(bloom);

}
function reloadBG(){
    remove(fondo11);
    var amount:Int = 0;
    var stagenumb:Int = FlxG.save.data.menuBG - 1;
    if(stagenumb < 0){ //make random or if you get -1
        stagenumb = FlxG.random.int(0, amount - 2);
        if(stagenumb < 0) stagenumb = 0; //somehow you get -1 so to make sure you dont get the FLIXELBG then uses 1-1 stage
    }

    if(stagenumb == 2 || stagenumb == 3){
        fondo11.frames = Paths.getSparrowAtlas('menus/mainmenu/bgs/bg' + stagenumb);
        fondo11.animation.addByPrefix('idle', "bg", 5, true);
        fondo11.animation.play('idle', true);
    }else{
        fondo11 = new FlxBackdrop(Paths.image(('menus/mainmenu/bgs/bg' + stagenumb)), FlxAxes.X);
    }
    fondo11.updateHitbox();
    fondo11.scale.set(4, 4);
    fondo11.scrollFactor.set();
    fondo11.velocity.set(-40, 0);
    fondo11.screenCenter(FlxAxes.Y);
    fondo11.y -= 40;
    fondo11.color = FlxColor.RED;
    add(fondo11);
    fondo11.x = FlxG.random.float(0, fondo11.width * 2);

    luigi = new FlxBackdrop(FlxAxes.x, null);
    luigi.frames = Paths.getSparrowAtlas('Too_Late_Luigi_Hallway');
    luigi.animation.addByPrefix('idle', "tll idle0000", 24, true);
    luigi.animation.play('idle', true);
    luigi.scrollFactor.set();
    luigi.updateHitbox();
    luigi.velocity.set(-2800, 0);
    luigi.alpha = 0;
    add(luigi);
}

function postionCorners(obj:FlxSprite, ?space:FlxPoint) {
    if (space == null)
        space = FlxPoint.get(12.5, 12.5);

    var res:FlxPoint = menuInfo[currentLevel].res;
    var postions:Map<Int, FlxPoint> = [
        0 => FlxPoint.get((obj.x-obj.offset.x) - space.x, (obj.y-obj.offset.y) - space.y),
        1 => FlxPoint.get(((obj.x-obj.offset.x) + res.x) + space.x, (obj.y-obj.offset.y) - space.y),
        2 => FlxPoint.get((obj.x-obj.offset.x) - space.x, ((obj.y-obj.offset.y) + res.y) + space.y),
        3 => FlxPoint.get(((obj.x-obj.offset.x) + res.x) + space.x, ((obj.y-obj.offset.y) + res.y) + space.y)
    ];

    for (corner in corners) {
        if (corner == null)
            continue;

        var postion:FlxPoint = postions[corner.ID];

        if (postion == null)
            continue;

        corner.setPosition(postion.x, postion.y);
        corner.visible = true;

        switch (corner.ID) // I swear im not weird - lunar
        {
            case 1:
                corner.x -= corner.width / 1.9;
            case 2:
                corner.y -= corner.height / 1.75;
            case 3:
                corner.x -= corner.width / 1.9;
                corner.y -= corner.height / 1.75;
        }

        postion.put();
    }

    space.put();
}
function changeItem(?huh:Int = 0, ?arrowCheck:Bool = true) {
    curSelected += huh;

    if (arrowCheck) {
        curSelected = FlxMath.wrap(currentLevel + huh, 0, menuInfo.length-1);

    }

    for (group in menuGroups) {
        group.forEachAlive((_) -> {
            if (findGroupLevel(group) == currentLevel && _.ID == curSelected) {
                _.animation.play("selected", true);
                curButton = _;
                postionCorners(_);
            }
            else
                _.animation.play("idle", true);
        });
    }
}
function changeLevel(?duh:Int = 0, ?arrowCheck:Bool = true) {
    var lastGroup = menuGroups[currentLevel];

    currentLevel += duh;

    if (arrowCheck) {
        curSelected = FlxMath.wrap(currentLevel + duh, 0, menuInfo.length-1);


        
        if (curSelected == lastGroup.members.length-1) {
            curSelected = menuGroups[currentLevel].members.length-1;
        }
    }

    changeItem();

}
function findGroupLevel(grp:FlxTypedSpriteGroup<FlxSprite>):Int {
    for (info in menuInfo) {
        if (info.group == grp)
            return menuInfo.indexOf(info);
    }
    return 0;
}
var tieneflauta:Bool = false;
var fullTimer:Float = 0;
function update(elapsed:Float) {
    fullTimer += elapsed;

    if (ntsc != null) ntsc.data.time.value = [fullTimer, fullTimer];

    if (FlxG.keys.justPressed.SEVEN) {
        openSubState(new EditorPicker());
        persistentUpdate = false;
        persistentDraw = true;
    }
    if (controls.SWITCHMOD) {
        openSubState(new ModSwitchMenu());
        persistentUpdate = false;
        persistentDraw = true;
    }
    if (FlxG.sound.music.volume < 0.8 && !selectedSomethin)
        FlxG.sound.music.volume += 0.5 * FlxG.elapsed;

    FlxG.camera.scroll.x = FlxMath.lerp(FlxG.camera.scroll.x, (FlxG.mouse.screenX-(FlxG.width/2)) * 0.015, (1/30)*240*elapsed);
    FlxG.camera.scroll.y = FlxMath.lerp(FlxG.camera.scroll.y, (FlxG.mouse.screenY-6-(FlxG.height/2)) * 0.015, (1/30)*240*elapsed);

    if (lerpCamZoom) // Check out my ouper duper code -lunar
        FlxG.camera.zoom = FlxMath.lerp(
            FlxG.camera.zoom, camZoomMulti * (.98 - 
            (Math.abs(((FlxG.mouse.screenX*0.4) + 
            (FlxMath.remapToRange(FlxG.mouse.screenY, 0, FlxG.height, 0, FlxG.width)*0.6))
            -(FlxG.width/2)) * 0.00002)), 
        (1/30)*240*elapsed);

    fog.scale.set(1/FlxG.camera.zoom, 1/FlxG.camera.zoom);
    estatica.scale.set(1/FlxG.camera.zoom, 1/FlxG.camera.zoom);


        WEHOVERING = false;
        if(canselectshit){
            for (group in menuGroups) {
                if (group == null) continue;

                var hovering:Bool = false;
                group.forEach((button) ->
                {
                    var groupLevel:Int = findGroupLevel(group);

                    button.offset.y = 8*(Math.floor(8 * FlxMath.fastSin((fullTimer/2) + ((.5*button.ID)+(2*groupLevel))))/8);
                    button.offset.x = 4*(Math.floor(8 * FlxMath.fastSin((fullTimer/8) + ((2/8)*groupLevel)))/8);

                    if (FlxG.mouse.overlaps(button)) {
                        hovering = WEHOVERING = true;
                        
                        if ((currentLevel != groupLevel) || (curSelected != button.ID)) {
                            currentLevel = groupLevel;
                            changeLevel(0, false);

                            curSelected = button.ID;
                            changeItem(0, false);

                            FlxG.sound.play(Paths.sound('scrollMenu'));
                        }
                    }
                });

                if (FlxG.mouse.justReleased && hovering && canSelectSomethin) goToState();
            }	
        }
    
    Mouse.cursor = WEHOVERING;
    if (controls.ACCEPT && smOpen) {
        smOpen = false;
        FlxG.sound.play(Paths.sound('accept'));
        if(showMsg == 1){
        FlxTween.tween(saveSign, {y: saveSign.y + 720}, 1, {ease: FlxEase.expoOut, onComplete: function(twn:FlxTween)
            {
                canSelectSomethin = true;
                selectedSomethin = false;
            }});
        }else{
            FlxTween.tween(beatSign, {y: beatSign.y + 720}, 1, {ease: FlxEase.expoOut, onComplete: function(twn:FlxTween)
                {
                    selectedSomethin = false;
                    canSelectSomethin = true;
                }});
        }
    }
}
    var oldButton:FlxSprite;
	var oldPos:FlxPoint;

	function goToState() {
		selectedSomethin = true; WEHOVERING = false;
		FlxG.sound.play(Paths.sound('confirmMenu'));


		lerpCamZoom = false; FlxTween.tween(FlxG.camera, {zoom: 1.1}, 1.3, {ease: FlxEase.circOut});

	
		new FlxTimer().start(.6, (_) -> {
			var choice:String = menuInfo[currentLevel].choices[curSelected];
			switch (currentLevel) {
				case 0:
					switch (choice) {
						case "Patch":
                            FlxG.switchState(new ModState("PatchNotes"));         
					}
				case 1:
					switch (choice) {
						case "MainGame":
							new FlxTimer().start(0.4, function(tmr:FlxTimer) { 
                                FlxG.switchState(new StoryMenuState());
                            });
						case "WarpZone":
							new FlxTimer().start(0.4, function(tmr:FlxTimer)
							{
                                FlxG.switchState(new ModState("extras/PartyState"));
							});
                        
                        //dont even think about it- inakuro
						case "Freeplay":
							new FlxTimer().start(0.4, function(tmr:FlxTimer) { 
                                FlxG.switchState(new ModState("MM/MMFreeplay"));
                            });

					}
				case 2:
					switch (choice) {
						case "Options":
							new FlxTimer().start(0.4, function(tmr:FlxTimer) {
                                FlxG.switchState(new OptionsMenu());
                            });
						case "Credits":
							FlxG.switchState(new ModState("MMCredits"));
					}
			}
		});
	}