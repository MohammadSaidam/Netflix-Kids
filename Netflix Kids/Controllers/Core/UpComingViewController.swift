//
//  UpComingViewController.swift
//  Netflix Kids
//
//  Created by Mohammed Saidam on 12/09/2024.
//

import UIKit

class UpComingViewController: UIViewController {
    
   
    public var titles:[Title] = [Title]()
    
    private let upComingTable:UITableView = {
        let tableView = UITableView()
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier:TitleTableViewCell.identifier)
        
        
        return tableView
        
    }()
    
    override func viewDidLoad() {
     
        
        // Add observers for notifications
    
        view.backgroundColor = .systemBackground
        title = "Coming Soon"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.addSubview(upComingTable)
        upComingTable.delegate = self
        upComingTable.dataSource = self
        fetchingData()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upComingTable.frame = view.bounds
    }
    public func fetchingData(){
        
        APICaller.shared.getComingSoonCartoons { [weak self] result in
            switch result{
            case.success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.upComingTable.reloadData()
                    
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
        
        //        APICaller.shared.getUpComingCartoons { [weak self] results in
        //            switch results{
        //            case .success(let titles):
        //                self?.titles = titles
        //                DispatchQueue.main.async {
        //                    self?.upComingTable.reloadData()
        //
        //                }
        //            case .failure(let error):
        //                print(error.localizedDescription)
        //
        //            }
        //        }
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

