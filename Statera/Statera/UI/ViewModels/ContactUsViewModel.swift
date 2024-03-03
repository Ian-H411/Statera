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
        deleteFilesAndFoldersUnderReference(completion: {
            Auth.auth().currentUser?.delete(completion: { _ in
                completionHandler(true)
            })
        })
    }
    
    func deleteFilesAndFoldersUnderReference(completion: @escaping () -> Void) {
        // Recursive function to delete all items
        let storageRef = Storage.storage().reference().child("\(currentUsersEmail)")
        
        func deleteItems(_ items: [StorageReference], completion: @escaping (Error?) -> Void) {
            guard !items.isEmpty else {
                completion(nil)
                return
            }
            
            let group = DispatchGroup()
            var deletionError: Error?
            
            for item in items {
                group.enter()
                item.listAll { result, error in
                    if let error = error {
                        deletionError = error
                        group.leave()
                        return
                    }
                    
                    let nestedItems: [StorageReference] = result?.items ?? []
                    let nestedDirectories: [StorageReference] = result?.prefixes ?? []
                    
                    deleteItems(nestedItems + nestedDirectories) { error in
                        if let error = error {
                            deletionError = error
                        }
                        item.delete { error in
                            if let error = error {
                                deletionError = error
                            }
                            group.leave()
                        }
                    }
                }
            }
            
            group.notify(queue: .main) {
                completion(deletionError)
            }
        }
        
        storageRef.listAll { result, error in
            if let _ = error {
                completion()
                return
            }
            
            let items: [StorageReference] = result?.items ?? []
            let directories: [StorageReference] = result?.prefixes ?? []
            
            deleteItems(items + directories) { deletionError in
                if let _ = deletionError {
                    completion()
                } else {
                    storageRef.delete { _ in
                        completion()
                    }
                }
            }
        }
    }
}
