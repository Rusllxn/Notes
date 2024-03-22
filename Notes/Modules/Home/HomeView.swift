//
//  HomeView.swift
//  Notes
//
//  Created by Руслан Канжарбеков on 21.02.2024.
//

import UIKit
import SnapKit

protocol HomeViewProtocol {
    func successNotes(notes: [Note])
}

// MARK: - HomeView
class HomeView: UIViewController {
    
    private var controller: HomeControllerProtocol?
    private var notes: [Note] = []
    private var filteredNotes: [Note] = []
    
    // MARK: Private Property
    private lazy var noteSearchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = NSLocalizedString("Search", comment: "")
        view.searchTextField.addTarget(self, action: #selector(noteSearchBarEditingChanged), for: .editingChanged)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = NSLocalizedString("Notes", comment: "")
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
        view.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
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
        updateNavigationBarAppearance()
        controller?.onGetNotes()
    }
    
    private func updateNavigationBarAppearance() {
        if UserDefaults.standard.bool(forKey: "theme") == true {
            overrideUserInterfaceStyle = .dark
            navigationController?.navigationBar.barTintColor = .black
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        } else {
            overrideUserInterfaceStyle = .light
            navigationController?.navigationBar.barTintColor = .white
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
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
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(settingsButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        navigationItem.title = NSLocalizedString("Home", comment: "")
    }
    
    @objc func settingsButtonTapped() {
        navigationController?.pushViewController(SettingsView(), animated: true)
    }
    
    @objc func noteSearchBarEditingChanged() {
        // TODO: Придумать логику
    }
    
    @objc func addButtonTapped() {
        navigationController?.pushViewController(NewNoteViewController(), animated: true)
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
            make.bottom.equalTo(view.safeAreaInsets.bottom)
        }
        
        addButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-60)
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
        cell.setup(title: notes[indexPath.row].title ?? "")
        return cell
    }
}

extension HomeView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 12) / 2, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let noteView = NewNoteViewController()
        noteView.note = notes[indexPath.row]
        navigationController?.pushViewController(noteView, animated: true)
    }
}

extension HomeView: HomeViewProtocol {
    func successNotes(notes: [Note]) {
        self.notes = notes
        self.filteredNotes = notes
        notesCollectionView.reloadData()
    }
}
