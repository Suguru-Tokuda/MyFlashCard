//
//  CardSummaryViewController.swift
//  MyFlashCard
//
//  Created by Suguru on 12/2/17.
//  Copyright © 2017 Suguru. All rights reserved.
//

import UIKit

class CardSummaryViewController: UIViewController {
    
    var studyCard: Card!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var answerTextView: UITextView!
    
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.studyCard = appDelegate.studyCard
        questionTextView.text = studyCard.question
        answerTextView.text = studyCard.answer
        
        if self.studyCard.marked == true {
            favoriteButton.image = UIImage(named: "star.png")
        } else {
            favoriteButton.image = UIImage(named: "empty_star.png")
        }

        
    }
    
    @IBAction func favoriteButton(_ sender: Any) {
        if self.studyCard.marked == true {
            favoriteButton.image = UIImage(named: "empty_star.png")
            self.studyCard.marked = false
        } else {
            favoriteButton.image = UIImage(named: "star.png")
            self.studyCard.marked = true
        }
        PersistentService.save()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
