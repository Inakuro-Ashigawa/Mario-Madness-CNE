function onNoteCreation(event) {
    if (event.noteType != "Bullet2")
        return;

    event.note.visible = false;
    return;
}