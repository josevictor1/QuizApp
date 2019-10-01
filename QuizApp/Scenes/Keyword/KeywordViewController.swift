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

class KeywordViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var wordInputTextField: CustomTextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var panelContainer: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    
    private var panelViewController: PanelViewController?
    private var keyboardAvoidingHelper: KeyboardAvoidable?
    private var keywordTableViewDataSource: KeywordTableViewDataSource?
    private var keywordDictionary: [String: String] = ["asdf": "Asdf", "vre": "Vre", "becxc": "Becxc"]
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationController()
        setUpKeyboardAvoiding()
        setUpKewordTextFieldDelegate()
        setUpKeywordTableViewDataSource()
    }
    
    // MARK: - Set up
    
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
    
    private func setUpKewordTextFieldDelegate() {
        wordInputTextField.delegate = self
    }
    
    private func setUpPannerViewController(_ panelViewController: PanelViewController) {
        self.panelViewController = panelViewController
        self.panelViewController?.onTimeFinish = { [unowned self] in
            self.timeDidFinish()
        }
    }
    
    private func setUpKeywordTableViewDataSource() {
        keywordTableViewDataSource = KeywordTableViewDataSource(tableView: tableView)
        tableView.dataSource = keywordTableViewDataSource
        tableView.register(cell: KeywordTableViewCell.self)
    }
    
    // MARK: - Prepare for segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? PanelViewController else { return }
        setUpPannerViewController(viewController)
    }
    
    // MARK: - Logic
    
    private func timeDidFinish() {
        presentTimeFinishedAlert()
    }
    
    // MARK: - Actions
    
    @IBAction func editingChanged(_ sender: CustomTextField) {
        if let text = sender.text, let answer = keywordDictionary[text] {
            keywordTableViewDataSource?.words.append(answer)
            sender.text = ""
        }
    }
    
    // MARK: - Alerts
    
    private func presentCongradulationsAlert() {
        presentAlert(title: "CONGRADULATIONS".localized(),
                     message: "CONGRADULATIONS_MESSAGE".localized(),
                     action: "PLAY_AGAIN".localized()) { }
    }
    
    private func presentTimeFinishedAlert() {
        presentAlert(title: "TIME_FINISHED".localized(),
                     message: "TIME_FINISHED_MESSAGE".localized(),
                     action: "TRY_AGAIN".localized()) { }
    }
    
}
