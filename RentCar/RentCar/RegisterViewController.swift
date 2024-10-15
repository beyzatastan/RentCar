//
//  ViewController.swift
//  RentCar
//
//  Created by beyza nur on 15.10.2024.
//

import UIKit

class RegisterViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds=true
        return scrollView
    }()
    
    private let firstNameField: UITextField = {
       let field=UITextField()
        field.placeholder="Name..."
        field.autocapitalizationType = .words
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.leftView=UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = . always
        field.backgroundColor = .secondarySystemBackground
        return field
    }()
    private let lastNameField: UITextField = {
       let field=UITextField()
        field.placeholder="Name..."
        field.autocapitalizationType = .words
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.leftView=UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = . always
        field.backgroundColor = .secondarySystemBackground
        return field
    }()
    
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image=UIImage(systemName: "person.circle")
        imageView.tintColor = .systemYellow
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds=true
        imageView.layer.borderWidth=2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lastNameField)
      
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame=view.bounds
        let size = scrollView.width/3
        imageView.frame=CGRect(x: (scrollView.width-size)/2, y: 20, width: size, height: size)
        imageView.layer.cornerRadius=imageView.width/2.0
        firstNameField.frame=CGRect(x: 30, y: imageView.bottom+10, width: scrollView.width-60, height: 52)
        lastNameField.frame=CGRect(x: 30, y: firstNameField.bottom+10, width: scrollView.width-60, height: 52)
       
        
    }


}

