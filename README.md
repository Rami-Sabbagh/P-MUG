# P-MUG
[W.I.P] Pocket's Material User Graphical Interface library for LÖVE 0.10.1

## How to run the current demo:
Download the repository and run it using love 0.10.1 (extract it and run the folder with main.lua ..)

For android extract the repository and copy all the files in the main.lua folder and paste them in lovegame folder at the root of your sdcard, then run love 0.10.1 for android.

## Current list of features:
- Material design :3
- Supports Windows, Linux, OS X, iOS and Android
- Supports Multi-Touch
- Runs on LOVE 0.10.1
- Real circle buttons
- Objects are easy to create

## Current list of objects:
- Button
- Frame
- Text
- TextBox
- FAB Button
- Slider
- Spinner

## TODO List for first Pre-Release:
- ~~Create spinner object~~ Done 4/8/2016.
- ~~Create slider object~~ Done 1/8/2016.
- Create progress bar object
- Build smart sizing & positions system
- Write the customization functions for the objects
- Document the code
- Pre-Release the library

### Later TODO List:
- Create checkbox object
- Upgrade ContainerBase to support lists
- Create list object

## How objects are constructed in P-Mug:
Objects in PMug are made in a complex way that makes it easier to handler touch&mouse event.

Objects are consisted of 4 different classes:
- Shapes: They are like blocks to construct the building (The object).
- Handlers: They are responsible for handling the mouse, touch and keyboard events.
- Actions: Those are called by handlers, and they do the specific things objects have to do, like calling onClick function, or dragging the objects like in frames.
- Drawers: Those are responsible for drawing shapes, with custom styling applied.

> [View How button object made documentation](../master/HowButtonMade.md)
