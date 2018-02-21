//
//  MeasurementsInteractor.swift
//  EventSource
//
//  Created by Sergey Kim on 19.02.2018.
//  Copyright © 2018 KS. All rights reserved.
//

import Foundation
import Marshal

final class MeasurementsInteractor {
    
    private(set) var dataProvider = EventsDataProvider()
    private var decodingQueue = OperationQueue()
    
    weak var presenter: MeasurementsPresenter!
    
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
    
    private func decode(data: Data) -> [MeasurementUIModel] {
        do {
            let results = try JSONDecoder().decode([MeasurementData].self, from: data)
            let models = results.map { MeasurementUIModel(data: $0) }
            return models
        }
        catch {
            print("\(error)")
        }
        return []
    }
}

extension MeasurementsInteractor: EventsDataProviderDelegate {
    
    func sourceOpened(_ provider: EventsDataProvider) {
        
    }
    
    func provider(_ provider: EventsDataProvider, didReceiveError error: Error?) {
        
    }
    
    func provider(_ provider: EventsDataProvider, didReceiveMessage message: SourceMessage) {
        guard let jsonString = message.data else {
            return
        }
        
        let operation: () -> Void = {
            guard let data = jsonString.data(using: .utf8) {
                return
            }
            let results = self.decode(data: data)
            if !results.isEmpty {
                DispatchQueue.main.async {
                    self.presenter.addItems(results)
                }
            }
        }
        decodingQueue.addOperation(operation)
    }
}
