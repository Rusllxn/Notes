//
//  HomeCell.swift
//  Notes
//
//  Created by Руслан Канжарбеков on 29.02.2024.
//

import UIKit
import SnapKit

class NoteCollectionViewCell: UICollectionViewCell {
    
    static var reuseID = "note_cell"
    
    let colors : [UIColor] = [.systemPink, .systemBrown, .systemPurple, .systemIndigo, .systemBlue, .systemOrange, .systemGreen, .systemRed, .systemTeal]
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        layer.cornerRadius = 10
        backgroundColor = colors.randomElement()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(title: String) {
        titleLabel.text = title
    }
    
    private func setupLayout() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.left.right.equalToSuperview().inset(10)
        }
    }
}
