//
//  LanguageView.swift
//  Notes
//
//  Created by Руслан Канжарбеков on 21.03.2024.
//

import UIKit

struct Language {
    let name: String
    let flag: UIImage
}

protocol LanguageViewDelegate: AnyObject {
    func didLanguageSelect(LanguageType: LanguageType)
}

class LanguageView: UIViewController {
    
    private var settingTableView = SettingsView()
    
    weak var delegate: LanguageViewDelegate?
    
    let languages: [Language] = [
        Language(name: "Кыргызча", flag: UIImage(named: "kyrgyz_flag")!),
        Language(name: "Русский", flag: UIImage(named: "russian_flag")!),
        Language(name: "English", flag: UIImage(named: "english_flag")!)
    ]
    let cellIdentifier = "languageCell"
    
    private let languageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Выберите язык"
        return label
    }()
    
    private let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 50
        tableView.layer.cornerRadius = 15
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(languageLabel)
        view.addSubview(seperatorView)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            languageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            languageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            languageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            languageLabel.heightAnchor.constraint(equalToConstant: 30),
            
            seperatorView.topAnchor.constraint(equalTo: languageLabel.bottomAnchor, constant: 10),
            seperatorView.leftAnchor.constraint(equalTo: view.leftAnchor),
            seperatorView.rightAnchor.constraint(equalTo: view.rightAnchor),
            seperatorView.heightAnchor.constraint(equalToConstant: 2),
            
            tableView.topAnchor.constraint(equalTo: seperatorView.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LanguageCell.self, forCellReuseIdentifier: cellIdentifier)
    }
}

// MARK: - TableView DataSource Methods
extension LanguageView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! LanguageCell
        let language = languages[indexPath.row]
        cell.configure(with: language)
        return cell
    }
}

// MARK: - TableView Delegate Methods
extension LanguageView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            AppLanguageManager.shared.setAppLanguage(language: .kg)
            delegate?.didLanguageSelect(LanguageType: .kg)
        case 1:
            AppLanguageManager.shared.setAppLanguage(language: .ru)
            delegate?.didLanguageSelect(LanguageType: .ru)
        case 2:
            AppLanguageManager.shared.setAppLanguage(language: .en)
            delegate?.didLanguageSelect(LanguageType: .en)
        default:
            ()
        }
        dismiss(animated: true)
    }
}
