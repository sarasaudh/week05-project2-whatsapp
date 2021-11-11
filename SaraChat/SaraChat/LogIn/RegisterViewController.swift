////
//  RegisterViewController.swift
//  chatApp
//
//  Created by SARA SAUD on 3/23/1443 AH.
//

import UIKit
import FirebaseAuth
class RegisterViewController: UIViewController {
    
    private let scrollView: UIScrollView  = {
       let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.tintColor = .purple
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.purple.cgColor
        return imageView
    }()
    
    private let emailField: UITextField = {
        
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Email Address..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .purple
        field.backgroundColor = UIColor(red: 200/255, green: 150/255, blue: 200/255, alpha: 70)

        return field
    }()
    
    private let PasswordField: UITextField = {
        
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Password..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = UIColor(red: 200/255, green: 150/255, blue: 200/255, alpha: 70)
        field.isSecureTextEntry = true
        
        return field
    }()
    
    private let firstNameField: UITextField = {
        
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "First Name..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = UIColor(red: 200/255, green: 150/255, blue: 200/255, alpha: 70)
       // field.isSecureTextEntry = true
        
        return field
    }()
    
    private let lastNameField: UITextField = {
        
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Last Name..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = UIColor(red: 200/255, green: 150/255, blue: 200/255, alpha: 70)
     //   field.isSecureTextEntry = true
        
        return field
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "LOG IN ☺︎"
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register ☞ ", style: .done, target: self, action: #selector(didTapRegister))
        // Do any additional setup after loading the view.
        
        registerButton.addTarget(self,
                              action: #selector(registerButtonTapped),
                              for: .touchUpInside
        )
        emailField.delegate = self
        PasswordField.delegate = self
       
        
        
        
        //add subviews
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(PasswordField)
        scrollView.addSubview(registerButton)
        scrollView.addSubview(lastNameField)
        scrollView.addSubview(firstNameField)
        
        imageView.isUserInteractionEnabled = true
        scrollView.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfilePic))
        imageView.addGestureRecognizer(gesture)
    }
    @objc private func didTapChangeProfilePic() {
        presentPhotoActionSheet()
    
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = scrollView.width/3
        imageView.frame = CGRect(x: (view.width-size)/2,
                                 y: 20,
                                 width: size,
                                 height: size)
        imageView.layer.cornerRadius = imageView.width/2.0
        firstNameField.frame = CGRect(x:30,
                                  y: imageView.bottom+10,
                                  width: scrollView.width-60,
                                 height: 52)
        lastNameField.frame = CGRect(x:30,
                                  y: firstNameField.bottom+10,
                                  width: scrollView.width-60,
                                 height: 52)
        emailField.frame = CGRect(x:30,
                                  y: lastNameField.bottom+10,
                                  width: scrollView.width-60,
                                 height: 52)
       
        PasswordField.frame = CGRect(x:30,
                                  y: emailField.bottom+10,
                                  width: scrollView.width-60,
                                 height: 52)
        
        registerButton.frame = CGRect(x:65,
                                 y: PasswordField.bottom+30,
                                   width: scrollView.width-120,
                                height: 60)
                
    }
    
    @objc private func registerButtonTapped() {

        
        emailField.resignFirstResponder()
        PasswordField.resignFirstResponder()
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()

        
        guard let firstName = firstNameField.text,
              let lastName = lastNameField.text,
              let email = emailField.text,
              let password = PasswordField.text,
            !email.isEmpty,
              !password.isEmpty,
              !firstName.isEmpty,
                !lastName.isEmpty,
              password.count >= 6 else {
                alertUserLoginError()
                return
                }
        //FireBase LogIn
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { [weak self] authResult, error  in
            guard let strongSelf = self else {
                return
            }
            guard let result = authResult, error == nil else {
                print("Error cureating user")
                return
            }
            let user = result.user
            print("Created User: \(user)")
            strongSelf.navigationController?.dismiss(animated: true , completion: nil)
        })
    }
    func alertUserLoginError() {
        let alert = UIAlertController(title: "oh...", message: "Please enter All Your Informations To Create New Account ☑︎", preferredStyle: .alert)
      
        alert.addAction(UIAlertAction(title: "Dismis", style: .cancel , handler: nil))
        present(alert, animated: true)
    }
    @objc private func didTapRegister() {
        let vc = RegisterViewController()
        vc.title = "Create Account"
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension RegisterViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if textField == emailField {
            PasswordField.becomeFirstResponder()
        }
        else if textField == PasswordField {
            registerButtonTapped()
        }

        return true
    }

}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func presentPhotoActionSheet(){
        let actionSheet = UIAlertController(title: "Profile Photo",
                                            message: "How would you like to select a Picture",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Canesl", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take Photo 📸 ", style: .default,
                                            handler: { [weak self]_ in
            self?.presentCamera()

        }))
        actionSheet.addAction(UIAlertAction(title: "Chose Photo ", style: .default,
                                            handler: { [weak self]_ in
            self?.presetPhotoPicker()
        }))
        present(actionSheet, animated: true)
    }
    
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func presetPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        print(info)
        
        guard let selectedImage =  info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
           return
           }
        self.imageView.image = selectedImage
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


