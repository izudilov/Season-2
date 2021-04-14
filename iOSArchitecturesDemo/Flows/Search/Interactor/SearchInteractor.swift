//
//  SearchInteractor.swift
//  iOSArchitecturesDemo
//
//  Created by user179996 on 14.04.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import Alamofire

protocol SearchInteractorInput {
    func getSongs(forQuery query: String, then completion: @escaping (Result<[ITunesSong]>) -> Void)
}

class SearchInteractor: SearchInteractorInput {
    private let searchService = ITunesSearchService()
    
    func getSongs(forQuery query: String, then completion: @escaping (Result<[ITunesSong]>) -> Void) {
        searchService.getSongs(forQuery: query) {
            result in
            
            print("Received songs")
            
            completion(result)
        }
    }
}
