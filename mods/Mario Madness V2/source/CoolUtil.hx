import flixel.FlxG;
import flixel.math.FlxPoint;

import StringTools;

#if sys
import sys.FileSystem;
import sys.io.File;
#else
import openfl.utils.Assets;
#end

class CoolUtil {

    public static function centerWindowOnPoint(?point:FlxPoint) {
        Lib.application.window.x = Std.int(point.x - (Lib.application.window.width / 2));
        Lib.application.window.y = Std.int(point.y - (Lib.application.window.height / 2));
    }

    public static function getCenterWindowPoint():FlxPoint {
        return FlxPoint.get(
            Lib.application.window.x + (Lib.application.window.width / 2),
            Lib.application.window.y + (Lib.application.window.height / 2)
        );
    }
}