//yashers code!!!
static var healthOverlay:FlxSprite;

function postCreate() {
    if(FlxG.save.data.callLuigi)
        healthOverlay = new FlxSprite(healthBarBG.x - 41, healthBarBG.y - 17).loadGraphic(Paths.image("game/healthbars/healthBarNEWluigi"));
    else
        healthOverlay = new FlxSprite(healthBarBG.x - 41, healthBarBG.y - 17).loadGraphic(Paths.image("game/hud/Mario Madness/healthBarBG"));
    healthOverlay.cameras = [camHUD];
    insert(members.indexOf(iconP1), healthOverlay);
    healthBarBG.visible = false;
}