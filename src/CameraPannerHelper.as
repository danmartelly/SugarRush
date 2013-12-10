package
{
	import flash.geom.Point;
	
	import org.flixel.*;
	
	public class CameraPannerHelper extends FlxSprite
	{
		public var end:FlxPoint;
		public var speed:Number;
		
		public function CameraPannerHelper(start:FlxPoint, end:FlxPoint, speed:Number = .005)
		{
			super(start.x, start.y);
			this.visible = false;
			this.end = end;
			this.speed = speed;
		}
		
		override public function update():void {
			var selfPoint:Point = new Point();
			this.getMidpoint().copyToFlash(selfPoint);
			var endPoint:Point = new Point();
			end.copyToFlash(endPoint);
			var vectorToEnd:Point = endPoint.subtract(selfPoint);
			var distance:Number = vectorToEnd.length;
			vectorToEnd.normalize(speed*distance*distance);
			velocity.copyFromFlash(vectorToEnd);
		}
	}
}