//
//  sentMemesTableVC.swift
//  MemeMe
//
//  Created by Nathaniel Remy on 2017-06-06.
//  Copyright © 2017 Nathaniel Remy. All rights reserved.
//

import UIKit

class sentMemesTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: UI Properties
    @IBOutlet weak var tableView: UITableView!
    
    var memes = [Meme]()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        print("Apper")
        configureBarButtonItem()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    func configureBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .done, target: self, action: #selector(sentMemesTableVC.showMemeEditor))
    }
    
    func showMemeEditor() {
        guard let memeEditor = storyboard?.instantiateViewController(withIdentifier: "memeEditor") as? MemeEditorVC else { fatalError() }
        present(memeEditor, animated: true, completion: nil)
    }
    
    //MARK: Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("NumberOfRowsInSection")
        
        let rowCount = memes.count
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "sentVillainsTableCell") as? MemeTableViewCell else { fatalError() }
        
        print("Cell For Row At")
        cell.memeImageView.image = memes[indexPath.row].memedImage
        cell.memeTitlelLabel.text = memes[indexPath.row].fullText
        
        return cell
    }
}
