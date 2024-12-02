//
//  ExxtentionsUpComingViewController.swift
//  Netflix Kids
//
//  Created by Mohammed M.Saidam on 02/11/2024.
//

import Foundation
import UIKit

extension UpComingViewController:UITableViewDataSource,UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return titles.count
        }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier,for: indexPath) as? TitleTableViewCell else{
    
    
                return UITableViewCell()
            }
            let title = titles[indexPath.row]
    
            cell.configuration(with: TitleViewModel(titleName: title.original_title ?? title.original_name ?? "unknwon title name", poster_URL: title.poster_path ?? ""))
    
            return cell
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 150
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
                    vc.configure(with: TitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: title.overview ?? "No content!",titleModel: title))
                    vc.modalPresentationStyle = .fullScreen
                    self?.present(vc, animated: true)
                }
                
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    
    
    
    }

