function onNoteHit(e){
    if(e.noteType == 'GF Duet'){
        e.healthGain += 0.002;
        gf.playSingAnim(e.direction, e.animSuffix);
    }
}