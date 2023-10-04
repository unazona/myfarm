package pattern;

/**
	Factory pattern
**/
class Item<T> {
    public static function create<T>():Item<T> {
      return new Item<T>();
    }
    
    public var value:T;
  
    private function new () {}
}