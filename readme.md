# GAN Tech Test
BreakingBad client to show a list of characters and their details

[![codecov](https://codecov.io/gh/andecoder/GAN-BreakingBad/branch/main/graph/badge.svg?token=DS8QLJXBRX)](https://codecov.io/gh/andecoder/GAN-BreakingBad)

### Api Links
- https://breakingbadapi.com/api/characters

### Development Platform
- iOS 13.0 (Minimum deployment traget) and XCode 12.3
- Swift 5.3

### Targets
- BreakingBad - Main application target
- BreakingBadTests - Unit testing target
- BreakingBadSnapshotTests - Snapshot testing target

### Swift libraries
- PointFreeco.SnapshotTesting - To test the UI

### Instruction to run
- Download/Clone the project from URL or .Zip
- open BreakingBad.xcodeproj and run in the simulator or device

### Swift architecture
- The app has been written using a variation of Clean Swift design pattern and the principles of clean code.
- The main difference from Clean Swift is that I decided to put the router as a dependency of the interactor.

### Code Coverage
- Current code coverage is 87.7%

### Features
- The app is composed of 2 screens
- Screen 1 shows a list of Breaking Bad characters, a search bar, and a filtering view
- When the user taps on a character Screen 2 is shown which displays some details of the selected character
- When using the search functionality, tapping on a search result also directs the user to Screen 2
- On top of the basic requirements the app also does on-device caching of the images to decrease data consumption
