//
//  AppDetailHeaderView.swift
//  iTunesSearchApp
//
//  Created by Anton Scherbaev on 02.05.2021.
//

import UIKit

class AppDetailHeaderView: UIView {
    
    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 30.0
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.numberOfLines = 2
        return label
    }()
    
    private(set) lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.numberOfLines = 1
        return label
    }()
    
    private(set) lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textAlignment = .right
        label.numberOfLines = 1
        return label
    }()
    
    private(set) lazy var openButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Open", for: .normal)
        button.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        button.layer.cornerRadius = 16.0
        button.layer.masksToBounds = true
        
        return button
    }()
    
    private(set) lazy var starsView: UIStackView = {
        
        var viewsArray: [UIImageView] = []
        for _ in 1...5 {
            let star = UIImageView()
            let starImage = UIImage(systemName: "star")?.withRenderingMode(.alwaysTemplate)
            star.image = starImage
            star.translatesAutoresizingMaskIntoConstraints = false
            star.backgroundColor = .clear
            star.tintColor = .orange
            viewsArray.append(star)
        }
        
        let stack = UIStackView(arrangedSubviews: viewsArray)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .fill
        stack.axis = .horizontal
        stack.spacing = CGFloat(5)
        
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureUI() {
        backgroundColor = .clear
        
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
        self.addSubview(ratingLabel)
        self.addSubview(openButton)
        self.addSubview(starsView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12.0),
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16.0),
            imageView.heightAnchor.constraint(equalToConstant: 120.0),
            imageView.widthAnchor.constraint(equalToConstant: 120.0),
            
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12.0),
            titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 16.0),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16.0),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12.0),
            subtitleLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            subtitleLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor),
            
            openButton.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 16.0),
            openButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            openButton.widthAnchor.constraint(equalToConstant: 80.0),
            openButton.heightAnchor.constraint(equalToConstant: 32.0),
            
            ratingLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12.0),
            ratingLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16.0),
            ratingLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12.0),
            
            starsView.leftAnchor.constraint(equalTo: imageView.leftAnchor),
            starsView.centerYAnchor.constraint(equalTo: ratingLabel.centerYAnchor),
            starsView.heightAnchor.constraint(equalToConstant: 20),
            starsView.widthAnchor.constraint(equalToConstant: 130)
            
        ])




    }
}
