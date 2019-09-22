//
//  PanelViewController.swift
//  QuizApp
//
//  Created by José Victor Pereira Costa on 21/09/19.
//  Copyright © 2019 José Victor Pereira Costa. All rights reserved.
//

import UIKit

class PanelViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var controlButton: UIButton!
    
    var onTimeFinish: (() -> Void)?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBActions
    
    @IBAction func controButtonTapped(_ sender: UIButton) {
        updatePanelState()
    }
    
    // MARK: - Logic
    
    private func updatePanelState() {
        guard let text = controlButton.titleLabel?.text, let state = PanelState(rawValue: text) else { return }
        switch state {
        case .reset:
            controlButton.titleLabel?.text = PanelState.start.rawValue
            resetScore()
            resetTimer()
        case .start:
            controlButton.titleLabel?.text = PanelState.reset.rawValue
            startTimer()
            startScore()
        }
    }
    
    private func startTimer() {
        
    }
    
    private func startScore() {
        
    }
    
    private func resetTimer() {
        
    }
    
    private func resetScore() {
        
    }
    
}
