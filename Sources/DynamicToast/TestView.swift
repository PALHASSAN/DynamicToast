import SwiftUI
import PhosphorSwift

struct TestView: View {
    var body: some View {
        NavigationStack {
            List {
                Button("Show Toast") {
                    ToastNotification.make()
                        .title("Created successfully!")
                        .body("KhatmaCreated")
                        .success()
                        .send()
                }
                
                Button("Show Phosphor Toast") {
                    ToastNotification.make()
                        .title("تم التحديث")
                        .body("تم مزامنة البيانات بنجاح")
//                        .phosphorIcon(.cloudCheck)
                        .send()
                }
            }
            .navigationTitle("Dynamic Island Toast")
        }
        .withDynamicToastContainer()
    }
}

#Preview {
    TestView()
}
