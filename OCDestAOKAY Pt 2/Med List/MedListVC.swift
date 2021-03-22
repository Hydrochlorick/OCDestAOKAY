//
//  MedListVC.swift
//  OCDestAOKAY Pt 2
//
//  Created by Rick Jacobson on 3/19/21.
//

import UIKit

class MedListVC: UIViewController {
    
    private var persistence = PersistenceLayer()
    
    let medTableView = UITableView()
    
    var meds: [Medication] = []
    
    let testMeds: [Medication] = [
        Medication(name: "Chicken Nuggets", dose: 20, units: .miligram),
        Medication(name: "Alcohol", dose: 100, units: .milliliter)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "notTooBlack")
        
        medTableView.register(MedTVCell.self, forCellReuseIdentifier: "cell")
        medTableView.backgroundColor = UIColor(named: "notTooBlack")
        
        medTableView.dataSource = self
        medTableView.delegate = self
        
        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(medTableView)
        medTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            medTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            medTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            medTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            medTableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        persistence.setNeedsToReloadMeds()
        medTableView.reloadData()
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
        return persistence.meds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MedTVCell
        cell.selectionStyle = .blue
        let med = persistence.meds[indexPath.row]
        cell.fillCell(med: med)
        return cell
    }
    
    
}
