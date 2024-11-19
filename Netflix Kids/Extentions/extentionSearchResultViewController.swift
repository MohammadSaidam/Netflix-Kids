//
//  SearchResultViewController.swift
//  Netflix Kids
//
//  Created by Mohammed M.Saidam on 06/11/2024.
//

import Foundation
import UIKit

extension SearchResultViewController :UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            
            return UICollectionViewCell()
            
            
        }
        
        let titles = titles[indexPath.row]
        cell.configure(model: titles.poster_path ?? " ")
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let title = titles[indexPath.row]
        let titleName = title.original_title ?? ""
        APICaller.shared.getMovie(with: titleName) {[weak self] results in
            switch results {
            case .success(let videoElement):
                self?.delegate?.SearchResultViewControllerDidTapItem(TitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: title.overview ?? "",titleModel: title))
                
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
         
    }
    
    
    
    
    
}
protocol SearchResultViewControllerDelegate :AnyObject {
    func SearchResultViewControllerDidTapItem (_ viewModel :TitlePreviewViewModel)
    
}
