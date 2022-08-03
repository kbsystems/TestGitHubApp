//
//  UserViewModel.swift
//  GitHubApp
//
//  Created by Jan Binkiewicz on 29/07/2022.
//

import Foundation
import Combine
import RealmSwift
import Alamofire

final class UserViewModel: ObservableObject {
    
    @Published var users: [User] = []
    @Published var user = ""
    
    private var token: NotificationToken?
    
    init() {
        setupObserver()
    }

    deinit {
        token?.invalidate()
    }
    
    private func setupObserver() {
        do {
            let realm = try Realm()
            self.clearToShowList(realm: realm)
            let results = realm.objects(UserObject.self)

            token = results.observe({ [weak self] changes in
                self?.users = results.map(User.init)
                .sorted(by: { $0.login > $1.login })
            })
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func getUsers(onSuccess: @escaping (_ success: String) -> Void, onFailure: @escaping (_ failure: Any) -> Void) {
        
        let realm = try! Realm()
        self.clearToShowList(realm: realm)
        self.users = []
        
        ApiManager().getUsers(self.user) { success in
            
            for userObject in realm.objects(UserObject.self).filter("toShow == %i", true) {
                self.users.append(User(userObject: userObject))
            }
            
            onSuccess("wszystko ok")
            
        } onFailure: { failure in
            onFailure(failure)
        }
    }
    
    func clearToShowList(realm: Realm) {
        try! realm.write {
            for userObject in realm.objects(UserObject.self) {
                userObject.toShow = false
            }
        }
    }
    
    func markAsVisited(_ user: User) {
        
        do {
            let realm = try! Realm()
            let objectId = try ObjectId(string: user.id)
            let userObj = realm.object(ofType: UserObject.self, forPrimaryKey: objectId)
            
            try! realm.write {
                userObj?.visited = true
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
