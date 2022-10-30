import Foundation
import CryptoKit


var publickey = "3c632b08ec945c4e8a9a07e6be4bcd20"
var privatekey = "804b5c74954f96b6fef1e73b63f814ea3c00ec1e"
var timeStamp = String(describing: Date().currentTimeInMillis())
var hashValue = timeStamp + privatekey + publickey
var hashMarvel = MD5(string: hashValue)

func MD5(string: String) -> String {
    let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())
    return digest.map {
        String(format: "%02hhx", $0)
    }.joined()
}

func marvelURL() -> URL? {
    var marvelComponents = URLComponents()
    marvelComponents.scheme = "https"
    marvelComponents.host = "gateway.marvel.com"
    marvelComponents.port = 443
    marvelComponents.path = "/v1/public/characters"
    marvelComponents.queryItems = [URLQueryItem(name: "id", value: "1011334"),
                                   URLQueryItem(name: "ts", value: timeStamp),
                                   URLQueryItem(name: "apikey", value: publickey),
                                   URLQueryItem(name: "hash", value: hashMarvel)]
    return marvelComponents.url
}

func getData(urlRequest: URL?) {
    guard let url = urlRequest else { return }
    URLSession.shared.dataTask(with: url) { data, response, error in
        if error != nil {
            print("Error - \(String(describing: (error?.localizedDescription) ?? ""))")
        }
        if let response = response as? HTTPURLResponse, response.statusCode == 200 {
            print("response - \(String(describing: response.statusCode))")
        }
        guard let data = data else { return }
        let dataAsString = String(data: data, encoding: .utf8)
        print("data - \(String(describing: (String(data: data, encoding: .utf8) ?? "")))")
    }.resume()
}


getData(urlRequest: marvelURL())
