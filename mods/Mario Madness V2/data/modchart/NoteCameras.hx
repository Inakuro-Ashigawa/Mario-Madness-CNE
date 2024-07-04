import funkin.game.HudCamera;
import funkin.game.StrumLine;
import funkin.game.Strum;
import funkin.game.Note;
import funkin.backend.scripting.events.NoteUpdateEvent;
import flixel.FlxCamera;
import funkin.backend.scripting.events.NoteCreationEvent;

public final camNotes:HudCamera;
public final camSustains:HudCamera;
public final camStrums:HudCamera;

/*
 * Basically defaultHudZoom, but for these cameras
 */
public var defaultNoteZoom:Float = 1;
public var defaultSustainZoom:Float = 1;
public var defaultStrumZoom:Float = 1;

function create(){
    FlxG.cameras.add(camStrums = new HudCamera(), false);
    FlxG.cameras.add(camSustains = new HudCamera(), false);
    FlxG.cameras.add(camNotes = new HudCamera(), false);

    camStrums.bgColor = '#00000000';
    camSustains.bgColor = '#00000000';
    camNotes.bgColor = '#00000000';

    camStrums.downscroll = downscroll;
    camNotes.downscroll = downscroll;
    camSustains.downscroll = downscroll;
}

function update()
    if (camZooming){
		camNotes.zoom = lerp(camNotes.zoom, defaultNoteZoom, 0.05);
        camSustains.zoom = lerp(camSustains.zoom, defaultSustainZoom, 0.05);
        camStrums.zoom = lerp(camStrums.zoom, defaultStrumZoom, 0.05);
	}

function beatHit()
    if (Options.camZoomOnBeat && camZooming && FlxG.camera.zoom < maxCamZoom && curBeat % camZoomingInterval == 0)
        for (camera in [camNotes, camSustains, camStrums]){
            camera.zoom += 0.03 * camZoomingStrength;
        }

function onNoteCreation(event:NoteCreationEvent){
    var note = event.note;
    var line  = note.strumLine;
    
    note.cameras = [note.isSustainNote ? camSustains : camNotes];
    
    for (strum in line.members) {
        strum.cameras = [camStrums];
    }
}