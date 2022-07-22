# TV Guide App

This is an app where a user can see all shows available on TVMaze API. On the first screen, besided the list containing the poster and show name, the user can search for shows.
After selecting a show, we'll display some basic info, like the poster, show name, air time and days and summary. The full episode list, separated by seasons will be shown after a brief loading.
User can also see more details from a specific episode, just need to tap on it on the episode list.

## Getting Started

This project uses CocoaPods to manage third party dependencies. To make it easier, all pods are already included on the project. The libraries used are:
- R.swift, to make it easier to reference assets
- Kingfisher, for image loading and cache
- RxSwift and RxCocoa, to create the binding between data on the View Model and View
- RxDataSources, to create reactive data sources for UITableViews
If pods needed to be reinstalled, just open the terminal, go to the project folder and run pod --install. If cocoapods is not installed on the machine, instructions can be found at https://guides.cocoapods.org/using/getting-started.html

To run the app, just clone the repository and use the develop branch. Since this project uses CocoaPods. you need to open the TV Guide.xcworkspace file on Xcode and not the .xcodeproject file. After opening it, just run the app using the chosen simulator/device. 
