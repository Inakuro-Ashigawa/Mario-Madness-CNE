//yo soi luigi, mama mia - Mlaofmd

function create() {
    var vig = new FlxSprite().loadGraphic(Paths.image('modstuff/126'));
    vig.cameras = [camHUD];
    add(vig);
}

function stepHit(curStep) {
	switch (curStep) {
		case 235:
			FlxTween.tween(camHUD, {alpha: 0}, 0.5, {ease: FlxEase.quadInOut});
		case 256:
			FlxTween.tween(camHUD, {alpha: 1}, 0.5, {ease: FlxEase.quadInOut});
	}
}