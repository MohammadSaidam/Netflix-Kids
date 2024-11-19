//
//  TitleTableViewCell.swift
//  Netflix Kids
//
//  Created by Mohammed M.Saidam on 02/11/2024.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    static let identifier = "TitleTableViewCell"
    private let titlesPosterUImageView :UIImageView = {
        
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true  
        
        return image
        
    }()
    
    private let titleLable :UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.numberOfLines = 0
//        lable.frame = CGRect(x: 10, y: 100, width: 200, height: 50)
        
        return lable
        
        
    }()
    
    
    private let playTitleButton:UIButton = {
        
        let button = UIButton()
        let image = UIImage(systemName: "play.circle",withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        return button
        
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:  style, reuseIdentifier: reuseIdentifier )
        contentView.addSubview(titlesPosterUImageView)
        contentView.addSubview(titleLable)
        contentView.addSubview(playTitleButton)
        applyConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func applyConstraints(){
        
        let titlePosterUiImageViewConstrints = [
            titlesPosterUImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titlesPosterUImageView.topAnchor.constraint(equalTo: contentView.topAnchor ,constant: 10),
            titlesPosterUImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10),
            titlesPosterUImageView.widthAnchor.constraint(equalToConstant: 100)
        ]
        let titleLableConstrints = [
            titleLable.leadingAnchor.constraint(equalTo: titlesPosterUImageView.trailingAnchor, constant: 10),
            titleLable.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            titleLable.widthAnchor.constraint(equalToConstant: 250),
//            titleLable.heightAnchor.constraint(equalToConstant: 100)
        
        ]
        
        let playTitleButtonConstraints = [
            playTitleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            playTitleButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        NSLayoutConstraint.activate(titlePosterUiImageViewConstrints)
        NSLayoutConstraint.activate(titleLableConstrints)
        NSLayoutConstraint.activate(playTitleButtonConstraints)
    }
    func configuration(with model: TitleViewModel ){
//       https://image.tmdb.org/t/p/w500/\(model)
       guard let url = URL(string:"https://image.tmdb.org/t/p/w500\(model.poster_URL)") else {return}
       
       
  titlesPosterUImageView.sd_setImage(with: url, completed: nil)
       titleLable.text = model.titleName
       
   }

}
