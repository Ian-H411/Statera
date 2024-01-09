//
//  FileInputView.swift
//  Statera
//
//  Created by Ian Hall on 1/2/24.
//

import SwiftUI
import PhotosUI
import UniformTypeIdentifiers

struct FileUploadView: View {
    @ObservedObject var viewModel: FileUploadViewModel
    @State private var selectedUploadOption: UploadOption?
    @State private var displayConfirmationDialog: Bool = false
    @State private var selectedPhotoUrl: URL?
    @State private var openCameraRoll: Bool = false
    
    var body: some View {
        VStack {
            List(viewModel.files) { file in
                HStack {
                    Text(file.fileName)
                    Spacer()
                    Text(file.uploadStatus)
                    if file.isUploaded {
                        Button("Delete") {
                            viewModel.deleteDocument(file)
                        }
                        .buttonStyle(SecondaryButtonStyle())
                    } else {
                        Button("Cancel") {
                            viewModel.cancelUpload(file)
                        }
                        .buttonStyle(SecondaryButtonStyle())
                    }
                }
            }
            Button("Upload") {
                displayConfirmationDialog = true
                selectedUploadOption = nil
            }
            .buttonStyle(PrimaryButtonStyle())
            .confirmationDialog(LocalizedStringKey("Choose an upload source"), isPresented: $displayConfirmationDialog) {
                Button("Choose Files") {
                    selectedUploadOption = .chooseFiles
                }
                Button("Use Camera") {
                    selectedUploadOption = .useCamera
                    openCameraRoll = true
                }
                Button("Choose from Photo Library") {
                    selectedUploadOption = .chooseFromLibrary
                    openCameraRoll = true
                }
                Button("Cancel", role: .cancel) {
                    selectedUploadOption = nil
                    displayConfirmationDialog = false
                }
            }
        }
        .padding()
        .sheet(isPresented: $openCameraRoll, content: {
            let sourceType: UIImagePickerController.SourceType = selectedUploadOption == .useCamera ? .camera : .photoLibrary
            ImagePicker(sourceType: sourceType, selectedImageURL: $selectedPhotoUrl)
        })
        .onChange(of: selectedPhotoUrl) { _, newURL in
            guard let url = newURL else { return }
            viewModel.addDocument(url)
        }
    }
}

enum UploadOption: Identifiable {
    case chooseFiles, useCamera, chooseFromLibrary

    var id: UploadOption { self }
}

#Preview {
    FileUploadView(viewModel: FileUploadViewModel(labelText: "Upload Documents"))
}
