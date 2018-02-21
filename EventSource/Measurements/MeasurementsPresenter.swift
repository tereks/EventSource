//
//  MeasurementsPresenter.swift
//  EventSource
//
//  Created by Sergey Kim on 21.02.2018.
//  Copyright © 2018 KS. All rights reserved.
//

import UIKit

final class MeasurementsPresenter {
    
    var interactor: MeasurementsInteractor!
    weak var view: MeasurementsViewInterface!
    
    func setup() {
        
    }
    
    func listeningStateChange(isListening: Bool) {
        if isListening {
            interactor.startListenSSE()
            view.setActionBarTitle("Stop")
        }
        else {
            interactor.stopListenSSE()
            view.setActionBarTitle("Start")
        }
    }
    
    func isListeningToSSE() -> Bool {
        return interactor.dataProvider.isListening
    }
    
    func addItems(_ items: [MeasurementUIModel]) {
        view.addItems(items)
        view.reloadData()
    }
}
