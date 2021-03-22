//
//  PersistenceLayer.swift
//  OCDestAOKAY Pt 2
//
//  Created by Rick Jacobson on 3/22/21.
//  Adapted from Make School Habitual Tutorial
// It's actually hilarious how similar my concept is to the tutorial that was planned for MOB 1.2


import Foundation

/*
 Everything we do needs to persist when the user leaves the app if we want this to be useful at all. So for every state change or data entry we have the user do, we also have to have a PersistenceLayer version of that action that saves it. We'll be using the UserDefaults class to save these Medications for now.
 */

struct PersistenceLayer {
    
    // Can't say I fully understand any of this
    private(set) var meds: [Medication] = []
    
    private static let userDefaultsMedsKeyValue = "MEDS_ARRAY"
    
    init() {
        self.loadMeds()
    }
    
    private mutating func loadMeds() {
        
        // Make a UserDefaults object
        let userDefaults = UserDefaults.standard
        
        // Wtf is this syntax? I do not get "guard" statements.
        guard
            let medData = userDefaults.data(forKey: PersistenceLayer.userDefaultsMedsKeyValue),
            let meds = try? JSONDecoder().decode([Medication].self, from: medData) else {
                return
        }
        
        self.meds = meds
    }
    
    @discardableResult
    mutating func createNewMed(name: String, dose: Float, unit: massUnit) -> Medication {
        
        let newMed = Medication(name: name, dose: dose, units: unit)
        self.meds.insert(newMed, at: 0) // Wonder if prepending the new med every time is going to bite me in the butt
        self.saveMeds()
        
        return newMed
    }
    
    private func saveMeds() {
        
        // This makes very little sense to me. I understand what it does, but not how it does it.
        guard let medData = try? JSONEncoder().encode(self.meds) else {
            fatalError("He's dead, Jim")
        }
        
        let userDefaults = UserDefaults.standard // Because we forgot the one contained in the function above
        userDefaults.setValue(medData, forKey: PersistenceLayer.userDefaultsMedsKeyValue)
        // Looks like userDefaults.synchronize() is no longer necessary to get this to work. Let's hope we don't bump into any issues
    }
    
    mutating func deleteMed(_ medIndex: Int) {  // Fuckin knew it
        
        self.meds.remove(at: medIndex)
        
        self.saveMeds()
    }
    
    mutating func markMedAsTaken(_ medIndex: Int) -> Medication {
        
        var updatedMedication = self.meds[medIndex]
        
        guard updatedMedication.completedToday == false else {return updatedMedication} // Holy shit I think I get guard statements now
        
        updatedMedication.dosesTaken += 1
        
        // If medication was taken yesterday
        if let lastDoseDate = updatedMedication.lastDoseDate, lastDoseDate.isYesterday {
            // Then add 1 to our streak
            updatedMedication.currentStreak += 1
        } else {
            // Gotta start somewhere
            updatedMedication.currentStreak = 1
        }
        
        // Is this a new record?
        if updatedMedication.currentStreak > updatedMedication.bestStreak {
            updatedMedication.bestStreak = updatedMedication.currentStreak
        }
        
        let now = Date()    // Creates a date object for the moment in time that this function is called. I think
        updatedMedication.lastDoseDate = now
        
        self.meds[medIndex] = updatedMedication
        
        self.saveMeds()
        
        return updatedMedication
    }
    
    // BUT WHAT IF USERS DON'T LIKE THE RANDOM ORDER OF MEDS? WELL THANKS FOR ASKING, LITTLE VOICE IN MY HEAD
    mutating func swapMeds(medIndex: Int, destinationIndex: Int) {
        let medToSwap = self.meds[medIndex]
        self.meds.remove(at: medIndex)
        self.meds.insert(medToSwap, at: destinationIndex)
        self.saveMeds()
        
        // There's probably a way to do this in one line, but let's not faff about where we shouldn't
    }
    
    // Reload the stuff we saved into the variables that we're currently using to reflect changes
    mutating func setNeedsToReloadMeds() {
        self.loadMeds()
    }
}
