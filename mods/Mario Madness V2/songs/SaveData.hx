var data = FlxG.save.data;
var curSong = PlayState.instance.curSong.toLowerCase();
function onSongEnd(){
   if (curSong == "starman-slaughter" && PlayState.isStoryMode){
     data.storySave = 1;
   }
   trace("Story progression = " +  data.storySave);
}