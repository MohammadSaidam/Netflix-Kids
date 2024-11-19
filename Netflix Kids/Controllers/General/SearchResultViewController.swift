//
//  SearchResultViewController.swift
//  Netflix Kids
//
//  Created by Mohammed M.Saidam on 06/11/2024.
//

import UIKit

class SearchResultViewController: UIViewController {
    public var titles:[Title] = [Title]()

    weak var delegate : SearchResultViewControllerDelegate?
    public let searchResultCollectionView :UICollectionView =  {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        
        let collection = UICollectionView(frame: .zero,collectionViewLayout:layout)
        collection.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier:  TitleCollectionViewCell.identifier)
        
        return collection
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        view.addSubview(searchResultCollectionView)
        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultCollectionView.frame = view.bounds
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
