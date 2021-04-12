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
        let presenter = SearchPresenter()
        let presenterMusic = SearchPresenterMusic()
        let viewController = SearchViewController(presenter: presenter, presenterMusic: presenterMusic)
        
        presenter.viewInput = viewController
        
        return viewController
    }
    
    static func buildSong() -> (UIViewController & SearchViewInputSong) {
        let presenter = SearchPresenter()
        let presenterMusic = SearchPresenterMusic()
        let viewController = SearchViewController(presenter: presenter, presenterMusic: presenterMusic)
        
        presenterMusic.viewInput = viewController
        
        return viewController
    }
}
