import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
var progress = 3;
var curSelected:Int = 0;
var bfprefix:String = '';
var time:Float = 1;
var screenText:FlxText;
var canciones:Array<Dynamic> = [	
    ['Start', 							'X', '1', 'X', 'x', 0],
    ['So-Cool',							'0', 'X', 'X', '2', 0],
    ['Nourishing-Blood', 				'3', 'X', '1', 'X', 1],
    ['mario-sing-and-game-rhythm-9', 	'X', '2', 'X', 'X', 2]
];     
var things:Array<Dynamic> = [		
    ['star', 	525, 280],
    ['dot', 	531, 428],
    ['none', 	0, 0],
    ['ring', 	697, 237]
];    
var worldDots:FlxTypedSpriteGroup;

function create(){
    bgworld1 = new FlxSprite(0, 10);
    bgworld1.loadGraphic(Paths.image('warpzone/1/bg1'));
    bgworld1.setGraphicSize(Std.int(bgworld1.width * 3));
    bgworld1.antialiasing = false;
    bgworld1.screenCenter();
    bgworld1.y -= 11;
    add(bgworld1);

    bgworld2 = new FlxSprite(0, 10);
    bgworld2.frames = Paths.getSparrowAtlas('warpzone/1/bg2');
    bgworld2.setGraphicSize(Std.int(bgworld2.width * 3));
    bgworld2.animation.addByPrefix('idle', "idle", 6, true);
    bgworld2.animation.play('idle');
    bgworld2.antialiasing = false;
    bgworld2.screenCenter();
    bgworld2.y -= 11;
    bgworld2.x -= 280;
    add(bgworld2);

    bgpath = new FlxSprite(605, 325);
    bgpath.frames = Paths.getSparrowAtlas('warpzone/1/path');
    bgpath.animation.addByPrefix('1', "path 1", 6);
    bgpath.animation.addByPrefix('2', "path 2", 6);  
    bgpath.animation.addByPrefix('3', "path 3", 6);
    bgpath.animation.addByPrefix('4', "path 4", 6);
    bgpath.animation.addByPrefix('5', "path 5", 6);
    bgpath.animation.addByPrefix('6', "path 6", 6);
    bgpath.animation.addByPrefix('7', "path 7", 6);
    bgpath.animation.play('' + progress);
    bgpath.setGraphicSize(Std.int(bgpath.width * 3));
    bgpath.antialiasing = false;
    add(bgpath);

    worldDots = new FlxTypedSpriteGroup();
    for (i in 0...canciones.length){
        var place:String = things[i][0];
        var theanim:String = 'idle';
        if(things[i][0] == 'none') place = 'dot';
        var dot:FlxSprite = new FlxSprite(things[i][1], things[i][2]);
        dot.frames = Paths.getSparrowAtlas('warpzone/' + place);
        dot.antialiasing = false;
        dot.setGraphicSize(Std.int(dot.width * 3));
        dot.ID = i;
        if(things[i][0] == 'ring'){
            dot.animation.addByPrefix("appear", 'appear', 6, false);
            dot.animation.addByPrefix("vanish", 'vanish', 24, false);
        }

        dot.animation.addByPrefix("anim", theanim, 6, true);
        dot.animation.play("anim");
        if(things[i][0] == 'none') dot.alpha = 0;//si lo omito entonces jode mas el contador
        worldDots.add(dot);
    }
    add(worldDots);

    pibemapa = new FlxSprite(400, 251);
    var deadSuffix = '';
    if(FlxG.save.data.storySave = 7) deadSuffix = 'dead_';
    pibemapa.frames = Paths.getSparrowAtlas('warpzone/' + deadSuffix + 'overworld_bf');
    pibemapa.animation.addByPrefix('idle', "overworld bf walk down", 6);
    pibemapa.animation.addByPrefix('up', "overworld bf walk up", 6);
    pibemapa.animation.addByPrefix('down', "overworld bf walk down", 6);
    pibemapa.animation.addByPrefix('left', "overworld bf walk left", 6);
    pibemapa.animation.addByPrefix('right', "overworld bf walk right", 6);
    pibemapa.animation.addByPrefix('start', "overworld bf level start", 6);
    pibemapa.animation.add('warp', [0, 5, 9, 13], 10);
    pibemapa.animation.play('idle');
    pibemapa.setGraphicSize(Std.int(pibemapa.width * 3));
    pibemapa.antialiasing = false;
    pibemapa.updateHitbox();
    add(pibemapa);


    gameLives = new FlxSprite(0, 0);
    gameLives.frames = Paths.getSparrowAtlas('warpzone/overworld_overlay');
    gameLives.animation.addByPrefix('idle', "overworld overlay idle", 6);
    gameLives.animation.play('idle');
    gameLives.setGraphicSize(Std.int(gameLives.width * 3));
    gameLives.antialiasing = false;
    gameLives.updateHitbox();
    gameLives.screenCenter();
    gameLives.scrollFactor.set(0, 0);
    add(gameLives);

    screenText = new FlxText(515, 70, 1280, "", 16);
    screenText.setFormat(Paths.font("smwWORLDS.TTF"), 24, FlxColor.BLACK, "LEFT");
    screenText.antialiasing = false;
    screenText.scrollFactor.set(0, 0);
    add(screenText);


    var lascord:Array<Float> = getCoords(curSelected, 1);
    pibemapa.x = lascord[0];
    pibemapa.y = lascord[1];
    pibemapa.animation.play('idle');

    FlxG.sound.playMusic(Paths.music('warpzone/1'), 0);
    FlxG.sound.music.fadeIn(1, 0, 0.5);
}
function getCoords(nextPos:Int){
    var x:Float = 0;
    var y:Float = 0;
    var theY:Array<Float> = [0];
    var theX:Array<Float> = [0];

    theX = [493, 493, 676, 676];
    theY = [218, 359, 359, 232];

    var thecoords:Array<Float> = [theX[nextPos], theY[nextPos]];
    return thecoords;
}

function animStart(nextDir:Int, lastDir:Float, pibe:FlxSprite, iswalk:Bool) {
    var coords:Array<Float> = getCoords(nextDir); // Get the coordinates for the next position
    var x:Float = coords[0]; // X position
    var y:Float = coords[1]; // Y position
    var anim:Int = 0;

    var theTweenX:FlxTween;
    var theTweenY:FlxTween;

    time = 1.4; // Default time for movement

    switch(nextDir) {
        case 0: // Move Up
            time = 1.4;
            theTweenX = FlxTween.tween(pibe, {x: x}, time); // Tween X axis
            theTweenY = FlxTween.tween(pibe, {y: y}, time); // Tween Y axis


        case 1: // Move Down
            time = 1.4;
            if (lastDir == 2) time = 1.6; // Slight delay for direction change
            theTweenX = FlxTween.tween(pibe, {x: x}, time);
            theTweenY = FlxTween.tween(pibe, {y: y}, time);


        case 2: // Move Left
            time = 1.6;
            if (lastDir == 3) time = 1.2; // Slight delay for direction change
            theTweenX = FlxTween.tween(pibe, {x: x}, time);
            theTweenY = FlxTween.tween(pibe, {y: y}, time);


        case 3: // Move Right
            time = 1.2;
            theTweenX = FlxTween.tween(pibe, {x: x}, time);
            theTweenY = FlxTween.tween(pibe, {y: y}, time);

    }
}

function caminar(direction:String, anim:Int) {
    if (direction != 'X') {
        var dir:Int = Std.parseInt(direction);
        animStart(curSelected, 0, pibemapa, true); // Call animStart to start the tween and update position

        screenText.text = canciones[curSelected][0].toUpperCase();
		curSelected = dir;

        if (pibemapa.animation.curAnim.name == bfprefix + 'idle') {
            switch (anim) {
                case 1: // Up
                    pibemapa.animation.play(bfprefix + 'up');
        
                case 2: // Down
                    pibemapa.animation.play(bfprefix + 'down');
        
                case 3: // Left
                    pibemapa.animation.play(bfprefix + 'left');
        
                case 4: // Right
                    pibemapa.animation.play(bfprefix + 'right');
        
            }
        }

        // Start a timer to reset the animation to idle after the move completes
        new FlxTimer().start(0.8, function(tmr:FlxTimer) {
            FlxG.sound.play(Paths.sound('owCuts/wz_move')); // Play sound
            pibemapa.animation.play('idle'); // Return to idle animation
        });
    }
}

function update() {

    if (FlxG.keys.justPressed.UP) {
        caminar(canciones[curSelected][1], 1); // Move up
    }
    else if (FlxG.keys.justPressed.DOWN) {
        caminar(canciones[curSelected][2], 2); // Move down
    }
    else if (FlxG.keys.justPressed.LEFT) {
        caminar(canciones[curSelected][3], 3); // Move left
    }
    else if (FlxG.keys.justPressed.RIGHT) {
        caminar(canciones[curSelected][4], 4); // Move right
    }
    goTHings();
}
function goTHings(){
    if (controls.ACCEPT)
        {
            if(canciones[curSelected][0] == 'Start'){
                pibemapa.animation.play('warp');
                FlxG.sound.play(Paths.sound('owCuts/smw_feather_get'));
                FlxTween.tween(pibemapa, {y: 0}, 0.5, {startDelay: 0.5, ease: FlxEase.quadIn});
                new FlxTimer().start(2, function(tmr:FlxTimer)
                {
                        FlxG.sound.music.fadeOut(0.5, 0);
                        FlxG.sound.playMusic(Paths.music('warpzone/0'), 0);
                        FlxG.sound.music.fadeIn(1, 0, 0.5);
                        FlxG.switchState(new ModState("WarpState"));   
                });
            }else{
                pibemapa.animation.play(bfprefix + 'start');
					
                var thesong:String = canciones[curSelected][0];
                PlayState.isWarp = true;
                PlayState.isStoryMode = false;
                PlayState.loadWeek({
                    name: "Main week",
                    id: "Main week",
                    sprite: null,
                    chars: [null, null, null],
                    songs: [for (song in [thesong]) {name: song, hide: false}],
                    difficulties: ['hard']
                }, "hard");

                if(curSelected == 2){
        
                    FlxG.sound.play(Paths.sound('warpring'));
                    worldDots.forEach(function(dot:FlxSprite){
                        if (dot.ID == 3){
                            dot.animation.play('vanish');
                        }
                    });
                    pibemapa.visible = false;
                    new FlxTimer().start(1, function(tmr:FlxTimer)
                    {
                        FlxG.sound.music.volume = 0;
                        var lightTrans:FlxSprite = new FlxSprite().makeGraphic(Std.int(gameLives.width), Std.int(gameLives.height), FlxColor.WHITE);
                        lightTrans.x = gameLives.x;
                        lightTrans.y = gameLives.y;
                        lightTrans.alpha = 0;
                        add(lightTrans);
                        FlxTween.tween(lightTrans, {alpha: 1}, 0.5, {startDelay: 0.2});
                        FlxG.sound.play(Paths.sound('warpring trans'));
                        
                        new FlxTimer().start(2, function(tmr:FlxTimer){
                            FlxG.switchState(new PlayState());
                        });
            
                    });
                }
            }
        }
    } 