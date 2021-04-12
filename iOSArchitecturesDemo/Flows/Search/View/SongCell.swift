//
//  SongCell.swift
//  iOSArchitecturesDemo
//
//  Created by user179996 on 12.04.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

final class SongCell: UITableViewCell {
    
    // MARK: - Subviews
    
    private(set) lazy var songName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()
    
    private(set) lazy var artistName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13.0)
        return label
    }()
    
    private(set) lazy var collectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12.0)
        return label
    }()
    
    private(set) lazy var songImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        return imageView
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    // MARK: - Methods
    
    func configure(with cellModel: SongCellModel) {
        self.songName.text = cellModel.artistName
        self.artistName.text = cellModel.artistName
        self.collectionLabel.text = cellModel.collectionLabel
        self.songImage.image = try! UIImage(data: Data(contentsOf: (URL(string: cellModel.songImage!)!)))
    }
    
    // MARK: - UI
    
    override func prepareForReuse() {
        [self.songName, self.artistName, self.collectionLabel].forEach { $0.text = nil }
    }
    
    private func configureUI() {
        self.addSongImage()
        self.addSongName()
        self.addSubtitleLabel()
        self.addcollectionLabelLabel()
    }
    
    private func addSongImage() {
        self.contentView.addSubview(self.songImage)
        NSLayoutConstraint.activate([
            self.songImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10.0),
            self.songImage.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16.0),
            self.songImage.heightAnchor.constraint(equalToConstant: 50.0),
            self.songImage.widthAnchor.constraint(equalToConstant: 50.0),
            ])
    }
    
    private func addSongName() {
        self.contentView.addSubview(self.songName)
        NSLayoutConstraint.activate([
            self.songName.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0),
            self.songName.leftAnchor.constraint(equalTo: self.songImage.rightAnchor, constant: 12.0),
            self.songName.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -40.0)
            ])
    }
    
    private func addSubtitleLabel() {
        self.contentView.addSubview(self.artistName)
        NSLayoutConstraint.activate([
            self.artistName.topAnchor.constraint(equalTo: self.songName.bottomAnchor, constant: 4.0),
            self.artistName.leftAnchor.constraint(equalTo: self.songImage.rightAnchor, constant: 12.0),
            self.artistName.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -40.0)
            ])
    }
    
    private func addcollectionLabelLabel() {
        self.contentView.addSubview(self.collectionLabel)
        NSLayoutConstraint.activate([
            self.collectionLabel.topAnchor.constraint(equalTo: self.artistName.bottomAnchor, constant: 4.0),
            self.collectionLabel.leftAnchor.constraint(equalTo: self.songImage.rightAnchor, constant: 12.0),
            self.collectionLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -40.0)
            ])
    }
}
