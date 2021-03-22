//
//  TabBarVC.swift
//  OCDestAOKAY
//
//  Created by Rick Jacobson on 2/14/21.
//

import UIKit

class TabBarVC: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = UIColor(named: "orangeRed")
        self.tabBar.barTintColor = UIColor(named: "notTooBlack")
        self.tabBar.unselectedItemTintColor = .lightGray
        setupViewControllers()
        // Do any additional setup after loading the view.
    }
    
//    func setupTabBarIcons(){
//        
//    }
    
    func setupViewControllers(){
        
        let homeView = HomeVC()
        let homeNavController = UINavigationController(rootViewController: homeView)
        homeView.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        let medListView = MedListVC()
        let medListController = UINavigationController(rootViewController: medListView)
        medListView.tabBarItem = UITabBarItem(title: "Meds", image: UIImage(systemName: "list.bullet"), selectedImage: UIImage(systemName: "list.triangle"))
        
        let newMedView = NewMedVC()
        let newMedController = UINavigationController(rootViewController: newMedView)
        newMedView.tabBarItem = UITabBarItem(title: "New Med", image: UIImage(systemName: "pills"), selectedImage: UIImage(systemName: "pills.fill"))
        
        viewControllers = [homeNavController, medListController, newMedController]
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
