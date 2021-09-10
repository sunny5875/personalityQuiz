//
//  ResultViewController.swift
//  PersonalityQuiz
//
//  Created by 현수빈 on 2021/03/27.
//

import UIKit

class ResultViewController: UIViewController {

    var response:[Answer]=[]
    
    @IBOutlet weak var resultAnswerLabel: UILabel!
    @IBOutlet weak var resultDefinitionLabel:
        UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton=true
        calculatePersonalityResult()
        // Do any additional setup after loading the view.
    }
    
    
    func calculatePersonalityResult(){
        
        var frequencyOfAnser : [AnimalType : Int] = [:]
        let responseTypes = response.map{$0.type}
        
        print(responseTypes)
        
        for response_ in responseTypes{
            //frequencyOfAnser에 값이 없으면 0을 집어넣고 1을 더한다
           frequencyOfAnser[response_] = (frequencyOfAnser[response_] ?? 0) + 1
        }
       
        //제일 많은게 앞에 오도록 정렬
        let  frequencyOfAnswerSorted = frequencyOfAnser.sorted(by:
                                                                    {(pair1,pair2) -> Bool in
                                                                        return pair1.value > pair2.value})
        let mostCommonAnswer = frequencyOfAnswerSorted.first!.key
        
        //라벨 설정
        resultAnswerLabel.text="Your are a \(mostCommonAnswer.rawValue)!"
        
        resultDefinitionLabel.text = mostCommonAnswer.definition
        
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
