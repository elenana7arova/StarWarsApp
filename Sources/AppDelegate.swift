//
//  AppDelegate.swift
//  StarWarsApp
//
//  Created by Elena Nazarova on 25.08.2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let mainController = UINavigationController(rootViewController: MainViewController())
        mainController.navigationBar.prefersLargeTitles = true
        mainController.tabBarItem = UITabBarItem(title: nil,
                                                 image: UIImage(named: "death-star"),
                                                 selectedImage: UIImage(named: "death-star-fill"))
        
        let favouritesController = UINavigationController(rootViewController: FavouritesViewController())
        favouritesController.navigationBar.prefersLargeTitles = true
        favouritesController.tabBarItem = UITabBarItem(title: nil,
                                                       image: UIImage(systemName: "heart"),
                                                       selectedImage: UIImage(systemName: "heart.fill"))
        
        let tabBarController = UITabBarController(nibName: nil, bundle: nil)
        tabBarController.viewControllers = [mainController, favouritesController]
        tabBarController.tabBar.unselectedItemTintColor = .white
        
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .black
        appearance.stackedLayoutAppearance.normal.iconColor = .white
        appearance.stackedLayoutAppearance.selected.iconColor = .yellow
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        
        window.makeKeyAndVisible()
        window.rootViewController = tabBarController
        
        self.window = window
        return true
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "StarWarsApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = self.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
