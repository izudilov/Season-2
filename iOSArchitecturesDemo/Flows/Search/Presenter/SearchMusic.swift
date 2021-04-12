//
//  SearchMusic.swift
//  iOSArchitecturesDemo
//
//  Created by user179996 on 11.04.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

protocol SearchViewInputSong: class {
    
    var searchResultsSongs: [ITunesSong] { get set }
    func throbber(show: Bool)
    func showError(error: Error)
    func showNoResults()
    func hideNoResults()
}

protocol SearchViewOutputSongs {
    func viewDidSearchSong(with query: String)
    func viewDidSelectApp(_ app: ITunesSong)
}

class SearchPresenterMusic {
    
    private let searchService = ITunesSearchService()
    
    weak var viewInput: (UIViewController & SearchViewInputSong)?
    
    private func requestSong(with query: String) {
        viewInput?.throbber(show: true)
        viewInput?.searchResultsSongs = []
        
        self.searchService.getSongs(forQuery: query) { [weak self] result in
            guard let self = self else { return }
            self.viewInput?.throbber(show: false)
            result
                .withValue { apps in
                    guard !apps.isEmpty else {
                        self.viewInput?.searchResultsSongs = []
                        self.viewInput?.showNoResults()
                        return
                    }
                    self.viewInput?.hideNoResults()
                    self.viewInput?.searchResultsSongs = apps
                }
                .withError {
                    self.viewInput?.showError(error: $0)
                }
        }
    }
    
    private func openDetailSong(_ app: ITunesSong) {
        //let appDetaillViewController = AppDetailViewController(app: app)
        //viewInput?.navigationController?.pushViewController(appDetaillViewController, animated: true)
    }
}

extension SearchPresenterMusic: SearchViewOutputSongs {

    func viewDidSearchSong(with query: String) {
        requestSong(with: query)
    }
    
    func viewDidSelectApp(_ app: ITunesSong) {
        openDetailSong(app)
    }
}
