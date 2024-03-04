//
//  HomeView.swift
//  Notes
//
//  Created by Руслан Канжарбеков on 21.02.2024.
//

import UIKit
import SnapKit

protocol HomeViewProtocol {
    func successNotes(notes: [String])
}

// MARK: - HomeView
class HomeView: UIViewController {
    
    private var controller: HomeControllerProtocol?
    
    private var notes: [String] = []
    
    // MARK: Private Property
    private lazy var noteSearchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "Search"
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Notes"
        view.textColor = .secondaryLabel
        return view
    }()
    
    private lazy var notesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self
        view.register(NoteCollectionViewCell.self, forCellWithReuseIdentifier: NoteCollectionViewCell.reuseID)
        return view
    }()
    
    private lazy var addButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "note.add"), for: .normal)
        return view
    }()
    
    private var button = UIButton()
    
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
    }
    
}

// MARK: - Setting Views
private extension HomeView {
    func setupView() {
        view.backgroundColor = .systemBackground
        addSubViews()
        setupLayout()
        setupNavigationItem()
        controller = HomeController(view: self)
        controller?.onGetNotes()
    }
}

// MARK: - Setting
private extension HomeView {
    func addSubViews() {
        view.addSubview(noteSearchBar)
        view.addSubview(titleLabel)
        view.addSubview(notesCollectionView)
        view.addSubview(addButton)
    }
    
    private func setupNavigationItem() {
        
        navigationItem.title = "Home"
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(settingsButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func settingsButtonTapped() {
        navigationController?.pushViewController(SettingsView(), animated: true)
    }
}

// MARK: - Layout
private extension HomeView {
    func setupLayout() {
        noteSearchBar.snp.makeConstraints {make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(36)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(noteSearchBar.snp.bottom).offset(22)
            make.leading.equalToSuperview().offset(39)
        }
        
        notesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalTo(addButton.snp.top)
        }
        
        addButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-100)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(42)
        }
    }
}

// MARK: - Extension HomeView
extension HomeView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoteCollectionViewCell.reuseID, for: indexPath) as! NoteCollectionViewCell
        cell.setup(title: notes[indexPath.row])
        return cell
    }
}

extension HomeView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 12) / 2, height: 100)
    }
}

extension HomeView: HomeViewProtocol {
    func successNotes(notes: [String]) {
        self.notes = notes
        notesCollectionView.reloadData()
    }
}

extension HomeView {
    func updateTheme() {
        if UserDefaults.standard.bool(forKey: "DarkModeEnabled") {
            overrideUserInterfaceStyle = .dark
        } else {
            overrideUserInterfaceStyle = .light
        }
    }
}
