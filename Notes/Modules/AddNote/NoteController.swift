//
//  NoteController.swift
//  Notes
//
//  Created by Руслан Канжарбеков on 21.03.2024.
//

import UIKit

class NewNoteViewController: UIViewController, UITextViewDelegate {
    private var newNoteView: NewNoteView!
    private let coreDataServices = CoreDataService.shared
    
    var note: Note?
    
    override func loadView() {
        super.loadView()
        newNoteView = NewNoteView()
        view = newNoteView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newNoteView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        newNoteView.copyButton.addTarget(self, action: #selector(copyButtonTapped), for: .touchUpInside)
        newNoteView.noteTextView.delegate = self
        setupUI(with: note)
    }
    
    private func setupUI(with note: Note?) {
        guard let note = note else { return }
        newNoteView.noteTF.text = note.title
        newNoteView.noteTextView.text = note.desc
    }
    
    @objc private func copyButtonTapped() {
        guard let textToCopy = newNoteView.noteTextView.text else { return }
        UIPasteboard.general.string = textToCopy
    }
    
    @objc private func saveButtonTapped() {
        let id = UUID().uuidString
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        
        coreDataServices.addNote(id: id, title: newNoteView.noteTF.text ?? "", description: newNoteView.noteTextView.text, date: dateString)
        navigationController?.popViewController(animated: true)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        updateSaveButtonState()
    }
    
    private func updateSaveButtonState() {
        let isNotEmpty = !(newNoteView.noteTF.text?.isEmpty ?? true) && !(newNoteView.noteTextView.text.isEmpty)
        
        newNoteView.saveButton.isEnabled = isNotEmpty
        newNoteView.saveButton.backgroundColor = isNotEmpty ? .systemRed : .systemGray
    }
}

