//
//  SettingsViewController.swift
//  raceApp
//
//  Created by Stas Dashkevich on 17.04.21.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var colorPickerView: UIPickerView!
    
    let colors = ["Yellow", "Red", "Green", "Black", "Orange", "Sky", "Purple", "Blue"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorPickerView.delegate = self
        colorPickerView.dataSource = self
        if let data = UserDefaults.standard.value(forKey: "UserKey") as? Data {
            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                ViewController.user = user
            } catch {
                print(error)
                ViewController.user = User(userName: "Default name",
                                           userObstacleImageName: "stub-image",
                                           userCarImageName: "red-car-image",
                                           userSpeedCar: 16)
            }
        } else {
            ViewController.user = User(userName: "Default name",
                                       userObstacleImageName: "stub-image",
                                       userCarImageName: "red-car-image",
                                       userSpeedCar: 16)
        }
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleKeyboardDidShow(_:)),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleKeyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    // MARK: - IBActions

    @IBAction func backButton(_ sender: Any) {
        selectCarColor()
        navigationController?.popViewController(animated: true)
    }
    @IBAction func stubPressed(_ sender: Any) {
        setObstacle(imageName: "stub-image")
    }

    @IBAction func rockPressed(_ sender: Any) {
        setObstacle(imageName: "rock-image")
    }
    @IBAction func logPressed(_ sender: Any) {
        setObstacle(imageName: "log-image")
    }

    @IBAction func userNameField(_ sender: Any) {
        if let name = textFieldName.text {
            ViewController.user.userName = name
        }
        do {
            let data = try JSONEncoder().encode(ViewController.user)
            UserDefaults.standard.setValue(data, forKey: UserDefaultsKeys.userKey)
        } catch {
            print(error)
        }
        print("name from class: \(ViewController.user.userName)")
    }

    @IBAction func slowSpeedCar(_ sender: Any) {
        ViewController.user.userSpeedCar = 16
        saveUser()
    }
    
    @IBAction func normalSpeedCar(_ sender: Any) {
        ViewController.user.userSpeedCar = 8
        saveUser()
    }
    
    @IBAction func hardSpeedCar(_ sender: Any) {
        ViewController.user.userSpeedCar = 4
        saveUser()
    }
    
    // MARK: - Flow functions

    func selectCarColor() {
        let numberOfSelectedColor = colorPickerView.selectedRow(inComponent: 0)
        switch numberOfSelectedColor {
        case 0: setColor(imageName: "yellow-car-image")
        case 1: setColor(imageName: "red-car-image")
        case 2: setColor(imageName: "green-car-image")
        case 3: setColor(imageName: "black-car-image")
        case 4: setColor(imageName: "orange-car-image")
        case 5: setColor(imageName: "sky-car-image")
        case 6: setColor(imageName: "purple-car-image")
        case 7: setColor(imageName: "blue-car-image")
        default:
            print("Select color, please")
        }
    }

    func setColor(imageName: String) {
        ViewController.user.userCarImageName = "\(imageName)"
        saveUser()
    }

    func setObstacle(imageName: String) {
        ViewController.user.userObstacleImageName = "\(imageName)"
        saveUser()
    }

    func saveUser() {
        do {
            let data = try JSONEncoder().encode(ViewController.user)
            UserDefaults.standard.setValue(data, forKey: UserDefaultsKeys.userKey)
        } catch {
            print(error)
        }
    }

    @objc func handleKeyboardWillHide () {
        scrollView.contentInset = .zero
    }

    @objc func handleKeyboardDidShow (_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let bottomInset = keyboardFrame.height
            let insets = UIEdgeInsets(top: 0, left: 0, bottom: bottomInset, right: 0)
            scrollView.contentInset = insets
        }
    }

}

// MARK: - Extension UIPickerView

extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colors.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(colors[row])"
    }
}

    

