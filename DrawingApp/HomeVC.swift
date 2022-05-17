//
//  ViewController.swift
//  DrawingApp
//
//  Created by Alexander Thompson on 17/5/2022.
//

import UIKit
import PencilKit

class HomeVC: UIViewController, PKCanvasViewDelegate, PKToolPickerObserver {
    
    var drawingView = PKCanvasView()
    let drawing = PKDrawing()
    let toolPicker = PKToolPicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configurebarButtons()
        layoutUI()
    }

    private func configure() {
        view.addSubview(drawingView)
        drawingView.translatesAutoresizingMaskIntoConstraints = false
        drawingView.delegate = self
        drawingView.drawing = drawing
        drawingView.alwaysBounceVertical = true
        drawingView.drawingPolicy = .anyInput
        
        
       
        toolPicker.addObserver(drawingView)
        toolPicker.setVisible(true, forFirstResponder: drawingView)
        drawingView.becomeFirstResponder()
    
    }
    
    private func configurebarButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "camera"), style: .done, target: self, action: #selector(screenshotPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Pencil", style: .done, target: self, action: #selector(pencilPressed))
    }
    
    private func layoutUI() {
        NSLayoutConstraint.activate([
            drawingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            drawingView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            drawingView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            drawingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    
    @objc func screenshotPressed() {
        
    }
    
    @objc func pencilPressed() {
        
    }
    
  
}

