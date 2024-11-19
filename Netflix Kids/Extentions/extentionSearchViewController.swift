//
//  extentionSearchTableViewController.swift
//  Netflix Kids
//
//  Created by Mohammed M.Saidam on 03/11/2024.
//

import Foundation
import UIKit
extension SearchViewController :UITableViewDelegate ,UITableViewDataSource,UISearchResultsUpdating , SearchResultViewControllerDelegate {
    func SearchResultViewControllerDidTapItem(_ viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true )
        }
       
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultsController = searchController.searchResultsController as? SearchResultViewController else{return}
        resultsController.delegate = self
        APICaller.shared.search(with:query) { results in
            DispatchQueue.main.async {
                switch results {
                case .success(let titles):
                    resultsController.titles = titles
                    resultsController.searchResultCollectionView.reloadData()
                case.failure(let error):
                    print(error.localizedDescription)
                    
                }
            
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let title  = titles[indexPath.row ]
        
        guard let titleName = title.original_title ?? title.original_name else{return}
        APICaller.shared.getMovie(with: titleName) {[weak self] results in
            switch results {
            case .success(let videoElement):
                DispatchQueue.main.async {
                    let vc  = TitlePreviewViewController()
                    vc.configure(with: TitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: title.overview ?? "",titleModel: title))
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
                
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else{
            
            return UITableViewCell()
        }
        let titles = titles[indexPath.row]
        let model = TitleViewModel(titleName: titles.original_name ?? titles.original_title ?? "Unknown" , poster_URL: titles.poster_path ?? "")
        cell.configuration(with: model)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
}

