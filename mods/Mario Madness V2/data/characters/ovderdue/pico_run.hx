var legs:FlxSprite;

function postCreate() {
    legs = new FlxSprite(0, 0);
    legs.frames = Paths.getFrames('characters/HellishHights/overdue/Too_Late_Pico_FINALSEQUENCE_assets');
    legs.animation.addByPrefix('legs', 'Legs', 32, true);
    legs.animation.play('legs');
    legs.offset.x = 100;
    legs.offset.y = -275;
    new FlxTimer().start(0.001, () -> state.insert(state.members.indexOf(this), legs));
    extra.set('legs', legs);
}

function update(elapsed:Float) {
    legs.setPosition(x + globalOffset.x - 100, y + globalOffset.y);
}
