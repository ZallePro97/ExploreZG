import Foundation
import Alamofire

class AppService {

    typealias json = [String : Any]
    private let connectionString = "https://morning-cliffs-28502.herokuapp.com"

    func getAllCategories(completion: @escaping (([CategoryModel]?) -> Void)) {
        let stringUrl = connectionString + AppRoutes.getAllCategoryes

        guard let url = URL(string: stringUrl) else { return }

        Alamofire
            .request(url, method: .get, parameters: nil)
            .validate()
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    print("Error while fetching categories: \(String(describing: response.result.error))")
                    completion(nil)
                    return
                }

                guard let jsonResponse = response.result.value as? [json] else  { return }

                var categories = [CategoryModel]()
                for data in jsonResponse {
                    categories.append(CategoryModel(fromJson: data))
                }

                completion(categories)
            }

    }

    func getAllRoutes(completion: @escaping (([RouteModel]?) -> Void)) {
        let stringUrl = connectionString + AppRoutes.getAllRoutes

        guard let url = URL(string: stringUrl) else { return }

        Alamofire
            .request(url, method: .get, parameters: nil)
            .validate()
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    print("Error while fetching routes: \(String(describing: response.result.error))")
                    completion(nil)
                    return
                }

                guard let jsonResponse = response.result.value as? [json] else  { return }

                var routeModels = [RouteModel]()
                for object in jsonResponse {
                    routeModels.append(RouteModel(fromJson: object))
                }

                completion(routeModels)
        }
    }

    func getAllLocations(completion: @escaping (([LocationModel]?) -> Void)) {
        let stringUrl = connectionString + AppRoutes.getAllLocations

        guard let url = URL(string: stringUrl) else { return }

        Alamofire
            .request(url, method: .get, parameters: nil)
            .validate()
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    print("Error while fetching locations: \(String(describing: response.result.error))")
                    completion(nil)
                    return
                }

                guard let jsonResponse = response.result.value as? [json] else { return }

                var locationModels = [LocationModel]()
                for object in jsonResponse {
                    locationModels.append(LocationModel(fromJson: object))
                }

                completion(locationModels)
        }
    }

    func incresePopularity(forRouteId routeId: Int) {
        let stringUrl = connectionString + AppRoutes.increasePopularity + String(routeId)

        guard let url = URL(string: stringUrl) else { return }

        Alamofire
            .request(url, method: .put, parameters: nil)
            .validate()
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    print("Error while increasing popularity: \(String(describing: response.result.error))")
                    return
                }
            }
    }

    func createUser(user: UserModel, completion: @escaping ((UserModel?) -> Void)) {
        let stringUrl = connectionString + AppRoutes.createUser

        guard let url = URL(string: stringUrl) else { return }

        let jsonUser = user.toPostJson()

        Alamofire
            .request(url, method: .post, parameters: jsonUser, encoding: JSONEncoding.default)
            .validate()
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    print("Error while creating user: \(String(describing: response.result.error))")
                    completion(nil)
                    return
                }

                guard let jsonResponse = response.result.value as? json else { return }

                let userModel = UserModel(fromJson: jsonResponse)

                completion(userModel)
            }
    }

    func updateUser(user: UserModel, completion: @escaping ((UserModel?) -> Void)) {
        let stringUrl = connectionString + AppRoutes.updateUser

        guard let url = URL(string: stringUrl) else { return }

        let jsonUser = user.toPutJson()

        Alamofire
            .request(url, method: .put, parameters: jsonUser, encoding: JSONEncoding.default)
            .validate()
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    print("Error while updating user: \(String(describing: response.result.error))")
                    completion(nil)
                    return
                }

                guard let jsonResponse = response.result.value as? json else { return }

                let userModel = UserModel(fromJson: jsonResponse)

                completion(userModel)
        }
    }

    func getUser(mail: String, completion: @escaping ((UserModel?) -> Void)) {
        let stringUrl = connectionString + AppRoutes.getUser + mail

        guard let url = URL(string: stringUrl) else { return }

        Alamofire
            .request(url, method: .get, parameters: nil)
            .validate()
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    print("Error while fatching user: \(String(describing: response.result.error))")
                    completion(nil)
                    return
                }

                guard let jsonResponse = response.result.value as? json else { return }

                let userModel = UserModel(fromJson: jsonResponse)

                completion(userModel)
        }
    }

    func createLocation(location: LocationModel, completion: @escaping ((LocationModel?) -> Void)) {
        let stringUrl = connectionString + AppRoutes.createLocation

        guard let url = URL(string: stringUrl) else { return }

        let jsonLocation = location.toPostJson()

        Alamofire
            .request(url, method: .post, parameters: jsonLocation, encoding: JSONEncoding.default)
            .validate()
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    print("Error while creating location: \(String(describing: response.result.error))")
                    completion(nil)
                    return
                }

                guard let jsonResponse = response.result.value as? json else { return }

                let locationModel = LocationModel(fromJson: jsonResponse)

                completion(locationModel)
        }
    }

    func createRoute(routeModel: CreateRouteModel, completion: @escaping ((RouteModel?) -> Void)) {
        let stringUrl = connectionString + AppRoutes.createRoute

        guard let url = URL(string: stringUrl) else { return }

        let jsonRoute = routeModel.toJson()

        Alamofire
            .request(url, method: .post, parameters: jsonRoute, encoding: JSONEncoding.default)
            .validate()
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    print("Error while creating route: \(String(describing: response.result.error))")
                    completion(nil)
                    return
                }

                guard let jsonResponse = response.result.value as? json else { return }

                let routeModel = RouteModel(fromJson: jsonResponse)

                completion(routeModel)
        }
    }

    func addRouteToFavorites(userMail: String, routeId: Int ) {
        let stringUrl = connectionString + AppRoutes.addToFavorites + userMail + "/" + String(routeId)

        guard let url = URL(string: stringUrl) else { return }

        Alamofire
            .request(url, method: .put, parameters: nil)
            .validate()
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    print("Error while adding favorites: \(String(describing: response.result.error))")
                    return
                }
        }
    }

    func removeRoutefromFavorites(userMail: String, routeId: Int ) {
        let stringUrl = connectionString + AppRoutes.removeFromFavorites + userMail + "/" + String(routeId)

        guard let url = URL(string: stringUrl) else { return }

        Alamofire
            .request(url, method: .delete, parameters: nil)
            .validate()
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    print("Error while adding favorites: \(String(describing: response.result.error))")
                    return
                }
        }
    }

    func createComment(commentModel: CreateCommentModel, completion: @escaping ((CommentModel?) -> Void)) {
        let stringUrl = connectionString + AppRoutes.addComment

        guard let url = URL(string: stringUrl) else { return }

        let jsonComment = commentModel.toJson()

        Alamofire
            .request(url, method: .post, parameters: jsonComment, encoding: JSONEncoding.default)
            .validate()
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    print("Error while creating comment: \(String(describing: response.result.error))")
                    completion(nil)
                    return
                }

                guard let jsonResponse = response.result.value as? json else { return }

                let commentModel = CommentModel(fromJson: jsonResponse)

                completion(commentModel)
        }
    }

    func getRoute(routeId: Int, completion: @escaping ((RouteModel?) -> Void)) {
        let stringUrl = connectionString + AppRoutes.getRoute + String(routeId)

        guard let url = URL(string: stringUrl) else { return }

        Alamofire
            .request(url, method: .get, parameters: nil)
            .validate()
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    print("Error while fatching user: \(String(describing: response.result.error))")
                    completion(nil)
                    return
                }

                guard let jsonResponse = response.result.value as? json else { return }

                let routeModel = RouteModel(fromJson: jsonResponse)

                completion(routeModel)
        }
    }
}
