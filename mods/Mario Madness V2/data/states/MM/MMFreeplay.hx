import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import funkin.backend.utils.DiscordUtil;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.tweens.misc.NumTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import StringTools;


var options:Array<String> = ['Mainweek', 'Island', 'Woodland', 'Cosmos', 'Heights', 'Classified', 'Legacy', 'Extra'];
var canciones = [];

var grpOptions:FlxTypedGroup<FlxSprite>;

var curSelected:Int = 0;
var menuBG:FlxSprite;

var devsong:Bool = false;
var ogsong:Bool = false;
var onMenu:Bool = false;

var cosotexto:Array<String> = ['idk', 'sexo'];

var bg:FlxSprite;
var estatica:FlxSprite;
var freeplaytext:FlxSprite;
var imagePortrait:FlxSprite;

var showAnim:Bool = false;

function create(){
    FlxG.mouse.visible = true;
    DiscordUtil.changePresence('In Freeplay', "Marios Madness Codename Port");

    grpOptions = new FlxTypedGroup();
    add(grpOptions);

    freeplaytext = new FlxSprite(299.85, 32.5);
    freeplaytext.frames = Paths.getSparrowAtlas('modstuff/freeplay/Freeplay_Assets');
    freeplaytext.animation.addByPrefix('Title', 'Title', 24, true);
    freeplaytext.animation.play('Title');
    freeplaytext.updateHitbox();
    freeplaytext.screenCenter(FlxAxes.X);
    freeplaytext.x += 20;
    add(freeplaytext);

    freeplaytext.alpha = 0; 
    freeplaytext.scale.set(0,0);
    FlxTween.tween(freeplaytext, {'scale.x': 1, 'scale.y': 1, alpha: 1}, .35, {ease: FlxEase.circInOut, startDelay: .2});

    for (i in 0...options.length)
		{
			imagePortrait = new FlxSprite();
			imagePortrait.frames = Paths.getSparrowAtlas('modstuff/freeplay/Freeplay_Assets');
			imagePortrait.animation.addByPrefix(options[i], options[i], 24, true);
			imagePortrait.animation.play(options[i]);
			imagePortrait.updateHitbox();
			imagePortrait.ID = i;
			grpOptions.add(imagePortrait);

            switch(options){
				case 'Mainweek':
					imagePortrait.setPosition(56.55, 130.5);
				
				case 'Island':
					imagePortrait.setPosition(257.35, 130.5);

				case 'Woodland':
					imagePortrait.setPosition(442.65, 130.5);

				case 'Cosmos':
					imagePortrait.setPosition(638.55, 130.5);

				case 'Heights':
					imagePortrait.setPosition(833.8, 130.5);

				case 'Classified':
					imagePortrait.setPosition(1028, 130.5);

				case 'Extra':
					imagePortrait.setPosition(736.35, 472.35);

				case 'Legacy':
					imagePortrait.setPosition(268.70, 472.35);
            }
			imagePortrait.x -= 25; 
            imagePortrait.y -= 15;
            (new FlxTimer()).start(.35 + (0.05 * grpOptions.members.length), function (t) showAnim = true);
        }
    }
var tottalTime:Float = 0;
function update(elapsed){
    tottalTime += elapsed;

    grpOptions.forEach(function(spr:FlxSprite)
		{
			spr.offset.y = (Math.floor(8 * Math.sin(tottalTime + (.2 * spr.ID)))/8) * 6;
			spr.offset.y += FlxG.random.float(0.4, .8) * FlxG.random.sign();
			spr.offset.x = FlxG.random.float(0.4, .8) * FlxG.random.sign();

			var cosowea:Int;
			cosowea = curSelected;

			if (FlxG.mouse.overlaps(spr))
			{
				if(curSelected != spr.ID){
					curSelected = spr.ID;
					changeSelection(0);
				}
			}

			if(FlxG.mouse.justPressed && FlxG.mouse.overlaps(spr)){
				goToState();
			}
		});
    if(!onMenu){
        FlxG.camera.scroll.x = FlxMath.lerp(FlxG.camera.scroll.x, (FlxG.mouse.screenX-(FlxG.width/2)) * 0.01, (1/30)*240*elapsed);
        FlxG.camera.scroll.y = FlxMath.lerp(FlxG.camera.scroll.y, (FlxG.mouse.screenY-6-(FlxG.height/2)) * 0.01, (1/30)*240*elapsed);
    }   
}
function changeSelection(change:Int = 0)
	{
		curSelected += change;
		if (curSelected < 0)
			curSelected = options.length - 1;
		if (curSelected >= options.length)
			curSelected = 0;

		for (item in grpOptions.members)
		{
			item.color = 0xFF505050;
			item.alpha = 0.9;
			if (item.ID == curSelected && showAnim)
			{
				item.color = 0xFFFFFFFF;
				item.alpha = 1;
			}
		}
	}
function goToState()
    {
        for (item in grpOptions.members)
        {
            item.alpha = 0;
            freeplaytext.visible = false;
        }
        onMenu = true;
        FlxG.camera.scroll.x = 0;
        FlxG.camera.scroll.y = 0;

        switch (options[curSelected])
        {
            case 'Mainweek':
                canciones = [
                    ["It's a me", 'its-a-me', '26'],
                    ["Starman Slaughter", 'starman-slaughter', '34'],
                ];
            case 'Island':
                canciones = [
                    ['So Cool', 'so-cool', '8'],
                    ['Nourishing Blood', 'nourishing-blood', '16'],
                    ['MARIO SING AND GAME RYTHM 9', 'mario-sing-and-game-rythm-9', '13']
                ];
            case 'Woodland':
                canciones = [
                    ['Alone', 			'alone', 			'22'],
                    ['Oh God No', 		'oh-god-no', 		'21'],
                    ['I Hate You', 		'i-hate-you', 		'25'],
                    ['Thalassophobia',	'thalassophobia',   '31'],
                    ['Apparition', 		'apparition', 		'24'],
                    ['Last Course',		'last-course',      '18'],
                    ['Dark Forest', 	'dark-forest', 		'17']
                ];			

            case 'Cosmos':
                canciones = [
                    ['Bad Day', 		'bad-day', 		'12'],
                    ['Day Out', 		'day-out', 		'10'],
                    ['Dictator', 		'dictator', 	'11'],
                    ['Race-traitors', 	'racetraitors', '20'],
                    ['No Hope',			'no-hope',      '19']
                ];
            case 'Heights':
                canciones = [
                    ['Golden Land', 'golden-land', '28'],
                    ['No Party',		'no-party',         '30'],
                    ['Paranoia', 'paranoia', '41'],
                    ['Overdue',		'overdue',         '35'],
                    ['Powerdown', 'powerdown', '27'],
                    ['Demise', 'demise', '23']
                ];

            case 'Classified':
                canciones = [
                    ['Promotion', 'promotion', 	'15'],
                    ['Abandoned', 'abandoned', 	'32'],
                    ['The End', 'the-end', 		'33']
                ];
            
            case 'Legacy':
                canciones = [
                    ["It's a me (Original)", 'its-a-me-old', 		'1'],
                    ['Golden Land (Original)', 'golden-land-old', 	'2'],
                    ['I Hate You (Original)', 'i-hate-you-old', 	'3'],
                    ['Powerdown (Original)', 'powerdown-old', 		'4'],
                    ['Apparition (Original)', 'apparition-old', 	'5'],
                    ['Forbidden Star', 'forbidden-star', 			'39'],
                    ['Alone (Original)', 'alone-old', 				'6'],
                    ['Race-traitors (Original)', 'racetraitors-old', '7']
                ];

            case 'Extra':
                canciones = [
                    ['Unbeatable', 'unbeatable', '14'],
                    ['Dictator (Original)', 		'dictator-old', 	'42'],
                    ['No Party (Original)', 'no-party-old', '36'],
                    ['Overdue (Original)', 'overdue-old', '37'],
                    ['Time Out (Demise Original)', 'demise-old', '40'],
                    ['All Stars Act 1 (Original)', 'all-stars-old', '38']
                ];				
        }
        openSubState(new ModSubState('MM/MMFreeplaySub'));
        persistentUpdate = false;
        persistentDraw = false;
    }