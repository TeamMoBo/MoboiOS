//
//  MyPageViewController.swift
//  Mobo_iOS
//
//  Created by 천유정 on 27/12/2019.
//  Copyright © 2019 조경진. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController , UITextFieldDelegate {
    
    let picker = UIImagePickerController()
    
    @IBOutlet weak var camera: UIButton!
    
    
    @IBOutlet weak var profilepic: UIImageView!
    @IBOutlet weak var selectedpic: UIImageView!
    
    @IBOutlet weak var agetext: UITextField!
    @IBOutlet weak var pwdtext: UITextField!
    @IBOutlet weak var kakaoidtext: UITextField!
    @IBOutlet weak var majortext: UITextField!
    @IBOutlet weak var nametext: UITextField!
    @IBOutlet weak var idtext: UITextField!
    @IBOutlet weak var placetext: UITextField!
    @IBOutlet weak var unitext: UITextField!
    
    @IBOutlet weak var ticketcount: UILabel!
    @IBOutlet weak var popcorncount: UILabel!
    
    
    @IBOutlet weak var womanbtn: UIButton!
    @IBOutlet weak var manbtn: UIButton!
    @IBOutlet weak var nomatterbtn: UIButton!
    
    @IBOutlet weak var womanimg: UIImageView!
    @IBOutlet weak var manimg: UIImageView!
    @IBOutlet weak var nomatterimg: UIImageView!
    
    var womanSelected: Bool = false {
        didSet {
            let image = womanSelected ? UIImage(imageLiteralResourceName: "icSelected") : UIImage(imageLiteralResourceName: "icUnselected")
            womanimg.image = image
        }
    }
    
    var manSelected: Bool = false {
        didSet {
            let image = manSelected ? UIImage(imageLiteralResourceName: "icSelected") : UIImage(imageLiteralResourceName: "icUnselected")
            manimg.image = image
        }
    }
    var nomatterSelected: Bool = false {
        didSet {
            let image = nomatterSelected ? UIImage(imageLiteralResourceName: "icSelected") : UIImage(imageLiteralResourceName: "icUnselected")
            nomatterimg.image = image
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationSetup()
        picker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        selectedpic.layer.cornerRadius = 52
        agetext.delegate = self;
        nametext.delegate = self;
        kakaoidtext.delegate = self;
        unitext.delegate = self;
        placetext.delegate = self;
        idtext.delegate = self;
        majortext.delegate = self;
        pwdtext.delegate = self;
        
        womanbtn.addTarget(self, action: #selector(womanSelect), for: .touchUpInside)
        
         manbtn.addTarget(self, action: #selector(manSelect), for: .touchUpInside)
        
         nomatterbtn.addTarget(self, action: #selector(nomatterSelect), for: .touchUpInside)
    }
    
    
    
    
    
    
    
    @IBAction func camerabtn(_ sender: Any) {
        let alert =  UIAlertController(title: "너를보여줘!", message: "인생사진 어때?", preferredStyle: .actionSheet)
        
        let library =  UIAlertAction(title: "사진앨범", style: .default) { (action) in self.openLibrary()
        }
        
        let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in
            self.openCamera()
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func ticketboxbtn(_ sender: Any) {
    }
    
    
    func openLibrary(){
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
    }
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
            present(picker, animated: false, completion: nil)
        }
        else{
            print("Camera not available")
        }
        
    }
    
    
    @objc func womanSelect() {
        womanSelected = true
        manSelected = false
        nomatterSelected = false
    }
    
    @objc func manSelect() {
        womanSelected = false
        manSelected = true
        nomatterSelected = false
    }
    
    @objc func nomatterSelect() {
        womanSelected = false
        manSelected = false
        nomatterSelected = true
    }
    
    func navigationSetup() { //네비게이션 투명색만들기
        
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 255/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "iconsDarkBack")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "iconsDarkBack")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "채팅대기", style: .done, target: nil, action: nil)
        self.navigationItem.backBarButtonItem?.tintColor = .black
        //투명하게 만드는 공식처럼 기억하기
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        //네비게이션바의 백그라운드색 지정. UIImage와 동일
        self.navigationController?.navigationBar.shadowImage = UIImage()
        //shadowImage는 UIImage와 동일. 구분선 없애줌.
        self.navigationController?.navigationBar.isTranslucent = true
        //false면 반투명이다.
        self.navigationController?.view.backgroundColor = .clear
        //뷰의 배경색 지정
        //        self.navigationController?.navigationBar.topItem?.title = "Home"
        //        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.init(red: 211/255.0, green: 211.0/255.0, blue: 211.0/255.0, alpha: 1.0)]
        //        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.endEditing(false)
    }
    
}
extension MyPageViewController : UIImagePickerControllerDelegate,
UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedpic.image = image
        }
        
        dismiss(animated: true)
    }
}
