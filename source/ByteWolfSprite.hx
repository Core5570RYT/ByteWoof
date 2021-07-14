package;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class CoolSettings
{
	
	public var x(default, null):Int;
	public var y(default, null):Int;
	public var scale(default, null):Float;
	public var flipped(default, null):Bool;

	public function new(x:Int = 0, y:Int = 0, scale:Float = 1.0, flipped:Bool = false)
	{
		this.x = x;
		this.y = y;
		this.scale = scale;
		this.flipped = flipped;
	}
}

class ByteWolfSprite extends FlxSprite
{
	public var holdTimer:Float = 0;

	private static var settings:Map<String, CoolSettings> = [
		'idle' => new CoolSettings(3, -40, 0, false),
		'singUP' => new CoolSettings(10, -36, 0, false),
		'singRIGHT' => new CoolSettings(-16, -36, 0, false),
		'singDOWN' => new CoolSettings(10, -42, 0, false),
		'singLEFT' => new CoolSettings(-5, -37, 0, false),
		'byteHey' => new CoolSettings(3, 30, 0, false)
	];

	private var flipped:Bool = false;

	public function new(x:Int, y:Int, scale:Float, flipped:Bool)
	{
		super(x, y);
		this.flipped = flipped;

		antialiasing = true;

		frames = Paths.getSparrowAtlas('ByteWolf');

		animation.addByPrefix('idle', 'Byte idle dance', 24);
		animation.addByPrefix('singUP', 'Byte Sing anim up', 24);
		animation.addByPrefix('singRIGHT', 'Byte Sing anim right', 24);
		animation.addByPrefix('singDOWN', 'Byte Sing anim down', 24);
		animation.addByPrefix('singLEFT', 'Byte Sing anim left', 24);
		animation.addByPrefix('byteHey', 'Byte hey anim', 24);
		animation.play('idle');

		setGraphicSize(Std.int(width * scale));
		updateHitbox();
	}

	public function setSprite(character:String):Void
	{
		if (character == '')
		{
			visible = false;
			return;
		}
		else
		{
			visible = true;
		}

		animation.play(character);

		var setting:CoolSettings = settings[character];
		offset.set(setting.x, setting.y);
		setGraphicSize(Std.int(width * setting.scale));
		flipX = setting.flipped != flipped;
	}

	function playAnim(animationName:String) {
		animation.play(animationName);
	}

	override function update(elapsed:Float) {
		if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}
	}
}
