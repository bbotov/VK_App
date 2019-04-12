//
//  LoginFromController.swift
//  Weather
//
//  Created by Boris Botov on 11.11.2018.
//  Copyright © 2018 Boris Botov. All rights reserved.
//

import UIKit

class LoginFromController: UIViewController {
    @IBOutlet weak var vkImage: AvatarImageView!
    @IBOutlet weak var devName: UILabel!
    @IBOutlet weak var authButton: UIButton!    
}

//    @IBOutlet weak var passwordInput: UITextField!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // жест нажатия
//        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
//        // присваиваем его UIScrollVIew
//        scrollView?.addGestureRecognizer(hideKeyboardGesture)
//
//        // Do any additional setup after loading the view.
//    }
//
//    @objc override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
//        // Второе — когда она пропадает
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//
//    @objc override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
//    }

    
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        // Проверяем данные
//        let checkResult = checkUserData()
//
//        // Если данные неверны, покажем ошибку
//        if !checkResult {
//            showLoginError()
//        }
//
//        // Вернем результат
//        return checkResult
//    }
//
//    func checkUserData() -> Bool {
//        let login = loginInput.text!
//        let password = passwordInput.text!
//
//        if login == "wortus" && password == "123456" {
//            return true
//        } else {
//            return false
//        }
//    }
//    
//    func showLoginError() {
//        // Создаем контроллер
//        let alter = UIAlertController(title: "Ошибка", message: "Введены не верные данные пользователя", preferredStyle: .alert)
//        // Создаем кнопку для UIAlertController
//        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//        // Добавляем кнопку на UIAlertController
//        alter.addAction(action)
//        // Показываем UIAlertController
//        present(alter, animated: true, completion: nil)
//    }
//
//    // Когда клавиатура появляется
//    @objc func keyboardWasShown(notification: Notification) {
//
//        // Получаем размер клавиатуры
//        let info = notification.userInfo! as NSDictionary
//        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
//        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
//
//        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
//        self.scrollView?.contentInset = contentInsets
//        scrollView?.scrollIndicatorInsets = contentInsets
//    }
//
//    //Когда клавиатура исчезает
//    @objc func keyboardWillBeHidden(notification: Notification) {
//        // Устанавливаем отступ внизу UIScrollView, равный 0
//        let contentInsets = UIEdgeInsets.zero
//        scrollView?.contentInset = contentInsets
//        scrollView?.scrollIndicatorInsets = contentInsets
//    }
//
//    @objc func hideKeyboard() {
//        self.scrollView?.endEditing(true)
//    }
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
