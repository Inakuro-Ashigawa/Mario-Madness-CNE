import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

class BGSprite extends FlxSprite
{
	private var idleAnim:String;

	public function new(image:String, x:Float = 0, y:Float = 0, ?scrollX:Float = 1, ?scrollY:Float = 1, ?animArray:Array<String> = null, ?loop:Bool = false)
	{
		super(x, y);

		this.x = x;
        this.y = y;


		if (animArray != null && animArray.length > 0)
		{
			// Load sprite atlas frames
			var atlasFrames = Paths.getFrames(image);
			if (atlasFrames != null)
			{
				frames = atlasFrames;
				// Add animations from animArray
				for (anim in animArray)
				{
					animation.addByPrefix(anim, anim, 24, loop);
					if (idleAnim == null)
					{
						idleAnim = anim;
					}
				}
				// Play the first animation by default
				if (idleAnim != null)
				{
					animation.play(idleAnim);
				}
			}
			else
			{
				trace("Error: Frames not found for image: " + image);
			}
		}
		else if (image != null)
		{
			// Load static graphic if no animations are defined
			loadGraphic(Paths.image(image));
			active = false;
		}
		else
		{
			trace("Error: No image or animations provided.");
		}

		// Set scroll factor
		scrollFactor.set(scrollX, scrollY);
	}

	public function create(?forceplay:Bool = false)
	{
		// Play the idle animation if it exists
		if (idleAnim != null)
		{
			animation.play(idleAnim, forceplay);
		}
	}
}
