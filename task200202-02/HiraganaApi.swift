//
//  HiraganaApi.swift
//  task200202-02
//
//  Created by 酒井 桂哉 on 2020/02/29.
//  Copyright © 2020 tokizo. All rights reserved.
//

import Foundation

class HiraganaAPI {
    private let host = "https://labs.goo.ne.jp/api"
    private let appID = ProcessInfo.processInfo.environment["GOO_API_KEY"] ?? nil
    private let requestID = "record003"
    private let postMethod = "POST"
    
    func convert(convertText: String, completion:((String?) -> Void)?) {
        
        // appIDが環境変数に入っていない場合
        if appID == nil {
            debugPrint("appID is empty. Please set environment variable GOO_API_KEY")
            completion?(nil)
            return
        }
        
        let url = "https://labs.goo.ne.jp/api/hiragana"
        let outputType = "hiragana"
        let postData = PostData(app_id: self.appID!, request_id: requestID, sentence: convertText, output_type: outputType)
        
        debugPrint("(before) convert text: ", convertText)
        self.request(method: "POST", url: url, postData: postData, completion: completion)
    }
    
    private func request(method: String, url: String, postData:PostData,  completion:((String?) -> Void)?) {
        guard let _url = URL(string: url) else { return }
        // URLRequstの設定
        var request = URLRequest(url: _url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //POSTするデータをURLRequestに持たせる
        guard let uploadData = try? JSONEncoder().encode(postData) else {
            debugPrint("json生成に失敗しました")
            return
        }
        request.httpBody = uploadData
        
        //APIへPOSTしてresponseを受け取る
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
            if let error = error {
                debugPrint ("error: \(error)")
                completion?(nil)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                debugPrint("server error")
                completion?(nil)
                return
            }
            
            if !((200...299).contains(response.statusCode)) {
                let errorMessage: String = HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
                debugPrint("\(response.statusCode): \(errorMessage)")
                completion?(nil)
                return
            }
            
            guard response.statusCode == 200 else {
                debugPrint("サーバエラー ステータスコード: \(response.statusCode)\n")
                completion?(nil)
                return
            }
            
            guard let data = data, let jsonData = try? JSONDecoder().decode(Rubi.self, from: data) else {
                debugPrint("json変換に失敗しました")
                completion?(nil)
                return
            }
            debugPrint("(after) converted text: ", jsonData.converted)
            completion?(jsonData.converted)
            
        }
        task.resume()
    }
}


struct Rubi:Codable {
    var request_id: String
    var output_type: String
    var converted: String
}
struct PostData: Codable {
    var app_id:String
    var request_id: String
    var sentence: String
    var output_type: String
}
