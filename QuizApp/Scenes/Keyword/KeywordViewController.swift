//
//  KeyWordsViewController.swift
//  QuizApp
//
//  Created by José Victor Pereira Costa on 21/09/19.
//  Copyright © 2019 José Victor Pereira Costa. All rights reserved.
//

import UIKit
import UIComponents
import Commons

protocol KeywordViewControllerDelegate: AnyObject {
    func keywordWasHitted(_ keywordViewController: KeywordViewController)
    func setPanel(_ keywordViewController: KeywordViewController, keywords: Keywords)
    func resetPanel(_ keywordViewController: KeywordViewController)
}

class KeywordViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var wordInputTextField: CustomTextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var panelContainer: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    
    private weak var delegate: KeywordViewControllerDelegate?
    private var keyboardAvoidingHelper: KeyboardAvoidable?
    private var keywordTableViewDataSource: KeywordTableViewDataSource?
    private var keywordController: KeywordControllerProvider?
    private var keywords: Keywords?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpKeywordController()
        requestKeywords()
        setUpNavigationController()
        setUpKeyboardAvoiding()
        setUpWordInputTextField()
        setUpKeywordTableViewDataSource()
    }
    
    // MARK: - Set up
    
    private func setUpKeywordController() {
        keywordController = KeywordController()
    }
    
    private func setUpNavigationController() {
        guard  let navigationController = navigationController else { return }
        navigationController.navigationBar.isHidden = true
    }
    
    private func setUpKeyboardAvoiding() {
        keyboardAvoidingHelper = KeyboardAvoidingHelper()
        keyboardAvoidingHelper?.onShow = { [unowned self] height in
            UIView.animate(withDuration: 0.25) {
                self.bottomConstraint.constant += height
                self.view.layoutIfNeeded()
            }
        }
        
        keyboardAvoidingHelper?.onHide = { [unowned self] height in
            UIView.animate(withDuration: 0.25) {
                self.bottomConstraint.constant -= height
                self.view.layoutIfNeeded()
            }
        }
        keyboardAvoidingHelper?.register()
    }
    
    private func setUpWordInputTextField() {
        wordInputTextField.delegate = self
        wordInputTextField.isEnabled = false
    }
    
    private func setUpPannerViewController(_ panelViewController: PanelViewController) {
        delegate = panelViewController
        panelViewController.onStart = { [unowned self] in
            self.activateTextField()
        }
        panelViewController.onReset = { [unowned self] in
            self.removeAllCellsFromTableView()
        }
        panelViewController.onTimeFinish = { [unowned self] total, hitted in
            self.presentTimeFinishedAlert(total: total, hitted: hitted)
        }
        panelViewController.onAnswersFinished = { [unowned self] in
            self.presentCongradulationsAlert()
        }
    }
    
    private func setUpKeywordTableViewDataSource() {
        keywordTableViewDataSource = KeywordTableViewDataSource(tableView: tableView)
        tableView.dataSource = keywordTableViewDataSource
        tableView.register(cell: KeywordTableViewCell.self)
    }
    
    private func setUpKeywords(_ keywords: Keywords) {
        DispatchQueue.main.async {
            self.titleLabel.text = keywords.question
            self.delegate?.setPanel(self, keywords: keywords)
        }
        self.keywords = keywords
    }
    
    // MARK: - Prepare for segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? PanelViewController else { return }
        setUpPannerViewController(viewController)
    }
    
    // MARK: - Logic
    
    private func activateTextField() {
        wordInputTextField.isEnabled = true
    }
    
    private func removeAllCellsFromTableView() {
        keywordTableViewDataSource?.removeAllKeywords()
    }
    
    private func requestKeywords() {
        keywordController?.requestKeywords(completion: { [unowned self] result in
            switch result {
            case .success(let response):
                self.setUpKeywords(response)
            case .failure(let error):
                self.presentRequestError(error)
            }
        })
    }
    
    // MARK: - Actions
    
    @IBAction func editingChanged(_ sender: CustomTextField) {
        if let text = sender.text, let keyword = keywords, let answer = keyword.answer[text],
            !(keywordTableViewDataSource?.words.contains(answer) ?? true) {
            keywordTableViewDataSource?.addKeyword(answer)
            sender.text = ""
            delegate?.keywordWasHitted(self)
        }
    }
    
    // MARK: - Alerts
    
    private func presentCongradulationsAlert() {
        DispatchQueue.main.async {
            self.presentAlert(title: "CONGRADULATIONS".localized(),
                              message: "CONGRADULATIONS_MESSAGE".localized(),
                              action: "PLAY_AGAIN".localized()) {
                                [unowned self] in
                                self.delegate?.resetPanel(self)
            }
        }
    }
    
    private func presentTimeFinishedAlert(total: Int, hitted: Int) {
        
        var message = "TIME_FINISHED_MESSAGE".localized()
        message = String(format: message, total, hitted)
        DispatchQueue.main.async {
            self.presentAlert(title: "TIME_FINISHED".localized(),
                              message: message,
                              action: "TRY_AGAIN".localized()) {
                                [unowned self] in
                                self.delegate?.resetPanel(self)
            }
        }
        
    }
    
    private func presentRequestError(_ error: Error) {
        DispatchQueue.main.async {
            self.presentAlert(title: "ERROR".localized(),
                              message: error.localizedDescription,
                              action: "OK".localized())
        }
    }
    
}
