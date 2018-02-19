//
//  Interactor.swift
//  EventSource
//
//  Created by Sergey Kim on 19.02.2018.
//  Copyright © 2018 KS. All rights reserved.
//

import Foundation

final class Interactor {
    
    private lazy var dataProvider = EventsDataProvider()
    weak var view: ViewController!
    
    func startListenSSE() {
        guard !dataProvider.isListening else {
            return
        }
        dataProvider.delegate = self
        dataProvider.startListening()
    }
    
    func stopListenSSE() {
        dataProvider.stopListening()
    }
}

extension Interactor: EventsDataProviderDelegate {
    
    func sourceOpened(_ provider: EventsDataProvider) {
        
    }
    
    func provider(_ provider: EventsDataProvider, didReceiveError error: Error?) {
        
    }
    
    func provider(_ provider: EventsDataProvider, didReceiveMessage message: SourceMessage) {
        if let data = message.data {
            view.addItem(with: data)
        }
    }
}
