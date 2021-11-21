//
//  ContentView.swift
//  Instafilter
//
//  Created by Luke Lazzaro on 17/11/21.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var filterIntensity2 = 0.5
    
    @State private var showingImagePicker = false
    @State private var showingFilterSheet = false
    @State private var showingSaveErrorAlert = false
    
    @State private var inputImage: UIImage?
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    @State private var processedImage: UIImage?
    @State private var filterButtonLabel = "Sepia Tone"

    var body: some View {
        let intensity = Binding<Double>(
            get: {
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
            }
        )
        
        let intensity2 = Binding<Double>(
            get: {
                self.filterIntensity2
            },
            set: {
                self.filterIntensity2 = $0
                self.applyProcessing()
            }
        )
    
        return NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }
                .alert(isPresented: $showingSaveErrorAlert) {
                    Alert(title: Text("Error"), message: Text("Please import an image first."), dismissButton: .default(Text("OK")))
                }
                
                VStack(alignment: .leading) {
                    Text("Value Sliders")
                    Slider(value: intensity)
                    currentFilter.inputKeys.count > 2 ? Slider(value: intensity2) : nil
                }.padding(.vertical)
                
                HStack {
                    Button(filterButtonLabel) {
                        self.showingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save") {
                        guard let processedImage = processedImage else {
                            self.showingSaveErrorAlert = true
                            return
                        }
                        let imageSaver = ImageSaver()
                        
                        imageSaver.successHandler = {
                            print("Success!")
                        }
                        
                        imageSaver.errorHandler = {
                            print("Oops: \($0.localizedDescription)")
                        }
                        
                        imageSaver.writeToPhotoAlbum(image: processedImage)
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
            .actionSheet(isPresented: $showingFilterSheet) {
                ActionSheet(title: Text("Select a filter"), buttons: [
                    .default(Text("Crystallize")) {
                        self.setFilter(CIFilter.crystallize())
                        self.filterButtonLabel = "Crystallize"
                    },
                    .default(Text("Edges")) {
                        self.setFilter(CIFilter.edges())
                        self.filterButtonLabel = "Edges"
                    },
                    .default(Text("Gaussian Blur")) {
                        self.setFilter(CIFilter.gaussianBlur())
                        self.filterButtonLabel = "Gaussian Blur"
                    },
                    .default(Text("Pixellate")) {
                        self.setFilter(CIFilter.pixellate())
                        self.filterButtonLabel = "Pixellate"
                    },
                    .default(Text("Sepia Tone")) {
                        self.setFilter(CIFilter.sepiaTone())
                        self.filterButtonLabel = "Sepia Tone"
                    },
                    .default(Text("Unsharp Mask")) {
                        self.setFilter(CIFilter.unsharpMask())
                        self.filterButtonLabel = "Unsharp Mask"
                    },
                    .default(Text("Vignette")) {
                        self.setFilter(CIFilter.vignette())
                        self.filterButtonLabel = "Vignette"
                    },
                    .default(Text("Box Blur")) {
                        self.setFilter(CIFilter.boxBlur())
                        self.filterButtonLabel = "Box Blur"
                    },
                    .cancel()
                ])
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
//        Crystallize:      ["inputImage", "inputRadius", "inputCenter"]
//        Edges:            ["inputImage", "inputIntensity"]
//        Gaussian Blur:    ["inputImage", "inputRadius"]
//        Pixellate:        ["inputImage", "inputCenter", "inputScale"]
//        Sepia Tone:       ["inputImage", "inputIntensity"]
//        Unsharp Mask:     ["inputImage", "inputRadius", "inputIntensity"]
//        Vignette:         ["inputImage", "inputIntensity", "inputRadius"]
//        Box Blur:         ["inputImage", "inputRadius"]
    
        let inputKeys = currentFilter.inputKeys
        
        // slider 1
        if inputKeys[1] == kCIInputIntensityKey { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys[1] == kCIInputRadiusKey { currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey) }
        if inputKeys[1] == kCIInputScaleKey { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }
        
        // slider 2
        if inputKeys.count > 2 {
            if inputKeys[2] == kCIInputIntensityKey { currentFilter.setValue(filterIntensity2, forKey: kCIInputIntensityKey) }
            if inputKeys[2] == kCIInputRadiusKey { currentFilter.setValue(filterIntensity2, forKey: kCIInputRadiusKey) }
            if inputKeys[2] == kCIInputScaleKey { currentFilter.setValue(filterIntensity2 * 10, forKey: kCIInputScaleKey) }
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImage)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
