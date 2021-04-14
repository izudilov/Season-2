//
//  SongDetailViewController.swift
//  iOSArchitecturesDemo
//
//  Created by user179996 on 14.04.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class SongDetailsViewController: UIViewController {
    
    public var song: ITunesSong?
    
    private var songDetailsView: SongDetails {
        return self.view as! SongDetails
    }
    
    override func loadView() {
        
        self.view = SongDetails()
    }
    
    init(song: ITunesSong) {
        self.song = song
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    private func configureUI() {
        songDetailsView.songImage.image = try! UIImage(data: Data(contentsOf: (URL(string: (song?.artwork!)!)!)))
        songDetailsView.artistName .text = song?.artistName
        songDetailsView.songName.text = song?.trackName
        songDetailsView.progress.trackImage = try! UIImage(data: Data(contentsOf: (URL(string: (song?.artwork!)!)!)))
    }
}
