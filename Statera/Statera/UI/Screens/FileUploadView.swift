//
//  FileUploadView.swift
//  Statera
//
//  Created by Ian Hall on 12/31/23.
//

import SwiftUI
import SwiftyDropbox

struct FileUploadView: View {
    
    @ObservedObject var fileUploadViewModel: FileUploadViewModel = FileUploadViewModel()
    
    var body: some View {
        VStack {
            Button("Login") {
                fileUploadViewModel.login()
            }
            Button("Upload") {
                if let file = "test sample".data(using: String.Encoding.utf8, allowLossyConversion: false) {
                    fileUploadViewModel.upload(data: file)
                }
            }
        }
    }
}

#Preview {
    FileUploadView()
}
