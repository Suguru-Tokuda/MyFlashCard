//
//  StudyViewController.swift
//  MyFlashCard
//
//  Created by Suguru on 12/2/17.
//  Copyright © 2017 Suguru. All rights reserved.
//

import UIKit

class StudyViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var prevBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var cards: [Card]!
    var currentCard: Card!
    var currentIndex: Int!
    var lastIndex: Int!
    var tempIndex: Int!
    var isShowingQuestion: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cards = appDelegate.cardsToStudy
        currentCard = cards[0]
        currentIndex = 0
        lastIndex = cards.count - 1
        textView.isEditable = false
        
        textView.text = currentCard.question
        
        if currentCard.marked {
            favoriteButton.image = UIImage(named: "star.png")
        } else {
            favoriteButton.image = UIImage(named: "empty_star.png")
        }
        isShowingQuestion = true
        prevBtn.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func prevBtnPushed(_ sender: Any) {
        if currentIndex != 0 {
            tempIndex = currentIndex - 1
            currentCard = cards[tempIndex]
            textView.text = currentCard.question
            currentIndex = tempIndex
        }
        
        if currentCard.marked {
            favoriteButton.image = UIImage(named: "star.png")
        } else {
            favoriteButton.image = UIImage(named: "empty_star.png")
        }
        
        if currentIndex != lastIndex && nextBtn.isHidden {
            nextBtn.isHidden = false
        }
        
        if currentIndex == 0 {
            prevBtn.isHidden = true
        }
        
    }
    
    @IBAction func nextBtnPushed(_ sender: Any) {
        if currentIndex != lastIndex {
            tempIndex = currentIndex + 1
            currentCard = cards[tempIndex]
            textView.text = currentCard.question
            currentIndex = tempIndex
        }
        
        if currentCard.marked {
            favoriteButton.image = UIImage(named: "star.png")
        } else {
            favoriteButton.image = UIImage(named: "empty_star.png")
        }
        
        if currentIndex != 0 && prevBtn.isHidden {
            prevBtn.isHidden = false
        }
        
        if currentIndex == lastIndex {
            nextBtn.isHidden = true
        }
        
        self.isShowingQuestion = true
    }
    
    
    @IBAction func favBtnPushed(_ sender: Any) {
        if currentCard.marked {
            currentCard.marked = false
            PersistentService.save()
            favoriteButton.image = UIImage(named: "empty_star.png")
        } else {
            currentCard.marked = true
            PersistentService.save()
            favoriteButton.image = UIImage(named: "star.png")
        }
        self.isShowingQuestion = true
    }
    
    
    @IBAction func textViewTapped(_ sender: Any) {
        if isShowingQuestion {
            textView.text = currentCard.answer
            isShowingQuestion = false
        } else {
            textView.text = currentCard.question
            isShowingQuestion = true
        }
    }

}
