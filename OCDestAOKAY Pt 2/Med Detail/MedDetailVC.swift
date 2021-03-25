//
//  MedDetailVC.swift
//  OCDestAOKAY Pt 2
//
//  Adapted from Make School Habitual Tutorial
//

import UIKit

class MedDetailVC: UIViewController {
    
    var detailedMed: Medication!
    var medIndex: Int!
    
    private var persistence = PersistenceLayer()
    
    // Current Streak label
    @IBOutlet weak var currentStreakLabel: UILabel!
    
    // Number Labels
    @IBOutlet weak var totalTakenLabel: UILabel!
    @IBOutlet weak var bestStreakLabel: UILabel!
    @IBOutlet weak var streakStartDateLabel: UILabel!
    
    // THE BUTTON
    @IBOutlet weak var doseTakenButton: UIButton!
    
    override func viewDidLoad() {
        // Couldn't figure out how to do this in the story board editor
        doseTakenButton.layer.cornerRadius = 15
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }

    @IBAction func doseTakenButtonPressed(_ sender: Any) {
        // Allow them to take more than once per day
        if detailedMed.completedToday == true {
            detailedMed.numberOfDosesTaken += 1
            updateUI()
        } else {
            // If they haven't taken it yet today
            detailedMed = persistence.markMedAsTaken(medIndex)
            updateUI()
        }
    }
    
    private func updateUI() {
        self.title = detailedMed.name
        currentStreakLabel.text = "\(detailedMed.currentStreak) days"
        totalTakenLabel.text = String(detailedMed.numberOfDosesTaken)
        bestStreakLabel.text = String(detailedMed.bestStreak)
        streakStartDateLabel.text = detailedMed.streakStartDate?.stringValue
        
    }

}
