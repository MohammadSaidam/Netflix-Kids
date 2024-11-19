//
//  HomeViewController.swift
//  Netflix Kids
//
//  Created by Mohammed Saidam on 12/09/2024.
//

import UIKit

class HomeViewController: UIViewController {
    
//    static let activityIndicator: UIActivityIndicatorView = {
//
//          let indicator = UIActivityIndicatorView(style: .large)
//        indicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
//            indicator.hidesWhenStopped = true
//
//           indicator.color = .white
//
//          indicator.translatesAutoresizingMaskIntoConstraints = false
//          return indicator
//        }()
    
    
    
    private var randomSelectImage :Title?
    private var headerView: HeroHeaderUIView?
    // This Array that contains header section in Home Screen
    let sectionsTitles:[String] = ["Comedey","Adventure ","Science Fiction","Fantasy","Disney","Top Rated"]
    
    private let homeFeedTable: UITableView = {
        
        let tableView = UITableView(frame: .zero,style: .grouped)
        
        tableView.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        
        return tableView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
//        view.addSubview(HomeViewController.activityIndicator)
//        HomeViewController.activityIndicator.center = view.center
        //        navigationController?.pushViewController(TitlePreviewViewController(), animated: true)
        
        
        headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTable.tableHeaderView = headerView
        configureNavBar()
        APICaller.shared.getMovie(with: "Family Guy") { results in
            //
        }
      
        configureHeaderView()
//        view.addSubview(LoaderViewController.activityIndicator)
       

//        NSLayoutConstraint.activate([
//                 // ActivityIndicator constraints
//            HomeViewController.activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            HomeViewController.activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//
//             ])
        
    }
    override func viewDidAppear(_ animated: Bool) {
    

    }
    
   
    
    
    
    private func configureHeaderView(){
        
        
        APICaller.shared.getTrendingMovies {[weak self] results in
            switch results {
                
            case .success(let titles):
                
                let selectedTitle = titles.randomElement()
                self?.randomSelectImage = selectedTitle
                self?.headerView?.configure(with: TitleViewModel(titleName: selectedTitle?.original_title ?? "", poster_URL: selectedTitle?.poster_path ?? ""))
                
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    override func viewDidLayoutSubviews() {
        homeFeedTable.frame = view.bounds
    }
    
    
    
    private func configureNavBar(){
        var image = UIImage(named: "netflixLogo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: 	image, style: .done, target: self,action: nil)
        
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            
            
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        
        
        navigationController?.navigationBar.tintColor = UIColor.white
        //        navigationItem.title = "Home"
        
        
    }
     static func sendRequestToServer(url :String,completion :@escaping (Result<[Title], Error>)  -> Void){
       let startLoader = HomeViewController()
        
        
          guard let url = URL(string: url) else{return}
        
         DispatchQueue.global().async {
             startLoader.loader()
            
             
             //             self.activityIndicator.startAnimating()
             
             print("Loader started")
             
         }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data,_,error in
            DispatchQueue.main.async {
//                       self.activityIndicator.stopAnimating()
                
                
                       print("Loader stopped")
                   }
           
            guard let data = data ,error == nil else{
                return
            }
        
            do{
                
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
                
            }catch{
                completion(.failure(APIError.failedToGetData))
                
            }
        }
        task.resume()
        
        
    }
 
  
    
    
}
extension UIViewController{
    func loader() -> UIAlertController {
        let alert = UIAlertController(title: nil , message: "Loading...", preferredStyle: .alert)
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        indicator.style = .large
        alert.view.addSubview(indicator)
        DispatchQueue.main.async {
               self.present(alert, animated: true, completion: nil)
           }
     


        return alert
    }
    func stopLoader (loader :UIAlertController){
       
            loader.dismiss(animated: true,completion: nil)
        
        
    }
}


