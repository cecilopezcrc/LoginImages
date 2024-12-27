//
//  ImageViewModel.swift
//  LoginImages
//
//  Created by Ariadna Cecilia López Colín on 27/12/24.
//

import UIKit

class ImageViewModel {
    
    func fetchDogImage(completion: @escaping (UIImage?) -> Void) {
        let url = URL(string: "https://dog.ceo/api/breeds/image/random")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching image: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let response = try JSONDecoder().decode(ImageModel.self, from: data)
                guard let imageUrl = URL(string: response.message) else {
                    completion(nil)
                    return
                }
                
                let imageData = try Data(contentsOf: imageUrl)
                let image = UIImage(data: imageData)
                completion(image)
                
            } catch {
                completion(nil)
            }
        }.resume()
    }
}
