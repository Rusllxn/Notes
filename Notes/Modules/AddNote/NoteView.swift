//
//  NoteView.swift
//  Notes
//
//  Created by Руслан Канжарбеков on 21.03.2024.
//

import UIKit
import SnapKit

class NewNoteView: UIView {
    
    lazy var noteTF: UITextField = {
        let view = UITextField()
        view.placeholder = NSLocalizedString("Title", comment: "")
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 15
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 5))
        view.leftView = leftView
        view.leftViewMode = .always
        return view
    }()
    
    lazy var noteTextView: UITextView = {
        let view = UITextView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .secondarySystemBackground
        view.font = .systemFont(ofSize: 15)
        return view
    }()
    
    lazy var copyButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(UIImage(systemName: "square.on.square"), for: .normal)
        view.tintColor = .systemGray
        return view
    }()
    
    lazy var saveButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle(NSLocalizedString("Save", comment: ""), for: .normal)
        view.tintColor = .white
        view.backgroundColor = .systemGray
        view.layer.cornerRadius = 15
        view.isEnabled = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(noteTF)
        noteTF.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        addSubview(noteTextView)
        noteTextView.snp.makeConstraints { make in
            make.top.equalTo(noteTF.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(440)
        }
        
        addSubview(copyButton)
        copyButton.snp.makeConstraints { make in
            make.top.equalTo(noteTextView.snp.bottom).offset(-40)
            make.right.equalTo(noteTextView.snp.right).offset(-10)
        }
        
        addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(45)
        }
    }
}

