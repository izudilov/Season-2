//
//  SongDetails.swift
//  iOSArchitecturesDemo
//
//  Created by user179996 on 14.04.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class SongDetails: UIView {
    
    private(set) lazy var songName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18.0)
        return label
    }()
    
    private(set) lazy var artistName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()
    
    private(set) lazy var songImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        return imageView
    }()
    
    private(set) lazy var progress: UIProgressView = {
        let progress = UIProgressView()
        progress.progressTintColor = .purple
        return progress
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        
        addSubview(songImage)
        addSubview(songName)
        addSubview(artistName)
        addSubview(progress)
        
        NSLayoutConstraint.activate([
            
            songImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 80.0),
            songImage.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            songImage.heightAnchor.constraint(equalToConstant: 250.0),
            songImage.widthAnchor.constraint(equalToConstant: 250.0),
            
            songName.topAnchor.constraint(equalTo: songImage.bottomAnchor, constant: 10.0),
            songName.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            
            artistName.topAnchor.constraint(equalTo: songName.bottomAnchor, constant: 3.0),
            artistName.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            
            //progress.topAnchor.constraint(equalTo: artistName.bottomAnchor, constant: 20.0),
            //progress.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20.0),
            //progress.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -20.0),
            
        ])
    }
}
