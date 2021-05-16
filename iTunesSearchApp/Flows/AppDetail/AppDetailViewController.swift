//
//  AppDetailViewController.swift
//  iTunesSearchApp
//
//  Created by Anton Scherbaev on 02.05.2021.
//

import UIKit

final class AppDetailViewController: UIViewController {
    
    var app: ITunesApp
    
    lazy var headerDetailViewController = AppDetailHeaderViewController(app: app)
    lazy var appScreenShotsViewController = AppScreenShotsViewController()
    
    let presenter: AppDetailViewOutput

    
    init(presenter: AppDetailViewOutput, app: ITunesApp) {
        self.presenter = presenter
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.configureNavigationController()
//      
        
        addChildViewController()
        addScreenShotsViewController()
        
        presenter.getAppIcon()
        presenter.getScreenshots()
        appScreenShotsViewController.startLoadingImages()
    }
    
    // MARK: - Private
    
    private func configureNavigationController() {
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    private func addChildViewController() {
        
        view.addSubview(headerDetailViewController.view)
        addChild(headerDetailViewController)
        
        headerDetailViewController.didMove(toParent: self)
        
        headerDetailViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerDetailViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerDetailViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            headerDetailViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
        
    }
    
    private func addScreenShotsViewController() {

        view.addSubview(appScreenShotsViewController.view)
        addChild(appScreenShotsViewController)
        appScreenShotsViewController.didMove(toParent: self)

        appScreenShotsViewController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            appScreenShotsViewController.view.topAnchor.constraint(equalTo: headerDetailViewController.view.bottomAnchor),
            appScreenShotsViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            appScreenShotsViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            appScreenShotsViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
} 

extension AppDetailViewController: AppDetailViewInput {
    func showError(error: Error) {
        
    }
    
    func setIcon(image: UIImage) {
        headerDetailViewController.setIcon(image: image)
    }
    
    func setScreenshots(screenShots images: [UIImage]) {
        appScreenShotsViewController.setScreenshots(images: images)
    }
}
