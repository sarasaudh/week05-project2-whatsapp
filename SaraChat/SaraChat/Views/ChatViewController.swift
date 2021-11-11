//
//  RegisterViewController.swift
//  chatApp
//
//  Created by SARA SAUD on 3/23/1443 AH.
//
//
//
//import UIKit
//import FirebaseAuth
//import FirebaseFirestore
//
//
//class MessagingVC: UIViewController {
//
////    let msg = MessagesService()
//    let cellId = "MessageCell"
//    var messages: [Message] = []
//    var user: User!
//
//    lazy var messagesTV: UITableView = {
//        let tv = UITableView()
//        tv.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
//        tv.translatesAutoresizingMaskIntoConstraints = false
//        tv.delegate = self
//        tv.dataSource = self
//        return tv
//    }()
//
//    lazy var tf: UITextField = {
//        let tf = UITextField()
//        tf.translatesAutoresizingMaskIntoConstraints = false
//        tf.delegate = self
//        tf.placeholder = "Write a message .."
//        tf.backgroundColor = .cyan
//        return tf
//    }()
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        guard let curruntUserId = Auth.auth().currentUser?.uid else {
//            return
//        }
//
//        msg.shared.listenToConversation(
//            userId1: user.id,
//            userId2: curruntUserId
//        ) { newMessages in
//            self.messages = newMessages
//            self.messagesTV.reloadData()
//        }
//
//        view.addSubview(messagesTV)
//        view.addSubview(tf)
//
//        NSLayoutConstraint.activate([
//            messagesTV.topAnchor.constraint(equalTo: view.topAnchor),
//            messagesTV.rightAnchor.constraint(equalTo: view.rightAnchor),
//            messagesTV.leftAnchor.constraint(equalTo: view.leftAnchor),
//            messagesTV.bottomAnchor.constraint(equalTo: tf.topAnchor),
//
//            tf.heightAnchor.constraint(equalToConstant: 40),
//            tf.topAnchor.constraint(equalTo: messagesTV.bottomAnchor),
//            tf.rightAnchor.constraint(equalTo: view.rightAnchor),
//            tf.leftAnchor.constraint(equalTo: view.leftAnchor),
//            tf.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//        ])
//    }
//
//}
//
//
//extension MessagingVC: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return messages.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
//        let message = messages[indexPath.row]
//        cell.textLabel?.text = message.content
//
//        if let currentUserId = Auth.auth().currentUser?.uid {
//            if currentUserId == message.sender {
//                cell.textLabel?.textAlignment = .right
//            } else {
//                cell.textLabel?.textAlignment = .left
//            }
//        }
//        return cell
//    }
//}
//
//
//extension MessagingVC: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        tf.resignFirstResponder()
//
//        let text = tf.text ?? ""
//        if text.isEmpty {
//            return true
//        }
//
//        guard let currentUserId = Auth.auth().currentUser?.uid else {
//            return true
//        }
//
//        shared.sendMessage(
//            message: Message(
//                id: UUID().uuidString,
//                sender: currentUserId,
//                receiver: user.id,
//                content: text,
//                timestamp: Timestamp()
//            )
//        )
//
//        tf.text = ""
//        return true
//    }
//}




import UIKit
import FirebaseFirestore
import Firebase

class ChatViewController: UIViewController {

    var user : User?
    var messages = [Message]()



    override func viewDidLoad() {
        super.viewDidLoad()
//        //h
//        guard let curruntUserId = Auth.auth().currentUser?.uid else {
//            return
//        }
//
//        MessagesService.shared.listenToConversation(
//            userId1: user.id,
//            userId2: curruntUserId
//        ) { newMessages in
//            self.messages = newMessages
//            self.messagesTV.reloadData()
//        }
//        //h
        setupUI()

        getAllMessages()

        chatTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }


    let chatTableView : UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView())

    let messageTextField : UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "Message..."
        $0.backgroundColor = .init(white: 0.85, alpha: 1)
        $0.layer.cornerRadius = 22.5
        return $0
    }(UITextField())

    let sendButton : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setBackgroundImage(UIImage(systemName: "paperplane.circle.fill"), for: .normal)
        $0.tintColor = .purple
        $0.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))


    func setupUI() {

      //  view.backgroundImage = UIImage(named: "z")

        navigationItem.title = user?.name

        chatTableView.delegate = self
        chatTableView.dataSource = self


        view.addSubview(chatTableView)
        view.addSubview(messageTextField)
        view.addSubview(sendButton)

        NSLayoutConstraint.activate([
            chatTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            chatTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            chatTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            chatTableView.bottomAnchor.constraint(equalTo: messageTextField.topAnchor),

            messageTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            messageTextField.rightAnchor.constraint(equalTo: sendButton.leftAnchor, constant: -5),//*****
            messageTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            messageTextField.heightAnchor.constraint(equalToConstant: 45),

            sendButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            sendButton.heightAnchor.constraint(equalTo: messageTextField.heightAnchor),
            sendButton.widthAnchor.constraint(equalTo: sendButton.heightAnchor),
            sendButton.centerYAnchor.constraint(equalTo: messageTextField.centerYAnchor)

        ])

    }


}


extension ChatViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
//    //h
//    guard let currentUserId = Auth.auth().currentUser?.uid else {
//        return true
//    }
//
//    MessagesService.shared.sendMessage(
//        message: Message(
//            id: UUID().uuidString,
//            sender: currentUserId,
//            receiver: user.id,
//            content: text,
//            timestamp: Timestamp()
//        )
//    )
//
//    tf.text = ""
//    return true
//
//    //h
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let currentUserID = Auth.auth().currentUser?.uid

        cell.textLabel?.text = messages[indexPath.row].content

        if messages[indexPath.row].sender == currentUserID {
            cell.textLabel?.textAlignment = .right
            cell.textLabel?.font = .italicSystemFont(ofSize: 20)
            cell.textLabel?.textColor = .blue
        } else {
            cell.textLabel?.textAlignment = .left
            cell.textLabel?.font = .italicSystemFont(ofSize: 15)
            cell.textLabel?.textColor = .green
        }




        return cell
    }


}


extension ChatViewController {
    @objc func sendMessage() {
        let messageId = String(Date().timeIntervalSince1970)
        guard let currentUserID = Auth.auth().currentUser?.uid else {return}
        guard let content = messageTextField.text else {return}
        guard let user = user else {return}


        Firestore.firestore().document("messages/\(messageId)").setData([
            "sender" : currentUserID,
            "receiver" :user.id ,
//            "id" : id ,
            "content" : content ,
            "id" : messageId
        ])

        messageTextField.text = ""
    }

    func getAllMessages() {
        guard let chatID = user?.id else {return}
        guard let userID = Auth.auth().currentUser?.uid else {return}
        self.messages.removeAll()

        Firestore.firestore().collection("messages")
            .whereField("receiver",  isEqualTo: userID)
           // .whereField("sender", isEqualTo: chatID)
            .addSnapshotListener { snapshot, error in
            if error == nil {
                for document in snapshot!.documents{
                    let data = document.data()
                    self.messages.append(Message(
                        id: data["id"]  as? String ?? "",
                        sender: data["sender"] as? String ?? "" ,
                        receiver: data["receiver"]  as? String ?? "",
                        content: data["content"] as? String ?? "",
                        timestamp: (data["timestamp"] as? Timestamp) ?? Timestamp()
                   )
                    )
                }
                self.chatTableView.reloadData()
            }
        }
    }
}
