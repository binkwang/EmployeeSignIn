//
//  ScanningViewController.swift
//  EmployeeSignIn
//
//  Created by Bink Wang on 4/10/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import UIKit
import AVFoundation

class ScanningViewController: UIViewController {

    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
    }
    
    private func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    let json = """
{"id": 2, "fullName": "Bink Wang", "avatar": "https://secure.cdn3.wdpromedia.cn/resize/mwImage/1/125/125/90/wdpromedia.disney.go.com/media/wdpro-shdr-assets/prod/zh-cn-cn/system/images/shdr-dine-pinocchio-village-gallery-19-pizza-feast-sq.jpg"}
""".data(using: .utf8)!

}

// MARK: - AVCaptureMetadataOutputObjectsDelegate

extension ScanningViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
        
        dismiss(animated: true)
    }
    
    private func found(code: String) {
        print(code)
        
        let jsonData = code.data(using: .utf8)!
        var staff: Staff?
        
        DispatchQueue.global(qos: .utility).async {
            do {
                staff = try JSONDecoder().decode(Staff.self, from: jsonData)
                print(staff as Any)
            } catch let error {
                print(error.localizedDescription)
            }
            
            if let staff = staff, let fullName = staff.fullName {
                
                self.showAlert("Confirm Signin", "Hi \(fullName), confirm your sign in at 8:30am", confirmHandler: { [weak self] in
                    guard let _ = self else { return }
                    
                    
                    
                    
                    
                    }, cancelHandler: { [weak self] in
                        guard let weakSelf = self else { return }
                        weakSelf.navigationController?.popViewController(animated: true)
                })
            }
        }
        
        
        
    }
    
}
