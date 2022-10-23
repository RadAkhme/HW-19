import Foundation


let session = URLSession(configuration: .default)
let breakingBadURL = "https://www.breakingbadapi.com/api/characters?name=Walter+White"
let passwordinatorURL = "https://passwordinator.herokuapp.com?num=true&char=true&caps=true&len=18"
let errorURL = "https://www.breakingbadapipi/chaacters?name=Wal"

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

getData(urlRequest: errorURL)
