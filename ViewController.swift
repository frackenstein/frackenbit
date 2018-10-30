//
//  ViewController.swift
//  BitGrader2
//
//  Created by American Code on 10/29/18.
//  Copyright © 2018 American Code and Dev LLC. All rights reserved.
//
import UIKit
import AVFoundation
import Vision
import CoreLocation
import Foundation
import MessageUI

extension CGRect{
    init(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat,_ height:CGFloat) {
        self.init(x:x,y:y,width:width,height:height)
    }
    
}
extension CGSize{
    init(_ width:CGFloat,_ height:CGFloat) {
        self.init(width:width,height:height)
    }
}
extension CGPoint{
    init(_ x:CGFloat,_ y:CGFloat) {
        self.init(x:x,y:y)
    }
}

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate, CLLocationManagerDelegate, MFMailComposeViewControllerDelegate, UITextFieldDelegate {
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Press Grade to Classify Bit"
        label.font = label.font.withSize(60)
        return label
        
    }()
    
    let label2: UILabel = {
        
        let label2 = UILabel()
        label2.textColor = .white
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.text = "Test"
        label2.font = label2.font.withSize(15)
        return label2
        
    }()
 
    let label3: UILabel = {
        
        let label3 = UILabel()
        label3.textColor = .white
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.text = "Email?"
        label3.font = label3.font.withSize(15)
        return label3
        
    }()
    
    @objc func buttonClicked() {
        print("Button Clicked")
//        if view.tag == 3 {
//            view.removeFromSuperview()
//        }
        setupCaptureSession()
        view.addSubview(label)
        setupLabel()
      
//        label.font = label.font.withSize(60)
//        setupLabel3()
    }
    
     @objc func buttonClicked2() {
        
        
//        view.removeFromSuperView()
        self.label3.textColor = .green
        self.label2.textColor = .green
        self.label.textColor = .green
        assignbackground2()
        view.addSubview(label)
        view.addSubview(button)
        view.addSubview(button2)
        view.addSubview(button3)
        view.addSubview(button4)
        view.addSubview(label2)
        view.addSubview(label3)
        
        setupLabel()
        setupLabel2()
        setupLabel3()
        button2.backgroundColor = .red
        button3.backgroundColor = .red
       
        
    }
    
    @objc func buttonClicked3() {
        
        
        //        view.removeFromSuperView()
        self.label3.textColor = .white
        self.label2.textColor = .white
        self.label.textColor = .white
        assignbackground()
        view.addSubview(label)
        view.addSubview(button)
        view.addSubview(button2)
        view.addSubview(button3)
        view.addSubview(button4)
        view.addSubview(label2)
        view.addSubview(label3)
      
        setupLabel()
        setupLabel2()
        setupLabel3()
        button2.backgroundColor = .red
        button3.backgroundColor = .red
        
    }
    
    @objc func buttonClicked4() {
        
        if let url = URL(string: "https://frackenstein.github.io"),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
        
    }
    let dFrom: UITextField = {
        
        let dFrom =  UITextField(frame: CGRect(x: 800, y: 200, width: 100, height: 40))
        dFrom.placeholder = "Depth From"
        dFrom.font = UIFont.systemFont(ofSize: 15)
        dFrom.borderStyle = UITextField.BorderStyle.roundedRect
        dFrom.autocorrectionType = UITextAutocorrectionType.no
        dFrom.keyboardType = UIKeyboardType.default
        dFrom.returnKeyType = UIReturnKeyType.done
        dFrom.clearButtonMode = UITextField.ViewMode.whileEditing;
        dFrom.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return dFrom
//        dFrom.delegate = self as UITextFieldDelegate
    }()
    
    let dTo: UITextField = {
        
        let dTo =  UITextField(frame: CGRect(x: 800, y: 300, width: 100, height: 40))
        dTo.placeholder = "Depth To"
        dTo.font = UIFont.systemFont(ofSize: 15)
        dTo.borderStyle = UITextField.BorderStyle.roundedRect
        dTo.autocorrectionType = UITextAutocorrectionType.no
        dTo.keyboardType = UIKeyboardType.default
        dTo.returnKeyType = UIReturnKeyType.done
        dTo.clearButtonMode = UITextField.ViewMode.whileEditing;
        dTo.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return dTo
//        dTo.delegate = self as UITextFieldDelegate
    }()
    
    let button: UIButton = {
        
        let button = UIButton(frame: CGRect(x: 125, y: 80, width: 100, height: 50))
        button.backgroundColor = .red
        //button.setTitle("Upload", for: .normal)
        button.setTitle("Grade", for: [])
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        return button
      
        //button.addTarget(self, action:#selector(buttonClicked), for: .touchUpInside)
        
    }()
    
    let button2: UIButton = {
        
        let button2 = UIButton(frame: CGRect(x: 800, y: 500, width: 100, height: 50))
        button2.backgroundColor = .red
        //button.setTitle("Upload", for: .normal)
        button2.setTitle("Dark?", for: [])
        button2.addTarget(self, action: #selector(buttonClicked2), for: .touchUpInside)
        return button2
        
        //button.addTarget(self, action:#selector(buttonClicked), for: .touchUpInside)
        
    }()
    
    let button3: UIButton = {
        
        let button3 = UIButton(frame: CGRect(x: 800, y: 570, width: 100, height: 50))
        button3.backgroundColor = .red
        //button.setTitle("Upload", for: .normal)
        button3.setTitle("Light?", for: [])
        button3.addTarget(self, action: #selector(buttonClicked3), for: .touchUpInside)
        return button3
        
        //button.addTarget(self, action:#selector(buttonClicked), for: .touchUpInside)
        
    }()
    
    let button4: UIButton = {
        
        let button4 = UIButton(frame: CGRect(x: 900, y: 650, width: 70, height: 50))
        button4.backgroundColor = .blue
        //button.setTitle("Upload", for: .normal)
        button4.setTitle("Info", for: [])
        button4.addTarget(self, action: #selector(buttonClicked4), for: .touchUpInside)
        return button4
        
        //button.addTarget(self, action:#selector(buttonClicked), for: .touchUpInside)
        
    }()
    
    func assignbackground(){
        
        let background1 = UIImage(named: "green-grass-field.jpg")
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background1
        imageView.center = view.center
        view.addSubview(imageView)
//        self.view.sendSubviewToBack(imageView)
        self.view.addSubview(dFrom)
        self.view.addSubview(dTo)
        
         var msg =  UserDefaults.standard.bool(forKey: "msg")
        let switchDemo=UISwitch(frame:CGRect(x: self.view.bounds.width - 100, y: 100, width: 30, height: 10))
        switchDemo.addTarget(self, action: #selector(ViewController.switchStateDidChange(_:)), for: .valueChanged)
        if msg == true{
            switchDemo.setOn(true, animated: false)
        }
        if msg == false{
            switchDemo.setOn(false, animated: false)
        }
        view.addSubview(switchDemo)
    }
    
    func assignbackground2(){
        
        let background = UIImage(named: "dark.jpg")
        var imageView2 : UIImageView!
        imageView2 = UIImageView(frame: view.bounds)
        imageView2.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView2.clipsToBounds = true
        imageView2.image = background
        imageView2.center = view.center
        view.addSubview(imageView2)
        self.view.addSubview(dFrom)
        self.view.addSubview(dTo)
        self.view.addSubview(button4)

         var msg =  UserDefaults.standard.bool(forKey: "msg")
        let switchDemo=UISwitch(frame:CGRect(x: self.view.bounds.width - 100, y: 100, width: 30, height: 10))
        switchDemo.addTarget(self, action: #selector(ViewController.switchStateDidChange(_:)), for: .valueChanged)
        if msg == true{
            switchDemo.setOn(true, animated: false)
        }
        if msg == false{
            switchDemo.setOn(false, animated: false)
        }
        view.addSubview(switchDemo)
        
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var msg =  UserDefaults.standard.bool(forKey: "msg")
//        var msg2 =  UserDefaults.standard.bool(forKey: "drk")
        //        var returnValue: [Bool]? = UserDefaults.standard.object(forKey: "msg") as? [Bool]
       
        
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "metal.jpg")!)
        assignbackground()
        let switchDemo=UISwitch(frame:CGRect(x: self.view.bounds.width - 100, y: 100, width: 30, height: 10))
        switchDemo.addTarget(self, action: #selector(ViewController.switchStateDidChange(_:)), for: .valueChanged)
        if msg == true{
            switchDemo.setOn(true, animated: false)
        }
        if msg == false{
            switchDemo.setOn(false, animated: false)
        }
        view.addSubview(switchDemo)
        
//        let switchDemo2=UISwitch(frame:CGRect(x: self.view.bounds.width - 100, y: 200, width: 30, height: 10))
//        switchDemo2.addTarget(self, action: #selector(ViewController.switchStateDidChange(_:)), for: .valueChanged)
//        if msg2 == true{
//            switchDemo2.setOn(true, animated: false)
//            assignbackground2()
//        }
//        if msg2 == false{
//            switchDemo2.setOn(false, animated: false)
////            viewDidLoad()
//        }
//        view.addSubview(switchDemo2)
        
       
        self.view.addSubview(dFrom)
        
        
        self.view.addSubview(dTo)
        
//        let imageName = "Icon-76@2x.png"
//        let image = UIImage(named: imageName)
//        let imageView = UIImageView(image: image!)
//        imageView.frame = CGRect(x: self.view.bounds.width/2 - 38, y: self.view.bounds.height/2 - 38, width: 76, height: 76)
//        imageView.tag = 3
//        view.addSubview(imageView)
        
        let locationManager = CLLocationManager()
        
        // Ask for Authorisation from the User.
        locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            let user_lat = String(format: "%f", locationManager.location!.coordinate.latitude)
            let user_long = String(format: "%f", locationManager.location!.coordinate.longitude)
            
            let first = user_lat + ", " + user_long
            //let second = "\(user_lat), \(user_long)"
            label2.text = first
            locationManager.stopUpdatingLocation()
        }
        
        
        
        view.addSubview(label)
        view.addSubview(button)
        view.addSubview(button2)
        view.addSubview(button3)
        view.addSubview(button4)
        view.addSubview(label2)
        view.addSubview(label3)
            setupLabel()
            setupLabel2()
            setupLabel3()
    }
    
    @objc func switchStateDidChange(_ sender:UISwitch!)
    {
        if (sender.isOn == true){
            print("UISwitch state is now ON")
            UserDefaults.standard.set(true, forKey: "msg") //Bool
        }
        else{
            print("UISwitch state is now Off")
            UserDefaults.standard.set(false, forKey: "msg") //Bool
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        label2.text = "locations = \(locValue.latitude) \(locValue.longitude)"
    }
    
    func setupCaptureSession() {
        let captureSession = AVCaptureSession()
        
        // search for available capture devices
        let availableDevices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back).devices
        
        // setup capture device, add input to our capture session
        do {
            if let captureDevice = availableDevices.first {
                let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
                
                captureSession.addInput(captureDeviceInput)
                
                
                //--------------------------------------------------------------------------------------
            }
        } catch {
            print(error.localizedDescription)
        }
        
        // setup output, add output to our capture session
        let captureOutput = AVCaptureVideoDataOutput()
        captureOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(captureOutput)
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.frame
        
        view.layer.addSublayer(previewLayer)
        
        //Add Rectangle
        let cgRect = CGRect(x: 375, y: 200, width: self.view.bounds.width/4, height: self.view.bounds.height/2)
        let myView = UIImageView()
        myView.frame = cgRect
        myView.backgroundColor = UIColor.clear
        myView.isOpaque = false
        myView.layer.cornerRadius = 10
        myView.layer.borderColor =  UIColor.yellow.cgColor
        myView.layer.borderWidth = 3
        myView.layer.masksToBounds = true
        previewLayer.addSublayer(myView.layer)
        
        captureSession.startRunning()
        
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { // change 5 to desired number of seconds
            // Your code with delay
            self.takeScreenshot(true)
            captureSession.stopRunning()
            
            //self.sendMail()
        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 6) { // change 5 to desired number of seconds
//            // Your code with delay
//            self.takeScreenshot(true)
//        }
        
    }
    
    // called everytime a frame is captured
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let model = try? VNCoreMLModel(for: BitClassifier().model) else {return}
        var readings1:NSMutableArray = []
        var readings2:NSMutableArray = []
        let request = VNCoreMLRequest(model: model) { (finishedRequest, error) in
            let textView = UITextView(frame: CGRect(x: 40.0, y: 300.0, width: 250.0, height: 400.0))
            //self.automaticallyAdjustsScrollViewInsets = false
            
            //textView.center = self.view.center
            textView.textAlignment = NSTextAlignment.justified
            textView.textColor = UIColor.red
            textView.backgroundColor = UIColor.black
            //self.view.layer.removeFromSuperlayer()
            self.view.addSubview(textView)
            guard let results = finishedRequest.results as? [VNClassificationObservation] else { return }
            guard let Observation = results.first else { return }
//            var sum1 = 0.0 as! Float
//            var sum2 = 0.0 as! Float
            DispatchQueue.main.async(execute: {
                self.label.text = "\(Observation.identifier)"
                let temp = "\(Observation.identifier)"
                let scoreArray = temp.components(separatedBy: "-")
                //cummulate readings here
                let numberFormatter = NumberFormatter()
                let number1 = numberFormatter.number(from: scoreArray[0])
                let value0 = Float(scoreArray[0]) ?? 0.0
                let number1FloatValue = number1?.floatValue
                let number2 = numberFormatter.number(from: scoreArray[1])
                 let value1 = Float(scoreArray[1]) ?? 0.0
                let number2FloatValue = number2?.floatValue
                readings1.add(number1FloatValue)
                readings2.add(number2FloatValue)
//                sum1 = value0 + sum1
//                sum2 = value0 + sum2
                
//                var sum = 0 as! Float
//                var counter = 0
//                while counter < readings1.count {
//                    if let str = readings1[counter] as? String, let i = Int(str) {
//                        // do what you want with i
//                        var newValue = readings1[counter] as! Float
//                        sum = newValue + sum
//                        counter += 1
//                    }
//
//                }
//                print(sum)
                
                let count1 = readings1.count
                let count2 = readings2.count
        
                
                textView.text = "Scan Complete! \n Location: \n \(self.label2.text!) \n Inner:  \(readings1[0]) \n Outer:  \(readings2[0]) \n Depth From:  \(self.dFrom.text!) \n Depth To: \(self.dTo.text!)"
                print(readings1)
                print(readings2)
                
              
                
                
            })
            
        }
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        // executes request
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }
    
    func setupLabel() {
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
    }
//    x: self.view.bounds.width - 100, y: 100
    
    
    
    func setupLabel3() {
        label3.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 360).isActive = true
        label3.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -260).isActive = true
//        label3.center = CGPoint(x: 300, y: 100)
    }
    func setupLabel2() {
        label2.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -330).isActive = true
        label2.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -600).isActive = true
    }

     func takeScreenshot(_ shouldSave: Bool = true) -> UIImage? {
        var screenshotImage :UIImage?
        let layer = UIApplication.shared.keyWindow!.layer
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        guard let context = UIGraphicsGetCurrentContext() else {return nil}
        layer.render(in:context)
        screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let image = screenshotImage, shouldSave {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            
        }
        var msg =  UserDefaults.standard.bool(forKey: "msg")
//        var returnValue: [Bool]? = UserDefaults.standard.object(forKey: "msg") as? [Bool]
        if msg == true{
            sendMail(imageView: screenshotImage!)
        }
        return screenshotImage
    
    
    
    }
    
   
    
    func sendMail(imageView: UIImage) {
    //func sendMail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self;
            mail.setCcRecipients(["drilling@dvn.com"])
            mail.setSubject("Updated Drill Bit Grading \(self.label2.text!)")
            mail.setMessageBody("Grading: \(self.label.text!) \n Depth From:  \(self.dFrom.text!) \n Depth To:  \(self.dTo.text!)", isHTML: false)
            let imageData: NSData = imageView.pngData()! as NSData
            mail.addAttachmentData(imageData as Data, mimeType: "image/png", fileName: "Test.png")
            self.present(mail, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result.rawValue {
        case MFMailComposeResult.cancelled.rawValue :
            print("Cancelled")
            
        case MFMailComposeResult.failed.rawValue :
            print("Failed")
            
        case MFMailComposeResult.saved.rawValue :
            print("Saved")
            
        case MFMailComposeResult.sent.rawValue :
            print("Sent")
            
            
            
        default: break
            
            
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
