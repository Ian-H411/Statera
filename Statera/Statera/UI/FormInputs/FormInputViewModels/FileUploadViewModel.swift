//
//  FileUploadViewModel.swift
//  Statera
//
//  Created by Ian Hall on 1/2/24.
//

import FirebaseStorage
import UniformTypeIdentifiers
import FirebaseAuth
import UIKit.UIImage
import Combine

class FileUploadViewModel: FormInputViewModel {
    @Published var files: [DocumentFile] = []
    
    private var currentUserName: String {
        return Auth.auth().currentUser?.displayName ?? "UNKNOWN"
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    //MARK: - File Network Handling
    func addDocument(_ fileURL: URL) {
        let newDoc = DocumentFile(url: fileURL, fileName: fileURL.lastPathComponent)
        files.append(newDoc)
        uploadDocument(newDoc)
    }
    
    func addDocument(_ image: UIImage) {
        let imageData = image.jpegData(compressionQuality: 1.0)
        let imageName = dateFormatter.string(from: Date())
        let newDoc = DocumentFile(imageData: imageData, fileName: "\(imageName).jpeg")
        files.append(newDoc)
        uploadDocument(newDoc)
    }
    
    private func uploadDocument(_ document: DocumentFile) {
        var document = document
        let storageRef = Storage.storage().reference().child("\(currentUserName)")
        var uploadTask: StorageUploadTask?
        if let url = document.url {
            uploadTask = storageRef.putFile(from: url, metadata: nil) { metadata, error in
                DispatchQueue.main.async {
                    if let error = error {
                        document.uploadStatus = "Upload Failed: \(error.localizedDescription)"
                    } else {
                        document.uploadStatus = "Upload Successful"
                        document.isUploaded = true
                    }
                }
            }
        } else if let data = document.data {
            uploadTask = storageRef.putData(data, metadata: nil, completion: { metaData, error in
                DispatchQueue.main.async {
                    if let error = error {
                        document.uploadStatus = "Upload Failed: \(error.localizedDescription)"
                    } else {
                        document.uploadStatus = "Upload Successful"
                        document.isUploaded = true
                    }
                }
            })
        }

        uploadTask?.observe(.progress) { snapshot in
            guard let progress = snapshot.progress else { return }
            DispatchQueue.main.async {
                document.uploadStatus = "Uploading (\(Int(progress.fractionCompleted * 100))%)"
            }
        }
    }
    
    func documentUploadComplete(_ file: DocumentFile) -> Bool {
        return file.uploadStatus == "Upload Successful" || //TODO: Localize
            file.uploadStatus.contains("Upload Failed")
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
        let storageRef = Storage.storage().reference().child("\(currentUserName)").child(document.fileName)
        storageRef.delete { error in
            if let error = error {
                print("Error Deleting: \(error.localizedDescription)")
            } else {
                print("Deletion Successful")
            }
        }
    }
}

class DocumentFile: Identifiable, ObservableObject {
    let id = UUID()
    var url: URL?
    var data: Data?
    let fileName: String
    @Published var uploadStatus: String = "Not Uploaded"
    var isUploaded: Bool = false
    
    init(url: URL? = nil, imageData: Data? = nil, fileName: String) {
        self.url = url
        self.fileName = fileName
    }
}
