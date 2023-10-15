//
//  FinalViewController.swift
//  Quizzer
//
//  Created by Max Kiselyov on 10/14/23.
//

import UIKit

final class ResultViewController: UIViewController {
    // MARK: - Private properties
    private let resultLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let closeButton = UIBarButtonItem()
    private let resultContainer = UIStackView()
    
    let answersChosen: [Answer]
    
    init(answersChosen: [Answer]) {
        self.answersChosen = answersChosen
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        self.answersChosen = []
        super.init(coder: coder)
    }
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        navigationItem.hidesBackButton = true
    }
    
    // MARK: - Methods
    @objc
    func backButtonTapped() {
        if let navigationController = self.navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}


// MARK: - Setting view
private extension ResultViewController {
    func setupView() {
        addSubviews()
        view.backgroundColor = .white
        setupResultLable()
        setupDescriptionLable()
        setupTextLabels()
        setupContainer()
        setupTitle()
        setupCloseButton()
        
        setupLayout()
    }
}

// MARK: - Settings
private extension ResultViewController {
    func addSubviews() {
        view.addSubview(resultLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(resultContainer)
    }
    
    func setupTitle() {
        navigationItem.title = "Результаты"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupResultLable() {
        resultLabel.textAlignment = .center
        resultLabel.font = .boldSystemFont(ofSize: 30)
    }
    
    func setupDescriptionLable() {
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .systemFont(ofSize: 20)
    }
    
    func setupTextLabels() {
        let results = findTheResults(answers: answersChosen)
        resultLabel.text = "Вы - \(results.0)"
        descriptionLabel.text = "\(results.1)"
    }
    
    func setupContainer() {
        resultContainer.axis = .vertical
        resultContainer.spacing = 15
        resultContainer.alignment = .fill
        
        resultContainer.addArrangedSubview(resultLabel)
        resultContainer.addArrangedSubview(descriptionLabel)
    }
    
    func setupCloseButton() {
        let closeButton = UIBarButtonItem(title: "Завершить", style: .plain, target: self, action: #selector(backButtonTapped))
//        closeButton.title = "Done"
//        closeButton.style = .plain
//        closeButton.target = self
//        closeButton.action = #selector(closeButtonTapped)
        navigationItem.rightBarButtonItem = closeButton
    }
}

// MARK: - Layout
private extension ResultViewController {
    func setupLayout() {
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        resultContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            resultContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 15),
            resultContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
}

// MARK: - Logic
private extension ResultViewController {
    func findTheResults(answers: [Answer]) -> (Character, String) {
        var animalCounts: [Animal: Int] = [:]
           
        for answer in answers {
        let animal = answer.animal
            animalCounts[animal, default: 0] += 1
        }
           
        var mostPopularAnimal: Animal?
        var maxCount = 0
        
        for (animal, count) in animalCounts {
            if count > maxCount {
                mostPopularAnimal = animal
                maxCount = count
            }
        }
           
        if let mostPopularAnimal = mostPopularAnimal {
            let emoji = mostPopularAnimal.rawValue
            let definition = mostPopularAnimal.definition
            return (emoji, definition)
        }
        return ("💩","Произошла ошибка, повторите позже!")
    }
}
