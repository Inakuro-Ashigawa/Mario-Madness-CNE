import flixel.util.FlxTimer;

var dodged:Bool = false;
var camEST = new FlxCamera();
function onEvent(_){
    if (_.event.name == 'Turmoil Attack') {
        if(_.event.params[0] == 'warningManual'){
            if(_.event.params[1] == '1'){
                FlxG.sound.play(Paths.sound('turmoil/warningT2'));
                FlxTween.tween(buttonxml, {alpha: 1}, 0.2, {ease: FlxEase.quadOut});

	            warning.alpha = 1;
	            var wary:Float = warning.y;
	            warning.y = wary - 50;
    	        warning.scale.set(0.7, 0.7);
	            FlxTween.tween(warning, {y: wary, alpha: 0.2}, 0.5 * (1 / (Conductor.bpm / 60)), {ease: FlxEase.expoOut});
            }
            if(_.event.params[1] == '2'){
                FlxG.sound.play(Paths.sound('turmoil/warningT2'));
		        warning.alpha = 1;
		        FlxTween.tween(warning.scale, {y: 0.8, x: 0.8}, 0.5 * (1 / (Conductor.bpm / 60)), {ease: FlxEase.elasticOut});
    		    FlxTween.tween(warning, {alpha: 0.2}, 0.5 * (1 / (Conductor.bpm / 60)), {ease: FlxEase.quadOut});
            }
            if(_.event.params[1] == '3'){
    		    FlxG.sound.play(Paths.sound('turmoil/warningT2'));
	    	    warning.alpha = 1;
		        FlxTween.tween(warning.scale, {y: 1, x: 1}, 0.5 * (1 / (Conductor.bpm / 60)), {ease: FlxEase.elasticOut});
    		    FlxTween.tween(warning, {alpha: 0}, 0.5 * (1 / (Conductor.bpm / 60)), {ease: FlxEase.quadOut});
                new FlxTimer().start(0.2083, function(tmr:FlxTimer)
                {
                    strumLines.members[0].characters[0].playAnim('preattack', true);
                });
            }
            if(_.event.params[1] == 'Attack'){
                strumLines.members[0].characters[0].playAnim('attack', true);
		        FlxG.sound.play(Paths.sound('turmoil/TURMOIL-LENGUETAZO'));
                if (!dodged){
    				boyfriend.playAnim('singRIGHTmiss', true);
    				var newhealth:Float = health - 1.2;
	    			FlxTween.tween(this, {health: newhealth}, 0.2, {ease: FlxEase.quadOut});
                    }
			    }
            }
        }
        if(_.event.params[0] == 'warning'){

			FlxG.sound.play(Paths.sound('turmoil/warningT2'));
		    warning.alpha = 1;
		    var wary:Float = warning.y;
		    warning.y = wary - 50;
		    warning.scale.set(0.7, 0.7);
			FlxTween.tween(buttonxml, {alpha: 1}, 0.5 * (1 / (Conductor.bpm / 60)), {ease: FlxEase.quadOut});          
		    FlxTween.tween(warning, {y: wary, alpha: 0.2}, 0.5 * (1 / (Conductor.bpm / 60)), {ease: FlxEase.expoOut});
		    new FlxTimer().start(((1 / (Conductor.bpm / 60))), function(tmr:FlxTimer)
			{
			    FlxG.sound.play(Paths.sound('turmoil/warningT2'));
			    warning.alpha = 1;
			    FlxTween.tween(warning.scale, {y: 0.8, x: 0.8}, 0.5 * (1 / (Conductor.bpm / 60)), {ease: FlxEase.elasticOut});
			    FlxTween.tween(warning, {alpha: 0.2}, 0.5 * (1 / (Conductor.bpm / 60)), {ease: FlxEase.quadOut});
            });
		    new FlxTimer().start(((2 / (Conductor.bpm / 60))), function(tmr:FlxTimer)
		    {
			    FlxG.sound.play(Paths.sound('turmoil/warningT2'));
			    warning.alpha = 1;
			    FlxTween.tween(warning.scale, {y: 1, x: 1}, 0.5 * (1 / (Conductor.bpm / 60)), {ease: FlxEase.elasticOut});
			    FlxTween.tween(warning, {alpha: 0}, 0.5 * (1 / (Conductor.bpm / 60)), {ease: FlxEase.quadOut});
		    });
		    new FlxTimer().start(0.2083 - (3 * (1 / (Conductor.bpm / 60))), function(tmr:FlxTimer)
			{
			    strumLines.members[0].characters[0].playAnim('preattack', true);
		    });
			new FlxTimer().start((3 * (1 / (Conductor.bpm / 60))), function(tmr:FlxTimer)
		    {
                strumLines.members[0].characters[0].playAnim('attack', true);
			    FlxG.sound.play(Paths.sound('turmoil/TURMOIL-LENGUETAZO'));
			    new FlxTimer().start(0.0483, function(tmr:FlxTimer)
	    		{
			    	if (!dodged){
						boyfriend.playAnim('singRIGHTmiss', true);
						var newhealth:Float = health - 1.2;
						FlxTween.tween(this, {health: newhealth}, 0.2, {ease: FlxEase.quadOut});
				}
				FlxTween.tween(buttonxml, {alpha: 0}, 0.5 * (1 / (Conductor.bpm / 60)), {startDelay: 0.5, ease: FlxEase.quadOut});          
			});
		});
	
    }  
}


function postUpdate() {
    if(FlxG.keys.justPressed.SPACE && !dodged){
        dodged = true;
        buttonxml.animation.play('press');
        strumLines.members[1].characters[0].playAnim('dodge', true);
        new FlxTimer().start(0.75, function(tmr:FlxTimer){
        dodged = false;
        });
    }
}

function create(){
    warning = new FlxSprite(-1300, -350).loadGraphic(Paths.image('stages/Woodland-of-Lies/course/Turmoil_HARHARHARHAR'));
	warning.cameras = [camHUD];
	warning.alpha = 0.0000000001;
	warning.screenCenter();
	add(warning);


    buttonxml = new FlxSprite(0, 550);
	buttonxml.frames = Paths.getFrames('stages/Woodland-of-Lies/course/Button');
	buttonxml.animation.addByPrefix('nopress', 'button no press0000', 12, false);
	buttonxml.animation.addByPrefix('press', 'button press', 12, false);
	buttonxml.cameras = [camEST];
	buttonxml.alpha = 0.0001;
	buttonxml.scale.set(0.25, 0.25);
	buttonxml.updateHitbox();
    add(buttonxml);

	camEST.bgColor = 0;
    camEST.alpha = 1;
    FlxG.cameras.remove(camHUD, false);
    FlxG.cameras.add(camHUD, false);
    FlxG.cameras.add(camEST, false);
}
function onSongStart(){
	FlxTween.tween(buttonxml, {alpha: 1}, 0.5 * (1 / (Conductor.bpm / 60)), {startDelay: 1, ease: FlxEase.quadOut});          
	FlxTween.tween(buttonxml, {alpha: 0}, 0.5 * (1 / (Conductor.bpm / 60)), {startDelay: 7, ease: FlxEase.quadOut});          
}