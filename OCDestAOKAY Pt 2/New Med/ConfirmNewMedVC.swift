//
//  ConfirmNewMed.swift
//  OCDestAOKAY Pt 2
//
//  Created by Rick Jacobson on 3/23/21.
//

import UIKit

class ConfirmNewMedVC: UIViewController {
    
    var medToConfirm: Medication!
    
    var confirmMedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "pills.fill") // Just for now
        return imageView
    }()
    
    var confirmMedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        label.textAlignment = .center
        label.textColor = UIColor(named: "offWhite")
        return label
    }()
    
    let confirmButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "orangeRed")
        button.setTitleColor(UIColor(named: "notTooBlack"), for: .normal)
        button.setTitle("Confirm", for: .normal)
        button.layer.cornerRadius = 15
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIJazz()
    }
    

    func setupUIJazz() {
        self.view.backgroundColor = UIColor(named: "notTooBlack")
        
        self.view.addSubview(confirmMedImageView)
        NSLayoutConstraint.activate([
            confirmMedImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            confirmMedImageView.bottomAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100),
            confirmMedImageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3)
        ])
        
        self.view.addSubview(confirmMedLabel)
        NSLayoutConstraint.activate([
            confirmMedLabel.topAnchor.constraint(equalTo: confirmMedImageView.bottomAnchor, constant: 40),
            confirmMedLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        confirmMedLabel.text = "\(medToConfirm.dose)\(medToConfirm.units.rawValue) \(medToConfirm.name)"
        
        self.view.addSubview(confirmButton)
        NSLayoutConstraint.activate([
            confirmButton.topAnchor.constraint(equalTo: confirmMedLabel.bottomAnchor, constant: 50),
            confirmButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            confirmButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4)
        ])
        confirmButton.addTarget(self, action: #selector(confirmButtonPressed), for: .touchUpInside)
    }

    @objc func confirmButtonPressed() {
        var persistenceLayer = PersistenceLayer()
        persistenceLayer.createNewMed(createdMed: medToConfirm)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }

}
