import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet var MessageBubble: UIView!
    @IBOutlet var RightImageView: UIImageView!
    @IBOutlet var TextLabel: UILabel!
    @IBOutlet var LeftImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
            
        MessageBubble.layer.cornerRadius=MessageBubble.frame.size.height/5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
