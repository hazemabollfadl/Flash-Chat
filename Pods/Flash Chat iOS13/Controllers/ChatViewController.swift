import UIKit
import FirebaseFirestore
import FirebaseAuth
class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db=Firestore.firestore()
    
    var message:[Message]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource=self
        
        title=K.appName
        
        navigationItem.hidesBackButton=true
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()
    }
    
    func loadMessages(){
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { querySnapshot, error in
                
            self.message=[]
                
            if let safeError=error{
                print("There was an issue getting data from fireStore \(safeError)")
            }else{
                if let safeSnapshotDocument=querySnapshot?.documents{
                    for doc in safeSnapshotDocument{
                        let data=doc.data()
                        if let messageSender=data[K.FStore.senderField] as? String, let messageBody=data[K.FStore.bodyField] as? String{
                            let newMessage=Message(sender: messageSender, body: messageBody)
                            self.message.append(newMessage)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath=IndexPath(row: self.message.count-1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody=messageTextfield.text, let messageSender=Auth.auth().currentUser?.email{
            
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField:messageSender,
                K.FStore.bodyField:messageBody,
                K.FStore.dateField:Date().timeIntervalSince1970
            ]) { error in
                if let safeError=error{
                    print("There was an issue saving data to firestore, \(safeError)")
                }else{
                    print("successfully saved data.")
                    DispatchQueue.main.async {
                        self.messageTextfield.text=""
                    }
                }
            }
        }
        
    }
    
    @IBAction func logOutButtonPressed(_ sender: UIBarButtonItem) {
        
        do {
            
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
            
        } catch let signOutError as NSError {
            let alert = UIAlertController(title: "Warning", message:"\(signOutError)" , preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
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
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

//MARK: - UITableViewDataSource
extension ChatViewController:UITableViewDataSource{
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return message.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message=message[indexPath.row]
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        
        cell.TextLabel.text = message.body
        
        //Sender is current user
        if message.sender==Auth.auth().currentUser?.email{
            cell.LeftImageView.isHidden=true
            cell.RightImageView.isHidden=false
            cell.MessageBubble.backgroundColor=UIColor(named: K.BrandColors.senderBubble)
        }else{
            cell.LeftImageView.isHidden=false
            cell.RightImageView.isHidden=true
            cell.MessageBubble.backgroundColor=UIColor(named: K.BrandColors.recieverBubble)
        }
        
       
        return cell
    }
}

