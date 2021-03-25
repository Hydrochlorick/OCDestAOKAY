//
//  NewMedVC.swift
//  OCDestAOKAY Pt 2
//
//  Created by Rick Jacobson on 3/18/21.
//

import UIKit

class NewMedVC: UIViewController {
    
    // Medication Name Input
    let medLabel: UILabel = {
        let medLabel = UILabel()
        medLabel.translatesAutoresizingMaskIntoConstraints = false
        medLabel.text = "Medication Name"
        medLabel.textColor = UIColor(named: "offWhite")
        medLabel.font = UIFont(name: "Helvetica-Bold", size: 20)
        return medLabel
    }()
    let newMedName: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Aspirin"
        textField.textAlignment = .center
        textField.backgroundColor = UIColor(named: "offWhite")
        textField.keyboardAppearance = .dark
        textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return textField
    }()
    
    // Dose view input
    let doseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Dosage"
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        label.textColor = UIColor(named: "offWhite")
        return label
    }()
//    let doseStack: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .horizontal
//        stackView.spacing = 10
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.distribution = .fillEqually
//        return stackView
//    }()
    let newMedDose: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "0"
        textField.textAlignment = .right
        textField.backgroundColor = UIColor(named: "offWhite")
        // LOOK AT ALL THESE FUN THINGS WE CAN DO WITH TEXT FIELDS
        textField.deleteBackward()
        textField.keyboardType = .numberPad
        textField.keyboardAppearance = .dark
        return textField
    }()
    
    // Unit Picker Input
    let unitsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Units"
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        label.textColor = UIColor(named: "offWhite")
        return label
    }()
    var unitPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.tintColor = UIColor(named: "offWhite")
        return picker
    }()
    var chosenUnit: massUnit! = .miligram
    
    // Add Medication Button
    let addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "orangeRed")
        button.setTitleColor(UIColor(named: "notTooBlack"), for: .normal)
        button.setTitle("Add Medication", for: .normal)
        button.layer.cornerRadius = 15
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "notTooBlack")
        self.title = "Add New Medication"
        
        unitPicker.delegate = self
        
        setupUIElements()
    }
        

    
    func setupUIElements() {
        
        // One subview at a time
        // Medication Name Label
        self.view.addSubview(medLabel)
        medLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        medLabel.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 30).isActive = true
        // New Med Text Field
        self.view.addSubview(newMedName)
        newMedName.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        newMedName.topAnchor.constraint(equalTo: medLabel.bottomAnchor, constant: 10).isActive = true
        newMedName.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        
        // Dose Label
        self.view.addSubview(doseLabel)
        doseLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        doseLabel.topAnchor.constraint(equalTo: newMedName.bottomAnchor, constant: 50).isActive = true
        // New Dose Text Field
        self.view.addSubview(newMedDose)
        newMedDose.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        newMedDose.topAnchor.constraint(equalTo: doseLabel.bottomAnchor, constant: 10).isActive = true
        newMedDose.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.25).isActive = true

        // Units Label
        self.view.addSubview(unitsLabel)
        unitsLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        unitsLabel.topAnchor.constraint(equalTo: newMedDose.bottomAnchor, constant: 50).isActive = true
        
        // Unit PickerView
        self.view.addSubview(unitPicker)
        unitPicker.topAnchor.constraint(equalTo: unitsLabel.bottomAnchor, constant: 10).isActive = true
        unitPicker.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        unitPicker.heightAnchor.constraint(equalToConstant: 100).isActive = true

        // Add Medication Button
        self.view.addSubview(addButton)
        addButton.topAnchor.constraint(equalTo: unitPicker.bottomAnchor, constant: 50).isActive = true
        addButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        addButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4).isActive = true
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
    }
    
    @objc func addButtonPressed() {
        
        let givenMedName = newMedName.text!
        
        // Will crash if user inputs text insead of a number, but that's only doable with a hardware keyboard
        // TODO: Learn about data validation
        guard let givenMedDose = Float(newMedDose.text!) else {fatalError("You're drunk, go home")}
        let givenMedication = Medication(name: givenMedName, dose: givenMedDose, units: chosenUnit)
        
        let confirmationVC = ConfirmNewMedVC()
        confirmationVC.medToConfirm = givenMedication
        navigationController?.present(confirmationVC, animated: true, completion: nil)
    }
    


}

extension NewMedVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return massUnit.allCases[row].rawValue
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return massUnit.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.chosenUnit = massUnit.allCases[pickerView.selectedRow(inComponent: component)]
        print("We've selected \(chosenUnit.rawValue)")  // IT WORKS!
    }
    
    
}
