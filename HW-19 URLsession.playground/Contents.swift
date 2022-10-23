import Foundation
import CryptoKit


var publickey = "3c632b08ec945c4e8a9a07e6be4bcd20"
var privatekey = "804b5c74954f96b6fef1e73b63f814ea3c00ec1e"
let ts = Date().currentTimeInMillis()
var stringToHash = String(describing: ts) + privatekey + publickey

func MD5(string: String) -> String {
    let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())

    return digest.map {
        String(format: "%02hhx", $0)
    }.joined()
}

extension Date {
    func currentTimeInMillis() -> Int64 {
        return Int64(timeIntervalSince1970 * 1000)
    }
}

let session = URLSession(configuration: .default)
let breakingBadURL = "https://www.breakingbadapi.com/api/characters?name=Walter+White"
let passwordinatorURL = "https://passwordinator.herokuapp.com?num=true&char=true&caps=true&len=18"
let errorURL = "https://www.breakingbadapipi/chaacters?name=Wal"
let marvelAPI = "https://gateway.marvel.com:443/v1/public/characters?&ts=\(ts)&apikey=3c632b08ec945c4e8a9a07e6be4bcd20&hash=\(MD5(string: stringToHash))"


func getData(urlRequest: String) {
    let urlRequest = URL(string: urlRequest)
    guard let url = urlRequest else { return }
    session.dataTask(with: url) { data, response, error in
        if error != nil {
            print("Error - \(String(describing: (error?.localizedDescription) ?? ""))")
        } else if let response = response as? HTTPURLResponse, response.statusCode == 200 {
            print("response - \(String(describing: response.statusCode))")
            guard let data = data else { return }
            let dataAsString = String(data: data, encoding: .utf8)
            print("data - \(String(describing: (String(data: data, encoding: .utf8) ?? "")))")
        }
    }.resume()
}


//getData(urlRequest: passwordinatorURL)

//getData(urlRequest: breakingBadURL)

getData(urlRequest: marvelAPI)

//getData(urlRequest: errorURL)



