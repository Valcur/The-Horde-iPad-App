//
//  Extensions.swift
//  Horde
//
//  Created by Loic D on 10/05/2022.
//

import Foundation
import SwiftUI
import UIKit

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

struct StaticButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}



import UIKit

class MyAppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        let config = UISceneConfiguration(name: "My Scene Delegate", sessionRole: connectingSceneSession.role)
        config.delegateClass = MySceneDelegate.self
        return config
    }
}

class MySceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let rootView = HordeAppNoHomeIndicatorView()
            let hostingController = HostingController(rootView: rootView)
            window.rootViewController = hostingController
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

class HostingController: UIHostingController<HordeAppNoHomeIndicatorView> {
    /*override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }*/
    override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge {
        return [.bottom]
    }
}

struct GradientView: View {
    
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    let gradient: Gradient
    
    init(gradientId: Int) {
        switch gradientId {
        case 1:
            gradient = Gradient(colors: [Color("GradientLightColor"), Color("GradientDarkColor")])
            break
        case 3:
            gradient = Gradient(colors: [Color("GradientLight3Color"), Color("GradientDark3Color")])
            break
        case 4:
            gradient = Gradient(colors: [Color("GradientLight4Color"), Color("GradientDark4Color")])
            break
        case 5:
            gradient = Gradient(colors: [Color("GradientLight5Color"), Color("GradientDark5Color")])
            break
        case 6:
            gradient = Gradient(colors: [Color("GradientLight6Color"), Color("GradientDark6Color")])
            break
        case 7:
            gradient = Gradient(colors: [Color("GradientLight7Color"), Color("GradientDark7Color")])
            break
        case 8:
            gradient = Gradient(colors: [Color("GradientLight8Color"), Color("GradientDark8Color")])
            break
        default:
            gradient = Gradient(colors: [Color("GradientLight2Color"), Color("GradientDark2Color")])
            break
        }
    }
    
    var body: some View {
        LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
            .saturation(hordeAppViewModel.useLessColorFullBackground ? 0.6 : 1)
            .ignoresSafeArea()
    }
}

struct SleeveArtImageView: View {

    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    var art: Image
    
    init(artId: Int) {
        switch artId {
        case -1:
            art = Image("BlackBackground")
            break
        case 0:
            art = Image("BlackBackground")
            art = getCustomSleeveArt()
            break
        case 2:
            art = Image("Sleeve_2")
            break
        case 3:
            art = Image("Sleeve_3")
            break
        case 4:
            art = Image("Sleeve_4")
            break
        case 5:
            art = Image("Sleeve_5")
            break
        case 6:
            art = Image("Sleeve_6")
            break
        case 7:
            art = Image("Sleeve_7")
            break
        case 8:
            art = Image("Sleeve_8")
            break
        default:
            art = Image("Sleeve_1")
            break
        }
    }
    
    func getCustomSleeveArt() -> Image {
        guard let data = UserDefaults.standard.data(forKey: "CustomSleeveArtImage") else { return Image("BlackBackground") }
        let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
        
        guard let inputImage = UIImage(data: decoded) else {
            return Image("BlackBackground")
        }
        
        return Image(uiImage: inputImage)
    }
    
    var body: some View {
        art.resizable().scaledToFill()
    }
}

struct CardSearchTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .foregroundColor(.white)
            .padding(10)
            .background(Color.black.opacity(0.2))
            .cornerRadius(30)
            .shadow(color: .gray, radius: 10)
    }
}

import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.preferredAssetRepresentationMode = .current
        config.selectionLimit = 1
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard !results.isEmpty else { return }

            guard let provider = results.first?.itemProvider else { return }

            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self, completionHandler: {image, error in
                       DispatchQueue.main.async {
                           guard let image = image as? UIImage else {
                               debugPrint("Error: UIImage is nil")
                               return }
                           self.parent.image = image
                       }
                   })
             }
        }
    }
}

class TextBindingManager: ObservableObject {
    @Published var text = "" {
        didSet {
            if text.count > characterLimit && oldValue.count <= characterLimit {
                text = oldValue
            }
        }
    }
    let characterLimit: Int

    init(limit: Int = 5){
        characterLimit = limit
    }
}


fileprivate struct UITextViewWrapper: UIViewRepresentable {
    typealias UIViewType = UITextView

    @Binding var text: String
    @Binding var calculatedHeight: CGFloat
    var onDone: (() -> Void)?

    func makeUIView(context: UIViewRepresentableContext<UITextViewWrapper>) -> UITextView {
        let textField = UITextView()
        textField.delegate = context.coordinator

        textField.isEditable = true
        textField.font = UIFont.preferredFont(forTextStyle: .subheadline)
        textField.textColor = .white
        textField.isSelectable = true
        textField.isUserInteractionEnabled = true
        textField.isScrollEnabled = false
        textField.backgroundColor = UIColor.clear
        if nil != onDone {
            textField.returnKeyType = .done
        }

        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return textField
    }

    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<UITextViewWrapper>) {
        if uiView.text != self.text {
            uiView.text = self.text
        }
        if uiView.window != nil, !uiView.isFirstResponder {
            uiView.becomeFirstResponder()
        }
        UITextViewWrapper.recalculateHeight(view: uiView, result: $calculatedHeight)
    }

    fileprivate static func recalculateHeight(view: UIView, result: Binding<CGFloat>) {
        let newSize = view.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        if result.wrappedValue != newSize.height {
            DispatchQueue.main.async {
                result.wrappedValue = newSize.height // !! must be called asynchronously
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, height: $calculatedHeight, onDone: onDone)
    }

    final class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>
        var calculatedHeight: Binding<CGFloat>
        var onDone: (() -> Void)?

        init(text: Binding<String>, height: Binding<CGFloat>, onDone: (() -> Void)? = nil) {
            self.text = text
            self.calculatedHeight = height
            self.onDone = onDone
        }

        func textViewDidChange(_ uiView: UITextView) {
            text.wrappedValue = uiView.text
            UITextViewWrapper.recalculateHeight(view: uiView, result: calculatedHeight)
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if let onDone = self.onDone, text == "\n" {
                textView.resignFirstResponder()
                onDone()
                return false
            }
            return true
        }
    }

}

struct MultilineTextField: View {

    private var placeholder: String
    private var onCommit: (() -> Void)?

    @Binding private var text: String
    private var internalText: Binding<String> {
        Binding<String>(get: { self.text } ) {
            self.text = $0
            self.showingPlaceholder = $0.isEmpty
        }
    }

    @State private var dynamicHeight: CGFloat = 100
    @State private var showingPlaceholder = false

    init (_ placeholder: String = "", text: Binding<String>, onCommit: (() -> Void)? = nil) {
        self.placeholder = placeholder
        self.onCommit = onCommit
        self._text = text
        self._showingPlaceholder = State<Bool>(initialValue: self.text.isEmpty)
    }

    var body: some View {
        UITextViewWrapper(text: self.internalText, calculatedHeight: $dynamicHeight, onDone: onCommit)
            .frame(minHeight: dynamicHeight, maxHeight: dynamicHeight)
            .background(placeholderView, alignment: .topLeading)
    }

    var placeholderView: some View {
        Group {
            if showingPlaceholder {
                Text(placeholder).foregroundColor(.gray)
                    .padding(.leading, 4)
                    .padding(.top, 8)
            }
        }
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    typealias Callback = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void
    
    @Binding var activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil
    let excludedActivityTypes: [UIActivity.ActivityType]? = nil
    let callback: Callback? = nil
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities)
        controller.excludedActivityTypes = excludedActivityTypes
        controller.completionWithItemsHandler = callback
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // nothing to do here
    }
}

struct ShareOnDiscordView: View {
    
    @EnvironmentObject var deckEditorViewModel: DeckEditorViewModel
    @State private var showShareSheet = false
    @State private var txtFile: [Any] = []
    
    var body: some View {
        Button(action: {
            txtFile = DeckManager.shareOnDiscord(
                deckName: deckEditorViewModel.loadDeckName(),
                deckList: deckEditorViewModel.getDeckDataString())
            self.showShareSheet = true
        }, label: {
            Text(".txt")
                .font(.title2)
                .foregroundColor(.white)
        })
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(activityItems: $txtFile)
        }
    }
}

extension Data {
    
    /// Get the current directory
    ///
    /// - Returns: the Current directory in NSURL
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory as NSString
    }

    /// Data into file
    ///
    /// - Parameters:
    ///   - fileName: the Name of the file you want to write
    /// - Returns: Returns the URL where the new file is located in NSURL
    func dataToFile(fileName: String) -> NSURL? {

        // Make a constant from the data
        let data = self

        // Make the file path (with the filename) where the file will be loacated after it is created
        let filePath = getDocumentsDirectory().appendingPathComponent(fileName)

        do {
            // Write the file from data into the filepath (if there will be an error, the code jumps to the catch block below)
            try data.write(to: URL(fileURLWithPath: filePath))

            // Returns the URL where the new file is located in NSURL
            return NSURL(fileURLWithPath: filePath)

        } catch {
            // Prints the localized description of the error from the do block
            print("Error writing the file: \(error.localizedDescription)")
        }

        // Returns nil if there was an error in the do-catch -block
        return nil
    }
}
