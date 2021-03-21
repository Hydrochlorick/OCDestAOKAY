//
//  Medication.swift
//  OCDisAOK
//
//  Created by Rick Jacobson on 1/12/21.
//

import Foundation

enum massUnit : String, CaseIterable { // Cool units only
    case miligram = "mg"
    case microgram = "ug"
    case milliliter = "mL"
    case cubicCentimeter = "cc"
    case internationalUnit = "IU" // Just kidding we'll have to add this one even though it isn't cool. Fuckin Vitamin D.
}

// Design a struct to contain Medication information
struct Medication {
    let name: String
    let dose: Float
    let units: massUnit
}
