//
//  NewNoteView.swift
//  Notes
//
//  Created by Руслан Канжарбеков on 07.03.2024.
//

import UIKit
import SnapKit

class NewNoteView: UIViewController, UITextViewDelegate {
    
    private lazy var noteTF: UITextField = {
        let view = UITextField()
        view.placeholder = "Title"
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 15
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 5))
        view.leftView = leftView
        view.leftViewMode = .always
        view.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return view
    }()
    
    private lazy var noteTextView: UITextView = {
        let view = UITextView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .secondarySystemBackground
        view.font = .systemFont(ofSize: 15)
        return view
    }()
    
    private lazy var copyButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(UIImage(systemName: "square.on.square"), for: .normal)
        view.frame = CGRect(x: 330, y: 600, width: 32, height: 32)
        view.tintColor = .systemGray
        view.addTarget(self, action: #selector(copyButtonTapped), for: .touchUpInside)
        return view
    }()
    
    private lazy var saveButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Сохранить", for: .normal)
        view.tintColor = .white
        view.backgroundColor = .systemGray
        view.layer.cornerRadius = 15
        view.isEnabled = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        noteTF.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        noteTextView.delegate = self
    }
    
    func setupLayout() {
        view.addSubview(noteTF)
        noteTF.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        view.addSubview(noteTextView)
        noteTextView.snp.makeConstraints { make in
            make.top.equalTo(noteTF.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(470)
        }
        view.addSubview(copyButton)
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(45)
        }
    }
    
    @objc private func copyButtonTapped() {
        guard let textToCopy = noteTextView.text else {
            return
        }
        UIPasteboard.general.string = textToCopy
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        updateSaveButtonState()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        updateSaveButtonState()
    }
    
    private func updateSaveButtonState() {
        let isNotEmpty = !(noteTF.text?.isEmpty ?? true) && !(noteTextView.text.isEmpty)
        
        saveButton.isEnabled = isNotEmpty
        saveButton.backgroundColor = isNotEmpty ? .systemRed : .systemGray
    }
    
    @objc private func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
    }
}
