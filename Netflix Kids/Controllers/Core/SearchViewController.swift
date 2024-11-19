//
//  SearchViewController.swift
//  Netflix Kids
//
//  Created by Mohammed Saidam on 12/09/2024.
//

import UIKit

class SearchViewController: UIViewController {
    public var titles:[Title] = [Title]()
    
    private let discoverTableView:UITableView = {
        let tableView = UITableView()
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        
        
        return tableView
        
    }()
    
    private let searchController :UISearchController = {
        let search = UISearchController(searchResultsController: SearchResultViewController())
        search.searchBar.placeholder = "Search for a Movie or Tv shows"
        search.searchBar.searchBarStyle = .minimal
        
        return search
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        discoverTableView.dataSource = self
        discoverTableView.delegate = self
        view.addSubview(discoverTableView )
        navigationItem.searchController = searchController
        navigationController?.navigationBar.tintColor = .white
        searchController.searchResultsUpdater = self
        fetchingDiscoverCartoons()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTableView.frame = view.bounds
    }
    
    func fetchingDiscoverCartoons(){
        APICaller.shared.getDiscoverResultsCartoons { [weak self] results in
            switch results {
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.discoverTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
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
