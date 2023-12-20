//
//  FormScreenView.swift
//  Statera
//
//  Created by Ian Hall on 12/4/23.
//

import SwiftUI

struct FormScreenView: View {
    @State var viewModel: FormScreenViewModel
    
    var body: some View {
        ScrollView {
            Form {
                ForEach(viewModel.inputs.indices, id: \.self) { sectionIndex in
                    Section {
                        ForEach(viewModel.inputs[sectionIndex], id: \.self) { inputVM in
                            switch inputVM.questionType {
                            case .text:
                                Text("texty text")
                            case .currency:
                                Text("texty text")
                            case .number:
                                Text("texty text")
                            case .ssn:
                                Text("texty text")
                            case .dob:
                                Text("texty text")
                            case .picker:
                                Text("texty text")
                            case .checkBox:
                                Text("texty text")
                            case .password:
                                Text("text")
                            case .emailAddress:
                                Text("text")
                            }
                        }
                    }
                }
            }
        }
    }
}


let previewViewModel = FormScreenViewModel()
struct FormScreenView_PreviewProvider: PreviewProvider {
    static var previews: some View {
        FormScreenView(viewModel: previewViewModel)
    }
}
