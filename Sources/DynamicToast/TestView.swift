import SwiftUI
import PhosphorSwift

struct TestView: View {
    var body: some View {
        NavigationStack {
            List {
                Button("Show Toast") {
                    ToastNotification.make()
                        .title("تم إنشاء ختمة بنجاح!")
                        .body("تم إنشاء ختمة")
                        .icon(Ph.checkFat.duotone)
                        .duration(10)
                        .send()
                }
                
                Button("Show Phosphor Toast") {
                    ToastNotification.make()
                        .title("تم الحذف بنجاح")
                        .icon(Ph.trash.duotone)
                        .send()
                }
            }
            .navigationTitle("Dynamic Island Toast")
        }
    }
}

#Preview {
    TestView()
}
