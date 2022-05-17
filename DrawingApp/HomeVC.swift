//
//  ViewController.swift
//  DrawingApp
//
//  Created by Alexander Thompson on 17/5/2022.
//

import UIKit
import PencilKit
import PhotosUI

class HomeVC: UIViewController, PKCanvasViewDelegate, PKToolPickerObserver {
    
    var canvasView = PKCanvasView()
    let drawing = PKDrawing()
    let toolPicker = PKToolPicker()
    let canvasWidth: CGFloat = 768
    let canvasoverScrollHeight: CGFloat = 500

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configurebarButtons()
        layoutUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let canvasScale = canvasView.bounds.width / canvasWidth
        canvasView.minimumZoomScale = canvasScale
        canvasView.maximumZoomScale = canvasScale
        canvasView.zoomScale = canvasScale
        
        canvasView.contentOffset = CGPoint(x: 0, y: -canvasView.adjustedContentInset.top)
        updateContentSizeForDrawing()
        
    }
    
    
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        updateContentSizeForDrawing()
    }

    private func configure() {
        view.addSubview(canvasView)
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        canvasView.delegate = self
        canvasView.drawing = drawing
        canvasView.alwaysBounceVertical = true
        canvasView.drawingPolicy = .anyInput
        
        
       
        toolPicker.addObserver(canvasView)
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        canvasView.becomeFirstResponder()
    
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    private func configurebarButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "camera"), style: .done, target: self, action: #selector(screenshotPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Pencil", style: .done, target: self, action: #selector(toggleFingerOrPencil))
    }
    
    private func layoutUI() {
        NSLayoutConstraint.activate([
            canvasView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            canvasView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            canvasView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            canvasView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    
    @objc func screenshotPressed() {
        UIGraphicsBeginImageContext(canvasView.bounds.size)
        canvasView.drawHierarchy(in: canvasView.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        if image != nil {
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAsset(from: image!)
            }, completionHandler: { success, error in
                
                
            })
        }
        
        
    }
    
    @objc func toggleFingerOrPencil(sender: UIBarButtonItem) {
        //add a bool here to switch between finger allowed and not.
//        canvasView.drawingPolicy = .
//        sender.title = canvasView.allowsFingerDrawing
    }
    
    
    func updateContentSizeForDrawing() {
        let drawing = canvasView.drawing
        let contentHeight: CGFloat
        
        if !drawing.bounds.isNull {
            contentHeight = max(canvasView.bounds.height, (drawing.bounds.maxY + self.canvasoverScrollHeight) * canvasView.zoomScale)
        } else {
            contentHeight = canvasView.bounds.height
        }
        canvasView.contentSize = CGSize(width: canvasWidth * canvasView.zoomScale, height: contentHeight)
    }
  
}

