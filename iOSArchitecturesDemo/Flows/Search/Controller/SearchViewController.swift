//
//  ViewController.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 14.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var searchView: SearchView {
        return self.view as! SearchView
    }
    
//    private let searchService = ITunesSearchService()
    var searchResults = [ITunesApp]() {
        didSet {
            searchView.tableView.isHidden = false
            searchView.tableView.reloadData()
            searchView.searchBar.resignFirstResponder()
        }
    }
    
    var searchResultsSongs = [ITunesSong]() {
        didSet {
            searchView.tableView.isHidden = false
            searchView.tableView.reloadData()
            searchView.searchBar.resignFirstResponder()
        }
    }
    
    var typeOfSearch = 0
    
    let router: SearchRouterInput
    
    private struct Constants {
        static let reuseIdentifier = "reuseId"
    }
    
    private let presenter: SearchViewOutput
    private let presenterMusic: SearchViewOutputSongs
    
    init(presenter: SearchViewOutput, presenterMusic: SearchViewOutputSongs, router: SearchRouterInput ) {
        self.presenter = presenter
        self.presenterMusic = presenterMusic
        self.router = router
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
//        super.loadView()
        self.view = SearchView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        typeOfSearchContent()
        self.searchView.searchBar.delegate = self
        self.searchView.tableView.register(SongCell.self, forCellReuseIdentifier: Constants.reuseIdentifier) // App: self.searchView.tableView.register(AppCell.self, forCellReuseIdentifier: Constants.reuseIdentifier)
        self.searchView.tableView.delegate = self
        self.searchView.tableView.dataSource = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.throbber(show: false)
    }
    
    // MARK: - Private
    
    func throbber(show: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = show
    }
    
    func showError(error: Error) {
        let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showNoResults() {
        self.searchView.emptyResultView.isHidden = false
    }
    
    func hideNoResults() {
        self.searchView.emptyResultView.isHidden = true
    }
    
    func typeOfSearchContent() {
        
        let controller = UIAlertController(
            title: "Выберите что хотите найти",
            message: "приложение или песню",
            preferredStyle: .alert)

          let app = UIAlertAction(title: "Приложение",
                                         style: .default) {
            [weak self] alert in

            self!.typeOfSearch = 0
            self!.searchView.tableView.register(AppCell.self, forCellReuseIdentifier: Constants.reuseIdentifier)

          }

          let song = UIAlertAction(title: "Песню",
                                   style: .default) {
            [weak self] alert in

            self!.typeOfSearch = 1
           
            print(self!.typeOfSearch)
          }
         
          controller.addAction(app)
          controller.addAction(song)

          present(controller, animated: true)
             
    }
}

//MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if typeOfSearch == 0 {
            return searchResults.count
        } else {
            return searchResultsSongs.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifier, for: indexPath)
                
        if typeOfSearch == 0 {
            let cell = dequeuedCell as? AppCell
            let app = self.searchResults[indexPath.row]
            let cellModel = AppCellModelFactory.cellModel(from: app)
            cell!.configure(with: cellModel)
            return cell!
        } else {
            let cell = dequeuedCell as? SongCell
            let song = self.searchResultsSongs[indexPath.row]
            let cellModelSong = SongCellModelFactory.cellModelSong(from: song)
            cell!.configure(with: cellModelSong)
            return cell!
        }


    }
}

//MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if typeOfSearch == 0 {
            let app = searchResults[indexPath.row]
            presenter.viewDidSelectApp(app)
        } else {
            let app = searchResultsSongs[indexPath.row]
            router.openDetail(for: app)
        }
    }
}

//MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            searchBar.resignFirstResponder()
            return
        }
        if query.count == 0 {
            searchBar.resignFirstResponder()
            return
        }
//        self.requestApps(with: query)
        
        if typeOfSearch == 0 {
            presenter.viewDidSearch(with: query)
        } else {
            presenterMusic.viewDidSearchSong(with: query)
        }
    }
}

extension SearchViewController: SearchViewInput {}
extension SearchViewController: SearchViewInputSong {}
