//
//  EntryDetailViewController.swift
//  JournalCoreData
//
//  Created by Spencer Curtis on 8/12/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func saveEntry(_ sender: Any) {
        
        guard let title = titleTextField.text,
            let bodyText = bodyTextView.text else { return }
        
        var mood: String!
        
        switch moodSegmentedControl.selectedSegmentIndex {
        case 0:
            mood = Mood.bad.rawValue
        case 1:
            mood = Mood.neutral.rawValue
        case 2:
            mood = Mood.good.rawValue
        default:
            break
        }
        
        if let entry = entry {
            entryController?.update(entry: entry, title: title, bodyText: bodyText, mood: mood)
        } else {
            entryController?.createEntry(with: title, bodyText: bodyText, mood: mood)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    private func updateViews() {
        guard isViewLoaded else { return }
        guard let entry = entry, let title = entry.title, let body = entry.bodyText else {
            self.title = "Create Entry"
                return
        }
        // must add self
        self.title = entry.title
        titleTextField.text = title
        bodyTextView.text = body
        
        var segmentIndex = 0
        
        switch entry.mood {
        case Mood.bad.rawValue:
            segmentIndex = 0
        case Mood.neutral.rawValue:
            segmentIndex = 1
        case Mood.good.rawValue:
            segmentIndex = 2
        default:
            break
        }
        
        moodSegmentedControl.selectedSegmentIndex = segmentIndex
    }
    
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
    
    var entryController: EntryController?
    
    @IBOutlet weak var moodSegmentedControl: UISegmentedControl!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!

}
