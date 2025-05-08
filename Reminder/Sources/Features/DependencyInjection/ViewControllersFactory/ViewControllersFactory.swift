//
//  ViewControllersFactory.swift
//  Reminder
//
//  Created by Gabriel Roveri on 15/04/25.
//

import UIKit

final class ViewControllersFactory: ViewControllersFactoryProtocol {
    func makeNewRecipesViewController() -> NewRecipeViewController {
        NewRecipeViewController()
    }
    
    
    func makeSplashController(delegate: any SplashFlowDelegate) -> SplashViewController {
        let splashView = SplashView()
        let vc = SplashViewController(contentView: splashView, delegate: delegate)
        
        return vc
    }
    
    func makeLoginBottomSheetViewController(delegate: any LoginBottomSheetFlowDelegate) -> LoginBottomSheetViewController {
        let contentView = LoginBottomSheetView()
        let vc = LoginBottomSheetViewController(contentView: contentView, delegate: delegate)
        
        return vc
    }
    
    func makeHomeViewController(delegate: any HomeFlowDelegate) -> HomeViewController {
        let contentView = HomeView()
        let viewController = HomeViewController(contentView: contentView, delegate: delegate)
        
        return viewController
    }
    
    func makeMyRecipesViewController(delegate: any MyRecipesFlowDelegate) -> MyRecipesViewController {
        let contentView = MyRecipesView()
        let vc = MyRecipesViewController(contentView: contentView, delegate: delegate)
        
        return vc
    }
}
