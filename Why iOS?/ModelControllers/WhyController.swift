//
//  WhyController.swift
//  Why iOS?
//
//  Created by shelby gold on 3/20/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import Foundation

class WhyController {
    
    //shared instance
    static let shared = WhyController()
    private init(){}
    
    //source of truth
    var why: [Why] = []
    
    static let baseURL = URL(string: "https://whydidyouchooseios.firebaseio.com/reasons")
    
    //crud
    static func getWhy(completion: @escaping (Bool) -> Void){
        
        //URL
        guard let url = baseURL?.appendingPathExtension("json") else { completion(false); return}
        print(url.absoluteString)
        
        //Request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        
        //datatask
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error{
                print("💩🧜🏻‍♂️ 🧜🏻‍♂️error in \(#function) ; \(error) ; \(error.localizedDescription)")
                completion(false)
                return
            }
            guard let data = data else{
                print("there was not data")
                completion(false); return}
            guard let jsonDict = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String:[String:Any]] else {
                print("Jason data was not converted into our format")
                completion(false)
                return
            }
            var why: [Why] = []
            for dict in jsonDict {
                if let newWhy = Why(dict: dict.value){
                    why.append(newWhy)
                }
            }
            WhyController.shared.why = why
            completion(true)
        }
        dataTask.resume()
        
    }
    static func postWhy(name: String, cohort: String, reason: String,completion: @escaping (Bool) -> Void){
        
        //URL
        guard let fullURL = baseURL?.appendingPathExtension("json") else {
            completion(false); return }
        
        
        print(fullURL.absoluteString)
        
        
        //URL request
        let newWhy = Why(name: name, cohort: cohort, reason: reason)
        var request = URLRequest(url: fullURL)
        request.httpBody = newWhy.asData
        request.httpMethod = "POST"
        //1)DataTask +Resume
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("💩🧜🏻‍♂️ 🧜🏻‍♂️error in \(#function) ; \(error) ; \(error.localizedDescription)")
                completion(false)
                return }
            guard data != nil else {
                print("no data was recovered")
                completion(false)
                return
            }
            print("success Why was posted to firebase")
            WhyController.shared.why.append(newWhy)
            completion(true)
        }
        dataTask.resume()
    }
    
}
