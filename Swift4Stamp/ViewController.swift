//
//  ViewController.swift
//  Swift4Stamp
//
//  Created by tatsumi kentaro on 2018/02/04.
//  Copyright © 2018年 tatsumi kentaro. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var imageNameArray: [String] = ["hana.png","hoshi.png","onpu.png","shitumon.png"]
    
    var imageIndex: Int = 0
    
    @IBOutlet var background_image: UIImageView!
    
    var imageView:UIImageView!
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selected_first(_ sender: Any) {
        imageIndex = 1
    }
    
    @IBAction func selected_secound(_ sender: Any) {
        imageIndex = 2
    }
    
    @IBAction func selected_third(_ sender: Any) {
        imageIndex = 3
    }
    
    @IBAction func selected_fourth(_ sender: Any) {
        imageIndex = 4
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        let location: CGPoint = touch.location(in: self.view)
        
        if imageIndex != 0{
            imageView = UIImageView(frame:CGRect(x: 0, y: 0, width: 40, height: 40))
            
            let image_min:UIImage = UIImage(named:imageNameArray[imageIndex-1])!
            imageView.image = image_min
            
            imageView.center = CGPoint(x: location.x, y: location.y)
            
            self.view.addSubview(imageView)
            
        }
    }
    
    @IBAction func image_select(_ sender: Any) {
        
        let imagePickerContoroller:UIImagePickerController = UIImagePickerController()
        imagePickerContoroller.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePickerContoroller.delegate = self
        imagePickerContoroller.allowsEditing = true
        
        self.present(imagePickerContoroller, animated: true, completion: nil)
        
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        background_image.image = image
        
        self.dismiss(animated: true, completion: nil)
       
    }
    
    
    @IBAction func back(_ sender: Any) {
        self.imageView.removeFromSuperview()
    }
    
    @IBAction func save(_ sender: Any) {
        
        let rect:CGRect = CGRect(x: 0, y: 30, width: 320, height: 380)
        UIGraphicsBeginImageContext(rect.size)
        self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let capture = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIImageWriteToSavedPhotosAlbum(capture!, nil, nil, nil)
        let alert: UIAlertController = UIAlertController(title:"確認", message: "写真を保存します", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            print("OK")
        }))
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
}
