//
//  AsyncOperation.swift
//  1l_ZudilovIlya
//
//  Created by user179996 on 14.02.2021.
//  Copyright © 2021 izudilov. All rights reserved.
//

import UIKit

class AsyncOperation: Operation {

    enum State: String {
            case ready, executing, finished
            fileprivate var keyPath: String {
                return "is" + rawValue.capitalized
            }
        }
        
        var state = State.ready {
            willSet {
                willChangeValue(forKey: state.keyPath)
                willChangeValue(forKey: newValue.keyPath)
            }
            didSet {
                didChangeValue(forKey: state.keyPath)
                didChangeValue(forKey: oldValue.keyPath)
            }
        }
        
        override var isAsynchronous: Bool {
            return true
        }
        
        override var isReady: Bool {
            return super.isReady && state == .ready
        }
        
        override var isExecuting: Bool {
            return state == .executing
        }
        override var isFinished: Bool {
            return state == .finished
        }
        override func start() {
            if isCancelled {
                state = .finished
            } else {
                main()
                state = .executing
            }
        }
        override func cancel() {
            super.cancel()
            state = .finished
        }
    
}
