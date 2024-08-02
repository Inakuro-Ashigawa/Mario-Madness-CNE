
public static var botplay:Bool = false;

public var botplaySine:Float = 0;
function update(elapsed) {
    botplaySine += 180 * elapsed;
    if(PlayState.SONG.meta.name != 'paranoia'){
    	luigiLogo.angle = ((1 - Math.sin((Math.PI * botplaySine) / 180)) * 20) - 20;
    }

    if(PlayState.SONG.meta.name == 'paranoia'){
        if(1 - Math.sin((Math.PI * (botplaySine * 2)) / 180) < 1)
            luigiLogo.alpha = 0;
        else
            luigiLogo.alpha = 1;
    }

    if (FlxG.save.data.callLuigi) 
    	botplay = true;
    else
    	botplay = false;
}

function postCreate() {
    playerStrums.onNoteUpdate.add(updateNote);
}

function onInputUpdate(event) {
    if (botplay) event.cancel();
}

function updateNote(event) {
    if (!botplay) return;

    var daNote:Note = event.note;

    if (!daNote.avoid && !daNote.wasGoodHit && daNote.strumTime < Conductor.songPosition)
        PlayState.instance.goodNoteHit(daNote.strumLine, daNote);
}