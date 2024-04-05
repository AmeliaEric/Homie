import FirebaseFirestoreSwift
import SwiftUI

struct TaskTesterView: View {
    @StateObject var viewModel: EventViewViewModel
    @FirestoreQuery var items: [EventItem]
    
    init(userId: String) {
        self._items = FirestoreQuery(
            collectionPath: "users/\(userId)/events"
        )
        self._viewModel = StateObject(
            wrappedValue: EventViewViewModel(userId: userId)
        )
    }

    var body: some View {
        // Display a list of TasksRowView for today's date
        List(items.filter { Calendar.current.isDate(Date(timeIntervalSince1970: $0.date), inSameDayAs: Date()) }) { task in
            TasksRowView(item: task)
        }
    }
}

struct TaskTesterView_Previews: PreviewProvider {
    static var previews: some View {
        TaskTesterView(userId: "yxnQ6iEu7QcsVGm55y4uXifJG6F2") // Pass your user ID here
    }
}
