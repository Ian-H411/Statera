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
    
    private var currentUsersEmail: String {
        return Auth.auth().currentUser?.email ?? "UNKNOWN"
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    //MARK: - File Network Handling
    func addDocument(_ fileURL: URL, type: DocumentFile.FileType) {
        let newDoc = DocumentFile(url: fileURL, fileName: fileURL.lastPathComponent, type: type)
        files.append(newDoc)
        uploadDocument(newDoc)
    }
    
    func addDocument(_ image: UIImage) {
        let imageData = image.pngData()
        let imageName = dateFormatter.string(from: Date())
        let newDoc = DocumentFile(imageData: imageData, fileName: "\(imageName).png", type: .camera)
        files.append(newDoc)
        uploadDocument(newDoc)
    }
    
    private func uploadDocument(_ document: DocumentFile) {
        let year = Calendar.current.component(.year, from: Date())
        let storageRef = Storage.storage().reference().child("\(currentUsersEmail)").child("\(year)")
        var uploadTask: StorageUploadTask?
        switch document.type {
        case .file:
            uploadTask = uploadDocumentFromFile(file: document, storageRef: storageRef)
        case .photoLibrary:
            uploadTask = uploadDocumentFromLibrary(file: document, storageRef: storageRef)
        case .camera:
            uploadTask = uploadDocumentFromCamera(file: document, storageRef: storageRef)
        }

        uploadTask?.observe(.progress) { snapshot in
            guard let progress = snapshot.progress else { return }
            DispatchQueue.main.async {
                document.uploadStatus = "Uploading (\(Int(progress.fractionCompleted * 100))%)"
            }
        }
    }
    
    private func uploadDocumentFromFile(file: DocumentFile, storageRef: StorageReference) -> StorageUploadTask? {
        if let url = file.url,
           url.startAccessingSecurityScopedResource() {
            guard let data = try? Data(contentsOf: url) else {
                return nil
            }
            url.stopAccessingSecurityScopedResource()
            return storageRef.child("\(file.fileName)").putData(data, metadata: nil) { metaData, error in
                DispatchQueue.main.async {
                    if let error = error {
                        file.uploadStatus = "Upload Failed: \(error.localizedDescription)"
                    } else {
                        file.uploadStatus = "Upload Successful"
                        file.isUploaded = true
                    }
                }
            }
        } else {
            file.isUploaded = false
            file.uploadStatus = "Upload Failed: Check Phone permissions"
            return nil
        }
    }
    
    private func uploadDocumentFromCamera(file: DocumentFile, storageRef: StorageReference) -> StorageUploadTask? {
        guard let data = file.data else {
            return nil
        }
        return storageRef.child("\(file.fileName)").putData(data, metadata: nil) { metaData, error in
            DispatchQueue.main.async {
                if let error = error {
                    file.uploadStatus = "Upload Failed: \(error.localizedDescription)"
                } else {
                    file.uploadStatus = "Upload Successful"
                    file.isUploaded = true
                }
            }
        }
    }
    
    private func uploadDocumentFromLibrary(file: DocumentFile, storageRef: StorageReference) -> StorageUploadTask? {
        if let url = file.url {
            return storageRef.child("\(file.fileName)").putFile(from: url) { metaData, error in
                DispatchQueue.main.async {
                    if let error = error {
                        file.uploadStatus = "Upload Failed: \(error.localizedDescription)"
                    } else {
                        file.uploadStatus = "Upload Successful"
                        file.isUploaded = true
                    }
                }
            }
        } else {
            file.isUploaded = false
            file.uploadStatus = "Upload Failed: Check Phone permissions"
            return nil
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
        let storageRef = Storage.storage().reference().child("\(currentUsersEmail)").child(document.fileName)
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
    enum FileType {
        case file
        case photoLibrary
        case camera
    }
    let id = UUID()
    var url: URL?
    var data: Data?
    let fileName: String
    let type: FileType
    @Published var uploadStatus: String = "Not Uploaded"
    var isUploaded: Bool = false
    
    init(url: URL? = nil, imageData: Data? = nil, fileName: String, type: FileType) {
        self.url = url
        self.fileName = fileName
        self.type = type
        self.data = imageData
    }
}
