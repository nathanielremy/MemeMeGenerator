//
//  DetailVC.swift
//  MemeMe
//
//  Created by Nathaniel Remy on 2017-06-06.
//  Copyright © 2017 Nathaniel Remy. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    //MARK: UI properties
    @IBOutlet weak var imageView: UIImageView!
    
    var meme: Meme?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
        
        if let meme = meme {
            imageView.image = meme.memedImage
        }
        
    }
}
