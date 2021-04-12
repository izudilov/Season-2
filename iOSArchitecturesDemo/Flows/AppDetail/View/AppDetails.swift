//
//  AppDetails.swift
//  iOSArchitecturesDemo
//
//  Created by user179996 on 11.04.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class AppDetails: UIView {
    
    private(set) lazy var tittle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18.0)
        return label
    }()
    
    private(set) lazy var numberOfVersion: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()
    
    private(set) lazy var dateRelize: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()
    
    private(set) lazy var whatsNew: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12.0)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        
        addSubview(numberOfVersion)
        addSubview(dateRelize)
        addSubview(tittle)
        addSubview(whatsNew)
        
        NSLayoutConstraint.activate([
            
            numberOfVersion.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 25.0),
            numberOfVersion.leftAnchor.constraint(equalTo: leftAnchor, constant: 10.0),
            numberOfVersion.rightAnchor.constraint(equalTo: rightAnchor, constant: -16.0),
            
            dateRelize.topAnchor.constraint(equalTo: numberOfVersion.bottomAnchor, constant: 3.0),
            dateRelize.leftAnchor.constraint(equalTo: numberOfVersion.leftAnchor),
            dateRelize.rightAnchor.constraint(equalTo: numberOfVersion.rightAnchor),
            
            tittle.topAnchor.constraint(equalTo: dateRelize.bottomAnchor, constant: 12.0),
            tittle.leftAnchor.constraint(equalTo: dateRelize.leftAnchor),
            tittle.rightAnchor.constraint(equalTo: dateRelize.rightAnchor),

            whatsNew.topAnchor.constraint(equalTo: tittle.bottomAnchor, constant: 3.0),
            whatsNew.leftAnchor.constraint(equalTo: tittle.leftAnchor),
            whatsNew.rightAnchor.constraint(equalTo: tittle.rightAnchor),
            whatsNew.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
