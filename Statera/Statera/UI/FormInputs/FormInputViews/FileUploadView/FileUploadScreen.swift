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
    @StateObject var viewModel: FileUploadViewModel = FileUploadViewModel(labelText: "Upload Documents")
    @State private var selectedUploadOption: UploadOption = .useCamera
    @State private var displayConfirmationDialog: Bool = false
    @State private var selectedPhotoUrl: URL?
    @State private var selectedPhoto: UIImage?
    @State private var openCameraRoll: Bool = false
    @State private var openFileExplorer: Bool = false
    let headerText: String = "Almost Done"
    
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
            let sourceType: UIImagePickerController.SourceType = selectedUploadOption == .useCamera ? .camera : .photoLibrary
            ImagePicker(sourceType: sourceType, selectedImageURL: $selectedPhotoUrl, selectedImageData: $selectedPhoto)
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
            Text("Help us by uploading documents pertaining to your taxes.  Ian doesnt know exactly what documents would help but he is going to write a very long message here so that way he can test  how much text he can put here")
                .fontWeight(.light)
        } header: {
            Text(headerText)
                .modifier(TitleTextStyle())
        }
    }
    
    @ViewBuilder
    func fileUploadOptions() -> some View {
        HStack {
            Image(systemName: "folder")
            Button("Choose Files") {
                openFileExplorer = true
            }
        }
        HStack {
            Image(systemName: "camera")
            Button("Use Camera") {
                selectedUploadOption = .useCamera
                openCameraRoll = true
            }
        }
        HStack {
            Image(systemName: "photo.on.rectangle.angled")
            Button("Choose from Photo Library") {
                selectedUploadOption = .chooseFromLibrary
                openCameraRoll = true
            }
        }
    }
    
    @ViewBuilder
    func uploadedFileView() -> some View {
        Section("Selected files") { //TODO: Localize
            List(viewModel.files) { file in
                UploadedFileView(file: file, viewModel: viewModel)
            }
        }
    }
    
    @ViewBuilder
    func submitButton() -> some View {
        NavigationLink("Submit") {
            SuccessScreen()
        }
        .foregroundColor(.blue)
        .fontWeight(.bold)
    }
}

struct UploadedFileView: View {
    @StateObject var file:  DocumentFile
    @ObservedObject var viewModel: FileUploadViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(file.fileName)
                Text(file.uploadStatus)
                    .modifier(TertiaryTextStyle())
            }
            Spacer()
            if file.uploadStatus == "Upload Successful" || //TODO: Localize
                file.uploadStatus.contains("Upload Failed") {
                Button(action: {
                    viewModel.deleteDocumentFromStorage(file)
                    viewModel.deleteDocument(file)
                }, label: {
                    Image(systemName: "trash.fill")
                        .foregroundColor(.red)
                })
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
    FileUploadScreen()
}
