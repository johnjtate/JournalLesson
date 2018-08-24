//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by John Tate on 8/22/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController, UITextFieldDelegate {

    // Getting passed in the segue
    var entry: Entry?
    
    // MARK - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()

        entryTitleField.delegate = self
    }
    
    func updateViews() {
        guard let entry = entry else { return }
        
        entryTitleField.text = entry.title
        bodyTextView.text = entry.bodytext
        
    }
    
    // MARK - IBOutlet
    
    @IBOutlet weak var entryTitleField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    // Show the keyboard for text field editing to begin
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    @IBAction func clearEntryButtonTapped(_ sender: Any) {
        entryTitleField.text = ""
        bodyTextView.text = ""
        
    }
    
    @IBAction func saveEntryButtonTapped(_ sender: Any) {
        if entryTitleField.text != "", bodyTextView.text != "" {
            guard let entryTitle = entryTitleField.text,
                let entryText = bodyTextView.text else { return }

        // For a new entry, segue will not have passed anything, so entry will be empty.
        // For updating an entry, segue will have passed an entry.
            if entry != nil {
                EntryController.shared.addEntryWith(title: entryTitle, bodytext: entryText)
            } else {
                EntryController.shared.update(entryToUpdate: entry!, newTitle: entryTitle, newBodyText: entryText)
            }
            
        navigationController?.popViewController(animated: true)
            
        }
        
    }
    
    // Dismiss the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
        return true
    }

}
