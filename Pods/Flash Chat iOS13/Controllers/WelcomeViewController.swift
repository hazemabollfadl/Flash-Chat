import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

    @IBOutlet var titleLabel: CLTypingLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text=K.appName
    }
}
