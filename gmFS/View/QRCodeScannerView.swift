//
//  QRCodeScannerView.swift
//  gmFS
//
//  Created by jincaitian on 2022/2/19.
//

import SwiftUI
import CodeScanner

struct QRCodeScannerView: View {
    @State private var isPresentingScanner = false
    @State private var scannedCode:String?
    var body: some View {
        VStack(spacing: 10) {
                    if let code = scannedCode {
                        Text(code)
                    }
                    Button("Scan Code") {
                        isPresentingScanner = true
                    }
                    Text("Scan a QR code to begin")
                }
                .sheet(isPresented: $isPresentingScanner) {
                    CodeScannerView(codeTypes: [.qr]) { response in
                        if case let .success(result) = response {
                            scannedCode = result.string
                            isPresentingScanner = false
                        }
                    }
                }
    }
}

struct QRCodeScannerView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeScannerView()
    }
}
