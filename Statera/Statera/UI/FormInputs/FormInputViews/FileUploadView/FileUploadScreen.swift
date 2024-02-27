//
//  FileInputView.swift
//  Statera
//
//  Created by Ian Hall on 1/2/24.
//

import SwiftUI
import PhotosUI
import UniformTypeIdentifiers

struct FileUploadScreen: View {
    @StateObject var viewModel: FileUploadViewModel = FileUploadViewModel(labelText: "uploadDocuments")
    @State private var displayConfirmationDialog: Bool = false
    @State private var selectedPhotoUrl: URL?
    @State private var selectedPhoto: UIImage?
    @State private var openCameraRoll: Bool = false
    @State private var openPhotoLibrary: Bool = false
    @State private var openFileExplorer: Bool = false
    @Environment(\.presentationMode) var presentationMode
    @Binding var loginStatus: LoginStatus
    
    let headerText: String = "almostDone"
    
    var body: some View {
        Form {
            headerView()
            Section("Upload Options") {
                fileUploadOptions()
            }
            if !viewModel.files.isEmpty {
                uploadedFileView()
                submitButton()
            }
        }
        .sheet(isPresented: $openCameraRoll, content: {
            ImagePicker(sourceType: .camera, selectedImageURL: $selectedPhotoUrl, selectedImageData: $selectedPhoto)
        })
        .sheet(isPresented: $openPhotoLibrary, content: {
            ImagePicker(sourceType: .photoLibrary, selectedImageURL: $selectedPhotoUrl, selectedImageData: $selectedPhoto)
        })
        .onChange(of: selectedPhotoUrl) { _, newURL in
            guard let url = newURL else { return }
            viewModel.addDocument(url, type: .photoLibrary)
        }
        .onChange(of: selectedPhoto) { _, newImage in
            guard let image = newImage else { return }
            viewModel.addDocument(image)
        }
        .fileImporter(isPresented: $openFileExplorer, allowedContentTypes: [.heic,.jpeg,.png,.pdf]) { result in
            do  {
                let possibleURL = try result.get()
                let coordinator = NSFileCoordinator(filePresenter: nil)
                var error: NSError?
                coordinator.coordinate(readingItemAt: possibleURL, options: .withoutChanges, error: &error) { (newURL) in
                    viewModel.addDocument(newURL, type: .file)
                }
                if let error = error {
                    print(error.localizedDescription)
                }
            } catch {
                print("Error importing file")
            }
        }
    }
    
    @ViewBuilder
    func headerView() -> some View {
        Section {
            Text("allowableFiles")
        } header: {
            Text(headerText)
                .modifier(TitleTextStyle())
        }
    }
    
    @ViewBuilder
    func fileUploadOptions() -> some View {
        HStack {
            Image(systemName: "folder")
            Button("chooseFiles") {
                openFileExplorer = true
            }
        }
        HStack {
            Image(systemName: "camera")
            Button("useCamera") {
                openCameraRoll = true
            }
        }
        HStack {
            Image(systemName: "photo.on.rectangle.angled")
            Button("usePhotoLibrary") {
                openPhotoLibrary = true
            }
        }
    }
    
    @ViewBuilder
    func uploadedFileView() -> some View {
        Section("selected_Files") {
            List(viewModel.files) { file in
                UploadedFileView(file: file, viewModel: viewModel)
            }
        }
    }
    
    @ViewBuilder
    func submitButton() -> some View {
        if loginStatus == .loggedInNewUser {
            NavigationLink("Submit") {
                SuccessScreen()
            }
            .foregroundColor(.blue)
            .fontWeight(.bold)
        } else {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Submit")
                    .foregroundColor(.blue)
                    .fontWeight(.bold)
            }
        }
    }
}

struct UploadedFileView: View {
    @ObservedObject var file: DocumentFile
    @ObservedObject var viewModel: FileUploadViewModel
    @State private var deletionConfirmation = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(file.fileName)
                Text(file.uploadStatus)
                    .modifier(TertiaryTextStyle())
            }
            Spacer()
            if file.uploadStatus == "Upload Successful" ||
                file.uploadStatus.contains("Upload Failed") {
                Button(action: {
                    deletionConfirmation.toggle()
                }, label: {
                    Image(systemName: "trash.fill")
                        .foregroundColor(.red)
                })
                .frame(width: 20, height: 20)
                .alert(isPresented: $deletionConfirmation) {
                    Alert(
                        title: Text("confirmDeletion"),
                        message: Text("fileDeleteConfirm"),
                        primaryButton: .default(Text("cancel")),
                        secondaryButton: .destructive(Text("delete")) {
                            // Perform deletion
                            viewModel.deleteDocumentFromStorage(file)
                            viewModel.deleteDocument(file)
                        }
                    )
                }
            } else {
                ProgressView()
                    .scaleEffect(1)
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.black))
                    .foregroundColor(.black)
                    .padding()
                    .cornerRadius(10)
                    .frame(width: 10, height: 10)
            }
        }
    }
}

enum UploadOption: Identifiable {
    case useCamera, chooseFromLibrary

    var id: UploadOption { self }
}

#Preview {
    FileUploadScreen(loginStatus: .constant(.loggedIn))
}
