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
        textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return textField
    }()
    
    // Dose view input
    let doseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Dose"
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        label.textColor = UIColor(named: "offWhite")
        return label
    }()
    let doseStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        return stackView
    }()
    let newMedDose: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "0"
        textField.textAlignment = .right
        textField.backgroundColor = UIColor(named: "offWhite")
        // LOOK AT ALL THESE FUN THINGS WE CAN DO WITH TEXT FIELDS
        textField.deleteBackward()
//        textField.keyboardType = .numberPad
        textField.keyboardAppearance = .dark
        return textField
    }()
    var unitPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
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
        self.title = "New Medication"
        
        unitPicker.delegate = self
        
        setupUIElements()
    }
    
    func setupUIElements() {
        
        // One subview at a time
        // Medication Name
        self.view.addSubview(medLabel)
        medLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        medLabel.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 30).isActive = true
        
        // New Med Text Fiels
        self.view.addSubview(newMedName)
        newMedName.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        newMedName.topAnchor.constraint(equalTo: medLabel.bottomAnchor, constant: 10).isActive = true
        newMedName.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        
        // Dose
        self.view.addSubview(doseLabel)
        doseLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        doseLabel.topAnchor.constraint(equalTo: newMedName.bottomAnchor, constant: 50).isActive = true
        
        // Dose text field and unit picker
        self.view.addSubview(doseStack)
        doseStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        doseStack.topAnchor.constraint(equalTo: doseLabel.bottomAnchor, constant: 10).isActive = true
        doseStack.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75).isActive = true
        doseStack.addArrangedSubview(newMedDose)
//        newMedDose.heightAnchor.constraint(equalToConstant: 35).isActive = true
        // I can't adjust the size of the PickerView without making the textfield look silly
        // I'm pretty salty about it
        doseStack.addArrangedSubview(unitPicker)
        unitPicker.heightAnchor.constraint(equalToConstant: 60).isActive = true

        // Add Medication Button
        self.view.addSubview(addButton)
        addButton.topAnchor.constraint(equalTo: doseStack.bottomAnchor, constant: 80).isActive = true
        addButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        addButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4).isActive = true
    }
    

    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
        // Who fuckin knows
    }
    
    
}
