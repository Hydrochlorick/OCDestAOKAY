//
//  Medication.swift
//  OCDisAOK
//
//  Created by Rick Jacobson on 1/12/21.
//

import Foundation

enum massUnit : String, CaseIterable, Codable { // Cool units only
    case miligram = "mg"
    case microgram = "ug"
    case milliliter = "mL"
    case cubicCentimeter = "cc"
    case internationalUnit = "IU" // Just kidding we'll have to add this one even though it isn't cool. Fuckin Vitamin D.
}

// TODO: Make an enum of SF Symbols to be used as icons for our TableView

// Design a struct to contain Medication information
struct Medication: Codable {
    var name: String
    var dose: Float
    var units: massUnit
    
    var lastDoseDate: Date?
    var dosesTaken: Int = 0
    
    var currentStreak: Int = 0
    var bestStreak: Int = 0
    
    var completedToday: Bool {
        return lastDoseDate?.isToday ?? false
    }

}
