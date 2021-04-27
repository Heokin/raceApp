
import UIKit

class GameOverViewController: UIViewController {

    
    @IBOutlet weak var backToMenuButton: UIButton!
    @IBOutlet weak var tryAgainButton: UIButton!
    
    @IBOutlet weak var blurEffectView: UIVisualEffectView!
    
    
    @IBOutlet weak var gameOverLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blurEffectView.alpha = 0.9

        backToMenuButton.backgroundColor = .black
        tryAgainButton.backgroundColor = .black
        backToMenuButton.layer.cornerRadius = backToMenuButton.frame.height / 2
        tryAgainButton.layer.cornerRadius = tryAgainButton.frame.height / 2

        let text = "YOU LOSE :("
        let wholeRangeText = (text as NSString).range(of: text)
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.font, value: UIFont.perfect(ofSize: 30), range: wholeRangeText)
        gameOverLabel.attributedText = attributedText

    }
    @IBAction func goToMenu(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let nameViewController = String(describing: ViewController.self)
        let vc = storyboard.instantiateViewController(identifier: nameViewController) as ViewController
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tryAgain(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let nameViewController = String(describing: GameViewController.self)
        let vc = storyboard.instantiateViewController(identifier: nameViewController) as GameViewController
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }

    func setFont(label string: String, for button: UIButton) {
        let text = "\(string)"
        let wholeRangeText = (text as NSString).range(of: text)
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.font, value: UIFont.perfect(ofSize: 20), range: wholeRangeText)
        if let title = button.titleLabel {
            title.attributedText = attributedText
        }
    }
    
}
