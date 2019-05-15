import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxCamera;
import flixel.math.FlxPoint;

class Camera extends FlxCamera
{
	public var leading = FlxPoint.get();
	public var maxShiftTime = FlxPoint.get(0.001, 0.001);
	
	var desiredOffset = FlxPoint.get();
	
	public function new(x:Int = 0, y:Int = 0, width:Int = 0, height:Int = 0, zoom:Int = 0)
	{
		super(x, y, width, height, zoom);
	}
	
	inline public function followSpecial(target:FlxObject):Void
	{
		follow(target, 0);
	}
	
	inline public function updateFollowSpecial(elapsed:Float):Void
	{
		if (target.acceleration.x != 0 || target.acceleration.y != 0)
		{
			if (target.velocity.x > 0)
				desiredOffset.x =  leading.x;
			else if (target.velocity.x < 0)
				desiredOffset.x = -leading.x;
			else
				desiredOffset.x = 0;
			
			if (target.velocity.y > 0)
				desiredOffset.y =  leading.y;
			else if (target.velocity.y < 0)
				desiredOffset.y = -leading.y;
			else
				desiredOffset.y = 0;
		}
		
		if (desiredOffset.x > targetOffset.x)
		{
			// pan right
			targetOffset.x += leading.x * 2 / maxShiftTime.x * elapsed;
			trace(leading.x * 2 / maxShiftTime.x * elapsed);
			if (targetOffset.x > desiredOffset.x)
				targetOffset.x = desiredOffset.x;
		}
		else if (desiredOffset.x < targetOffset.x)
		{
			// pan left
			targetOffset.x -= leading.x * 2 / maxShiftTime.x * elapsed;
			if (targetOffset.x < desiredOffset.x)
				targetOffset.x = desiredOffset.x;
		}
		
		
		if (desiredOffset.y > targetOffset.y)
		{
			// pan down
			targetOffset.y += leading.y * 2 / maxShiftTime.y * elapsed;
			if (targetOffset.y > desiredOffset.y)
				targetOffset.y = desiredOffset.y;
		}
		else if (desiredOffset.y < targetOffset.y)
		{
			// pan up
			targetOffset.y -= leading.y * 2 / maxShiftTime.y * elapsed;
			if (targetOffset.y < desiredOffset.y)
				targetOffset.y = desiredOffset.y;
		}
	}
	
	inline static public function replace(camera:FlxCamera):Camera
	{
		var out = new Camera();
		out.copyFrom(camera);
		
		FlxG.camera = out;
		FlxG.cameras.add(out);
		if (FlxG.cameras.list.indexOf(camera) != -1)
			FlxG.cameras.remove(camera);
		
		return out;
	}
}