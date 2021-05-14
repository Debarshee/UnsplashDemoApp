# Project Name: UnsplashAppDemo

It is a replica of Unsplash App

## Implementation
1) Implemented MVVM Architecture
2) Implemented SwiftLynt to follow proper design guidelines 
3) Implemented Tab Bar Controller for Home Screen, Search Screen, AddImageScreen and Profile Screen
4) Implemented Generic Network layer using URLSession to get the data from the Unsplash API 
5) Implemented NSCache library to store Images in the local cache 

<p align="center">
<img src="https://i.imgur.com/GhiIf4e.gif" width="180" height="320"> 
</p>

## HomeScreen
1) Implemented horizontal collection View to show list of topics
2) Implemented table view to show photos based on the selected topic
3) Selecting a photo navigates to PhotoViewScreen

## PhotoViewScreen
1) Display the selected Photo from the Home Screen
2) Selecting info button pops up the PhotoInfoScreen

## PhotoInfoViewScreen
1) Display the information on the photo and the device used to capture the photo
2) Display location on Apple map, if available
3) Clicking User name navigates to UserDetailScreen

## UserDetailScreen
1) Display User profile image with user location and profile link
2) Implemented segmented control to show photos of the user, photos liked by user (if any), photo collection of the user (if any)
3) Implemented multi-cell to display different cell style for collections
4) Selecting a collection from the cell navigates to CollectionPhotosDisplayScreen

## SearchScreen
1) Implemented segmented control to display list of photos, collections and users
2) Implemented SearchBar to search for photos, users or collections based on the segmented control
3) Implemented multi-cell to display different cell style for collections and users
4) Selecting a collection from the cell navigates to CollectionPhotosDisplayScreen

## CollectionScreen
1) Implemented horizontal CollectionView to display list of collection

## API Reference
https://api.unsplash.com/


## Technologies

iOS 13.0 or above

Xcode 12.5

Swift 5

## Frameworks

UIKit
MapKit

## Supported Devices

iPhone SE (2nd gen)

iPhone 8 - 12 (All sizes supported)
