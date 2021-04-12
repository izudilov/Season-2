//
//  SongCellModel.swift
//  iOSArchitecturesDemo
//
//  Created by user179996 on 12.04.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

struct SongCellModel {
    let songName: String
    let artistName: String?
    let collectionLabel: String?
    let songImage: String?
}

final class SongCellModelFactory {
    
    static func cellModelSong(from model: ITunesSong) -> SongCellModel {
        return SongCellModel(songName: model.trackName,
                             artistName: model.artistName,
                             collectionLabel: model.collectionName,
                             songImage: model.artwork)    
    }
}
