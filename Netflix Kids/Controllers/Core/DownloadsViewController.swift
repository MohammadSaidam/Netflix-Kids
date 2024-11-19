//
//  DownloadsViewController.swift
//  Netflix Kids
//
//  Created by Mohammed Saidam on 12/09/2024.
//

import UIKit

class DownloadsViewController: UIViewController {
    public var titles:[TitleItem] = [TitleItem]()
    
    private let downloadedTable:UITableView = {
        let tableView = UITableView()
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier:TitleTableViewCell.identifier)
        
        
        return tableView
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Downloads"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        downloadedTable.delegate = self
        downloadedTable.dataSource = self
        view.addSubview(downloadedTable)
        fetchLocalStorgeForDownload()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("downloaded"), object: nil, queue: nil) { _ in
            self.fetchLocalStorgeForDownload()
        }
    }
    func fetchLocalStorgeForDownload (){
        DataPersistenceManager.shard.fetchingTitlesFromDatabase { [weak self] results in
            switch results {
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.downloadedTable.reloadData()

                }
            case.failure(let error):
                print(error.localizedDescription)
                 
                
            }
        }
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        downloadedTable.frame = view.bounds
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
