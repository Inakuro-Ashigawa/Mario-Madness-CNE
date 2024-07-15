//yo soi luigi, mama mia - Mlaofmd

var castleFloor:FlxSprite;
var castleCeiling:FlxSprite;

var street1:FlxSprite;
var street2:FlxSprite;
var street3:FlxSprite;
var street4:FlxSprite;
var streetFore:FlxSprite;

var streetGroup = [];

function create() {
	castleFloor = new FlxSprite(-1500, 650);
    castleFloor.frames = Paths.getSparrowAtlas('stages/HellishHights/TooLateBG/feet/Overdue_Final_BG_floorfixed');
    castleFloor.animation.addByPrefix('idle', "Floor", 24, false);
    castleFloor.animation.addByPrefix('loop', "Floor", 24, true);
    castleFloor.animation.play('idle');
    castleFloor.alpha = 0;
    insert(0, castleFloor);

    castleCeiling = new FlxSprite(-1500, -1100);
    castleCeiling.frames = Paths.getSparrowAtlas('stages/HellishHights/TooLateBG/feet/Overdue_Final_BG_floorfixed');
    castleCeiling.animation.addByPrefix('idle', "Top", 24, false);
    castleCeiling.animation.addByPrefix('loop', "Top", 24, true);
    castleCeiling.animation.play('idle');
    castleCeiling.alpha = 0;
    insert(1, castleCeiling);

    street1 = new FlxSprite(-1400, -550).loadGraphic(Paths.image('stages/HellishHights/TooLateBG/street/BackTrees'));
    street1.scrollFactor.set(0.95, 0.95);
    streetGroup.push(street1);
    insert(2, street1);

    street2 = new FlxSprite(-1400, -550).loadGraphic(Paths.image('stages/HellishHights/TooLateBG/street/Front Trees'));
    street2.scrollFactor.set(1.05, 1.05);
    streetGroup.push(street2);
    insert(3, street2);

    street3 = new FlxSprite(-1400, -550).loadGraphic(Paths.image('stages/HellishHights/TooLateBG/street/Road'));
    streetGroup.push(street3);
    insert(4, street3);

    street4 = new FlxSprite(-1400, -550).loadGraphic(Paths.image('stages/HellishHights/TooLateBG/street/car'));
    streetGroup.push(street4);
    insert(5, street4);

    streetFore = new FlxSprite(-1600, -550).loadGraphic(Paths.image('stages/HellishHights/TooLateBG/street/Foreground Trees'));
    streetFore.scrollFactor.set(1.2, 1);
    add(streetFore);

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