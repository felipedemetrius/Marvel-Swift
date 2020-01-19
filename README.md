# Marvel-Swift

## Getting Started

1. Download or Clone the project
1. Open the terminal and navigate to the directory of project ```cd Marvel-Swift```
1. Install the Carthage. [How to install](https://github.com/Carthage/Carthage#installing-carthage)
1. Install Dependencies with Carthage ```carthage update --platform ios```
1. Open the workspace ```open Marvel-Swift.xcodeproj```

## Running modules

The project was divided into 2 modules. The first is SDKMarvel, which is the entire data provider layer. Run the SDK first to build the framework. The second is the app itself, Marvel-Swift. After you build SDKMarvel, you can run Marvel-Swift.

SDKMarvel has [documentation](https://gitlab.com/felipedemetrius/marvel-swift/blob/master/docs/sdk/index.html) available in ```<PathProject>/docs/sdk/index.html```. Documentation made with jazzy.

## Requirements

- iOS 10.0+ 
- Xcode 11.3+
- Swift 5.1+

## Unit Tests Coverage 

- SDKMarvel
    - 82,5%

- Marvel-Swift (App)
    - 27,6 %

