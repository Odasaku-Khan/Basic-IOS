import UIKit

final class HeroImageLoader {

    static let shared = HeroImageLoader()

    private let cache = NSCache<NSString, UIImage>()

    private init() {}

    @discardableResult
    func loadImage(
        from urlString: String,
        completion: @escaping (UIImage?) -> Void
    ) -> URLSessionDataTask? {

        if let cachedImage = cache.object(forKey: urlString as NSString) {
            completion(cachedImage)
            return nil
        }

        guard let url = URL(string: urlString) else {
            completion(nil)
            return nil
        }

        let task = URLSession.shared.dataTask(with: url) {
            [weak self] data, response, error in

            guard error == nil,
                  let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode),
                  let data = data,
                  let image = UIImage(data: data) else {

                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            self?.cache.setObject(
                image,
                forKey: urlString as NSString
            )
            DispatchQueue.main.async {
                completion(image)
            }

        }

        task.resume()
        return task
    }
}
