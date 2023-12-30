# MemeMe

MemeMe is an image-processing app that allows users to create, share and download custom memes from their phone. The goal of this app was to build a strong foundation in UIKit. It helped me get comfortable with navigation controllers, tab bar controllers, table views, collection views, image upload, camera access, and much more. This helped set the groundwork for more complex UIKit projects down the line.

<img src="/Images/img1.png" height="49%" width="30%"> <img src="/Images/img2.png" height="49%" width="30%"> <img src="/Images/img3.png" height="49%" width="30%">

# Implementation

**Containers:** The app opens onto a tab bar controller which allows users to view their memes in two modes -- a table view and a collection view. The view controllers are SentMemesTableView and SentMemesCollectionView. Users can also select a meme to get a more detailed view in MemeDetailVC. The tab bar segues to navigation controllers which provide a universal title for the two central views and an "add" button ("+") to create new memes.

**Meme editor:** Pressing the "+" button opens the meme editor, MemeEditorVC. Here, users can pick photos from their files or take new photos directly from the camera (if it exists). They can also add text to create their meme. Once they are happy with the result, they can press the save button, and the app will take a screenshot of their work and give them the option to share on social media. Records of all memes saved can be found through the tab bar controller.

# Future work
Some minor improvements to improve efficiency:
* Replace the two navigation controllers with a new root navigation controller that segues to the tab bar controller. This would help to eliminate redundancy and allow for more modularity.
* Create a single SentMemesVC class with the core functionality for the navigation controller and subclass it to create the separate UITableView and UICollectionView view controllers with their respective delegates.
* Write unit tests.

# Libraries and frameworks
UIKit

# Installation
Download the zip folder and open the file "MemeMe V2.0.xcodeproj" in Xcode.

# License

All code is original and was written by me. The project was developed as part of the iOS Developer Nanodegree Program, in accordance with the [project rubric](https://docs.google.com/document/d/1G2onkzN_weWmiYErhQJw1lB9-zxM-2TQ0N5bNMAaI7I/pub).
