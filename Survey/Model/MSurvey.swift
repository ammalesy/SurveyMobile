//
//  Survey.swift
//  Survey
//
//  Created by AmmalesPSC91 on 9/12/2558 BE.
//  Copyright (c) 2558 dev.com. All rights reserved.
//

import UIKit
import Alamofire

class MSurvey: Model,NSCoding,NSCopying {
    var pSm_id:NSString!
    var pSm_name:NSString!
    var pSm_description:NSString!
    var pSm_table_code:NSString!
    var pSm_order_column:NSString!
    var pSm_update_at:NSString!
    var pCountUser:NSInteger!
    
    //associate
    var pQuestions:NSMutableArray!
    
    override init() {}

    func copyWithZone(zone: NSZone) -> AnyObject {
        let obj:MSurvey = MSurvey()
        obj.pSm_id = self.pSm_id
        obj.pSm_name = self.pSm_name
        obj.pSm_description = self.pSm_description
        obj.pSm_table_code = self.pSm_table_code
        obj.pSm_order_column = self.pSm_order_column
        obj.pSm_update_at = self.pSm_update_at
        obj.pCountUser = self.pCountUser
        obj.pQuestions = self.pQuestions
        return obj
    }
    
    required init(coder aDecoder: NSCoder) {
        self.pSm_id  = aDecoder.decodeObjectForKey("pSm_id") as? NSString
        self.pSm_name  = aDecoder.decodeObjectForKey("pSm_name") as? NSString
        self.pSm_description  = aDecoder.decodeObjectForKey("pSm_description") as? NSString
        self.pSm_table_code  = aDecoder.decodeObjectForKey("pSm_table_code") as? NSString
        self.pSm_order_column  = aDecoder.decodeObjectForKey("pSm_order_column") as? NSString
        self.pSm_update_at  = aDecoder.decodeObjectForKey("pSm_update_at") as? NSString
        self.pCountUser  = aDecoder.decodeObjectForKey("pCountUser") as? NSInteger
        self.pQuestions  = aDecoder.decodeObjectForKey("pQuestions") as? NSMutableArray
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        if let val = self.pSm_id{
            aCoder.encodeObject(val, forKey: "pSm_id")
        }
        if let val = self.pSm_name{
            aCoder.encodeObject(val, forKey: "pSm_name")
        }
        if let val = self.pSm_description{
            aCoder.encodeObject(val, forKey: "pSm_description")
        }
        if let val = self.pSm_table_code{
            aCoder.encodeObject(val, forKey: "pSm_table_code")
        }
        if let val = self.pSm_order_column{
            aCoder.encodeObject(val, forKey: "pSm_order_column")
        }
        if let val = self.pSm_update_at{
            aCoder.encodeObject(val, forKey: "pSm_update_at")
        }
        if let val = self.pCountUser{
            aCoder.encodeObject(val, forKey: "pCountUser")
        }
        if let val = self.pQuestions{
            aCoder.encodeObject(val, forKey: "pQuestions")
        }
    }
    
    class func get_surveys(completionHandler: (NSMutableArray) -> Void, failure: (NSString!) -> Void){
        
        if(!Reachability.isConnectedToNetwork()){
            
            failure("Please open the internet.")
            
        }else{
            
            Alamofire.request(.GET,
                "\(Model.basePath.url)/SurveyManagement/surveys",
                parameters: nil,
                encoding:ParameterEncoding.JSON)
                .responseString { _, _, string, _ in
                    
                }
                .responseJSON { _, response, JSON, error in
                    if(response?.statusCode == 200){
                        var json:NSMutableArray = JSON as! NSMutableArray
                        
                        var list:NSMutableArray = NSMutableArray()
                        for(var indexMain = 0; indexMain < json.count; indexMain++){
                            
                            var survey:MSurvey = MSurvey()
                            survey.pSm_id = survey.handleNullString(json[indexMain].objectForKey("sm_id")!)
                            survey.pSm_name = survey.handleNullString(json[indexMain].objectForKey("sm_name")!)
                            survey.pSm_description = survey.handleNullString(json[indexMain].objectForKey("sm_description")!)
                            survey.pSm_table_code = survey.handleNullString(json[indexMain].objectForKey("sm_table_code")!)
                            survey.pSm_order_column = survey.handleNullString(json[indexMain].objectForKey("sm_order_column")!)
                            survey.pSm_update_at = survey.handleNullString(json[indexMain].objectForKey("sm_update_at")!)
                            survey.pCountUser = 0
                            
                            /*======================*/
                            /*======questions=======*/
                            /*======================*/
                            var questions:NSMutableArray = survey.handleNullArray(json[indexMain].objectForKey("questions")!)
                            var listQuestion:NSMutableArray = NSMutableArray()
                            for(var indexQuestion = 0; indexQuestion < questions.count; indexQuestion++){
                                var m_question:MQuestion = MQuestion()
                                m_question.pAq_id = survey.handleNullString(questions[indexQuestion].objectForKey("aq_id")!)
                                m_question.pAq_description = survey.handleNullString(questions[indexQuestion].objectForKey("aq_description")!)
                                m_question.pActive = survey.handleNullString(questions[indexQuestion].objectForKey("active")!)
                                
                                /*======================*/
                                /*======answers=========*/
                                /*======================*/
                                var answers:NSMutableArray = survey.handleNullArray(questions[indexQuestion].objectForKey("answers")!)
                                var listAnswer:NSMutableArray = NSMutableArray()
                                for(var indexAns = 0; indexAns < answers.count; indexAns++){
                                    var m_answer:MAnswer = MAnswer()
                                    m_answer.pAa_id = survey.handleNullString(answers[indexAns].objectForKey("aa_id")!)
                                    m_answer.pAa_description = survey.handleNullString(answers[indexAns].objectForKey("aa_description")!)
                                    m_answer.pAa_image = survey.handleNullString(answers[indexAns].objectForKey("aa_image")!)
                                    m_answer.pAq_id_ref = survey.handleNullString(answers[indexAns].objectForKey("aq_id_ref")!)
                                    m_answer.pType = survey.handleNullString(answers[indexAns].objectForKey("type")!)
                                    m_answer.pActive = survey.handleNullString(answers[indexAns].objectForKey("active")!)
                                    m_answer.pChecked = false
                                    
                                    listAnswer.addObject(m_answer)
                                }
                                m_question.pAnswers = listAnswer
                                
                                listQuestion.addObject(m_question)
                            }
                            survey.pQuestions = listQuestion
                            list.addObject(survey)
                        }
                        completionHandler(list)
                    }else{
                        failure(error?.localizedDescription)
                    }
            }
        }
        
    }
    
}
