# zwo_achtundvierzig

[![CircleCI](https://circleci.com/gh/jeyemwey/zwo_achtundvierzig.svg?style=svg)](https://circleci.com/gh/jeyemwey/zwo_achtundvierzig)

A implementation of the [2048 game](https://play2048.co/) in flutter including a history that will be used to train a neural network.

## Contributing

You are more than welcome to help me out in this project. Open points are:

-   [ ] **Flutter**: Remove/Don't save history entries that did not change the board. (i.e. all tiles are on the left side and the user swipes to the left again)
-   [ ] **Flutter**: Preserve Game State (gameboard, score, history) over app quits
-   [ ] **Flutter**: Animations in any way, shape or form (you're welcome to do whatever you want, please be creative)
-   [ ] **Golang**: A backend server that saves the history items so we can train a neural network with it
-   [ ] **Python**: A neural network training facility that tells you what to do based on a gameboard.

Please format your code before submitting it, just to save some hassle. Adding unit tests would be great, too, but I can do that if you don't know what it means.

## Getting Started

A few resources to get you started if this is your first Flutter project:

-   [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
-   [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
