//
//  ImageService.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 20/03/2023.
//

import UIKit
import PromiseKit

protocol ImageServiceProtocol {
	func getImageFor(country: String, contest: String) -> Promise<UIImage>
}

enum ImageServiceError: Error {
	case cannotConnectToDatabase
	case badURL
	case dataMissing
	case wrongData
}

class ImageService: ImageServiceProtocol {
	func getImageFor(country: String, contest: String) -> Promise<UIImage> {
		let service = APIManager.shared().dbService
		return Promise { seal in
			let path = "/Participants/\(contest)/All"
			
			service.fetchData(as: String.self, for: country, path: path)
			.then { url in
				self.getImage(from: url)
			}.done { image in
				let croppedImage = self.cropImage(image: image)
				seal.fulfill(croppedImage)
			}.catch { error in
				seal.reject(error)
			}
		}
	}
	
	private func cropImage(image: UIImage) -> UIImage {
		let sideLength = min(image.size.width, image.size.height)
		let sourceSize = image.size
		let xOffset = (sourceSize.width - sideLength) / 2.0
		let yOffset = (sourceSize.height - sideLength) / 2.0
		
		let cropRect = CGRect(
			x: xOffset,
			y: yOffset,
			width: sideLength,
			height: sideLength).integral
		
		let sourceCGImage = image.cgImage!
		let croppedCGImage = sourceCGImage.cropping(to: cropRect)!
		
		return UIImage(cgImage: croppedCGImage)
	}
	
	private func getImage(from url: String) -> Promise<UIImage> {
		return Promise { seal in
			guard let url = URL(string: url) else {
				seal.reject(ImageServiceError.badURL)
				return
			}
			
			downloadData(from: url).done { data in
				guard let image = UIImage(data: data) else {
					seal.reject(ImageServiceError.wrongData)
					return
				}
				
				seal.fulfill(image)
			}.catch { error in
				seal.reject(error)
			}
		}
	}
	
	private func downloadData(from url: URL) -> Promise<Data> {
		return Promise { seal in
			URLSession.shared.dataTask(with: url) { data, response, error in
				guard error == nil else {
					seal.reject(error!)
					return
				}
				
				guard let data = data else {
					seal.reject(ImageServiceError.dataMissing)
					return
				}
				
				seal.fulfill(data)
			}
		}
	}
	
}
