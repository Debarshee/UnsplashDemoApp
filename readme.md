# Project Name: UnsplashAppDemo

It is a replica of Unsplash App

## Implementation
1) Implemented MVVM Architecture
2) Implemented SwiftLynt to follow proper design guidelines 
3) Implemented Tab Bar Controller for Home Screen, Search Screen, AddImageScreen and Profile Screen
4) Implemented Generic Network layer using URLSession to get the data from the Unsplash API 
5) Implemented NSCache library to store Images in the local cache 
6) Implemented a separate storyboard for Login/Signup Screens
7) Implemented Firebase for the user related functionalities

<p align="center">
<img src="https://github.com/Debarshee/UnsplashDemoApp/blob/master/UnsplashDemoApp/Resources/Github%20Source/Simulator%20Screen%20Recording%20-%20iPhone%2011%20Pro%20Max%20-%202021-05-14%20at%2015.56.41.gif" width="180" height="320"> 
</p>

## HomeScreen
1) Implemented horizontal collection View to show list of topics
2) Implemented table view to show photos based on the selected topic
3) Selecting a photo navigates to PhotoViewScreen
4) Implemented pagination

## PhotoViewScreen
1) Display the selected Photo from the Home Screen
2) Selecting info button pops up the PhotoInfoScreen

## PhotoInfoViewScreen
1) Display the information on the photo and the device used to capture the photo
2) Display location on Apple map, if available
3) Clicking User name navigates to UserDetailScreen
4) Implement download image functionality and store it in the photo library

## UserDetailScreen
1) Display User profile image with user location and profile link
2) Implemented segmented control to show photos of the user, photos liked by user (if any), photo collection of the user (if any)
3) Implemented multi-cell to display different cell style for collections
4) Selecting a collection from the cell navigates to CollectionPhotosDisplayScreen
5) Implemented pagination

## SearchScreen
1) Implemented segmented control to display list of photos, collections and users
2) Implemented SearchBar to search for photos, users or collections based on the segmented control
3) Implemented multi-cell to display different cell style for collections and users
4) Selecting a collection from the cell navigates to CollectionPhotosDisplayScreen
5) Implemented pagination

## Collection Display Screen
1) Display all the photos in a collection
2) Selecting a photo navigates to Photo View Screen

## CollectionScreen (Third Tab)
1) Implemented horizontal CollectionView to display list of collection

## Login Screen
1) Implementing delegate in login screen to display the information of the user in user detail info screen

## Signup Screen
1) Implementing Signup screen

## API Reference
https://api.unsplash.com/


## Technologies

iOS 13.0 or above

Xcode 12.5

Swift 5

## Frameworks

UIKit
MapKit
Firebase

## Supported Devices

iPhone SE (2nd gen)

iPhone 8 - 12 (All sizes supported)
