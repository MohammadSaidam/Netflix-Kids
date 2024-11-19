//
//  extentionHomeViewController.swift
//  Netflix Kids
//
//  Created by Mohammed Saidam on 12/09/2024.
//

import Foundation
import UIKit

extension HomeViewController : UITableViewDelegate , UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath)as?CollectionViewTableViewCell else{
            return UITableViewCell()
        }
        cell.delegate = self
        
  
        switch indexPath.section {
           
        case Sections.TrendingMoviesCartoon.rawValue:
            APICaller.shared.getTrendingMovies { result in
             
                    switch result{
                    case .success(let titles):

                        cell.configure(with: titles)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                
           
            }
            
            
            
        case Sections.TrendingCartoonMediaAll.rawValue:
            APICaller.shared.getTrendingMoviesCatroon { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
           
        case Sections.PopularCartoon.rawValue:
            APICaller.shared.getPopularCartoon { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
            
            
            
            
        case Sections.Upcomping.rawValue:
            
            APICaller.shared.getUpComingCartoons { result in
                switch result{
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.DisneyCartoons.rawValue :
          
                APICaller.shared.getDisneyCatroon { result in
                    switch result {
                    case .success(let titles):
                        cell.configure(with: titles)
                    case.failure(let error):
                        print(error.localizedDescription)
                        
                    }
                }
            
        case Sections.TopRatedCartoon.rawValue:
          
                APICaller.shared.getTopRatedCartoons { result in
                    switch result{
                   
                    case .success(let titles):
                        cell.configure(with: titles)
                    case.failure(let error):
                        print(error.localizedDescription)
                    }
                    
                }
                
          
      
          
   
            
                
            
        
            
        default:
            return UITableViewCell()
        
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsTitles.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsTitles[section]
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else{
            return
        }
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizedFirstLetters()
    }
    
    
    // Scroll navigation Bar
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOfSet = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOfSet
        navigationController?.navigationBar.transform = .init(translationX: 0, y: -offset)
    }
   
    
}
enum Sections: Int {
    case TrendingMoviesCartoon = 0 // comedy
    case  TrendingCartoonMediaAll = 1 // advsnture
    case PopularCartoon = 2
    case Upcomping = 3
    case DisneyCartoons = 4
    case TopRatedCartoon = 5

 
}

extension HomeViewController :CollectionViewTableViewCellDelegate {
    func collectionViewTableViewCellTapClick(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async {[weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
       
    }
    
    
}
extension UIViewController{


 


}

