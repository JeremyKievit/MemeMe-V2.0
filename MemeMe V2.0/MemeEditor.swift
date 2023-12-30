//
//  MemeEditor.swift
//  MemeMe V1.0
//
//  Created by admin on 9/7/20.
//  Copyright © 2020 Com.JeremyKievit. All rights reserved.
//

import Foundation
import UIKit

func save() {
            let meme = Meme(topText: textFieldTop.text!, bottomText: textFieldBottom.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())
    }
