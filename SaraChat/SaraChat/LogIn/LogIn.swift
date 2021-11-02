//
//
//  LogIn.swift
//  SaraChat
//
//  Created by SARA SAUD on 3/26/1443 AH.
//
//
//  LogInViewController.swift
//  chatApp
//
//  Created by SARA SAUD on 3/23/1443 AH.
//
//


import UIKit
import FirebaseAuth

final class LogInViewController: UIViewController {

    private let scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()


    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Image")
        imageView.contentMode = .scaleAspectFit
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

    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .systemPurple
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "LOG IN ☺︎"
        view.backgroundColor = .white

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register ☞ ", style: .done, target: self, action: #selector(didTapRegister))
        // Do any additional setup after loading the view.

        loginButton.addTarget(self,
                              action: #selector(loginButtonTapped),
                              for: .touchUpInside
        )
        emailField.delegate = self
        PasswordField.delegate = self

        //add subviews
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(PasswordField)
        scrollView.addSubview(loginButton)

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = scrollView.width/3
        imageView.frame = CGRect(x: (view.width-size)/2,
                                 y: 20,
                                 width: size,
                                 height: size)

        emailField.frame = CGRect(x:30,
                                  y: imageView.bottom+10,
                                  width: scrollView.width-60,
                                 height: 52)
        PasswordField.frame = CGRect(x:30,
                                  y: emailField.bottom+10,
                                  width: scrollView.width-60,
                                 height: 52)

        loginButton.frame = CGRect(x:65,
                                 y: PasswordField.bottom+30,
                                   width: scrollView.width-120,
                                height: 60)
        

    }

    @objc private func loginButtonTapped() {

        emailField.resignFirstResponder()
        PasswordField.resignFirstResponder()

        guard let email = emailField.text, let password = PasswordField.text,
            !email.isEmpty, !password.isEmpty, password.count >= 6 else {
                alertUserLoginError()
                return
                }
        //FireBase LogIn

        FirebaseAuth.Auth.auth().signIn(withEmail: email,
                                        password: password,
                                        completion: { [weak self] authResult, error in
            guard let strongSelf = self else {
                return
            }
            guard let result = authResult, error == nil else {
                print("Filed to log in user with email: \(email)")
                return
            }
                
                //guard let strongSelf = self else {
                
            let user = result.user
            print("Logged in User \(user)")
            strongSelf.navigationController?.dismiss(animated: true , completion: nil)
        
        })}
        
    
    func alertUserLoginError() {
        let alert = UIAlertController(title: "oh...", message: "Please enter your Email & Password To LogIN ✪", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Dismis", style: .cancel , handler: nil))
        present(alert, animated: true)
    }
    @objc private func didTapRegister() {
        let vc = RegisterViewController()
        vc.title = "Create Account"
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension LogInViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if textField == emailField {
            PasswordField.becomeFirstResponder()
        }
        else if textField == PasswordField {
            loginButtonTapped()
        }

        return true
    }

    
    
    @objc func loginAction() {
        if let email = emailField.text, email.isEmpty == false, let password = PasswordField.text, password.isEmpty == false {
            
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if error == nil {
                    // go to main vc
                    let vc = UINavigationController( rootViewController:  TabVC())
                    vc.modalTransitionStyle = .crossDissolve
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                } else {
                    print(error?.localizedDescription)
                }
            }
        }
        
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
