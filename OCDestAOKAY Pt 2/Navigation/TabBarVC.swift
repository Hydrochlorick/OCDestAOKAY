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
    
    
    func setupViewControllers(){
        
        let medListView = MedListVC()
        let medListController = UINavigationController(rootViewController: medListView)
        medListView.tabBarItem = UITabBarItem(title: "Meds", image: UIImage(systemName: "pills"), selectedImage: UIImage(systemName: "pills.fill"))
        
        let newMedView = NewMedVC()
        let newMedController = UINavigationController(rootViewController: newMedView)
        newMedView.tabBarItem = UITabBarItem(title: "New Med", image: UIImage(systemName: "plus.square.on.square"), selectedImage: UIImage(systemName: "plus.square.fill.on.square.fill"))
        
        viewControllers = [medListController, newMedController]
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
