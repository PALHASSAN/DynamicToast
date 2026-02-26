import SwiftUI
import PhosphorSwift

struct TestView: View {
    var body: some View {
        NavigationStack {
            List {
                Button("Show Toast") {
                    ToastNotification.make()
                        .title("تم التحديث")
                        .success()
                        .body("تم مزامنة البيانات بنجاح")
                        .send()
                }
                
                Button("Show Phosphor Toast") {
                    ToastNotification.make()
                        .title("تم الحذف بنجاح")
                        .body("تم حذف الملف نهائياً من النظام")
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
