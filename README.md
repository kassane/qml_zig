# QML-zig
![GitHub All Releases](https://img.shields.io/github/downloads/kassane/qml_zig/total?style=flat-square) ![GitHub release (latest by date)](https://img.shields.io/github/v/release/kassane/qml_zig?style=flat-square) ![GitHub](https://img.shields.io/github/license/kassane/qml_zig?style=flat-square)

Bindings are based on [DOtherSide](https://github.com/filcuc/dotherside) C bindings for QML Library is mostly feature-compliant with other bindings based on the library, but lacks some minor features and has quite a few bugs.

# Preview
![qml_zig](https://user-images.githubusercontent.com/6756180/102698635-a5518500-421d-11eb-8705-98013d2328d7.jpg)

# Build - Steps

## Requirements

All software required for building.

- Qt 5.15 or higher
- Zig v0.11.0 or higher
- CMake v3.2 or higher (DOtherSide build)

### Question

#### Works on Qt6?

Maybe, check [DOtherSide](https://github.com/filcuc/dotherside) support!!

## Instructions

~~~bash
# Clone repo
git clone --recursive https://github.com/kassane/qml_zig

# Open folder
cd qml_zig

# build DOtherSide
zig build cmake

# Build
zig build ExampleName -Doptimize=ReleaseSafe|-Doptimize=ReleaseFast|-Doptimize=ReleaseSmall
~~~

# Examples

`zig build Animated` - Run an Animated Box

`zig build Hello` - Hello World, with Menu and Clickable Button

`zig build Cells` - Cells example from QML Tute, click a color to change the text

`zig build Button` - Button with 2-way comms to the Zig code

`zig build Layouts` - Layouts examples

`zig build Splits` - Splitview example

`zig build Tables` - Tableview example

# Work in Progres Examples

`zig build Particle` - Particle system example
- Needs QObject wrapper working yet, to pass zig objects to the QML side

# Status

- Basic initialization and execution
- More Examples - thanks [@zigster64](https://github.com/zigster64)!
- Providing properties to QML files

# TODO

- [ ] QAbstractListModels
- [ ] QObject - **working progress**
- [ ] QStyle
