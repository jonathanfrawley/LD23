package
{
    import org.flixel.*;
    [SWF(width="640", height="480", backgroundColor="#000000")] //Set the size and color of the Flash file
    [Frame(factoryClass="Preloader")]

    public class Game extends FlxGame
    {
        public function Game()
        {
            super(640,480,PlayState,1);
//            super(640,480,SplashState,1);
//            forceDebugger = true;
        }
    }
}
