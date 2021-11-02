////
//  RegisterViewController.swift
//  chatApp
//
//  Created by SARA SAUD on 3/23/1443 AH.
//



import UIKit
class TabVC: UITabBarController, UITabBarControllerDelegate {
  override func viewDidLoad() {
    super.viewDidLoad()
    delegate = self
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
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    let item1 = UsersViewController()
    let item2 = ProfileVC()
      let item3 = favorite()
    let icon1 = UITabBarItem(title: "chats", image: UIImage(systemName: "contextualmenu.and.cursorarrow"), selectedImage: UIImage(systemName: "contextualmenu.and.cursorarrow"))
    let icon2 = UITabBarItem(title: "profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person"))
      let icon3 = UITabBarItem(title: "fav", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star"))
    item1.tabBarItem = icon1
    item2.tabBarItem = icon2
      item3.tabBarItem = icon3
    let controllers = [item1,item2,item3] //array of the root view controllers displayed by the tab bar interface
    self.viewControllers = controllers
  }
  func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
    print("Should select viewController: \(viewController.title ?? "") ?")
    return true;
  }
}
