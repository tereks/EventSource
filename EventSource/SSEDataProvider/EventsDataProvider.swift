//
//  EventsDataProvider.swift
//  EventSource
//
//  Created by Sergey Kim on 19.02.2018.
//  Copyright © 2018 KS. All rights reserved.
//

import Foundation
import IKEventSource

typealias SourceMessage = (id: String?, event: String?, data: String?)

protocol EventsDataProviderDelegate: class {
    func sourceOpened(_ provider: EventsDataProvider)
    func provider(_ provider: EventsDataProvider, didReceiveError error: Error?)
    func provider(_ provider: EventsDataProvider, didReceiveMessage message: SourceMessage)
}

final class EventsDataProvider {
    
    weak var delegate: EventsDataProviderDelegate?
    private var eventSource: EventSource?
    
    var isListening: Bool {
        return eventSource != nil
    }
    
    func startListening() {
        guard eventSource == nil else {
            return
        }
        eventSource = createEventSource()
    }
    
    func stopListening() {
        eventSource?.close()
        eventSource = nil
    }
    
    private func createEventSource() -> EventSource {
        let source = EventSource(url: sseHost)
        
        source.onOpen { [weak self] in
            guard let `self` = self else { return }
            self.delegate?.sourceOpened(self)
        }
        
        source.onError { [weak self] error in
            guard let `self` = self else { return }
            self.delegate?.provider(self, didReceiveError: error)
        }
        
        source.onMessage { [weak self] (id, event, data) in
            guard let `self` = self else { return }
            let message = (id: id, event: event, data: data)
            self.delegate?.provider(self, didReceiveMessage: message)
        }
        
        return source
    }
}
