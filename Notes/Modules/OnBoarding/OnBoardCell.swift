//
//  OnBoardCell.swift
//  Notes
//
//  Created by Руслан Канжарбеков on 05.03.2024.
//

import UIKit
import SnapKit

class OnBoardCell: UICollectionViewCell {
    
    static var reuseID = "on_board_cell"
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        view.spacing = 20
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.preferredFont(forTextStyle: .title1)
        return view
    }()
    
    lazy var subtitleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.preferredFont(forTextStyle: .body)
        view.textColor = .secondaryLabel
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(title: String) {
        titleLabel.text = title
    }
    
    func setup(subtitle: String) {
        subtitleLabel.text = subtitle
    }
    
    func setup(image: UIImage) {
        imageView.image = image
    }
    
    private func setupLayout() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.width.equalTo(320)
        }
    }
}
