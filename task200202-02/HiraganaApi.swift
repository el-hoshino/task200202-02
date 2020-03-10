//
//  HiraganaApi.swift
//  task200202-02
//
//  Created by 酒井 桂哉 on 2020/02/29.
//  Copyright © 2020 tokizo. All rights reserved.
//

import Foundation

class HiraganaAPI {
    private let appID = accessToken
    private let requestID = "record003"
    private let postMethod = "POST"
    
    func convert(convertText: String, completion:@escaping (Result<String, Error>) -> Void) {
        let url = URL(string: "https://labs.goo.ne.jp/api/hiragana")!
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
    
    private func apiTask(with request: URLRequest, from uploadData: Data, completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionTask {
        
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(APIError.network))
                return
            }
            
            guard (200 ..< 300).contains(response.statusCode) else {
                completion(.failure(APIError.server(response.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.unknown("jsonの変換エラー")))
                return
            }
            
            completion(.success(data))
            
        }
        
        return task
        
    }
    
    private func getRubiString(from result: Result<Data, Error>) throws -> String {
        
        guard let jsonData = self.decodeToRubi(data: try result.get()) else {
            throw APIError.unknown("jsonの変換エラー")
        }
        
        debugPrint("(after) converted text: ", jsonData.converted)
        return jsonData.converted
        
    }
    
    private func request(method: String, url: URL, postData:PostData, completion: @escaping(Result<String, Error>) -> Void) {
        // URLRequstの設定
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // URLRequestに持たせるためのPOSTするデータを変換
        guard let uploadData = encodeToJson(postData: postData) else {
            completion(.failure(APIError.unknown("jsonの生成エラー")))
            return
        }
        
        request.httpBody = uploadData
        
        //APIへPOSTしてresponseを受け取る
        let task = apiTask(with: request, from: uploadData) { [self] (result) in
            do {
                let rubiString = try self.getRubiString(from: result)
                completion(.success(rubiString))
                
            } catch let error {
                completion(.failure(error))
            }
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
