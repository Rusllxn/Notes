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

class LanguageView: UIViewController {
    
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
        label.textAlignment = .center
        return label
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
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            languageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            languageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            languageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            languageLabel.heightAnchor.constraint(equalToConstant: 30),
            
            tableView.topAnchor.constraint(equalTo: languageLabel.bottomAnchor, constant: 20),
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
        let selectedLanguage = languages[indexPath.row].name
        print("Selected Language: \(selectedLanguage)")
    }
}

// MARK: - Custom Cell
class LanguageCell: UITableViewCell {
    private let flagImageView: UIImageView = {
        let imageView = UIImageView()
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
