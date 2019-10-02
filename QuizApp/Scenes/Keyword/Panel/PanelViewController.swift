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
    
    // MARK: - Outlets
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var controlButton: UIButton!
    
    // MARK: - Properties
    
    var onStart: (() -> Void)?
    var onTimeFinish: ((Int, Int) -> Void)?
    var onAnswersFinished: (() -> Void)?
    var onReset: (() -> Void)?
    
    var scoreboardTotal: Int = .zero
    var scoreboardHitted: Int = .zero
    
    lazy var countDownTimer: CountdownTimer = {
        return CountdownTimer(startTime: 300, timeLimit: .zero)
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCountDownTimer()
        updateScoreboard()
    }
    
    // MARK: - Actions
    
    @IBAction func controButtonTapped(_ sender: UIButton) {
        updatePanelState()
    }
    
    // MARK: - Set up
    
    private func setUpCountDownTimer() {
        countDownTimer.onTick = { [unowned self] time in
            self.timerLabel.text = time.formatToMinutesAndSeconds()
        }
        countDownTimer.onFinish = { [unowned self] in
            self.onTimeFinish?(self.scoreboardTotal, self.scoreboardHitted)
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
        onStart?()
    }
    
    private func reset() {
        countDownTimer.stop()
        resetScoreboard()
        onReset?()
    }
    
    private func resetScoreboard() {
        scoreboardHitted = .zero
        updateScoreboard()
    }
    
    private func updateScoreboard() {
        scoreLabel.text = "\(scoreboardHitted)/\(scoreboardTotal)"
    }
    
    private func presentPlayAgainAlertIfNeeded() {
        guard scoreboardHitted == scoreboardTotal else { return }
        onAnswersFinished?()
    }
    
    func keywordWasHitted() {
        scoreboardHitted += 1
        updateScoreboard()
        presentPlayAgainAlertIfNeeded()
    }
    
}
// MARK: - KeywordViewControllerDelegate
extension PanelViewController: KeywordViewControllerDelegate {
    func keywordWasHitted(_ keywordViewController: KeywordViewController) {
        keywordWasHitted()
    }
    
    func setPanel(_ keywordViewController: KeywordViewController, keywords: Keywords) {
        scoreboardTotal = keywords.answer.count
        updateScoreboard()
    }
    
    func resetPanel(_ keywordViewController: KeywordViewController) {
        reset()
    }
}
