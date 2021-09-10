//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by 현수빈 on 2021/03/27.
//

import UIKit

class QuestionViewController: UIViewController {
    
    //질문배열
    var questions: [Question] = [Question(text: "Which food do you live the most?", type: .single, answers: [Answer(text: "Steak", type: .dog),
                Answer(text: "Fish", type: .cat),
                Answer(text: "Carrot", type: .rabbit),
                Answer(text: "Corn", type: .turtle)
    ]),
    Question(text: "Which activities do you enjoy?", type: .multiple, answers:
                [Answer(text: "Swimming", type: .turtle),
                Answer(text: "Sleeping", type: .cat),
                Answer(text: "Cuddling", type: .rabbit),
                Answer(text: "Eating", type: .dog)
    ]),
    Question(text: "How much do you enjoy car rides?", type: .ranged, answers:
                [Answer(text: "I dislike them", type: .cat),
                Answer(text: "I get a little nervous", type: .rabbit),
                Answer(text: "I barely notice them", type: .turtle),
                Answer(text: "I love them", type: .dog)
    ])]
    
    //지금 몇번째 질문인지
    var questionIndex = 0
    //답 고른 것
    var answersChosen: [Answer] = []
    
    
    
    
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    
    @IBOutlet var singleButtons: [UIButton]!
    
    

    @IBOutlet weak var multipleStackView: UIStackView!
    
    @IBOutlet var multiLabels: [UILabel]!
    @IBOutlet var multiSwitches: [UISwitch]!
    
    
    @IBOutlet weak var rangeStackView: UIStackView!
    
    @IBOutlet var rangedLabels: [UILabel]!
    
    @IBOutlet weak var rangedSlider: UISlider!
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
      
    }
    
    
    func updateUI(){
        //일단은 다끄기
        singleStackView.isHidden=true
        multipleStackView.isHidden=true
        rangeStackView.isHidden=true
         
        //질문과 답 가져오기, 프로그레스바 표시하기
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        
        navigationItem.title="Question #\(questionIndex+1)"
        questionLabel.text=currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        
//        print(currentQuestion.type)
  
        //각 질문 유형에 맞게 ui 구성
        switch currentQuestion.type{

        case .single:
                updateSingleStack(using: currentAnswers)
        
        case .multiple:
                updateMultipleStack(using: currentAnswers)
                
        case .ranged:
                updateRangedStack(using: currentAnswers)
        }
        
    }
    
    
    func updateSingleStack(using answers:[Answer]){
        singleStackView.isHidden=false
        for i in 0...3{
            singleButtons[i].setTitle(answers[i].text, for: .normal)
        }
    }
    
    func updateMultipleStack(using answers:[Answer]){
        multipleStackView.isHidden=false
        
        for i in 0...3{
            multiSwitches[i].isOn = false
            multiLabels[i].text = answers[i].text
        }
    }
    
    func updateRangedStack(using answers:[Answer]){
        rangeStackView.isHidden=false
        rangedSlider.setValue(0.5, animated: false)
        rangedLabels[0].text = answers.first?.text
        rangedLabels[1].text=answers.last?.text

    }
    

    
    @IBAction func singleAnswerButtonPresssed(_ sender: UIButton) {
        
        let currentAnswer = questions[questionIndex].answers
        
        switch sender {
        
        case singleButtons[0]:
            answersChosen.append(currentAnswer[0])
            
        case singleButtons[1]:
            answersChosen.append(currentAnswer[1])
                
        case singleButtons[2]:
            answersChosen.append(currentAnswer[2])
                    
        case singleButtons[3]:
            answersChosen.append(currentAnswer[3])
        default:
            break
        }
        
        nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonPressed(_ sender: Any) {
        let currentAnswers = questions[questionIndex].answers
        if multiSwitches[0].isOn{
            answersChosen.append(currentAnswers[0])
        }
        if multiSwitches[1].isOn{
            answersChosen.append(currentAnswers[1])
        }
        if multiSwitches[2].isOn{
            answersChosen.append(currentAnswers[2])
        }
        if multiSwitches[3].isOn{
            answersChosen.append(currentAnswers[3])
        }
        
        nextQuestion()
    }
    
    
    @IBAction func rangedAnswerButtonPressed(_ sender: Any) {
        
        let currentAnswers = questions[questionIndex].answers
        let index = Int(round(rangedSlider.value*Float(currentAnswers.count - 1)))
        
        answersChosen.append(currentAnswers[index])
        
        nextQuestion()
    }
    
    func nextQuestion(){
        //다음 질문 보이게 하기
            questionIndex += 1
        //질문이 남아있으면 update하고 아니면 generic segue로 넘긴다
        if questionIndex < questions.count{
            updateUI()
        }
        else{
            performSegue(withIdentifier: "ResultSegue", sender: nil)
        }
        }
    
    
    
    // MARK: - Navigation

     //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultSegue"{
            let resultViewController = segue.destination as! ResultViewController
            resultViewController.response = answersChosen
        }
    }
    

}
