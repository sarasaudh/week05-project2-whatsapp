//
//  RegisterViewController.swift
//  chatApp
//
//  Created by SARA SAUD on 3/23/1443 AH.
//

//
//import UIKit
//
//
//class UsersViewController: UIViewController {
//
//    let cellId = "PeopleCell"
//    var people: [User] = []
//
//    lazy var peopleTV: UITableView = {
//        let tv = UITableView()
//        tv.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
//        tv.translatesAutoresizingMaskIntoConstraints = false
//        tv.delegate = self
//        tv.dataSource = self
//        return tv
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        UsersService.shared.listenToUsers { newUsers in
//            self.people = newUsers
//            self.peopleTV.reloadData()
//        }
//
//        view.backgroundColor = .brown
//        let image = UIImage(systemName: "chat")
//        tabBarItem = .init(title: "People", image: image, selectedImage: image)
//
//        view.addSubview(peopleTV)
//        NSLayoutConstraint.activate([
//            peopleTV.topAnchor.constraint(equalTo: view.topAnchor),
//            peopleTV.rightAnchor.constraint(equalTo: view.rightAnchor),
//            peopleTV.leftAnchor.constraint(equalTo: view.leftAnchor),
//            peopleTV.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//        ])
//    }
//
//}
//
//extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return people.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
//        let user = people[indexPath.row]
//
//        cell.textLabel?.text = user.name
//        cell.detailTextLabel?.text = user.status
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let user = people[indexPath.row]
//        let messagingVC = MessagingVC()
//        messagingVC.user = user
//        messagingVC.title = user.name
//
//        present(
//            UINavigationController(rootViewController: messagingVC),
//            animated: true,
//            completion: nil
//        )
//    }
//}

import UIKit
import Firebase
import FirebaseFirestore


class UsersViewController : UITableViewController {

    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.title = "Conatct"

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

       getUsers()

    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ChatViewController()
        vc.user = users[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

//
    func getUsers() {
        Firestore.firestore().collection("users").addSnapshotListener { snapshot, error in

            if error == nil {
                guard let userID = Auth.auth().currentUser?.uid else {return}

                for document in snapshot!.documents{
                    let data = document.data()

                    if data["id"] as? String != userID
                    {
                        self.users.append(User(
                            id: data["id"]as? String ?? "", name: data["name"] as? String ?? "",
                            status: data["status"] as? String ?? "" ))

                    }

                }

                self.tableView.reloadData()

            } else {
                print("ERROR : ", error?.localizedDescription as Any)
            }
        }
    }

}

