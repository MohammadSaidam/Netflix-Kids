
//
//  ViewController.swift
//  Netflix Kids
//
//  Created by Mohammed M.Saidam on 19/11/2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var loader:UIActivityIndicatorView? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
      
        
        

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let viewController = storyboard.instantiateViewController(withIdentifier: "TitlePreviewViewController")
//        viewController.modalPresentationStyle = .fullScreen
//       present(viewController, animated: true)

        let mainTabBarVC = MainTabBarViewController()
        mainTabBarVC.modalPresentationStyle = .fullScreen
        self.present(mainTabBarVC, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func startLoader(){
        loader?.startAnimating()
    }
    func stopLoader(){
        loader?.stopAnimating()
    }
    
}
