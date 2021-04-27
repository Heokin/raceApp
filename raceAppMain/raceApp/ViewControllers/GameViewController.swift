
import UIKit

class GameViewController: UIViewController {

    
    @IBOutlet weak var moveToLeftButton: UIButton!
    @IBOutlet weak var moveToRightButton: UIButton!
    @IBOutlet weak var roadImageView: UIImageView!
    
    @IBOutlet weak var rightView: UIView!
    static let dateFormatter = DateFormatter()
    var startPosition = CGPoint(x: 0, y: 0)
    var carImageView: UIImageView!
    var timeScore = 0
    let obstacle = UIImageView()
    var stopFlag = true
    var animateBarrier = Timer()
    var timerForCrash = Timer()
    var scoreTimer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        if let data = UserDefaults.standard.value(forKey: UserDefaultsKeys.userKey.rawValue) as? Data {
            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                ViewController.user = user
            } catch {
                print(error)
                ViewController.user = User(userName: "Gamer",
                                           userObstacleImageName: "stub-image",
                                           userCarImageName: "red-car-image",
                                           userSpeedCar: 16)
                print("Not found user")
            }
        } else {
            ViewController.user = User(userName: "Gamer",
                                       userObstacleImageName: "stub-image",
                                       userCarImageName: "red-car-image",
                                       userSpeedCar: 16)
            print("Not found user")
        }
        roadImageView.contentMode = .scaleAspectFill
        startPosition = self.roadImageView.frame.origin
        roadImageView.frame.origin = CGPoint(x: 0, y: 0)
        moveRoad()
        createCar()
        view.addSubview(carImageView)
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (scoreTimer) in
            self.timeScore += 1
        }
        GameViewController.dateFormatter.dateStyle = .medium
        GameViewController.dateFormatter.setLocalizedDateFormatFromTemplate("MMM d, h:mm a")
        print(GameViewController.dateFormatter.string(from: Date()))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addMotionControlSwipes()
        obstacle.image = UIImage(named: ViewController.user.userObstacleImageName)
        obstacle.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        obstacle.center = CGPoint(x: view.frame.width / .random(in: 1...3), y: 0)
        view.addSubview(obstacle)
        view.bringSubviewToFront(carImageView)
        animateObstacle()
        checkHit()
    }

    func addMotionControlSwipes() {
        let swipeLeftGesture = UISwipeGestureRecognizer()
        let swipeRightGesture = UISwipeGestureRecognizer()
        swipeLeftGesture.addTarget(self, action: #selector(swipeToMove(_:)))
        swipeRightGesture.addTarget(self, action: #selector(swipeToMove(_:)))
        swipeLeftGesture.direction = .left
        swipeRightGesture.direction = .right
        view.addGestureRecognizer(swipeLeftGesture)
        view.addGestureRecognizer(swipeRightGesture)
    }

    func checkHit() {
        timerForCrash = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (timerForCrash) in
            if self.carImageView.frame.intersects(self.obstacle.frame) {
                self.stopFlag = false
                timerForCrash.invalidate()
                self.animateBarrier.invalidate()
                self.scoreTimer.invalidate()
                self.showGameOverVC()
            }
        })
    }

    func animateObstacle() {
        if stopFlag == true {
            UIView.animate(withDuration: 0.1, delay: 0, animations: {
                self.obstacle.frame.origin.y += 25
            }) { (result) in
                if self.obstacle.frame.origin.y <= self.view.frame.height {
                    self.animateObstacle()
                } else {
                    self.obstacle.center = CGPoint(x: self.view.frame.width / .random(in: 1...4), y: -180)
                    Timer.scheduledTimer(withTimeInterval: .random(in: 1...3), repeats: false) { (animateBarrier) in
                        self.animateObstacle()
                    }
                }
            }
        } else {
            return
        }
    }

    func createCar() {
        self.carImageView = UIImageView()
        self.carImageView.contentMode = .scaleAspectFit
        self.carImageView.image = UIImage(named: ViewController.user.userCarImageName)
        self.carImageView.frame.origin = CGPoint(x: 130, y: view.frame.height - 260)
        self.carImageView.frame.size = CGSize(width: 103, height: 164)
    }

    func moveRoad() {
        UIView.animate(withDuration: ViewController.user.userSpeedCar, delay: 0, options: [.curveLinear], animations: {
            self.roadImageView.frame.origin = self.view.frame.origin
        }) { (result) in
            self.roadImageView.frame.origin = self.startPosition
            self.moveRoad()
        }
    }

    @IBAction func moveToLeftButtonPressed(_ sender: Any) {
//        moveCarToLeft()
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveLinear], animations: {
            self.carImageView.center.x -= 15
            if self.carImageView.frame.origin.x == -20 {
                self.stopFlag = false
                self.showGameOverVC()
            }
        }) { (_) in
//            self.moveCarToLeft()
        }
    }

    @IBAction func moveToRightButtonPressed(_ sender: Any) {
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveLinear], animations: {
            self.carImageView.center.x += 15
            if self.carImageView.frame.intersects(self.rightView.frame) {
                self.stopFlag = false
                self.showGameOverVC()
            }
//            if (self.carImageView.frame.origin.x + self.carImageView.frame.width > self.view.frame.width) &&
//                (self.carImageView.frame.origin.x + self.carImageView.frame.width < self.view.frame.width + 5) {
//                self.stopFlag = false
//                self.showGameOverVC()
//            }
        }) { (_) in
//            self.moveCarToRight()
        }
//        moveCarToRight()
    }
  
    func moveCarToLeft() {
        UIView.animate(withDuration: 0.05, delay: 0, options: [.curveLinear], animations: {
            self.carImageView.center.x -= 5
            if self.carImageView.frame.origin.x == -20 {
                self.stopFlag = false
                self.showGameOverVC()
            }
        }) { (_) in
            self.moveCarToLeft()
        }
    }

    func moveCarToRight() {
        UIView.animate(withDuration: 0.05, delay: 0, options: [.curveLinear], animations: {
            self.carImageView.center.x += 5
            if self.carImageView.frame.intersects(self.rightView.frame) {
                self.stopFlag = false
                self.showGameOverVC()
            }
//            if (self.carImageView.frame.origin.x + self.carImageView.frame.width > self.view.frame.width) &&
//                (self.carImageView.frame.origin.x + self.carImageView.frame.width < self.view.frame.width + 5) {
//                self.stopFlag = false
//                self.showGameOverVC()
//            }
        }) { (_) in
            self.moveCarToRight()
        }
    }

    func saveLastResult() {
        let newRecord = ResultGame(userName: ViewController.user.userName,
                                   time: GameViewController.dateFormatter.string(from: Date()),
                                   score: timeScore)
        TopRaitingViewController.arrayOfResultGame.append(newRecord)
        moveToLeftButton.isSelected = false
        moveToRightButton.isSelected = false
        do {
            let data = try JSONEncoder().encode(TopRaitingViewController.arrayOfResultGame)
            UserDefaults.standard.setValue(data, forKey: UserDefaultsKeys.resultsKey)
        } catch {
            print(error)
        }
    }

    func showGameOverVC() {
        saveLastResult()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nameController = String(describing: GameOverViewController.self)
        let viewController = storyboard.instantiateViewController(identifier: nameController) as GameOverViewController
        viewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(viewController, animated: true)
    }

    func backToMainView() {
        let newRecord = ResultGame(userName: ViewController.user.userName,
                                   time: GameViewController.dateFormatter.string(from: Date()),
                                   score: timeScore)
        TopRaitingViewController.arrayOfResultGame.append(newRecord)
        moveToLeftButton.isSelected = false
        moveToRightButton.isSelected = false
        do {
            let data = try JSONEncoder().encode(TopRaitingViewController.arrayOfResultGame)
            UserDefaults.standard.setValue(data, forKey: UserDefaultsKeys.resultsKey)
        } catch {
            print(error)
        }
        navigationController?.popViewController(animated: true)
    }

    @objc func swipeToMove(_ swipeGesture: UISwipeGestureRecognizer) {
        switch swipeGesture.direction {
        case .left: moveCarToLeft()
        case .right: moveCarToRight()
        default:
            print("")
        }
    }
}
