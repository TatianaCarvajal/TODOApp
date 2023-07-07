//
//  WelcomeViewController.swift
//  TODOApp
//
//  Created by Tatiana Carvajal on 7/07/23.
//

import Foundation
import UIKit
import Lottie

class WelcomeViewController: UIViewController {
    
    private struct Constants {
        static let labelViewPadding = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: -20)
        static let animationViewPadding = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        static let animationHeight: CGFloat = 300
        static let animationWidth: CGFloat = 300
    }
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Bienvenido a TODOAPP"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.backgroundColor = UIColor(named: "backgroundColor")
        label.textAlignment = .center
        return label
    }()
    
    private lazy var animationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "TodoAnimation")
        animationView.contentMode = .scaleToFill
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "backgroundColor")
        setupLabel()
        setupAnimationView()
    }
    
    private func setupLabel() {
        view.addSubview(self.label)
        
        self.label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.labelViewPadding.left).isActive = true
        self.label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.labelViewPadding.right).isActive = true
        self.label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.labelViewPadding.top).isActive = true
        
    }
    
    private func setupAnimationView() {
        view.addSubview(self.animationView)
        
        self.animationView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: Constants.animationViewPadding.top).isActive = true
        self.animationView.heightAnchor.constraint(equalToConstant: Constants.animationHeight).isActive = true
        self.animationView.widthAnchor.constraint(equalToConstant: Constants.animationWidth).isActive = true
        self.animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        self.animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

