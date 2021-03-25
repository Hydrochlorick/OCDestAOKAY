//
//  MedTVCell.swift
//  OCDestAOKAY Pt 2
//
//  Created by Rick Jacobson on 3/19/21.
//

import UIKit

class MedTVCell: UITableViewCell {
    // Even when my Table View Cells are formated exactly like default ones, I still feel compelled to set everything up manually. Maybe I'll kick that habit eventually
    
    // Create UI Elements
    let cellStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    let medLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 20)
        label.textColor = UIColor(named: "offWhite")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    let medImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.tintColor = UIColor(named: "orangeRed")
        return image
    }()
    
    // init OUR way
    // Which is basically their way, anyway
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    func setupCell() {
        contentView.addSubview(cellStack)
        self.backgroundColor = UIColor(named: "notTooBlack")
        
        // Setup stackView constraints the fancy way
        NSLayoutConstraint.activate([
            cellStack.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.85),
            cellStack.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.75),
            cellStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cellStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        cellStack.addArrangedSubview(medImage)
        medImage.leftAnchor.constraint(equalTo: cellStack.leftAnchor, constant: 10).isActive = true
        
        cellStack.addArrangedSubview(medLabel)
        medLabel.rightAnchor.constraint(equalTo: cellStack.rightAnchor).isActive = true
//        medLabel.widthAnchor.constraint(equalTo: cellStack.widthAnchor, multiplier: 0.6).isActive = true
    }
    
    func fillCell(med: Medication) {
        // TODO It'd be cool to have a database of images of chemical structures or brand names for these, one day
        medImage.image = UIImage(systemName: "pills.fill")
        medLabel.text = "\(med.dose)\(med.units.rawValue) \(med.name)"
        
        if med.completedToday {
            self.accessoryType = .checkmark
        } else {
            self.accessoryType = .none
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. But wtf even is that anyway?")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Still not sure what this does. Bet I can do something nifty with it. TODO: Look it up later
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
