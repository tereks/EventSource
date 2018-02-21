//
//  MeasurementsConfigurator.swift
//  EventSource
//
//  Created by Sergey Kim on 21.02.2018.
//  Copyright © 2018 KS. All rights reserved.
//

import UIKit

final class MeasurementsConfigurator {
    
    class func createNavigationController() -> UINavigationController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let navController = storyboard.instantiateInitialViewController() as? UINavigationController,
            let controller = navController.topViewController as? MeasurementsViewController else {
                fatalError("Cannot find MeasurementsViewController")
        }
        
        let presenter    = MeasurementsPresenter()
        presenter.view   = controller
        
        let interactor   = MeasurementsInteractor()
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        controller.presenter = presenter
        return navController
    }
}
