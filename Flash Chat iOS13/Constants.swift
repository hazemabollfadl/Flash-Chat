struct K {
    static let appName            = "⚡️FlashChat"
    static let cellIdentifier     = "ReusableCell"
    static let cellNibName        = "MessageCell"
    static let registerSegue      = "registerToChat"
    static let loginSegue         = "loginToChat"
    
    struct BrandColors {
        static let purple         = "BrandPurple"
        static let lightPurple    = "BrandLightPurple"
        static let blue           = "BrandBlue"
        static let lighBlue       = "BrandLightBlue"
        static let senderBubble   = "SenderBubbleColor"
        static let recieverBubble = "RecieverBubbleColor"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField    = "sender"
        static let bodyField      = "body"
        static let dateField      = "date"
    }
}
