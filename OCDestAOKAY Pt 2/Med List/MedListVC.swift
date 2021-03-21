//
//  MedListVC.swift
//  OCDestAOKAY Pt 2
//
//  Created by Rick Jacobson on 3/19/21.
//

import UIKit

class MedListVC: UIViewController {
    
    let medTableView = UITableView()
    
    var meds: [Medication] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "notTooBlack")
        
        medTableView.register(MedTVCell.self, forCellReuseIdentifier: "cell")
        
        medTableView.dataSource = self
        medTableView.delegate = self
    }
    

    /*
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MedListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
