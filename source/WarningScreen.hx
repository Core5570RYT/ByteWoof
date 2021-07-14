package;

import flixel.FlxG;
import flixel.FlxSprite;
import flash.system.System;

class WarningScreen extends MusicBeatState
{
	var warning:FlxSprite;

	override function create()
	{
		warning = new FlxSprite(0,0).loadGraphic(Paths.image('someImage'));
		add(warning);

		super.create();
	}

	override function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.SPACE)
			{
				FlxG.switchState(new MainMenuState());
			}
		
		if (FlxG.keys.justPressed.D)
			{
				FlxG.save.data.dontshow = !FlxG.save.data.dontshow;
				FlxG.switchState(new MainMenuState());
			}
		if (FlxG.keys.justPressed.Q)
			{
				System.exit(0);
			}

		super.update(elapsed);
	}
}
