function onNoteCreation(event) {
    if (event.noteType != "Bullet Bill")
        return;

    event.noteSprite = 'stages/secret/BulletBillMario_NOTE_assets';
    if (downscroll)
    {
        
    }
    return;
}

function onPostNoteCreation(event) {
    if (event.noteType != "Bullet Bill")
        return;

    event.note.offset.set(10);
    event.note.flipY = true;
    return;
}
