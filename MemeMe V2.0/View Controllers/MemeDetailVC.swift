//
//  MemeDetailVC.swift
//  MemeMe V1.0
//
//  Created by admin on 9/28/20.
//  Copyright © 2020 Com.JeremyKievit. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailVC: UIViewController {
       
    var meme: Meme!
   
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    
    // MARK: App state

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
        self.imageView!.image = meme.memedImage
    }
       
    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.tabBarController?.tabBar.isHidden = false
    }
}
