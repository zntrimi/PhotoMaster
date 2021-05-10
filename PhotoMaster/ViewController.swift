//
//  ViewController.swift
//  PhotoMaster
//
//  Created by Zentaro Imai on 2021/05/10.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    @IBOutlet var photoImageView: UIImageView!   // 写真表示用Image View
    
    
    func presentPickerController(sourceType: UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true, completion: nil)
        
        photoImageView.image = info[.originalImage] as? UIImage

    }
    
   
    
       func drawText(image: UIImage) -> UIImage {
           
           let text = "ZENTAROIMAI今井善太郎"
           
           
           let textFontAttributes = [
               NSAttributedString.Key.font: UIFont(name: "Arial", size: 120)!,
               NSAttributedString.Key.foregroundColor: UIColor.red]
        
        UIGraphicsBeginImageContext (image.size)
        
        
        //Render photo
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        
        let margin: CGFloat = 5.5 //余白
        let textReact = CGRect(x: margin, y: margin, width: image.size.width - margin, height: image.size.height - margin)
        
        text.draw(in: textReact, withAttributes: textFontAttributes)
        
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage!
        
        
        
        
       }
    
    func drawMaskImage(image: UIImage) -> UIImage {
        
        let maskImage = UIImage(named: "familyguy")!
        
        UIGraphicsBeginImageContext(image.size)
        
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        
        let margin: CGFloat = 50.0
        let maskRect = CGRect(x: image.size.width - maskImage.size.width - margin,
                             y: image.size.height - maskImage.size.height - margin,
                             width: maskImage.size.width, height: maskImage.size.height)
        
        maskImage.draw(in: maskRect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage!
        
        
    }
           
    
    



    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTappedCameraButton(){
        
        presentPickerController(sourceType: .camera)
        
    }
    
    @IBAction func onTappedAlbumButton() {
        
        presentPickerController(sourceType: .photoLibrary)
        
    }
    
    @IBAction func onTappedTextButton(){
        
        if photoImageView.image != nil {
            photoImageView.image = drawText(image: photoImageView.image!)
        
            
        }else{
            print ("画像がありません")
        }
        
    }
    
    
    @IBAction func onTappedIllustButton(){
        
        if photoImageView.image != nil {
            photoImageView.image = drawMaskImage(image: photoImageView.image!)
        
            
        }else{
            print ("画像がありません")
        }
        
    }
    
    @IBAction func onTappedUploadButton() {
        if photoImageView.image != nil {
            let activityVC = UIActivityViewController(activityItems: [photoImageView.image!, "#PhotoMaster"],
                                                      applicationActivities: nil)
            
            self.present(activityVC, animated: true, completion: nil)
            
        }else{
            print ("画像がありません")
        }
        
    }
 

    


}

