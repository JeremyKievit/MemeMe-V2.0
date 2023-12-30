# MemeMe

Meme is an image processing app that allows users to create, share and download custom memes on their phone. This project helped me build a strong foundation in UIKit. It helped me get comfortable with navigation controllers, tab bar controllers, table views, collection views, image upload, camera access, and much more. This helped set the groundwork for more complex projects down the line.

<img src="/Images/img1.png" height="49%" width="30%"> <img src="/Images/img2.png" height="49%" width="30%"> <img src="/Images/img3.png" height="49%" width="30%">

# Implementation

**Conttainers:** The app opens onto a tab bar conroller which offers two modes to view the memes which were downloaded to the app -- a table view and a collection view. The tab bar segues to navigation controllers whch give the universal title the two central views and an "add" button ("+") to create new memes.

**Meme editor:** Pressing the "+" button opens the meme editor. Here, users can pick photos form their files or take new photos directlty from the camera. They can also add text to create their meme. Once they are happy with the result, they can press the save button and the app will take a screenshot of their work and give them the option to share on social media. Records of all memes saved can be found thorough the tab bar controller.

# Libraries and frameworks
UIKit

# Installation
Download the zip folder and open the file "MemeMe V2.0.xcodeproj" in Xcode.

# Future work

* Replace the two navigation controllers with a new root navigation controller that segues to the tab bar controller. This would help to eliminate redundancy and allow for more modularity for future improvements.
* Create a single SentMemesVC class with the core functionality for the navigation controller and extend it to create the separate UITableView and UICollectionView view controllers.
* Write unit tests.

# License

All code is original and was written by me. The project was developed as part of the iOS Developer Nanodegree Program, in accordance with the [project rubric](https://docs.google.com/document/d/1G2onkzN_weWmiYErhQJw1lB9-zxM-2TQ0N5bNMAaI7I/pub).
