package;

//import js.html.svg.Number;
import haxe.Timer;
import Controls.KeyboardScheme;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import io.newgrounds.NG;
import lime.app.Application;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class MainMenuState extends MusicBeatState
{
	var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;
	var menaItems:FlxTypedGroup<FlxSprite>;

	#if !switch
	var optionShit:Array<String> = ['story mode', 'freeplay', 'options'];
	#else
	var optionShit:Array<String> = ['story mode', 'freeplay'];
	#end

	var newGaming:FlxText;
	var newGaming2:FlxText;
	var newInput:Bool = true;
	var gfDance:FlxSprite;
	var bfIdleTitle:FlxSprite;
	var bytetitle:FlxSprite;
	var logoBl:FlxSprite;
	var menuItem:FlxSprite;
	//var danceLeft:Bool = true;
	var bg:FlxSprite;
	var bg1:FlxSprite;
	var magenta:FlxSprite;
	var menuItemDefaultX:Float;

	public static var nightly:String = "";

	public static var kadeEngineVer:String = "1.4.2" + nightly;
	public static var gameVer:String = "V.S ByteWolf V.0.2.7";

	var camFollow:FlxObject;
	override function create()
	{
		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end
		Conductor.changeBPM(110);
		persistentUpdate = true;
		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		persistentUpdate = persistentDraw = true;

		bg = new FlxSprite(-80).loadGraphic(Paths.image('menuBG'));
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.15;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

/*		bg1 = new FlxSprite(-80).loadGraphic(Paths.image('freeplayBlur'));
		bg1.scrollFactor.x = 0;
		bg1.scrollFactor.y = 0.15;
		bg1.setGraphicSize(Std.int(bg1.width * 1.1));
		bg1.updateHitbox();
		bg1.screenCenter();
		bg1.antialiasing = true;
		add(bg1);*/

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		magenta.scrollFactor.x = 0;
		magenta.scrollFactor.y = 0.15;
		magenta.setGraphicSize(Std.int(magenta.width * 1.1));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = true;
		magenta.color = 0xFFfd719b;
		add(magenta);
		// magenta.scrollFactor.set();

		logoBl = new FlxSprite(-150, -100);
		logoBl.frames = Paths.getSparrowAtlas('logoBumpin');
		logoBl.antialiasing = true;
		logoBl.animation.addByPrefix('bump', 'logo bumpin', 24);
		//logoBl.animation.play('bump');
		logoBl.updateHitbox();

		gfDance = new FlxSprite(FlxG.width * 0.4, FlxG.height * 0.07);
		gfDance.frames = Paths.getSparrowAtlas('gfDanceTitle');
		gfDance.animation.addByIndices('danceLeft', 'gfDance', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
		gfDance.animation.addByIndices('danceRight', 'gfDance', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
		gfDance.setGraphicSize(Std.int(gfDance.width * 0.7));
		gfDance.animation.play('danceLeft');
		gfDance.scrollFactor.x = 0;
		gfDance.scrollFactor.y = 0.15;
		gfDance.antialiasing = true;
		add(gfDance);

		bfIdleTitle = new FlxSprite(FlxG.width * 0.7, FlxG.height * 0.4);
		bfIdleTitle.frames = Paths.getSparrowAtlas('boipren');
		bfIdleTitle.antialiasing = true;
		bfIdleTitle.animation.addByPrefix('idle', 'BF idle dance', 24);
		bfIdleTitle.setGraphicSize(Std.int(bfIdleTitle.width * 0.7));
		bfIdleTitle.animation.play('idle');
		//bfIdleTitle.flipX = true;
		bfIdleTitle.scrollFactor.x = 0;
		bfIdleTitle.scrollFactor.y = 0.15;
		add(bfIdleTitle);
		//add(logoBl);

		bytetitle = new FlxSprite(FlxG.width * 0.3, FlxG.height * 0.05);
		bytetitle.frames = Paths.getSparrowAtlas('ByteWolf');
		bytetitle.antialiasing = true;
		bytetitle.animation.addByPrefix('idle', 'Byte idle dance', 24);
		bytetitle.setGraphicSize(Std.int(bfIdleTitle.width * 0.64));
		bytetitle.animation.play('idle');
		bytetitle.scrollFactor.x = 0;
		bytetitle.scrollFactor.y = 0.15;
		add(bytetitle);

		bytetitle.x += 50;
		bytetitle.alpha = 0;

		bfIdleTitle.x += 50;
		bfIdleTitle.alpha = 0;

		gfDance.x += 50;
		gfDance.alpha = 0;
		
		FlxTween.tween(bytetitle, {x: bytetitle.x - 50, alpha: 1}, 1, {ease: FlxEase.circOut, startDelay: 0.3 });
		FlxTween.tween(gfDance, {x: gfDance.x - 50, alpha: 1}, 1, {ease: FlxEase.circOut, startDelay: 0.3});
		FlxTween.tween(bfIdleTitle, {x: bfIdleTitle.x - 50, alpha: 1}, 1, {ease: FlxEase.circOut, startDelay: 0.3});
/*		if (optionShit[curSelected] == 'story menu')
			{
				bg.visible = true;
				bg1.visible = false;
				magenta.visible = false;
			} else if (optionShit[curSelected] == 'freeplay')
				{
					bg.visible = false;
					bg1.visible = true;
					magenta.visible = false;
				} else if (optionShit[curSelected] == 'options')
					{
						bg.visible = false;
						bg1.visible = false;
						magenta.visible = true;
					}*/

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		//menaItems = new FlxTypedGroup<FlxSprite>();
		//add(menaItems);

		var tex = Paths.getSparrowAtlas('FNF_main_menu_assets');

		for (i in 0...optionShit.length)
		{
			menuItem = new FlxSprite(50, 390 + (i * 100));
			menuItemDefaultX = 50;
			menuItem.frames = tex;
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.setGraphicSize(Std.int(menuItem.width * 0.7));
			//menuItem.x = 0.6;
			menuItem.updateHitbox();
			menuItem.ID = i;
			menuItems.add(menuItem);
			menuItem.scrollFactor.set(0,0);
			menuItem.antialiasing = true;

			menuItem.x -= 50;
			menuItem.alpha = 0;
			FlxTween.tween(menuItem, {x: menuItem.x + 50, alpha: 1}, 1, {ease: FlxEase.circOut, startDelay: 0.5 + (0.2 * i)});
		}


		FlxG.camera.follow(camFollow, null, 0.60 * (60 / FlxG.save.data.fpsCap));

		var versionShit:FlxText = new FlxText(5, FlxG.height - 18, 0, gameVer +  (Main.watermarks ? " - " + kadeEngineVer + " Kade Engine" : ""), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();


		if (FlxG.save.data.dfjk)
			controls.setKeyboardScheme(KeyboardScheme.Solo, true);
		else
			controls.setKeyboardScheme(KeyboardScheme.Duo(true), true);

		changeItem();

		super.create();
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.save.data.fullmodescreen)
			FlxG.fullscreen = true;
		else if (!FlxG.save.data.fullmodescreen)
			FlxG.fullscreen = false;

		if (FlxG.save.data.bytesave)
			if (FlxG.keys.justPressed.B)
				FlxG.switchState(new ByteBeep());

		if (optionShit[curSelected] == 'story mode')
			{
				bg.loadGraphic(Paths.image('menuBG'));
			} 
		if (optionShit[curSelected] == 'freeplay')
			{
				bg.loadGraphic(Paths.image('freeplayBlur'));
			} else if (optionShit[curSelected] == 'options')
				{
					bg.loadGraphic(Paths.image('menuDesat'));
				}

		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}
		//danceLeft = !danceLeft;

		if (gfDance.animation.curAnim.name == 'danceLeft' && gfDance.animation.curAnim.finished)
		{
			gfDance.animation.play('danceRight');
		}else if (gfDance.animation.curAnim.name == 'danceRight' && gfDance.animation.curAnim.finished){
				gfDance.animation.play('danceLeft');
			}

		if (!selectedSomethin)
		{
			if (controls.UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				FlxG.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				if (optionShit[curSelected] == 'options')
					{
						FlxG.sound.pause();
						FlxG.sound.play(Paths.sound('confirmMenu'));
					}

				if (optionShit[curSelected] == 'donate')
				{
					#if linux
					Sys.command('/usr/bin/xdg-open', ["https://www.kickstarter.com/projects/funkin/friday-night-funkin-the-full-ass-game", "&"]);
					#else
					FlxG.openURL('https://www.kickstarter.com/projects/funkin/friday-night-funkin-the-full-ass-game');
					#end
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));
					
					if (FlxG.save.data.flashing)
						FlxFlicker.flicker(magenta, 1.1, 0.15, false);

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {x: spr.x - 50}, 1.3, {ease: FlxEase.circOut, onComplete: function(twn:FlxTween){}});
							FlxTween.tween(spr, {alpha: 0}, 1.3, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});

							FlxTween.tween(bytetitle, {x: bytetitle.x + 50, alpha: 0}, 1, {ease: FlxEase.circOut, onComplete: function(twn:FlxTween){}});
							FlxTween.tween(gfDance, {x: gfDance.x + 50, alpha: 0}, 1, {ease: FlxEase.circOut, onComplete: function(twn:FlxTween){}});
							FlxTween.tween(bfIdleTitle, {x: bfIdleTitle.x + 50, alpha: 0}, 1, {ease: FlxEase.circOut, onComplete: function(twn:FlxTween){}});
							new FlxTimer().start(1, function(tmr:FlxTimer)
								{
									//goToState();
									FlxTween.tween(bg, {y: bg.y + 720, alpha: 0}, 2, {ease: FlxEase.circIn, onComplete: function(twn:FlxTween){goToState();}});
								});
						}
						else
						{
							if (FlxG.save.data.flashing)
							{
								new FlxTimer().start(1, function(tmr:FlxTimer)
									{
										FlxTween.tween(spr, {alpha: 0}, 1, {ease: FlxEase.circOut,
											onComplete: function(twn:FlxTween){

											}});
									});

								FlxFlicker.flicker(spr, 2, 0.06, false, false, function(flick:FlxFlicker)
								{
									goToState();
								});
							}
							else
							{
								new FlxTimer().start(2, function(tmr:FlxTimer)
								{
									goToState();
								});
							}
						}
					});
				}
			}
		}

		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
		{
			//spr.screenCenter(X);
		});
	}
	
	function goToState()
	{
		var daChoice:String = optionShit[curSelected];

		switch (daChoice)
		{
			case 'story mode':
				FlxG.switchState(new StoryMenuState());
				trace("Story Menu Selected");
			case 'freeplay':
				FlxG.switchState(new FreeplayState());

				trace("Freeplay Menu Selected");

			case 'options':
				FlxG.switchState(new OptionsMenu());
		}
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				//camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);
				camFollow.setPosition(spr.getGraphicMidpoint().y, spr.getGraphicMidpoint().y);
			}

			spr.updateHitbox();
		});
	}
}
