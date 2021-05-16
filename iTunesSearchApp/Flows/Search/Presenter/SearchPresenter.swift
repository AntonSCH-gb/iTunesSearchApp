//
//  SearchPresenter.swift
//  iTunesSearchApp
//
//  Created by Anton Scherbaev on 02.05.2021.
//

import UIKit
import Alamofire

protocol SearchViewInput: AnyObject {
    
    var searchResults: [ITunesApp] { get set }
    func showError(error: Error)
    func hideNoResults()
    func showNoResults()
    func searchBarThrobber(show: Bool)
}

protocol SearchViewOutput {
    
    func viewDidSearch(with query: String)
    func viewDidSelectApp(_ app: ITunesApp)
}

class SearchPresenter {
    
    private let searchService = ITunesSearchService()
    
    weak var viewInput: (UIViewController & SearchViewInput)?
    
    private func requestApps(with query: String) {
        
        self.searchService.getApps(forQuery: query) { [weak self] result in
            guard let self = self else { return }
            
            self.viewInput?.searchBarThrobber(show: false)
            
            switch result {
            
            case let .success(apps):
                guard !apps.isEmpty else {
                    self.viewInput?.showNoResults()
                    return
                }
                self.viewInput?.hideNoResults()
                self.viewInput?.searchResults = apps
            case .failure(let error):
                self.viewInput?.showError(error: error)
            }
        }
    }
    
    private func openAppDetail(with app: ITunesApp) {
        let appDetaillViewController = AppDetailBuilder.build(with: app)
        
//        let appDetaillViewController = AppDetailViewController(app: app)
        viewInput?.navigationController?.pushViewController(appDetaillViewController, animated: true)
    }
}

extension SearchPresenter: SearchViewOutput {
    
    func viewDidSearch(with query: String) {
        self.viewInput?.searchBarThrobber(show: true)
        requestApps(with: query)
    }
    
    func viewDidSelectApp(_ app: ITunesApp) {
        openAppDetail(with: app)
    }
}
