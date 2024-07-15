var healthDrain:Int = 0;

function onNoteCreation(event) {
    if (event.noteType != "Bullet")
        return;

    event.noteSprite = 'game/notes/BulletMario_NOTE_assets';
    return;
}

function onNoteHit(event) {
    if (event.noteType == "Bullet"){
        event.animCancelled = true;
        boyfriend.playAnim('singUP-alt', true);

        dad.alpha = 0;
        FlxTween.tween(dad, {alpha: 1}, 0.5);
        FlxG.sound.play(Paths.sound('overdue/gunshot'), 1);
    }
    return;
}

function onPlayerMiss(event){
    if (event.noteType == "Bullet")
        healthDrain = healthDrain + 0.6;
}

function update(elapsed) {
    if (healthDrain > 0){
        healthDrain = healthDrain - 0.2 * elapsed;
        health = health - 0.2 * elapsed;
        if (healthDrain < 0)
            healthDrain = 0;
    }
}
