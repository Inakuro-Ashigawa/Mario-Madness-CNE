function onNoteHit(e){
    if(e.noteType == 'GF Sing'){
        e.character = strumLines.members[2].characters[0];
        e.healthGain += 0.002;
    }
}