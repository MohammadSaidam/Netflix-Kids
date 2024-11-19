//
//  extentionCollectionTableViewCell.swift
//  Netflix Kids
//
//  Created by Mohammed Saidam on 13/09/2024.
//

import Foundation
import UIKit
protocol CollectionViewTableViewCellDelegate : AnyObject{
    func collectionViewTableViewCellTapClick(_ cell :CollectionViewTableViewCell , viewModel: TitlePreviewViewModel)
    
}

extension CollectionViewTableViewCell : UICollectionViewDelegate , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:TitleCollectionViewCell.identifier  , for: indexPath) as? TitleCollectionViewCell else{
            return UICollectionViewCell()
        }
        guard let model =  titles[indexPath.row].poster_path else{return UICollectionViewCell()}
        cell.configure(model: model)
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        
        guard let titleName = title.original_title ?? title.original_name else{return}
        guard let titleOverview = title.overview else{return}
        APICaller.shared.getMovie(with: titleName + "trailer") { [weak self] results in
            switch results {
            case .success(let videoElemnt):
                //                let title = self.titles[indexPath.row].original_title
                
                let viewModel = TitlePreviewViewModel(title: titleName  , youtubeView: videoElemnt, titleOverview:titleOverview,titleModel: title)
                guard let StringSelf = self else{return}
                self?.delegate?.collectionViewTableViewCellTapClick(StringSelf, viewModel: viewModel)
            case.failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil,previewProvider: nil) {[weak self] _ in
            
            var action: UIAction?
            
            DataPersistenceManager.shard.isDownloaded(self?.titles[indexPath.row].id ?? 0) { result in
                switch result {
                case.success(let isDownloaded):
                    if isDownloaded{
                        action = UIAction(title: "Delete",
                                          image: nil,
                                          identifier: nil,
                                          discoverabilityTitle: nil,
                                          state: .off) { _ in
                            self?.removeTitleAt(indexPath: indexPath)
                        }
                        
                    }else{
                        action = UIAction(title: "Download",
                                          image: nil,
                                          identifier: nil,
                                          discoverabilityTitle: nil,
                                          state: .off) { _ in
                            self?.downloadTitleAt(indexPath: indexPath)
                        }
                    }
                case.failure(let error):
                    print(error.localizedDescription)
                    action = UIAction(title: "Download",
                                      image: nil,
                                      identifier: nil,
                                      discoverabilityTitle: nil,
                                      state: .off) { _ in
                        self?.downloadTitleAt(indexPath: indexPath)
                    }
                }
            }
                    
                    
                    return UIMenu(title: "",image: nil , identifier: nil , options: .displayInline,children: [action!] )
                
                
            }
        return config
            
            
        }
    }

    
    

