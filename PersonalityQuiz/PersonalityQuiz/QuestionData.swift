//
//  QuestionData.swift
//  PersonalityQuiz
//
//  Created by 현수빈 on 2021/03/27.
//

import Foundation


struct Question{
    var text: String //질문
    var type : ResponseType //어떤 형식으로 물을 껀지
    var answers: [Answer] //답, 각 답에 해당되는 동물 표시
    
}

//질문 형식
enum ResponseType{
    case single, multiple,ranged
}


struct Answer{
    var text: String
    var type: AnimalType
    
}


enum AnimalType : Character {
    case dog="🐶", cat="🐱", rabbit="🐰", turtle="🐢"
    
    var definition : String{
        
        switch self{
        case .dog:
            return "You are incredbly outgoing. You surround yourself with the people you love, and enjoy activcities with your friends"
        case .cat:
            return "Mischievous, yet mild-tempered, you enjoy doing things on your own terms"
        case .rabbit:
            return "You love everything that's soft. YOu are healthy and full of energy"
        case .turtle:
            return "You are wise beyond your years, and you focus on the details. Slow and steady wins the race"
        
        }
    }
}

