//
//  SearchRouter.swift
//  iOSArchitecturesDemo
//
//  Created by user179996 on 14.04.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

import UIKit

protocol SearchRouterInput {
    func openDetail(for song: ITunesSong)
}

class SearchRouter: SearchRouterInput {
    
    weak var viewController: UIViewController?
    
    func openDetail(for song: ITunesSong) {
        let songDetailViewController = SongDetailsViewController(song: song)
        viewController?.navigationController?.pushViewController(songDetailViewController, animated: true)
    }
}
