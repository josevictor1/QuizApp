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
    
    // MARK: - Properties
    
    private var panelViewController: PanelViewController?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationController()
        panelContainer.register()
    }
    
    // MARK: - Set up
    
    private func setUpNavigationController() {
        guard  let navigationController = navigationController else { return }
        navigationController.navigationBar.isHidden = true
    }
    
    private func setUpPannerViewController(_ panelViewController: PanelViewController) {
        self.panelViewController = panelViewController
        self.panelViewController?.onTimeFinish = { [unowned self] in
            self.timeDidFinish()
        }
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
    
    // MARK: - Alerts
    
    private func presentCongradulationsAlert() {
        presentAlert(title: NSLocalizedString("CONGRADULATIONS", comment: ""),
                     message: NSLocalizedString("CONGRADULATIONS_MESSAGE", comment: ""),
                     action: NSLocalizedString("PLAY_AGAIN", comment: "")) { }
    }
    
    private func presentTimeFinishedAlert() {
        presentAlert(title: NSLocalizedString("TIME_FINISHED", comment: ""),
                     message: NSLocalizedString("TIME_FINISHED_MESSAGE", comment: ""),
                     action: NSLocalizedString("TRY_AGAIN", comment: "")) { }
    }
    
}
