//
//  SearchBuilder.swift
//  iOSArchitecturesDemo
//
//  Created by Evgenii Semenov on 06.04.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

enum SearchBuilder {
    
    static func buildApp() -> (UIViewController & SearchViewInput) {
        
        let interactor = SearchInteractor()
        let presenter = SearchPresenter(interactor: interactor)
        let presenterMusic = SearchPresenterMusic(interactor: interactor)
        let router = SearchRouter()
        let viewController = SearchViewController(presenter: presenter, presenterMusic: presenterMusic, router: router)
        
        presenter.viewInput = viewController
        router.viewController = viewController
        
        return viewController
    }
    
    static func buildSong() -> (UIViewController & SearchViewInputSong) {
        
        let router = SearchRouter()
        let interactor = SearchInteractor()
        let presenter = SearchPresenter(interactor: interactor)
        let presenterMusic = SearchPresenterMusic(interactor: interactor)
        let viewController = SearchViewController(presenter: presenter, presenterMusic: presenterMusic, router: router)
        
        presenterMusic.viewInput = viewController
        router.viewController = viewController
        
        return viewController
    }
}
