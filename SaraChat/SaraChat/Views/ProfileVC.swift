//
//  RegisterViewController.swift
//  chatApp
//
//  Created by SARA SAUD on 3/23/1443 AH.
//



import UIKit
class ProfileVC : UIViewController{
    var img: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "p1")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let name = UITextField()
    let status = UITextField()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .red
        
        view.addSubview(img)
        NSLayoutConstraint.activate([
            img.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            img.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 10),
            img.heightAnchor.constraint(equalToConstant: 80),
            img.widthAnchor.constraint(equalTo: img.heightAnchor,multiplier: 100/100)])
        
        
        
        name.text = "sara"
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
//
//        var img: UIImageView = {
//            let imageView = UIImageView()
//            imageView.image = UIImage(named: "p2")
//            imageView.translatesAutoresizingMaskIntoConstraints = false
//            return imageView
//        }()
//        let name = UILabel()
//        let status = UILabel()
        
    
            
//            view.backgroundColor = .green
//
//            view.addSubview(img)
//            NSLayoutConstraint.activate([
//                img.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
//                img.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 10),
//                img.heightAnchor.constraint(equalToConstant: 80),
//                img.widthAnchor.constraint(equalTo: img.heightAnchor,multiplier: 100/100)])
//
//
//
//            name.text = "tasnim"
//            name.font = .boldSystemFont(ofSize: 23)
//            name.translatesAutoresizingMaskIntoConstraints = false
//
//            view.addSubview(name)
//            NSLayoutConstraint.activate([
//
//                name.topAnchor.constraint(equalTo: view.topAnchor,constant: 80),
//                name.leftAnchor.constraint(equalTo: img.leftAnchor , constant: -130),
//                name.heightAnchor.constraint(equalToConstant: 120),
//                name.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: 140)
//            ])
//
            
//            status.text = "offline"
//            status.textColor = .gray
//            status.translatesAutoresizingMaskIntoConstraints = false
//
            view.addSubview(status)
            NSLayoutConstraint.activate([
                
                status.topAnchor.constraint(equalTo: view.topAnchor,constant: 120),
                status.leftAnchor.constraint(equalTo: view.leftAnchor , constant: 30),
                status.heightAnchor.constraint(equalToConstant: 50),
                status.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: 130)
            ])
        view.backgroundColor = UIColor(red: 200/255, green: 150/255, blue: 200/255, alpha: 70)

        assignbackground()

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
