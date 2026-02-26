import SwiftUI
import PhosphorSwift

struct TestView: View {
    var body: some View {
        NavigationStack {
            List {
                Button("Show Toast") {
                    ToastNotification.make()
                        .title("تم إنشاء ختمة بنجاح!")
                        .body(" تم إنشاء ختمة")
                        .icon(Ph.checkFat.duotone)
                        .iconSize(46)
                        .duration(10)
                        .send()
                }
                
                Button("Show Phosphor Toast") {
                    ToastNotification.make()
                        .title("Deleted")
                        .body("Deleted Successfully")
                        .success()
                        .send()
                }
            }
            .navigationTitle("Try Toast")
        }
    }
}

#Preview {
    TestView()
}
