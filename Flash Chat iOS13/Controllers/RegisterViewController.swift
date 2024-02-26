import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        if let email=emailTextfield.text, let password=passwordTextfield.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let safeError=error{
                    
                    let alert = UIAlertController(title: "Warning", message: safeError.localizedDescription, preferredStyle: .alert)
                    let alertAction=UIAlertAction(title: "OK", style: .cancel) { action in
                        switch action.style{
                        case .default:
                            print("default")
                            
                        case .cancel:
                            print("cancel")
                            
                        case .destructive:
                            print("destructive")
                        default:
                            print("")
                        }
                    }
                    alert.addAction(alertAction)
                    
                    self.present(alert, animated: true, completion: nil)
                    
                }else{
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)
                }
            }
        }
        
    }
}

