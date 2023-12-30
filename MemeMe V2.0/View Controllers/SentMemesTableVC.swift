//
//  SentMemesTableVC.swift
//  MemeMe V1.0
//
//  Created by admin on 9/25/20.
//  Copyright © 2020 Com.JeremyKievit. All rights reserved.
//

import Foundation
import UIKit

class SentMemesTableVC: UITableViewController {
    
     @IBAction func memeEditor() {
        let memeEditor = self.storyboard!.instantiateViewController(withIdentifier: "MemeEditorVC") as! MemeEditorVC
        present(memeEditor, animated: true, completion: nil)
     }
    
    
    // MARK: App state
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadData), name: NSNotification.Name(rawValue: "reloadTableData"), object: nil)
    }
    
    
    // MARK: Fetch data
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    @objc func reloadData(notification: NSNotification) {
        self.tableView.reloadData()
    }
    
    
    // MARK: Table view delegate methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell", for: indexPath)
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        cell.imageView?.image = meme.memedImage
        cell.textLabel?.text = meme.topText
        
        if let detailTextLabel = cell.detailTextLabel {
            detailTextLabel.text = "\(meme.bottomText)"
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Grab the DetailVC from Storyboard
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailVC") as! MemeDetailVC

        //Populate view controller with data from the selected item
        detailController.meme = memes[(indexPath as NSIndexPath).row]

        // Present the view controller using navigation
        navigationController!.pushViewController(detailController, animated: true)
    }
}

