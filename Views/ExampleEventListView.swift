//
//  EventListView.swift
//  ToDoList
//
//  Created by Amelia Eric-Markovic on 2024-03-11.
//
import FirebaseFirestoreSwift
import SwiftUI

struct ExampleEventListView: View {
    @StateObject var viewModel: EventViewViewModel
    //@Binding var events: [EventItem]
    @State private var currentDate = Calendar.current.startOfDay(for: Date())
    @State private var weekSlider: [[Date.WeekDay]] = []
    @State private var currentWeekIndex: Int = 1
    @State private var createWeek: Bool = false
    @FirestoreQuery var items: [EventItem]
    @Namespace private var animation
    
    
    init(userId: String) {
        self._items = FirestoreQuery(
            collectionPath: "users/\(userId)/events"
        )
        self._viewModel = StateObject(
            wrappedValue: EventViewViewModel(userId: userId)
        )
    }

    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HeaderView()
            ScrollView(.vertical) {
                VStack{
                    //Tasks View
                    Text("HELLO WORLD")
                    TasksView()
                    Text("HELLO WORLD")
                }
                .hSpacing(.center)
                .vSpacing(.center)
                
            }
            //.scrollIndicators(.hidden)
        }
        //.vSpacing(.top)
        .onAppear(perform: {
            if weekSlider.isEmpty {
                let currentWeek = Date().fetchWeek()
                
                if let firstDate = currentWeek.first?.date {
                    weekSlider.append(firstDate.createPreviousWeek())
                }
                
                weekSlider.append(currentWeek)
                
                if let lastDate = currentWeek.last?.date {
                    weekSlider.append(lastDate.createNextWeek())
                }
            }
        })
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        VStack(alignment: .leading, spacing: 6){
            HStack(spacing: 5) {
                Text(currentDate.format("MMMM"))
                    .foregroundStyle(Color("AccentColor"))
                Text(currentDate.format("YYYY"))
                    .foregroundStyle(.gray)
            }
            .titleStyle()
            Text(currentDate.formatted(date: .complete, time: .omitted))
                .font(.callout)
                .foregroundColor(.gray)
                .fontWeight(.semibold)
                .captionStyle()
            
            TabView(selection: $currentWeekIndex) {
                ForEach(weekSlider.indices, id: \.self) { index in
                    let week = weekSlider[index]
                    WeekView(week)
                        .padding(.horizontal, 15)
                        .tag(index)
                }
            }
            .padding(.horizontal, -15)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 90)
        }
        .padding(15)
        .hSpacing(.leading)
        .overlay(alignment: .topTrailing, content: {
            Button(action: {viewModel.showingEventCreationView = true}, label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .foregroundColor(Color("AccentColor"))
                    .frame(width: 30, height: 30) // Set the desired dimensions
            })
            .aspectRatio(contentMode: .fill)
            .padding(30)
        })
        .background(.white)
        .onChange(of: currentWeekIndex) { newValue in
            if newValue == 0 || newValue == (weekSlider.count - 1) {
                createWeek = true
                print("createWeek set to true")
            }
            print("currentWeekIndex changed to \(newValue)")
        }

        .sheet(isPresented: $viewModel.showingEventCreationView) {
                    // Replace NewEventView() with EventCreationView()
                    EventCreationView(newItemPresented: $viewModel.showingEventCreationView)
        }
    }
    
    @ViewBuilder
    func WeekView(_ week: [Date.WeekDay]) -> some View {
        HStack(spacing: 0){
            ForEach(week) { day in
                VStack(spacing: 8) {
                    Text(day.date.format("E"))
                        .font(.callout)
                        .bodyStyle()
                        .foregroundColor(isSameDate(day.date, currentDate) ? .white : Color("SecondTitle"))
                    
                    Text(day.date.format("dd"))
                        .font(.callout)
                        .captionStyle()
                        .foregroundColor(isSameDate(day.date, currentDate) ? .white : Color("SecondTitle"))
                        .frame(width: 45, height: 35)
                        
                }
                .background {
                    if isSameDate(day.date, currentDate) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("AccentColor"))
                    }
                    
                    if day.date.isToday {
                        Circle()
                            .fill(Color("AccentColor"))
                            .frame(width: 5, height: 5)
                            .vSpacing(.bottom)
                            .offset(y: 12)
                    }
                }
                .hSpacing(.center)
                //.contentShape(.rect)
                .onTapGesture {
                    withAnimation() {
                        currentDate = day.date
                        print("currentDate updated to \(currentDate)")
                    }
                }

            }
        }
        .background {
            GeometryReader {
                let minX = $0.frame(in: .global).minX
                
                Color.clear
                    .preference(key: OffsetKey.self, value: minX)
                    .onPreferenceChange(OffsetKey.self) { value in
                        if value.rounded() == 15 && createWeek {
                            print("Generate")
                            paginateWeek()
                            createWeek = false
                        }
                    }
            }
        }
    }
    
    ///Tasks View
    @ViewBuilder
    func TasksView() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            ForEach(items.filter { isSameDate(Date(timeIntervalSince1970: $0.date), currentDate) }) { item in
                TasksRowView(item: item)
                    .background(alignment: .leading) {
                        if items.last?.id != item.id {
                            Rectangle()
                                .frame(width: 1)
                                .offset(x: 8)
                                .padding(.bottom, -35)
                        }
                    }
            }

        }
        //.padding([.verticle, .leading], 15)
        //.padding([.top], 15)
    }
    
    
    func paginateWeek() {
        print("Paginating week...")
        print(currentDate)
        
        if weekSlider.indices.contains(currentWeekIndex) {
            if let firstDate = weekSlider[currentWeekIndex].first?.date, currentWeekIndex == 0 {
                weekSlider.insert(firstDate.createPreviousWeek(), at: 0)
                weekSlider.removeLast()
                currentWeekIndex = 1
                print("Inserted first date of previous week")
            }
            
            if let lastDate = weekSlider[currentWeekIndex].last?.date, currentWeekIndex == (weekSlider.count - 1) {
                weekSlider.append(lastDate.createNextWeek())
                weekSlider.removeFirst()
                currentWeekIndex = weekSlider.count - 2
                print("Appended last date of next week")
            }
        } else {
            print("currentWeekIndex is out of bounds")
        }
        
        print("Current weekSlider count: \(weekSlider.count)")
        
        // Ensure proper view update
        DispatchQueue.main.async {
            createWeek.toggle()
            print("createWeek toggled: \(createWeek)")
        }
    }

}


struct ExampleEventListView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleEventListView(userId: "yxnQ6iEu7QcsVGm55y4uXifJG6F2")
    }
}
