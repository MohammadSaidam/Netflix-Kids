//
//  TitlePreviewViewController.swift
//  Netflix Kids
//
//  Created by Mohammed M.Saidam on 07/11/2024.
//

import UIKit
import WebKit

class TitlePreviewViewController: UIViewController {
    enum DownloadButtonType {
        case download
        case remove
    }
   
    private var titleModel: Title?
    public var titles:[Title] = [Title]()
    private var buttonType: DownloadButtonType = .download


    private let webView :WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
        
    }()
    
    private let titleTheViewController :UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22,weight: .bold)
       
        label.text = "Cartoon Detailes"
        label.textColor = .white
        
        return label
        
    }()

    private let scrollView : UIScrollView  = {
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    private let contentView :UIView = {
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentView
    }()

    private let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .red
        
        return button
    }()
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22,weight: .bold)
        label.numberOfLines = 0
        label.text = "Rick and Morty"
       
        
        return label
        
        
    }()

    
    private let titleOverview :UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 18 , weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "This os the best movie to watch as the kid"
        return label
        
    }()
    
    private let downloadButton :UIButton = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Download ", for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.setTitleColor(.white, for: .normal)
        
      
    
      
        
        return button
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
     
     
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        
        
        contentView.addSubview(webView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(titleOverview)
        contentView.addSubview(downloadButton)
        contentView.addSubview(closeButton)
       
        
//        view.addSubview(scrollView)
//        view.addSubview(contentView)
        
       configeConstrintes()
        
      
        
     
        
       
       
        downloadButton.addTarget(self, action: #selector(downloadButtonTapped(_:)), for: .touchUpInside)
        
        closeButton.addTarget(self, action: #selector(myLeftSideBarButtonItemTapped(_:)), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("downloaded"),
                                               object: nil,
                                               queue: nil) { [weak self] _ in
            guard let id = self?.titleModel?.id else {
                return
            }
            self?.checkIsDownloadedBefore(Int(id))
        }

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
      
    }
    func  configeConstrintes(){
        let scrollViewConsritnts = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        
        
        ]
        
        let contentViewConsritnts = [
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo:scrollView.heightAnchor)
        
        ]
        let closeButtonConstraints = [
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 100)
        ]
        
        let webViewConstraints = [
            webView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            webView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 0),
            webView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: 0),
            webView.widthAnchor.constraint(equalToConstant: 300),
            webView.heightAnchor.constraint(equalToConstant: 270)
            
            
        ]
        
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
        titleLabel.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            titleOverview.heightAnchor.constraint(equalToConstant:100)

        ]
        
        let overviewLabelConstraints = [
            titleOverview.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant:0),
            titleOverview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleOverview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10),
       
//            titleOverview.heightAnchor.constraint(equalToConstant:280),
            titleOverview.widthAnchor.constraint(equalToConstant: 200)
        ]
        
        let downloadButtonConstraints = [
            downloadButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            downloadButton.topAnchor.constraint(equalTo: titleOverview.bottomAnchor, constant: 25),
            downloadButton.widthAnchor.constraint(equalToConstant: 200),
            downloadButton.heightAnchor.constraint(equalToConstant: 50)
        ]
    
        
        
//        let scrollViewConsraints = [
//            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//
//        ]
//        let contentViewConsraints = [
//            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
//        ]
   
        
        NSLayoutConstraint.activate(closeButtonConstraints)
        NSLayoutConstraint.activate(webViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(overviewLabelConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
        NSLayoutConstraint.activate(scrollViewConsritnts)
        NSLayoutConstraint.activate(contentViewConsritnts)
//        NSLayoutConstraint.activate(scrollViewConsraints)
//        NSLayoutConstraint.activate(contentViewConsraints)
        
        
    }
    
    func configure (with model:TitlePreviewViewModel){
        titleModel = model.titleModel
        titleLabel.text = model.title
        self.titleOverview.text = model.titleOverview
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId)")else{return}
        
        webView.load(URLRequest(url: url))
        checkIsDownloadedBefore(model.titleModel.id)
    }
    private func checkIsDownloadedBefore(_ id: Int) {
        DataPersistenceManager.shard.isDownloaded(id) { [weak self] result in
            switch result {
            case.success(let isDownloaded):
                if isDownloaded {
                    self?.buttonType = .remove
                    self?.downloadButton.setTitle("Remove", for: .normal)
                   
                   
                  
                }else{
                    self?.buttonType = .download
                    self?.downloadButton.setTitle("Download", for: .normal)
                }
            case.failure(let error):
                print(error.localizedDescription)
                
            }
        }
//        DataPersistenceManager.shared.isDownloaded(id) { [weak self] result in
//            switch result {
//            case .success(let isDownloaded):
//                if isDownloaded {
//                    self?.buttonType = .remove
//                    self?.downloadButton.setTitle("Remove", for: .normal)
//                } else {
//                    self?.buttonType = .download
//                    self?.downloadButton.setTitle("Download", for: .normal)
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
    
    @IBAction func downloadButtonTapped(_ sender: UIButton) {
            print("Button tapped!")
        // TODO: add or remove from coredata
        switch buttonType {
        case .download:
            guard let titleModel = titleModel else {
                return
            }
            
            DataPersistenceManager.shard.downloadTitleWith(model: titleModel) { result in
                switch result {
                case .success():
                    NotificationCenter.default.post(name: NSNotification.Name("download"), object: nil)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }

//            DataPersistenceManager.shared.downloadTitleWith(model: titleModel) { result in
//                switch result {
//                case .success():
//                    // reload downloads screen data
//                    NotificationCenter.default.post(name: NSNotification.Name("downloaded"), object: nil)
//                    // cell deki icon da burada güncellenebilir
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
        case .remove:
            guard let id = titleModel?.id else {
                return
            }
            DataPersistenceManager.shard.deleteTitleBy(id: id) { result in
                switch result {
                case .success():
                    NotificationCenter.default.post(name: NSNotification.Name("downloaded"),object: nil)
                    
//                    when remove video return DownloadViewController
                    self.dismiss(animated: true,completion: nil)
                case.failure(let error):
                    print(error.localizedDescription)
            }
//            DataPersistenceManager.shared.deleteTitleBy(id: id) { result in
//                switch result {
//                case .success():
//                    // reload downloads screen data
//                    NotificationCenter.default.post(name: NSNotification.Name("downloaded"), object: nil)
//                    // cell deki icon da burada güncellenebilir
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
            }
        }
    }
    
    
    
    @IBAction func myLeftSideBarButtonItemTapped(_ sender:UIButton!)
       {
           self.navigationController?.popViewController(animated: true)
         
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
