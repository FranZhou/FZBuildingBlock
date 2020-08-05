# FZObserver

<!--
[![CI Status](https://img.shields.io/travis/FranZhou/FZObserver.svg?style=flat)](https://travis-ci.org/FranZhou/FZObserver)
[![Version](https://img.shields.io/cocoapods/v/FZObserver.svg?style=flat)](https://cocoapods.org/pods/FZObserver)
[![License](https://img.shields.io/cocoapods/l/FZObserver.svg?style=flat)](https://cocoapods.org/pods/FZObserver)
[![Platform](https://img.shields.io/cocoapods/p/FZObserver.svg?style=flat)](https://cocoapods.org/pods/FZObserver)
-->
## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

FZObserver is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'FZObserver'
```

## Directions for use

### The first way

observer define
```
var observer: FZObserver<UInt32?> = FZObserver(wrappedValue: nil)
```

we can addObserver like this
```
observer.addObserver(key: "addObserver", target: nil) { (change) in
    print("addObserver = old: \(String(describing: change.old)) -> new: \(String(describing: change.new))")
}
```

observer execute when value assign to observer's wrappedValue
```
observer.wrappedValue = arc4random()
```

###  The second way

observer define
```
/// we can get a property when we use @FZObserver,
/// It is: var _store: FZObserver<UInt32?>
@FZObserver var store: UInt32? = nil
```

```
_store.addObserver(key: "addObserver", target: nil) { (change) in
    print("addObserver = old: \(String(describing: change.old)) -> new: \(String(describing: change.new))")
}
```

observer execute when this happends
```
store = arc4random()
```

## Author

FranZhou, fairytale_zf@outlook.com

## License

FZObserver is available under the MIT license. See the LICENSE file for more info.
