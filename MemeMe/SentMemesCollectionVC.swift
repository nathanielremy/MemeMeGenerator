//
//  SentMemesCollectionVC.swift
//  MemeMe
//
//  Created by Nathaniel Remy on 2017-06-06.
//  Copyright © 2017 Nathaniel Remy. All rights reserved.
//

import UIKit

class SentMemesCollectionVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: UI properties
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionFlow: UICollectionViewFlowLayout!
    
    var memes = [Meme]()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        setUpFlowLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        configureBars()
        collectionView.reloadData()
    }
    
    func setUpFlowLayout() {
        //Set the size and dimension of the collection view cells
        let space: CGFloat = 3.0
        let widthDimension = (view.frame.size.width - (2 * space)) / 3.0
        let heightDimension = (view.frame.size.height - (2 * space)) / 3.0
        
        collectionFlow.minimumInteritemSpacing = space
        collectionFlow.minimumLineSpacing = space
        collectionFlow.itemSize = CGSize(width: widthDimension, height: heightDimension)
    }
    
    func configureBars() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New", style: .done, target: self, action: #selector(SentMemesCollectionVC.showMemeEditor))
        tabBarController?.tabBar.isHidden = false
    }
    
    func showMemeEditor() {
        guard let memeEditor = storyboard?.instantiateViewController(withIdentifier: "memeEditor") as? MemeEditorVC else { fatalError() }
        present(memeEditor, animated: true, completion: nil)
    }

    //MARK: Delegate & DataSource Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let itemCount = memes.count
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sentMemesCollectionViewCell", for: indexPath) as? MemeCollectionViewCell else { fatalError() }
        cell.imageView.image = memes[indexPath.row].memedImage
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailVC else { fatalError() }
        
        detailVC.meme = memes[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
}
