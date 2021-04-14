//
//  SearchPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Evgenii Semenov on 06.04.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

protocol SearchViewInput: class {
    
    var searchResults: [ITunesApp] { get set }
    func throbber(show: Bool)
    func showError(error: Error)
    func showNoResults()
    func hideNoResults()
}

protocol SearchViewOutput {
    func viewDidSearch(with query: String)
    func viewDidSelectApp(_ app: ITunesApp)
}

class SearchPresenter {
    
    private let searchService = ITunesSearchService()
    
    weak var viewInput: (UIViewController & SearchViewInput)?
    
    
    let interactor: SearchInteractorInput
    
    init(interactor: SearchInteractorInput) {
        self.interactor = interactor
    } 
    
    private func requestApps(with query: String) {
        viewInput?.throbber(show: true)
        viewInput?.searchResults = []
        
        self.searchService.getApps(forQuery: query) { [weak self] result in
            guard let self = self else { return }
            self.viewInput?.throbber(show: false)
            result
                .withValue { apps in
                    guard !apps.isEmpty else {
                        self.viewInput?.searchResults = []
                        self.viewInput?.showNoResults()
                        return
                    }
                    self.viewInput?.hideNoResults()
                    self.viewInput?.searchResults = apps
                }
                .withError {
                    self.viewInput?.showError(error: $0)
                }
        }
    }
    
    private func openDtailApp(_ app: ITunesApp) {
        let appDetaillViewController = AppDetailViewController(app: app)
        viewInput?.navigationController?.pushViewController(appDetaillViewController, animated: true)
    }
}

extension SearchPresenter: SearchViewOutput {
    
    func viewDidSearch(with query: String) {
        requestApps(with: query)
    }
    
    func viewDidSelectApp(_ app: ITunesApp) {
        openDtailApp(app)
    }
}
