//
//  SettingsCell.swift
//  Notes
//
//  Created by Руслан Канжарбеков on 24.02.2024.
//

import UIKit
import SnapKit

enum SetingsCellType {
    case none
    case withSwitch
    case wothButton
}

struct Settings {
    var leftImage: String
    var title: String
    var type: SetingsCellType
    var description: String
}

protocol SettingsCellDelegate: AnyObject {
    func didSwitchOn(isOn: Bool)
}

class NoteTableViewCell: UITableViewCell {
    
    static let reuseID = "note_cell"
    
    weak var delegate: SettingsCellDelegate?
    
    var switchHandler: ((Bool) -> ())?
    
    private lazy var settingImageView: UIImageView = {
        let view = UIImageView()
        view.tintColor = UIColor.label
        return view
    }()
    
    private lazy var settingTitleLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.label
        return view
    }()
    
    lazy var button: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        view.setTitle("Русский", for: .normal)
        view.setTitleColor(.secondaryLabel, for: .normal)
        view.tintColor = UIColor.label
        view.semanticContentAttribute = .forceRightToLeft
        view.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -15)
        return view
    }()
    
    lazy var switchButton: UISwitch = {
        let view = UISwitch()
        view.isOn = UserDefaults.standard.bool(forKey: "theme")
        view.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(settingImageView)
        contentView.addSubview(settingTitleLabel)
        contentView.addSubview(button)
        contentView.addSubview(switchButton)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func switchValueChanged() {
        delegate?.didSwitchOn(isOn: switchButton.isOn)
    }
    
    func setup(settings: Settings) {
        settingImageView.image = UIImage(systemName: settings.leftImage)
        settingTitleLabel.text = settings.title
        switch settings.type {
        case .none:
            button.isHidden = true
            switchButton.isHidden = true
        case .withSwitch:
            button.isHidden = true
        case .wothButton:
            switchButton.isHidden = true
            button.setTitle(settings.description, for: .normal)
            
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        settingImageView.image = nil
        settingTitleLabel.text = nil
    }
    
    func setup(title: String) {
        settingTitleLabel.text = title
    }
    
    func setup(image: UIImage) {
        settingImageView.image = image
    }
    
    private func setupLayout() {
        settingImageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).offset(16)
            make.width.height.equalTo(24)
        }
        
        settingTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(settingImageView.snp.trailing).offset(13)
        }
        
        button.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView).offset(-25)
        }
        
        switchButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView).offset(-25)
        }
    }
}
