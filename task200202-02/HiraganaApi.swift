//
//  HiraganaApi.swift
//  task200202-02
//
//  Created by 酒井 桂哉 on 2020/02/29.
//  Copyright © 2020 tokizo. All rights reserved.
//

import Foundation

func isInClosedInterval(start: Int, end: Int, value: Int) -> Bool {
    return (start...end).contains(value)
}

class HiraganaAPI {
    private let host = "https://labs.goo.ne.jp/api"
    private let appID = AccessToken
    private let requestID = "record003"
    private let postMethod = "POST"
    
    func convert(convertText: String, completion:@escaping (Result<String, Error>) -> Void) {
        let url = "https://labs.goo.ne.jp/api/hiragana"
        let outputType = "hiragana"
        let postData = PostData(app_id: self.appID, request_id: requestID, sentence: convertText, output_type: outputType)
        
        debugPrint("(before) convert text: ", convertText)
        self.request(method: "POST", url: url, postData: postData, completion: completion)
    }
    
    private func encodeToJson(postData: PostData) -> Foundation.Data? {
        guard let convertedData = try? JSONEncoder().encode(postData) else {
            return nil
        }
        return convertedData
    }
    
    private func decodeToRubi (data: Data) -> Rubi? {
        guard let convertedData = try? JSONDecoder().decode(Rubi.self, from: data) else {
            return nil
        }
        return convertedData
    }
    
    private func request(method: String, url: String, postData:PostData, completion: @escaping(Result<String, Error>) -> Void) {
        guard let _url = URL(string: url) else { return }
        // URLRequstの設定
        var request = URLRequest(url: _url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // URLRequestに持たせるためのPOSTするデータを変換
        guard let uploadData = encodeToJson(postData: postData) else {
            completion(.failure(APIError.unknown("jsonの生成エラー")))
            return
        }
        
        request.httpBody = uploadData
        
        //APIへPOSTしてresponseを受け取る
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(APIError.network))
                return
            }
            
            if(!isInClosedInterval(start: 200, end: 299, value: response.statusCode)) {
                completion(.failure(APIError.server(response.statusCode)))
                return
            }
            
            guard let data = data, let jsonData = self.decodeToRubi(data: data) else {
                completion(.failure(APIError.unknown("jsonの変換エラー")))
                return
            }
            
            debugPrint("(after) converted text: ", jsonData.converted)
            completion(.success(jsonData.converted))
            
        }
        task.resume()
    }
}

enum APIError: Error {
    case network
    case server(Int)
    case unknown(String)
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
