# QML-zig

Bindings are based on [DOtherSide](https://github.com/filcuc/dotherside) C bindings for QML Library is mostly feature-compliant with other bindings based on the library, but lacks some minor features and has quite a few bugs.

# Preview:
![qml_zig](https://user-images.githubusercontent.com/6756180/102698635-a5518500-421d-11eb-8705-98013d2328d7.jpg)

# Status:

Initial

# Examples

`zig build Animated` - Run an Animated Box

`zig build Hello` - Hello World, with Menu and Clickable Button

`zig build Basic` - super basic Hello World

`zig build Cells` - Cells example from QML Tute, click a color to change the text

`zig build Button` - Button with 2-way comms to the Zig code

`zig build Layouts` - Layouts examples

# Work in Progres Examples

`zig build Particle` - Particle system example
- Needs QObject wrapper working yet, to pass zig objects to the QML side
