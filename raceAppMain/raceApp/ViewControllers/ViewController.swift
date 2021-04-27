//
//  ViewController.swift
//  raceApp
//
//  Created by Stas Dashkevich on 16.04.21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var startGameOutlet: UIButton!
    @IBOutlet weak var settingsOutlet: UIButton!
    @IBOutlet weak var topRaitingOutlet: UIButton!
    static var user: User!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainLabel.textColor = .purple
        view.backgroundColor = .white
        startGameOutlet.layer.cornerRadius = 25
        settingsOutlet.layer.cornerRadius = 25
        topRaitingOutlet.layer.cornerRadius = 25
        settingsOutlet.setTitle("Settings", for: .normal)
        topRaitingOutlet.setTitle("Top Raiting", for: .normal)
    }
    @IBAction func startGameAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let nameController = String(describing: GameViewController.self)
        if let vc = storyboard.instantiateViewController(identifier: nameController) as? GameViewController {
            vc.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(vc, animated: true )
        }
    }
    @IBAction func settingsAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let nameViewController = String(describing: SettingsViewController.self)
        if let vc = storyboard.instantiateViewController(identifier: nameViewController) as? SettingsViewController {
            vc.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func topRaitingAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let nameViewController = String(describing: TopRaitingViewController.self)
        if let vc = storyboard.instantiateViewController(identifier: nameViewController) as? TopRaitingViewController {
            vc.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}

