//
//  SettingsView.swift
//  Notes
//
//  Created by Руслан Канжарбеков on 24.02.2024.
//

import UIKit
import SnapKit

protocol SettingsViewProtocol {
    func successTitles(titles: [String])
    func successImages(images: [UIImage])
    func successCellTexts(cellTexts: [String])
}

protocol Reloadable {
    func reloadData()
}

// MARK: - SettingsView
class SettingsView: UIViewController {
    
    var selectedLanguage: LanguageType?
    
    private var controller: SettingsControllerProtocol?
    
    private var titles: [String] = []
    private var images: [UIImage] = []
    
    // MARK: - Private Property
    
    private lazy var settingTableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 55
        view.isScrollEnabled = false
        view.layer.cornerRadius = 10
        view.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        view.register(NoteTableViewCell.self, forCellReuseIdentifier: NoteTableViewCell.reuseID)
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.bool(forKey: "theme") == true {
            overrideUserInterfaceStyle = .dark
        } else {
            overrideUserInterfaceStyle = .light
        }
        navigationItem.title = "Settings".localized()
    }
}

// MARK: - Setting Views
private extension SettingsView {
    func setupView() {
        view.backgroundColor = .systemBackground
        addSubviews()
        setupLayout()
        controller = SettingsController(view: self)
        controller?.onGetTitles()
        controller?.onGetImages()
    }
}

// MARK: - Setting
private extension SettingsView {
    func addSubviews() {
        view.addSubview(settingTableView)
    }
}

// MARK: - Layout
private extension SettingsView {
    func setupLayout() {
        settingTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(165)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SettingsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.reuseID, for: indexPath) as! NoteTableViewCell
        if indexPath.row == 0 {
            cell.button.isHidden = false
        } else {
            cell.button.isHidden = true
        }
        if indexPath.row == 1 {
            cell.switchButton.isHidden = false
        } else {
            cell.switchButton.isHidden = true
        }
        cell.switchHandler = { isOn in
            print(isOn)
        }
        cell.delegate = self
        cell.setup(title: titles[indexPath.row])
        cell.setup(image: images[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let languageView = LanguageView()
            languageView.delegate = self
            let multiplier = 0.35
            let customDetent = UISheetPresentationController.Detent.custom(resolver: { context in
                languageView.view.frame.height * multiplier
            })
            if let sheet = languageView.sheetPresentationController {
                sheet.detents = [customDetent, .medium()]
                sheet.prefersGrabberVisible = true
            }
            self.present(languageView, animated: true)
        }
    }
}

// MARK: - SettingsViewProtocol
extension SettingsView: SettingsViewProtocol {
    func successTitles(titles: [String]) {
        self.titles = titles
        settingTableView.reloadData()
    }
    
    func successImages(images: [UIImage]) {
        self.images = images
        settingTableView.reloadData()
    }
    
    func successCellTexts(cellTexts: [String]) {
        guard let selectedLanguage = selectedLanguage else {
            return
        }
        
        for (index, text) in cellTexts.enumerated() {
            if let cell = settingTableView.cellForRow(at: IndexPath(row: index, section: 0)) as? NoteTableViewCell {
                cell.setup(title: text)
                if index == 0 {
                    cell.setupButtonTitle(title: text, language: selectedLanguage)
                }
            }
        }
    }
}

extension SettingsView: SettingsCellDelegate {
    func didSwitchOn(isOn: Bool) {
        UserDefaults.standard.set(isOn, forKey: "theme")
        if isOn {
            overrideUserInterfaceStyle = .dark
        } else {
            overrideUserInterfaceStyle = .light
        }
    }
}

extension SettingsView: LanguageViewDelegate {
    func didLanguageSelect(LanguageType: LanguageType) {
        navigationItem.title = "Settings".localized()
        selectedLanguage = LanguageType
        controller?.onGetTitles()
        settingTableView.reloadData()
        controller?.onGetCellTexts()
    }
}


