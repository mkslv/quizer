//
//  QuestionViewController.swift
//  Quizzer
//
//  Created by Max Kiselyov on 10/14/23.
//

import UIKit

class QuestionViewController: UIViewController {
    // MARK: - Properties
    
    // MARK: 1
    
    private let answerOneButton = UIButton()
    private let answerTwoButton = UIButton()
    private let answerThreeButton = UIButton()
    private let answerFourButton = UIButton()
    
    private let singleContainer = UIStackView()
    
    // MARK: 2
    private let answerOneLabel = UILabel()
    private let answerTwoLabel = UILabel()
    private let answerThreeLabel = UILabel()
    private let answerFourLabel = UILabel()
    
    private let answerOneSwich = UISwitch()
    private let answerTwoSwich = UISwitch()
    private let answerThreeSwich = UISwitch()
    private let answerFourSwich = UISwitch()
    
    private let answerOneContainer = UIStackView()
    private let answerTwoContainer = UIStackView()
    private let answerThreeContainer = UIStackView()
    private let answerFourContainer = UIStackView()
    
    private let questionTwoButton = UIButton()
    
    private let multipleContainer = UIStackView()
    
    // MARK: 3
    private let rangedSlider = UISlider()
    private let questionMinThreeLabel = UILabel()
    private let questionMaxThreeLabel = UILabel()
    private let minMaxContainer = UIStackView()
    private let rangeContainer = UIStackView()
    private let questionThreeButton = UIButton()
    
    private var questionProgressView = UIProgressView()
    private let questionLabel = UILabel()

    private let questions = Question.getQuestions()
    private var questionIndex = 0
    private var answersChosen: [Answer] = []
    
    private var currentAnswers: [Answer] {
        questions[questionIndex].answers
    }
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Private methods
    @objc 
    func singleButtonPressed(_ sender: UIButton) {
        let tag = sender.tag
        let currentAnswer = currentAnswers[tag - 1]  // Assuming currentAnswers is zero-based
        answersChosen.append(currentAnswer)
        print(currentAnswer)
        nextQuestion()
    }
    
    @objc
    func multipleButtonPressed() {
        let multipleSwich = [answerOneSwich, answerTwoSwich, answerThreeSwich, answerFourSwich]
        for (multipleSwich, answer) in zip(multipleSwich, currentAnswers) {
            if multipleSwich.isOn {
                answersChosen.append(answer)
                print(answer)
            }
        }
        nextQuestion()
    }
    
    @objc
    func rangedButtonPressed() {
        let index = lrintf(rangedSlider.value - 1) // TODO: Learn more
        answersChosen.append(currentAnswers[index])
        print(currentAnswers[index])
        nextQuestion()
    }
    
}

// MARK: - Setting view
private extension QuestionViewController {
    func setupView() {
        addSubviews()
        view.backgroundColor = .white
        setupButtons()
        setupQuestionTitle()
        setupFirstContainer()
        setupSecondContainer()
        setupTitle()
        setupThirdContainer()
        updateUI()

        setupLayout()
    }
}

// MARK: - Settings
private extension QuestionViewController {
    func addSubviews() {
        [
            questionProgressView, questionLabel,
            
            answerOneButton, answerTwoButton, answerThreeButton, answerFourButton, singleContainer,
            
            answerOneLabel, answerTwoLabel, answerThreeLabel, answerFourLabel,
            answerOneSwich, answerTwoSwich, answerThreeSwich, answerFourSwich, questionTwoButton,
            answerOneContainer, answerTwoContainer, answerThreeContainer, answerFourContainer, multipleContainer,
            
            rangedSlider, questionMinThreeLabel, questionMaxThreeLabel, rangeContainer,
            minMaxContainer, questionThreeButton
        ].forEach { subView in
            view.addSubview(subView)
        }
    }
    
    func setupButtons() {
        answerOneButton.tag = 1
        answerTwoButton.tag = 2
        answerThreeButton.tag = 3
        answerFourButton.tag = 4

        answerOneButton.addTarget(self, action: #selector(singleButtonPressed), for: .touchUpInside)
        answerTwoButton.addTarget(self, action: #selector(singleButtonPressed), for: .touchUpInside)
        answerThreeButton.addTarget(self, action: #selector(singleButtonPressed), for: .touchUpInside)
        answerFourButton.addTarget(self, action: #selector(singleButtonPressed), for: .touchUpInside)

        questionTwoButton.addTarget(self, action: #selector(multipleButtonPressed), for: .touchUpInside)
        questionThreeButton.addTarget(self, action: #selector(rangedButtonPressed), for: .touchUpInside)
    }
    
    func setupTitle() {
        navigationItem.title = "Вопросы"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupQuestionTitle() {
        questionLabel.text = "LABEL"
        questionLabel.font = .systemFont(ofSize: 20)
        questionLabel.numberOfLines = 0
    }
    
    func setupFirstContainer() {
        singleContainer.axis = .vertical
        singleContainer.spacing = 16
        singleContainer.isHidden = true
        
        [answerOneButton, answerTwoButton, answerThreeButton, answerFourButton].forEach { view in
            singleContainer.addArrangedSubview(view)
        }
    }

    func setupSecondContainer() {
        multipleContainer.axis = .vertical
        multipleContainer.spacing = 16
        multipleContainer.isHidden = true
        
        createQuestionsTwoContainers()
        
        setupButton(for: questionTwoButton)
        
        [answerOneContainer, answerTwoContainer, answerThreeContainer, answerFourContainer, questionTwoButton].forEach { view in
            multipleContainer.addArrangedSubview(view)
        }
    }
    
    func createQuestionsTwoContainers() {
        [answerOneContainer, answerTwoContainer, answerThreeContainer, answerFourContainer].forEach { container in
            container.axis = .horizontal
            container.distribution = .fill
        }
        answerOneContainer.addArrangedSubview(answerOneLabel)
        answerOneContainer.addArrangedSubview(answerOneSwich)
        answerTwoContainer.addArrangedSubview(answerTwoLabel)
        answerTwoContainer.addArrangedSubview(answerTwoSwich)
        answerThreeContainer.addArrangedSubview(answerThreeLabel)
        answerThreeContainer.addArrangedSubview(answerThreeSwich)
        answerFourContainer .addArrangedSubview(answerFourLabel)
        answerFourContainer.addArrangedSubview(answerFourSwich)
    }
    
    func setupThirdContainer() {
        rangeContainer.axis = .vertical
        rangeContainer.spacing = 16
        rangeContainer.isHidden = true

        setupSlider()

        minMaxContainer.axis = .horizontal
        minMaxContainer.addArrangedSubview(questionMinThreeLabel)
        minMaxContainer.addArrangedSubview(questionMaxThreeLabel)
        
        setupButton(for: questionThreeButton)
        
        
        [rangedSlider, minMaxContainer, questionThreeButton].forEach { view in
            rangeContainer.addArrangedSubview(view)
        }
    }
    
    func setupSlider() {
        let answerCount = Float(currentAnswers.count)
        rangedSlider.maximumValue = answerCount
        rangedSlider.value = answerCount / 2
        
        // it shoud be in different method by SOLID
        questionMinThreeLabel.textAlignment = .left
        questionMaxThreeLabel.textAlignment = .right
    }
    
    func setupButton(for button: UIButton) {
        button.setTitle("Ответить", for: .normal)
        button.setTitleColor(.systemCyan, for: .normal)
        button.setTitleColor(.systemCyan.withAlphaComponent(0.6), for: .highlighted)
    }
}

// MARK: - Layout
private extension QuestionViewController {
    func setupLayout() {
        [
            questionProgressView, questionLabel,
            answerOneButton, answerTwoButton, answerThreeButton, answerFourButton, singleContainer,
            
            answerOneLabel, answerTwoLabel, answerThreeLabel, answerFourLabel,
            answerOneSwich, answerTwoSwich, answerThreeSwich, answerFourSwich, questionTwoButton,
            answerOneContainer, answerTwoContainer, answerThreeContainer, answerFourContainer, multipleContainer,
            
            rangedSlider, questionMinThreeLabel, questionMaxThreeLabel, minMaxContainer,
            rangeContainer, questionThreeButton
        ].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            questionProgressView.bottomAnchor.constraint(equalTo: questionLabel.topAnchor,constant: -10),
            questionProgressView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            questionProgressView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            questionLabel.bottomAnchor.constraint(equalTo: singleContainer.topAnchor, constant: -100),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -19),

            singleContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            singleContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 16),
            singleContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            singleContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            multipleContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            multipleContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 16),
            multipleContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            multipleContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                       
            rangeContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rangeContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 16),
            rangeContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            rangeContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
}


// MARK: - Navigation and busines logic
private extension QuestionViewController {
    func updateUI() {
        [multipleContainer, singleContainer, rangeContainer].forEach { stackView in
            stackView.isHidden = true
        }
        
        // Get current question
        let currentQuestion = questions[questionIndex]
        
        // Set current question to question label
        questionLabel.text = currentQuestion.title
        
        // Calculate progress
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        // Set progress to questionProgressView
        questionProgressView.setProgress(totalProgress, animated: true)
        
        title = "Вопрос № \(questionIndex + 1) из \(questions.count)"
        
        showCurrentAnswers(for: currentQuestion.type)
    }
    
    func showCurrentAnswers(for type: ResponseType) {
        switch type {
        case .single:
            showSingleContainer(with: currentAnswers)
        case .multiple:
            showMultipleContainer(with: currentAnswers)
        case .ranged:
            showRangedContainer(with: currentAnswers)
        }
    }
    
    func showSingleContainer(with answers: [Answer]) {
        singleContainer.isHidden = false
        
        let singleButtons = [answerOneButton, answerTwoButton, answerThreeButton, answerFourButton]
        
        for (button, answer) in zip(singleButtons, answers) {
            button.setTitle(answer.title, for: .normal)
            button.setTitleColor(.systemCyan, for: .normal)
            button.setTitleColor(.systemCyan.withAlphaComponent(0.6), for: .highlighted)
        }
    }
    
    func showMultipleContainer(with answers: [Answer]) {
        multipleContainer.isHidden = false
        
        let multipleLabels = [answerOneLabel, answerTwoLabel, answerThreeLabel, answerFourLabel]
        
        for (label, answer) in zip(multipleLabels, answers) {
            label.text = answer.title
        }
    }
    
    func showRangedContainer(with answers: [Answer]) {
        rangeContainer.isHidden = false
        
        questionMinThreeLabel.text = answers.first?.title
        questionMaxThreeLabel.text = answers.last?.title
    }
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
            return
        }
        let resultViewController = ResultViewController(answersChosen: answersChosen)
        navigationController?.pushViewController(resultViewController, animated: true)
    }
}
