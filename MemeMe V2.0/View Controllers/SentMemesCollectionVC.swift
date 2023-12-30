//
//  SentMemesCollectionVC.swift
//  MemeMe V1.0
//
//  Created by admin on 9/26/20.
//  Copyright © 2020 Com.JeremyKievit. All rights reserved.
//

import Foundation
import UIKit

class SentMemesCollectionVC: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
     @IBAction func memeEditor() {
        let memeEditor = self.storyboard!.instantiateViewController(withIdentifier: "MemeEditorVC") as! MemeEditorVC
        present(memeEditor, animated: true, completion: nil)
     }
    
    
    // MARK: App state
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Flow layout
        let space:CGFloat = 3.0
        let frameWidth = (view.frame.size.width - (2 * space)) / 3.0
        let frameHeight = (view.frame.size.height - (2 * space)) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        
        // Orientation
        if let interfaceOrientation = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.windowScene?.interfaceOrientation {
          if interfaceOrientation.isLandscape {
              flowLayout.itemSize = CGSize(width: frameWidth, height: frameHeight)
          } else {
            flowLayout.itemSize = CGSize(width: frameWidth, height: frameHeight)
          }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadData), name: NSNotification.Name(rawValue: "reloadCollectionData"), object: nil)
    }
    
    
    //MARK: Fetch data
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    @objc func reloadData(notification: NSNotification) {
        self.collectionView.reloadData()
    }
    
    
    // MARK: Collection view delegate methods
    
    override func collectionView(_ tableView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCell", for: indexPath) as! MemeCell
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        cell.memeImage?.image = meme.memedImage

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailVC") as! MemeDetailVC
        detailController.meme = memes[(indexPath as NSIndexPath).row]
        navigationController!.pushViewController(detailController, animated: true)
    }
}
