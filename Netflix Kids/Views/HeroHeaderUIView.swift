//
//  HeroHeaderUIView.swift
//  Netflix Kids
//
//  Created by Mohammed Saidam on 12/09/2024.
//

import UIKit

class HeroHeaderUIView: UIView {
    
    private let heroImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "heroImage")
        
        return imageView
        
    }()
    
    private let playButton :UIButton = {
        let button = UIButton()
        button.setTitle("play", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints  = false
        button.layer.cornerRadius = 5
    
        return button
    }()
    
    private let downloadButton : UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
    }()
    private func addGradient(){
        let gradentLayer = CAGradientLayer()
        ///in here
        gradentLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
            
        ]
        gradentLayer.frame = bounds
        layer.addSublayer(gradentLayer)
        
       
    }
    public func configure(with model :TitleViewModel){
        guard let url = URL(string:"https://image.tmdb.org/t/p/w500\(model.poster_URL)") else {return}

        heroImageView.sd_setImage(with: url,completed: nil)
        
    }
    private func applyConstraints(){
//        70
        	let playButtonConstrints = [
                playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
                playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
                playButton.widthAnchor.constraint(equalToConstant: 120)
  
            ]
//        -70
        let downloadButtonConstraints = [
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant:-50),
            downloadButton.widthAnchor.constraint(equalToConstant: 120)
        
        ]
        NSLayoutConstraint.activate(playButtonConstrints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
        
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradient()
        addSubview(playButton)
        addSubview(downloadButton)
       applyConstraints()
       
        
    }
    
    
    required init?(coder:NSCoder) {
        fatalError()
    }
    override func layoutSubviews(){
        super.layoutSubviews()
        heroImageView.frame = bounds
        
    }

}
