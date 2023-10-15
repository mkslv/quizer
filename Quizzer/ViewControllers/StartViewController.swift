//
//  ViewController.swift
//  Quizzer
//
//  Created by Max Kiselyov on 10/14/23.
//

import UIKit

final class StartViewController: UIViewController {
    // MARK: - Private properties
    private let firstAnimalLabel = UILabel()
    private let secondAnimalLabel = UILabel()
    private let thirdAnimalLabel = UILabel()
    private let fourthAnimalLabel = UILabel()

    private let welcomeLabel = UILabel()
    private let beginButton = UIButton()
    
    private let centreContainer = UIStackView()

    // MARK: - Override methods and actions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: - Private methods
    @objc
    func startButtonTapped() {
        let questionViewController = QuestionViewController()
        navigationController?.pushViewController(questionViewController, animated: true)
    }
}


// MARK: - Setting view
private extension StartViewController {
    func setupView() {
        addSubviews()
        view.backgroundColor = .white
        
        setupContainer()
        setupLabels()
        setupButton()
        
        setupLayout()
    }
}

// MARK: - Settings
private extension StartViewController {
    func addSubviews() {
        [firstAnimalLabel, secondAnimalLabel, thirdAnimalLabel, fourthAnimalLabel,
         centreContainer, welcomeLabel, beginButton].forEach { subview in
            view.addSubview(subview)
        }
    }
    
    func setupContainer() {
        centreContainer.axis = .vertical
        centreContainer.spacing = 20
        centreContainer.alignment = .fill //не уверен нужно ли это тут?
        
        centreContainer.addArrangedSubview(welcomeLabel)
        centreContainer.addArrangedSubview(beginButton)
        
    }
    
    func setupLabels() {
        firstAnimalLabel.text = "🐶"
        secondAnimalLabel.text = "🐰"
        thirdAnimalLabel.text = "🐱"
        fourthAnimalLabel.text = "🐢"
        
        welcomeLabel.text = "Какое вы животное?"
        
        [firstAnimalLabel, secondAnimalLabel,
         thirdAnimalLabel, fourthAnimalLabel].forEach { label in
            label.font = UIFont.systemFont(ofSize: 40)
        }
        welcomeLabel.font = .boldSystemFont(ofSize: 28)
        welcomeLabel.textAlignment = .center //не уверен нужно ли это тут?
        
    }
    
    func setupButton() {
        beginButton.setTitle("Начать опрос", for: .normal)
        beginButton.setTitleColor(.systemCyan, for: .normal)
        beginButton.setTitleColor(.systemCyan.withAlphaComponent(0.6), for: .highlighted)
        beginButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
}

// MARK: - Layout
private extension StartViewController {
    func setupLayout() {
        [
            firstAnimalLabel, secondAnimalLabel, thirdAnimalLabel, fourthAnimalLabel,
            centreContainer, welcomeLabel, beginButton
        ].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            firstAnimalLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstAnimalLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            
            thirdAnimalLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            thirdAnimalLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            
            centreContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centreContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            centreContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            centreContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            secondAnimalLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            secondAnimalLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
                        
            fourthAnimalLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            fourthAnimalLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
}
