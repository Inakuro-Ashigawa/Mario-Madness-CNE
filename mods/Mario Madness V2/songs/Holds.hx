function onNoteHit(event) {
    if (event.note.isSustainNote) {
        event.animCancelled = true;
        for (char in event.characters) {
            char.lastHit = Conductor.songPosition;
        }
    }
}