//
//  ContactUsViewModel.swift
//  Statera
//
//  Created by Ian Hall on 2/26/24.
//

import FirebaseStorage
import UniformTypeIdentifiers
import FirebaseAuth

class ContactUsViewModel: ObservableObject {
    
    private var currentUsersEmail: String {
        return Auth.auth().currentUser?.email ?? "UNKNOWN"
    }
    
    func deleteAccount(completionHandler: @escaping (Bool) -> Void) {
        deleteFilesFromStorage()
        Auth.auth().currentUser?.delete(completion: { _ in
            completionHandler(true)
        })
    }
    
    func deleteFilesFromStorage() {
        
        let storageRef = Storage.storage().reference().child("\(currentUsersEmail)")
        
        storageRef.listAll { result, error in
            if let error = error {
                print("Error listing files: \(error.localizedDescription)")
                return
            }
            guard let resultList = result?.items else { return }
            for item in resultList {
                item.delete { error in
                    if let error = error {
                        print("Error deleting file: \(error.localizedDescription)")
                    } else {
                        print("File deleted successfully.")
                    }
                }
            }
        }
    }
}
