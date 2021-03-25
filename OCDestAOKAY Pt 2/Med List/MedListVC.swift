//
//  MedListVC.swift
//  OCDestAOKAY Pt 2
//
//  Adapted from Make School Habitual Tutorial

import UIKit

class MedListVC: UIViewController {
    
    private var persistence = PersistenceLayer()
    
    let medTableView = UITableView()
    
    var meds: [Medication] = []
    
//    let testMeds: [Medication] = [
//        Medication(name: "Chicken Nuggets", dose: 20, units: .miligram),
//        Medication(name: "Alcohol", dose: 100, units: .milliliter)
//    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "notTooBlack")
        self.title = "My Medications"
        
                
        setupNavBar()
        setupTableView()
    }
    
    func setupNavBar() {
        navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func setupTableView() {
        
        medTableView.register(MedTVCell.self, forCellReuseIdentifier: "cell")
        medTableView.backgroundColor = UIColor(named: "notTooBlack")
        
        medTableView.dataSource = self
        medTableView.delegate = self

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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedMed = persistence.meds[indexPath.row]
        let medDeatilVC = MedDetailVC()
        medDeatilVC.detailedMed = selectedMed
        medDeatilVC.medIndex = indexPath.row
        
        navigationController?.pushViewController(medDeatilVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let medIndexToDelete = indexPath.row
            let medToDelete = persistence.meds[medIndexToDelete]
            
            let deleteAlert = UIAlertController(medTitle: medToDelete.name) {
                self.persistence.deleteMed(medIndexToDelete)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            
            self.present(deleteAlert, animated: true)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        persistence.swapMeds(medIndex: sourceIndexPath.row, destinationIndex: destinationIndexPath.row)
    }
    
}

extension UIAlertController {
    convenience init(medTitle: String, comfirmHandler: @escaping () -> Void) {
            self.init(title: "Delete Medication", message: "Are you sure you want to delete \(medTitle)?", preferredStyle: .actionSheet)

            let confirmAction = UIAlertAction(title: "Confirm", style: .destructive) { _ in
                comfirmHandler()
            }
            self.addAction(confirmAction)

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            self.addAction(cancelAction)
        }

}
