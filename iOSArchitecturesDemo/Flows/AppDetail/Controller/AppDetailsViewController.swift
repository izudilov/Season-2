//
//  AppDetailsViewController.swift
//  iOSArchitecturesDemo
//
//  Created by user179996 on 11.04.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class AppDetailsViewController: UIViewController {
    
    public var app: ITunesApp?
    
    private var appDetailsView: AppDetails {
        return self.view as! AppDetails
    }
    
    override func loadView() {
        
        self.view = AppDetails()
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
        appDetailsView.tittle.text = "Что нового:"
        appDetailsView.numberOfVersion.text = "Версия: \(app?.version ?? "1.0.0")"
        appDetailsView.dateRelize.text = "Дата релиза: \(app?.dateText ?? "01.01.2021")"
        appDetailsView.whatsNew.numberOfLines = 0
        appDetailsView.whatsNew.text = app?.releaseNotes
    }
}
