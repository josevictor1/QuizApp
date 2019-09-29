//
//  PanelViewController.swift
//  QuizApp
//
//  Created by José Victor Pereira Costa on 21/09/19.
//  Copyright © 2019 José Victor Pereira Costa. All rights reserved.
//

import UIKit
import Commons

class PanelViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var controlButton: UIButton!
    
    var onTimeFinish: (() -> Void)?
    
    lazy var countDownTimer: CountdownTimer = {
        return CountdownTimer(startTime: 300, timeLimit: 0)
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCountDownTimer()
    }
    
    // MARK: - IBActions
    
    @IBAction func controButtonTapped(_ sender: UIButton) {
        updatePanelState()
    }
    
    // MARK: - Set up
    
    private func setUpCountDownTimer() {
        countDownTimer.onTick = { time in
            self.timerLabel.text = time.formatToMinutesAndSeconds()
        }
        countDownTimer.onFinish = { [unowned self] in
            self.onTimeFinish?()
        }
    }
    
    // MARK: - Logic
    
    private func updatePanelState() {
        guard let text = controlButton.titleLabel?.text, let state = PanelState(rawValue: text) else { return }
        switch state {
        case .reset:
            controlButton.setTitle(PanelState.start.rawValue, for: .normal)
            reset()
        case .start:
            controlButton.setTitle(PanelState.reset.rawValue, for: .normal)
            start()
        }
    }
    
    private func start() {
        countDownTimer.start()
    }
    
    private func reset() {
        countDownTimer.stop()
    }
}
