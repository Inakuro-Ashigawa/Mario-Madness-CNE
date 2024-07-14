function onNoteCreation(event) {
    if (event.noteType != "Bullet Bill")
        return;

    event.noteSprite = 'game/notes/BulletBillMario_NOTE_assets';
    return;
}

function onPostNoteCreation(event) {
    if (event.noteType != "Bullet Bill")
        return;

    event.note.offset.set(10);
    if (downscroll)
    {
        event.note.flipY = true;
    }
    return;
}
