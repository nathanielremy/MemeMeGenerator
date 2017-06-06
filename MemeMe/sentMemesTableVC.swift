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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        configureBars()
        tableView.reloadData()
    }
    
    
    func configureBars() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New", style: .done, target: self, action: #selector(sentMemesTableVC.showMemeEditor))
        tabBarController?.tabBar.isHidden = false
    }
    
    func showMemeEditor() {
        guard let memeEditor = storyboard?.instantiateViewController(withIdentifier: "memeEditor") as? MemeEditorVC else { fatalError() }
        present(memeEditor, animated: true, completion: nil)
    }
    
    //MARK: Delegate & DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowCount = memes.count
        return rowCount
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "sentMemesTableCell") as? MemeTableViewCell else { fatalError() }
        
        cell.memeImageView.image = memes[indexPath.row].memedImage
        cell.memeTitlelLabel.text = memes[indexPath.row].fullText
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailVC else { print("NIIIILLLLL")
            return }
        detailVC.meme = memes[indexPath.row]
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
