//
//  AppDetailHeaderViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Evgenii Semenov on 05.04.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class AppDetailHeaderViewController: UIViewController {
    
    public var app: ITunesApp?
    
    private let imageDownloader = ImageDownloader()
    
    private var appDetailHeaderView: AppDetailHeaderView {
        return self.view as! AppDetailHeaderView
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        
        self.view = AppDetailHeaderView()
    }
    
    init(app: ITunesApp) {
        self.app = app
        
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
        downloadImage()
        appDetailHeaderView.titleLabel.text = app?.appName
        appDetailHeaderView.subtitleLabel.text = app?.company
        appDetailHeaderView.ratingLabel.text = String(format: "%.1f", app?.averageRating ?? 0)
        
        appDetailHeaderView.openButton.addTarget(self, action: #selector(openButtonDidTap), for: .touchUpInside)
    }
    
    private func downloadImage() {
        guard let url = self.app?.iconUrl else { return }
        self.imageDownloader.getImage(fromUrl: url) { (image, error) in
            guard let image = image else { return }
            self.appDetailHeaderView.imageView.image = image
        }
    }
    
    @objc private func openButtonDidTap() {
        guard let urlString = self.app?.appUrl, let url = URL(string: urlString) else { return }
        
        UIApplication.shared.open(url)
    }
}
