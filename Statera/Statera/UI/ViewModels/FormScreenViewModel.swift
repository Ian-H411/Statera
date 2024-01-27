//
//  FormScreenViewModel.swift
//  Statera
//
//  Created by Ian Hall on 12/4/23.
//

import Foundation
import PDFKit
import FirebaseStorage
import FirebaseAuth

class FormScreenViewModel: ObservableObject {
    
    static let stateCodes = [
        "AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA",
        "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD",
        "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ",
        "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC",
        "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"
    ]
    
    enum FilingStatus: String {
        case single = "Single"
        case marriedFilingJoint = "Married_Filing_Joint"
        case headOfHousehold = "Head_of_Household"
    }
    
    private var currentUserName: String {
        return Auth.auth().currentUser?.displayName ?? "UNKNOWN"
    }
    
    private var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        return dateFormatter
    }()
    
    let filingStatusInfo: String = "filing_Status_Info"
    
    static let filingStatusOptions: [String] = [FilingStatus.single.rawValue, FilingStatus.marriedFilingJoint.rawValue, FilingStatus.headOfHousehold.rawValue]
    
    static let dependents = ["0","1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    @Published var nameViewModel = TextInputViewModel(labelText: "Full_Name", preFill: "", minCharacters: 5, maxCharacters: 30, allowedCharacterSet: .alphanumerics)
    @Published var SSNViewModel = SSNInputViewModel(labelText: "Social_Security_Number")
    @Published var DOBViewModel = DOBInputViewModel(labelText: "Date_of_Birth")
    @Published var phoneNumberViewModel = PhoneNumberInputViewModel(labelText: "Phone_Number", preFill: "")
    
    @Published var addressLine1ViewModel = TextInputViewModel(labelText: "Address_Line_1", preFill: "", minCharacters: 5, maxCharacters: 50, allowedCharacterSet: .alphanumerics)
    @Published var addressLine2ViewModel = TextInputViewModel(labelText: "Address Line 2", preFill: "", minCharacters: 5, maxCharacters: 50, allowedCharacterSet: .alphanumerics)
    @Published var cityViewModel = TextInputViewModel(labelText: "City", preFill: "", minCharacters: 4, maxCharacters: 20, allowedCharacterSet: .alphanumerics)
    @Published var StateViewModel = PickerInputViewModel(labelText: "State", options: stateCodes)
    @Published var zipCodeViewModel = ZipCodeInputViewModel(labelText: "Zip_Code", preFill: "")
    
    @Published var filingStatusViewModel = PickerInputViewModel(labelText: "Filing_Status", options: filingStatusOptions)
    
    @Published var dependentsViewModel = PickerInputViewModel(labelText: "How_Many_Dependents?", options: dependents)
    
    @Published var dependentsInfoViewModels: [[FormInputViewModel]] = []
    
    func shouldAskDependents() -> Bool {
        return FilingStatus(rawValue: filingStatusViewModel.userInput) != .single
    }
    
    func numberOfDependentsFields() -> Int {
        return Int(dependentsViewModel.userInput) ?? 0
    }
    
    func updateDependentViewModels() {
        let baseDependentArray: [FormInputViewModel] = [
            TextInputViewModel(labelText: "Full_Name", preFill: "", minCharacters: 5, maxCharacters: 30, allowedCharacterSet: .alphanumerics),
            SSNInputViewModel(labelText: "Social_Security_Number"),
            DOBInputViewModel(labelText: "Date_of_Birth")
        ]
        dependentsInfoViewModels = Array(repeating: baseDependentArray, count: numberOfDependentsFields())
    }
    
    func enableSubmitButton() -> Bool {
        var dependentsInfoComplete = dependentsInfoViewModels.contains { inputViewModels in
            inputViewModels.contains(where: { !$0.isValid() })
        }
        if dependentsInfoViewModels.isEmpty {
            dependentsInfoComplete = true
        }
        return dependentsInfoComplete && dependentsViewModel.isValid() &&
            filingStatusViewModel.isValid() && zipCodeViewModel.isValid() &&
            StateViewModel.isValid() && cityViewModel.isValid() &&
            addressLine1ViewModel.isValid() && phoneNumberViewModel.isValid() &&
            DOBViewModel.isValid() && SSNViewModel.isValidSSN() && nameViewModel.isValid()
    }
    
    func submitData(completionHandler: @escaping (Bool) -> Void) {
        let pdfData = createPDF()
        let time = dateFormatter.string(from: Date())
        let fileName = "\(nameViewModel.userInput) \(time)"
        let storageRef = Storage.storage().reference().child("\(currentUserName)").child(fileName)
        
        let uploadTask = storageRef.putData(pdfData) { metaData, error in
            guard metaData != nil, error == nil else {
                completionHandler(false)
                return
            }
        }
        uploadTask.observe(.success) { snapshot in
            completionHandler(true)
        }
    }
    
    private func createPDF() -> Data {
        // 1
        let pdfMetaData = [
          kCGPDFContextCreator: "Martin Medina",
          kCGPDFContextAuthor: "Statera.com"
        ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]

        // 2
        let pageWidth = 8.5 * 72.0
        let pageHeight = 11 * 72.0
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)

        // 3
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        // 4
        let data = renderer.pdfData { (context) in
          // 5
          context.beginPage()
          // 6
          let attributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)
          ]
          let text = createPDFTextContent()
          text.draw(at: CGPoint(x: 0, y: 0), withAttributes: attributes)
        }

        return data
    }
    
    private func createPDFTextContent() -> String {
        var dependentString = ""
        for (index, dependentsInfoViewModel) in dependentsInfoViewModels.enumerated() {
            let name = dependentsInfoViewModel[0].userInput
            let ssn = dependentsInfoViewModel[1].userInput
            let dob = dependentsInfoViewModel[2].userInput
            dependentString.append("Dependent: \(index + 1) \n Name: \(name) \n Social: \(ssn) \n Date Of Birth: \(dob) \n\n")
        }
        return "FullName: \(nameViewModel.userInput) \n Social: \(SSNViewModel.userInput) \n Date of Birth: \(DOBViewModel.userInput) \n Phone Number: \(phoneNumberViewModel.userInput) \n Address: \(addressLine1ViewModel.userInput) \n    \(addressLine2ViewModel.userInput) \n   \(cityViewModel.userInput), \(StateViewModel.userInput), \(zipCodeViewModel.userInput) \n\n Filing Status: \(filingStatusViewModel.userInput) \n Number of Dependents: \(dependentsViewModel.userInput) \n \(dependentString)"
    }
}
