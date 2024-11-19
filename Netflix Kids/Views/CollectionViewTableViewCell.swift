//
//  CollectionViewTableViewCell.swift
//  Netflix Kids
//
//  Created by Mohammed Saidam on 12/09/2024.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell {
    
    
    weak var delegate :CollectionViewTableViewCellDelegate?
    
    static let identifier = "CollectionViewTableViewCell"
    var titles:[Title] =  [Title]()
    private let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200 )
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        
        return collectionView
    }()
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        
        return indicator
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
        contentView.addSubview(collectionView)
        contentView.addSubview(activityIndicator)
        //        New
        activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
        
        
    }
    public func configure(with titles :[Title ]){
        self.titles = titles
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
            
            
        }
        
    }
    public  func downloadTitleAt(indexPath : IndexPath){
        
        DataPersistenceManager.shard.downloadTitleWith(model: titles[indexPath.row]) { [weak self] results in
            switch results {
                
            case.success():
                NotificationCenter.default.post(name: NSNotification.Name("downloaded"), object: nil)
                
                
                //                NotificationCenter.default.post(name: NSNotification.Name("downloaded"), object: nil)
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    public func removeTitleAt(indexPath: IndexPath) {
        DataPersistenceManager.shard.deleteTitleBy(id: titles[indexPath.row].id) { result in
            switch result {
            case.success():
                NotificationCenter.default.post(name: NSNotification.Name("downloaded"), object: nil)
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
        //        DataPersistenceManager.shared.deleteTitleBy(id: titles[indexPath.row].id) { result in
        //            switch result {
        //            case .success():
        //                // reload downloads screen data
        //                NotificationCenter.default.post(name: NSNotification.Name("downloaded"), object: nil)
        //                // cell deki icon da burada güncellenebilir
        //            case .failure(let error):
        //                print(error.localizedDescription)
        //            }
        //        }
        //    }
        
    }
}
 
