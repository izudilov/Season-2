//
//  RecordsCaretaker.swift
//  2-Zudilov
//
//  Created by user179996 on 20.03.2021.
//

import Foundation

class RecordsCaretaker {
    
    private typealias Memento = Data
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "snakeRecords"
    private let key2 = "userQuestions"
    
    func saveRecords(_ records: [GameSessioin]) {
        do {
            let data: Memento = try encoder.encode(records)
            UserDefaults.standard.setValue(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func saveQuestions(_ newQuestion: [Questions]) {
        do {
            let data: Memento = try encoder.encode(newQuestion)
            UserDefaults.standard.setValue(data, forKey: key2)
        } catch {
            print(error)
        }
    }
    
    func loadResults() -> [GameSessioin] {
        guard let data: Memento = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        do {
            return try decoder.decode([GameSessioin].self, from: data)
        } catch {
            print(error)
        }
        return []
    }
    
    func loadQuestions() -> [Questions] {
        guard let data: Memento = UserDefaults.standard.data(forKey: key2) else {
            return []
        }
        do {
            return try decoder.decode([Questions].self, from: data)
        } catch {
            print(error)
        }
        return []
    }
}

