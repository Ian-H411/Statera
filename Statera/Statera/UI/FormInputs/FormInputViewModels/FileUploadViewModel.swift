//
//  FileUploadViewModel.swift
//  Statera
//
//  Created by Ian Hall on 1/2/24.
//

import FirebaseStorage
import UniformTypeIdentifiers
import FirebaseAuth

class FileUploadViewModel: FormInputViewModel {
    @Published var files: [DocumentFile] = []
    
    private var currentUserName: String {
        return Auth.auth().currentUser?.displayName ?? "UNKNOWN"
    }
    
    //MARK: - File access and obtaining
    
    
    
    //MARK: - File Network Handling
    func addDocument(_ fileURL: URL) {
        let newDoc = DocumentFile(url: fileURL, fileName: fileURL.lastPathComponent)
        files.append(newDoc)
        uploadDocument(newDoc)
    }
    
    private func uploadDocument(_ document: DocumentFile) {
        var document = document
        let storageRef = Storage.storage().reference().child("\(currentUserName)").child(document.url.lastPathComponent)
        
        let uploadTask = storageRef.putFile(from: document.url, metadata: nil) { metadata, error in
            if let error = error {
                document.uploadStatus = "Upload Failed: \(error.localizedDescription)"
            } else {
                document.uploadStatus = "Upload Successful"
                document.isUploaded = true
            }
        }

        uploadTask.observe(.progress) { snapshot in
            guard let progress = snapshot.progress else { return }
            document.uploadStatus = "Uploading (\(Int(progress.fractionCompleted * 100))%)"
        }
    }
    
    func deleteDocument(_ document: DocumentFile) {
        if let index = files.firstIndex(where: { $0.id == document.id }) {
            files.remove(at: index)
        }
    }
    
    func cancelUpload(_ document: DocumentFile) {
        if let index = files.firstIndex(where: { $0.id == document.id }) {
            files[index].uploadStatus = "Upload Successful"
        }
    }
    
    func deleteDocumentFromStorage(_ document: DocumentFile) {
        let storageRef = Storage.storage().reference().child("\(currentUserName)").child(document.url.lastPathComponent)
        storageRef.delete { error in
            if let error = error {
                print("Error Deleting: \(error.localizedDescription)")
            } else {
                print("Deletion Successful")
            }
        }
    }
}

struct DocumentFile: Identifiable {
    let id = UUID()
    let url: URL
    let fileName: String
    var uploadStatus: String = "Not Uploaded"
    var isUploaded: Bool = false
    
    init(url: URL, fileName: String) {
        self.url = url
        self.fileName = fileName
    }
}
