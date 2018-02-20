//
//  Interactor.swift
//  EventSource
//
//  Created by Sergey Kim on 19.02.2018.
//  Copyright © 2018 KS. All rights reserved.
//

import Foundation
import Marshal

final class Interactor {
    
    private(set) var dataProvider = EventsDataProvider()
    private var decodingQueue = OperationQueue()
    
    weak var view: ViewController?
    
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
    
    private func decode(data: Data) -> [MeasurementData] {
        do {
            let results = try JSONDecoder().decode([MeasurementData].self, from: data)
            return results
        }
        catch {
            print("\(error)")
        }
        return []
    }
}

extension Interactor: EventsDataProviderDelegate {
    
    func sourceOpened(_ provider: EventsDataProvider) {
        
    }
    
    func provider(_ provider: EventsDataProvider, didReceiveError error: Error?) {
        
    }
    
    func provider(_ provider: EventsDataProvider, didReceiveMessage message: SourceMessage) {
        if let jsonString = message.data,
            let data = jsonString.data(using: .utf8) {
            
            let operation: () -> Void = {
                let results = self.decode(data: data)
                if !results.isEmpty {
                    DispatchQueue.main.async {
                        self.view?.addItems(results)
                    }
                }
            }
            decodingQueue.addOperation(operation)
        }
    }
}
