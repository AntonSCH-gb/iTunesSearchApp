//
//  AppScreenShotsView.swift
//  iTunesSearchApp
//
//  Created by Anton Scherbaev on 07.05.2021.
//

import UIKit

final class ScreenShotsView: UIView {
    
    // MARK: - Subviews
    
    private(set) lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = .zero
        layout.scrollDirection = .horizontal
//        layout.minimumInteritemSpacing = 5
//        layout.minimumLineSpacing = 5
          
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private(set) lazy var screenShotStatusStackView: UIStackView = {
        let stackLabel = UILabel()
        stackLabel.translatesAutoresizingMaskIntoConstraints = false
        stackLabel.font = UIFont.systemFont(ofSize: 14.0)
        stackLabel.textColor = .black
        stackLabel.numberOfLines = 1
        
        let stackThrobber = UIActivityIndicatorView()
        stackThrobber.translatesAutoresizingMaskIntoConstraints = false
        stackThrobber.style = .medium
        stackThrobber.hidesWhenStopped = true
        
        let loadingStack = UIStackView(arrangedSubviews:[stackLabel, stackThrobber])
        loadingStack.translatesAutoresizingMaskIntoConstraints = false
        loadingStack.alignment = .fill
        loadingStack.axis = .horizontal
        loadingStack.spacing = CGFloat(5)
        loadingStack.isHidden = true
        return loadingStack
    }()

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    enum ScreenshotsLoadingState {
        case loading, success, error
    }
    
    func throbberView(set state: ScreenshotsLoadingState){
        let labelText: String
        let textColor: UIColor
        let throbberState: Bool
        
        switch state {
        case .loading:
            labelText = "Loading images... "
            textColor = .black
            throbberState = true
        case .success:
            labelText = ""
            textColor = .clear
            throbberState = false
        case .error:
            labelText = "No screenshots available. "
            textColor = .gray
            throbberState = false
        }
        
        self.screenShotStatusStackView.subviews.forEach{
            if let label = $0 as? UILabel {
                label.text = labelText
                label.textColor = textColor
            } else if let throbber = $0 as? UIActivityIndicatorView {
                throbberState ? throbber.startAnimating() : throbber.stopAnimating()
            }
        }
        screenShotStatusStackView.isHidden = state == .success ? true : false
    }
    
    // MARK: - UI
    
    private func configureUI() {
        backgroundColor = .clear
        
        self.addSubview(collectionView)
        self.addSubview(screenShotStatusStackView)
        
        NSLayoutConstraint.activate([
            screenShotStatusStackView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10.0),
            screenShotStatusStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
//            screenShotStatusStackView.heightAnchor.constraint(equalToConstant: 120.0),
//            screenShotStatusStackView.widthAnchor.constraint(equalToConstant: 120.0),
            
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12.0),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])

    }
    
}
