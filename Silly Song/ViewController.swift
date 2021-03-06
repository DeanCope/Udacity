//
//  ViewController.swift
//  Silly Song
//
//  Created by Dean Copeland on 3/9/17.
//  Copyright © 2017 Dean Copeland. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var lyricsView: UITextView!
    
    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
    }

    @IBAction func displayLyrics(_ sender: Any) {
        if let name = nameField.text {
            lyricsView.text = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: name)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
    }
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

// MARK: - "Pure" functions, not part of the ViewController class
func shortNameFromName(name: String) -> String {
    
    let name = name.lowercased()
    var shortName = name
    // find the first vowel
    if let index = name.rangeOfCharacter(from: CharacterSet(charactersIn: "aeiou")) {
        // short name starts with the first vowel
        shortName = name.substring(from: index.lowerBound)
    }
    
    return shortName
    
}

// join an array of strings into a single template string:
let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joined(separator: "\n")


func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    let shortName = shortNameFromName(name: fullName)
    
    var returnString = lyricsTemplate.replacingOccurrences(of: "<FULL_NAME>", with: fullName)
    returnString = returnString.replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
    return returnString
}

