//
//  LanguageCell.swift
//  Notes
//
//  Created by Руслан Канжарбеков on 22.03.2024.
//

import UIKit

// MARK: - Custom Cell
class LanguageCell: UITableViewCell {
    private let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let languageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .secondarySystemBackground
        contentView.addSubview(flagImageView)
        contentView.addSubview(languageLabel)
        
        NSLayoutConstraint.activate([
            flagImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            flagImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            flagImageView.widthAnchor.constraint(equalToConstant: 32),
            flagImageView.heightAnchor.constraint(equalToConstant: 32),
            
            languageLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            languageLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            languageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with language: Language) {
        flagImageView.image = language.flag
        languageLabel.text = language.name
    }
}
