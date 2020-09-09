# FZTheme

[![CI Status](https://img.shields.io/travis/FranZhou/FZTheme.svg?style=flat)](https://travis-ci.org/FranZhou/FZTheme)
[![Version](https://img.shields.io/cocoapods/v/FZTheme.svg?style=flat)](https://cocoapods.org/pods/FZTheme)
[![License](https://img.shields.io/cocoapods/l/FZTheme.svg?style=flat)](https://cocoapods.org/pods/FZTheme)
[![Platform](https://img.shields.io/cocoapods/p/FZTheme.svg?style=flat)](https://cocoapods.org/pods/FZTheme)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

FZTheme is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'FZTheme'
```

## instructions
1. switch theme style:
```
FZThemeManager.manager.switchCurrentTheme(to: .dark)
```

2. register theme loader:
```
FZThemeManager.manager.themeLoader { (style) -> (Bool, FZThemeMachineProtocol?)? in
            // true means it will cache themeMachine for the style
            // false means when style changed, it will enter here again
            return (true, DemoThemeMachine(themeStyle: style))
        }
```
3.bind UI like:
```
self.view.fz_theme.appearance { (view, style, themeMachine) in
            switch style{
            case .light:
                view.backgroundColor = UIColor.white
            case .dark:
                view.backgroundColor = UIColor.red
            case .custom(let _):
                view.backgroundColor = UIColor.green
            }
        }

```
if use theme machine, you can use it like this:
```
self.view.fz_theme.appearance { (view, style, themeMachine) in
            view.layer.contents = themeMachine?.themeImage(withIdentifier: "backgroundImage", themeStyle: style, defaultImage: nil)?.cgImage
        }
```
4. More to see Example Project


## Author

FranZhou, fairytale_zf@outlook.com

## License

FZTheme is available under the MIT license. See the LICENSE file for more info.
