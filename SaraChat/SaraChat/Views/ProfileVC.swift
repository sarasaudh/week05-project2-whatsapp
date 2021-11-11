//
//  RegisterViewController.swift
//  chatApp
//
//  Created by SARA SAUD on 3/23/1443 AH.
//



import UIKit
import FirebaseFirestore
import FirebaseAuth
class ProfileVC : UIViewController{
    var img: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "p1")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let name = UITextField()
    let status = UITextField()
    
    let saveBtn : UIButton = {
        $0.backgroundColor = .white
        $0.setTitle("Save Changes", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.tintColor = .blue
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(saveBTn), for: .touchUpInside)
        return $0
    }(UIButton())
    
    
    let outBtn : UIButton = {
        $0.backgroundColor = .quaternarySystemFill
        $0.setTitle("Sing Out", for: .normal)
        $0.setTitleColor(UIColor.red, for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(singOutBtn), for: .touchUpInside)
        return $0
    }(UIButton())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .white
        
        view.addSubview(img)
        NSLayoutConstraint.activate([
            img.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            img.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 10),
            img.heightAnchor.constraint(equalToConstant: 80),
            img.widthAnchor.constraint(equalTo: img.heightAnchor,multiplier: 100/100)])
        
        
        
        name.text = "Sara"
        name.font = .boldSystemFont(ofSize: 23)
        name.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(name)
        NSLayoutConstraint.activate([
            
            name.topAnchor.constraint(equalTo: view.topAnchor,constant: 90),
            name.leftAnchor.constraint(equalTo: img.leftAnchor , constant: -90),
            name.heightAnchor.constraint(equalToConstant: 80),
            name.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: 100)
        ])
        
        
        status.text = "Available"
        status.textColor = .green
        status.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(status)
        NSLayoutConstraint.activate([
            
            status.topAnchor.constraint(equalTo: view.topAnchor,constant: 120),
            status.leftAnchor.constraint(equalTo: view.leftAnchor , constant: 30),
            status.heightAnchor.constraint(equalToConstant: 20),
            status.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: 100)
        ])

            view.addSubview(status)
            NSLayoutConstraint.activate([
                
                status.topAnchor.constraint(equalTo: view.topAnchor,constant: 120),
                status.leftAnchor.constraint(equalTo: view.leftAnchor , constant: 30),
                status.heightAnchor.constraint(equalToConstant: 50),
                status.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: 130)
            ])
        view.backgroundColor = UIColor(red: 200/255, green: 150/255, blue: 200/255, alpha: 70)

        assignbackground()
        
        
        view.addSubview(saveBtn)
        
        NSLayoutConstraint.activate([
            saveBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 400),
            saveBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            saveBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            saveBtn.widthAnchor.constraint(equalToConstant: 200),
            saveBtn.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
        view.addSubview(outBtn)
        
        NSLayoutConstraint.activate([
            outBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 450),
            outBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            outBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            outBtn.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        guard let currentUserID = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore()
            .document("users/\(currentUserID)")
            .addSnapshotListener{ doucument, error in
                if error != nil {
                    print (error)
                    return
                }
                
                self.name.text = doucument?.data()?["name"] as? String
                self.status.text = doucument?.data()?["status"] as? String
            }
        
    

    }
    
    @objc func saveBTn() {
        guard let currentUserID = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().document("users/\(currentUserID)").updateData([
            "name" : name.text,
            "uID" : currentUserID,
            "status" :status.text,
            
        ])
        let alert1 = UIAlertController(
            title: ("Saved"),
            message: "Saved update data",
            preferredStyle: .alert)
        
        alert1.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                handler: { action in
                    print("OK")
                }
            )
        )
        present(alert1, animated: true, completion: nil)
    }
    
@objc func singOutBtn() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: \(signOutError.localizedDescription)")
        }
    }

    func assignbackground(){
          let background = UIImage(named: "z")

          var imageView : UIImageView!
          imageView = UIImageView(frame: view.bounds)
        //  imageView.contentMode =  UIViewContentMode.ScaleAspectFill
          imageView.clipsToBounds = true
          imageView.image = background
          imageView.center = view.center
          view.addSubview(imageView)
          self.view.sendSubviewToBack(imageView)
      }
    
}

