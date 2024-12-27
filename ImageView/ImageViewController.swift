//
//  ImageViewController.swift
//  LoginImages
//
//  Created by Ariadna Cecilia López Colín on 27/12/24.
//

import UIKit

class ImageViewController: UIViewController {

    private var imageView: UIImageView!
    private var getImageButton: UIButton!
    private var logoutButton: UIButton!
    private var currentImageURL: String?
    typealias ConstantSize = ImageConstants.sizes
    typealias ConstantString = ImageConstants.strings

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)

        getImageButton = UIButton(type: .system)
        getImageButton.setTitle(ConstantString.getImageButtonTitle, for: .normal)
        getImageButton.translatesAutoresizingMaskIntoConstraints = false
        getImageButton.addTarget(self, action: #selector(getNewImage), for: .touchUpInside)
        view.addSubview(getImageButton)

        logoutButton = UIButton(type: .system)
        logoutButton.setTitle(ConstantString.logoutButtonTitle, for: .normal)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        view.addSubview(logoutButton)

        setupLayout()

        loadDogImage()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: ConstantSize.imageViewTop),
            imageView.widthAnchor.constraint(equalToConstant: ConstantSize.imageViewWidth),
            imageView.heightAnchor.constraint(equalToConstant: ConstantSize.imageViewHeight)
        ])
        
        NSLayoutConstraint.activate([
            getImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getImageButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.topAnchor.constraint(equalTo: getImageButton.bottomAnchor, constant: ConstantSize.logoutButtonTop)
        ])
    }
    
    @objc private func getNewImage() {
        loadDogImage()
    }

    private func loadDogImage() {
        let url = URL(string: "https://dog.ceo/api/breeds/image/random")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error getting image: \(error)")
                return
            }
            
            if let data = data {
                do {
                    let jsonResponse = try JSONDecoder().decode(ImageModel.self, from: data)
                    self.currentImageURL = jsonResponse.message
                    
                    DispatchQueue.main.async {
                        if let imageURL = self.currentImageURL, let url = URL(string: imageURL) {
                            self.loadImage(from: url)
                        }
                    }
                } catch {
                    print("Error parsing API response: \(error)")
                }
            }
        }
        task.resume()
    }

    private func loadImage(from url: URL) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error loading image: \(error)")
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
        task.resume()
    }

    @objc private func logout() {
        UserDefaults.standard.removeObject(forKey: "userToken")
        
        if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate {
            sceneDelegate.checkSession()
        }
    }
}

