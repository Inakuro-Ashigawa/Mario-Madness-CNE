var _internal_curCameraTarget = [
    0 => 0,
];
function onNoteHit(event) {
    if (event.noteType != "StrumLine Character") return;
    var _strumLineID = Std.parseInt(event.note.extra.get("strumLineID"));
    var _noteTypeID = Std.parseInt(event.note.extra.get("noteTypeID"));

    if (_strumLineID == null || _noteTypeID == null) return;

    var character = strumLines.members[_strumLineID].characters[(_noteTypeID - 1)];
    if (character == null) return;
    event.character = character;
    _internal_curCameraTarget.set(_strumLineID, _noteTypeID);
}

function onNoteCreation(event) {
    event.note.extra.set("strumLineID", event.strumLineID);
    event.note.extra.set("noteTypeID", event.noteTypeID);
}

function onCameraMove(event) {
    trace("curCameraTarget: " + curCameraTarget);
    if (!_internal_curCameraTarget.exists(curCameraTarget)) return;
    var _target = _internal_curCameraTarget[curCameraTarget];
    trace(_target);
    if (_target == null) return;
    // var char = _target.getCameraPosition();
    // event.position.set
}