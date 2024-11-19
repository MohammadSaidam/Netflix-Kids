//
//  LoaderViewController.swift
//  Netflix Kids
//
//  Created by Mohammed M.Saidam on 17/11/2024.
//

import UIKit

class LoaderViewController: UIViewController {
    
    
  static let activityIndicator: UIActivityIndicatorView = {
        
        let indicator = UIActivityIndicatorView()
        
          indicator.hidesWhenStopped = true
      indicator.style = .whiteLarge
   
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
      }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(LoaderViewController.activityIndicator)
       

        NSLayoutConstraint.activate([
                 // ActivityIndicator constraints
            LoaderViewController.activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            LoaderViewController.activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
             ])
    }
  
 

    static func sendRequest(url :String,completion :@escaping (Result<[Title], Error>)  -> Void){
        

        guard let url = URL(string: url) else{return}
        DispatchQueue.main.async {
              print("Starting loader...")
              self.activityIndicator.startAnimating()
              print("Loader isAnimating: \(self.activityIndicator.isAnimating) the first")
          }
        

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data,_,error in
            DispatchQueue.main.async {
                       print("Stopping loader...")
                       self.activityIndicator.stopAnimating()
                       print("Loader isAnimating: \(self.activityIndicator.isAnimating ?? false) the scond")
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
