//
//  AppDetailViewController.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 20.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

final class AppDetailViewController: UIViewController {
    
    public var app: ITunesApp
    
    lazy var headerViewController = AppDetailHeaderViewController(app: app)
    lazy var detailsViewController = AppDetailsViewController(app: app)
    
//    private let imageDownloader = ImageDownloader()
    
//    private var appDetailView: AppDetailView {
//        return self.view as! AppDetailView
//    }
    
    init(app: ITunesApp) {
        self.app = app
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
//    override func loadView() {
////        super.loadView()
//        self.view = AppDetailView()
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        configureNavigationController()
        addHeaderView()        
        addDescriptionView()
    }
    
    // MARK: - Private
    
    private func configureNavigationController() {
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    private func addHeaderView() {
        view.addSubview(headerViewController.view)
        self.addChild(headerViewController)
        
        headerViewController.didMove(toParent: self)
        
        headerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerViewController.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            headerViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            headerViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }
    
    private func addDescriptionView() {
        // ​TODO:​ ДЗ, сделать другие сабмодули
        let vc = AppDetailsViewController(app: app)
        
        self.addChild(vc)
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            vc.view.topAnchor.constraint(equalTo: headerViewController.view.safeAreaLayoutGuide.bottomAnchor),
            vc.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            vc.view.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }
}
