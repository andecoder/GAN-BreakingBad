# GAN Tech Test
Create a Breaking Bad character explorer

## Requirements
The app must have the following screens
- A list of Breaking Bad characters
- Details about the selected character

### Screen specific requirements
**Screen 1**
- Must display at least the character name and image
- Selecting a character transitions the user to screen 2
- The user should be able to search for a character name
- The user should be able to filter by season appearance

**Screen 2**
- User should be able to go back to screen 1
- Should present the following information about the character
  - Image
  - Name
  - Occupation
  - Status
  - Nickname
  - Season appearance

### API Endpoint
- https://breakingbadapi.com/api/characters

### Notes
- The use of 3rd party libraries is accepted where needed. Reasons for usage might be requested
- It is expected to have written as many tests as considered necessary
- Layout is up to me

### Additional functionality
- When using the search functionality, tapping on a search result also directs the user to Screen 2
- On top of the basic requirements the app also does on-device caching of the images to decrease data consumption

## Solution
### UI design
<img src="https://i.ibb.co/L6sxKws/1-loading.png" width=150 />  <img src="https://i.ibb.co/S0BKNs3/2-Characters-loaded.png" width=150 />  <img src="https://i.ibb.co/7psTLqs/3-Filter-applied.png" width=150 />  <img src="https://i.ibb.co/0DsKk8b/3-Search.png" width=150 /> <img src="https://i.ibb.co/BLbMxV6/4-Character-s-details.png" width=150 />

### Development Environment
- Xcode 12.3
- Swift 5.3
- **Minimum deployment target**: iOS 13.0

### Running the app
- Clone the project using your preferred method
- Open **BreakingBad.xcodeproj**
- Select the **BreakingBad** target and a device with iOS 13+
- Run the project in Xcode

### Project Targets
- **BreakingBad**: Can be used to run the application or all the tests
- **BreakingBadTests**: Use this to run only unit tests
- **BreakingBadSnapshotTests** - Use this to run only Snapshot tests

### 3rd Party Dependencies
There is only one 3rd party dependency in the project and it has been installed using SPM
- **PointFreeco's SnapshotTesting**: Used to take snapshots of the view states

### Code structure
The app has been written with the principles of clean code and is logically divided into 4 groups
<img src="https://i.ibb.co/pLHZWwx/Breaking-Bad.png" />

On the presentation layer I have select *Clean Swift* as the design pattern responsible for creating the views and interacting with the required data.

**Note:**
- I am using my personal variation of the *Clean Swift* design pattern which has the router as a dependency of the interactor instead of the view.

### Code Coverage
- Current code coverage is **87.7%**
