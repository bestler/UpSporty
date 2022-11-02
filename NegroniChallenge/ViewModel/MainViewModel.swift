//
//  MainViewModel.swift
//  NegroniChallenge
//
//  Created by Nicola Rigoni on 25/10/22.
//

import CoreData
import Combine
import SwiftUI

enum TrainingType: String, CaseIterable {
    case exercise = "Exercise"
    case assestment = "Assestment"
}

class MainViewModel: ObservableObject {
    let manager = CoreDataManager.instance
    
    @Published var test: String = "Connected"
    
    @Published var allSports: [SportModel] = SportModel.allSports
    
    //MARK: AddNewGoal
    @Published var selectedSport: Int16 = 0
    @Published var dueDate: Date = Date()
    @Published var target: String = ""
    @Published var selectedHourPicker: Int = 0
    @Published var selectedMinutePicker: Int = 0
    @Published var selectedSecondPicker: Int = 0
    @Published var selectedMilliSecondPicker: Int = 0
    
    //MARK: Goals
    @Published var allGoals: [GoalEntity] = []
    
    //MARK: Training sheet
    @Published var selectedTrainingInSheet : TrainingEntity? = nil
    @Published var trainingDueDate: Date = Date()
    @Published var trainingTarget : String = ""
    @Published var trainingType : TrainingType = .exercise
    @Published var trainingRepCount : Int = 1
    @Published var traininingSheetUpdatedTrainings: [TrainingEntity] = []
    @Published var currentTrainingSheet: [TrainingEntity] = []
    @Published var newTrainingStep: [TrainingEntity] = []
    @Published var deletedTrainings: [TrainingEntity] = []
    @Published var currentResultTraining: [TrainingResultEntity] = []
    
    //MARK: Today section
    @Published var todayTrainingSheet: [TrainingEntity] = []
    @Published var todayGoals: [GoalEntity] = []
    @Published var selectedToday: GoalEntity? = nil
    @Published var goalToShow: GoalEntity? = nil
    @Published var selectedResultsToday: [TrainingResultEntity] = []
    @Published var todayResultFilter: PresentationDetent = .medium
    @Published var selectedTraining: TrainingEntity? = nil
    @Published var resultsToday: [TrainingResultEntity] = []
    @Published var temporaryMillisecods: Int64 = 0
    @Published var update: Bool = false
    
    
    //MARK: Combine
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: Charts
    @Published var assesmentsChartData : [TrainingsPerDay] = []
    @Published var exercisesChartData : [TrainingsPerDay] = []
    @Published var chartData : [TrainingsPerDay] = []
    
    //MARK: Results
    @Published var results: [String:[GoalEntity]] = [:]
    
    
    init() {
        getGoals()
        
        $selectedToday
            .combineLatest($todayGoals)
            .map(filterToday)
            .sink { [weak self] goal in
                self?.goalToShow = goal
                self?.getTodayTrainingFromTodayGoal(for: goal)
            }
            .store(in: &cancellables)
        
        $resultsToday
            .combineLatest($todayResultFilter, $update)
            .map(filterResultToday)
            .sink { [weak self] results in
                print("filter \(self?.todayResultFilter == .medium ? "medium" : "full")")
                self?.selectedResultsToday = results
            }
            .store(in: &cancellables)
    }
    
    func checkSportSelection() -> Bool {
        guard selectedSport != 0 else { return false }
        return true
    }
    
    func saveNewGoal() {
        addGoal()
        saveGoal()
        cleanNewGoalSetup()
    }
    
    private func addGoal() {
        guard selectedSport != 0 else { return }
        let newGoal = GoalEntity(context: manager.context)
        newGoal.id = UUID()
        newGoal.dueDate = dueDate
        newGoal.isCompleted = false
        newGoal.sportID = selectedSport
        guard let target = Double(target) else { return }
        newGoal.target = target
        newGoal.createDate = Date()
        newGoal.targetTime = calculateMilliseconds(hour: selectedHourPicker, minute: selectedMinutePicker, second: selectedSecondPicker, millisecond: selectedMilliSecondPicker)
    }
    //TODO: complete
    func calculateMilliseconds(hour: Int, minute: Int, second: Int, millisecond: Int) -> Int64 {
        return Int64((hour * 3600000) + (minute * 60000) + (second * 1000) + millisecond)
    }
    
    //TODO: complete
    private func cleanNewGoalSetup() {
        
    }
    
    private func getGoals() {
        let request = NSFetchRequest<GoalEntity>(entityName: "GoalEntity")
        
        let sort = NSSortDescriptor(keyPath: \GoalEntity.dueDate, ascending: true)
        request.sortDescriptors = [sort]
        
        let filter = NSPredicate(format: "isCompleted == false")
        request.predicate = filter
        
        do {
            allGoals = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching coredata: \(error.localizedDescription)")
        }
    }
    
    func deleteGoal(goal: GoalEntity) {
        manager.context.delete(goal)
        getGoals()
    }
    
    func saveTraining(selectedGoal: GoalEntity) {
        
        //Updated Trainings will be deleted and recreated
        deletedTrainings.append(contentsOf: traininingSheetUpdatedTrainings)
        newTrainingStep.append(contentsOf: traininingSheetUpdatedTrainings)
        
        //New created trainings
        for step in newTrainingStep {
            selectedGoal.addToTrainings(step)
                for repetition in 0..<step.repeatCountTotal {
                    print("dentro a for")
                    step.addToResults(createResult(number: repetition + 1))
                }
        }
        
        // Deleted Trainigs
        for deletedTraining in deletedTrainings {
            selectedGoal.removeFromTrainings(deletedTraining)
        }

        
        //TODO: update current training sheet
        saveTraining(goal: selectedGoal)
    }
    
    func saveNewTrainingStep() {
        
        let newTraining = TrainingEntity(context: manager.context)
        newTraining.id = UUID()
        if trainingType == .exercise {
            newTraining.isExcercise = true
            newTraining.target = Int16(trainingTarget) ?? 0
        }
        newTraining.repeatCountTotal = Int16(trainingRepCount)
        newTraining.dueDate = trainingDueDate
        newTraining.repeatCountActual = 0
        currentTrainingSheet.append(newTraining) //TODO: sorting
        newTrainingStep.append(newTraining)
        let currentTrainingSheet = currentTrainingSheet.sorted(by: { $0.dueDate?.compare($1.dueDate!) == .orderedAscending })
        self.currentTrainingSheet = currentTrainingSheet
        cleanNewTrainingSetup()
    }
    
    func deleteTrainingFromSheet(at offsets : IndexSet ){
        for index in offsets {
            let removedTraining = currentTrainingSheet.remove(at: index)
            deletedTrainings.append(removedTraining)
        }
    }
    
    func updateTrainingFromSheet(){
        if let training = selectedTraining {
            traininingSheetUpdatedTrainings.append(training)
            let index = currentTrainingSheet.firstIndex(of: training)
            if let index = index {
                currentTrainingSheet.remove(at: index)
            }
        }
    }
    
    private func createResult(number: Int16) -> TrainingResultEntity {
        let newResult = TrainingResultEntity(context: manager.context)
        newResult.id = UUID()
        newResult.number = number
        newResult.result = 0
        return newResult
    }
    
    
    //TODO: complete
    private func cleanNewTrainingSetup() {
        selectedTraining = nil
        trainingDueDate = Date()
        trainingTarget = ""
        trainingType = .exercise
        trainingRepCount = 1
    }
    
    func cancelTrainingSheet(for goal : GoalEntity){
        getTrainingSheet(for: goal)
        cleanNewTrainingSetup()
    }
    
    func getTrainingSheet(for goal: GoalEntity) {
        let request = NSFetchRequest<TrainingEntity>(entityName: "TrainingEntity")
        let filter = NSPredicate(format: "goal == %@", goal)
        request.predicate = filter
        
        let sort = NSSortDescriptor(keyPath: \TrainingEntity.dueDate, ascending: true)
        request.sortDescriptors = [sort]
        
        print("get training sheet for \(goal.sportID)")
        do {
            currentTrainingSheet = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching coredata: \(error.localizedDescription)")
        }
    }
    
    func getResult(for training: TrainingEntity) {
        let request = NSFetchRequest<TrainingResultEntity>(entityName: "TrainingResultEntity")
        let filter = NSPredicate(format: "training == %@", training)
        request.predicate = filter
        
        let sort = NSSortDescriptor(keyPath: \TrainingResultEntity.number, ascending: true)
        request.sortDescriptors = [sort]
        
        
        do {
            currentResultTraining = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching coredata: \(error.localizedDescription)")
        }
    }
    

    func getTrainingsPerDay(for goal: GoalEntity){
        //TODO: Maybe show only completed
        let request = NSFetchRequest<TrainingEntity>(entityName: "TrainingEntity")
        let filter = NSPredicate(format: "goal == %@", goal)
        request.predicate = filter
        
        let sort = NSSortDescriptor(keyPath: \TrainingEntity.dueDate, ascending: true)
        request.sortDescriptors = [sort]
        
        var trainings: [TrainingEntity] = []
        
        do {
            trainings = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching coredata: \(error.localizedDescription)")
        }
        
        assesmentsChartData = [
            TrainingsPerDay(day: "Monday", trainingType: .assestment),
            TrainingsPerDay(day: "Tuesday", trainingType: .assestment),
            TrainingsPerDay(day: "Wednesday", trainingType: .assestment),
            TrainingsPerDay(day: "Thursday", trainingType: .assestment),
            TrainingsPerDay(day: "Friday", trainingType: .assestment),
            TrainingsPerDay(day: "Saturday", trainingType: .assestment),
            TrainingsPerDay(day: "Sunday", trainingType: .assestment),
        ]
        
        exercisesChartData = [
            TrainingsPerDay(day: "Monday", trainingType: .exercise),
            TrainingsPerDay(day: "Tuesday", trainingType: .exercise),
            TrainingsPerDay(day: "Wednesday", trainingType: .exercise),
            TrainingsPerDay(day: "Thursday", trainingType: .exercise),
            TrainingsPerDay(day: "Friday", trainingType: .exercise),
            TrainingsPerDay(day: "Saturday", trainingType: .exercise),
            TrainingsPerDay(day: "Sunday", trainingType: .exercise),
        ]
        
        for training in trainings {
            if let date = training.dueDate {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "EEEE"
                dateFormatter.locale = Locale(identifier: "en_US")
                let dayOfTheWeek = dateFormatter.string(from: date)
                if training.isExcercise {
                    if let i = exercisesChartData.firstIndex(where: {$0.day == dayOfTheWeek}){
                        exercisesChartData[i].count += 1
                    }
                }else {
                    if let i = assesmentsChartData.firstIndex(where: {$0.day == dayOfTheWeek}){
                        assesmentsChartData[i].count += 1
                    }
                }
            }
        }
        chartData = assesmentsChartData + exercisesChartData
    }

    func updateResult(resultNumber: Int16, newResult: Int64, onSave: Bool) {
        let resultNumber = onSave ? resultNumber : resultNumber - 1
        if let index = selectedResultsToday.firstIndex(where: { $0.number == resultNumber }) {
            selectedResultsToday[index].result = Int64(newResult)
            print("training result: \(selectedResultsToday[index].result)")
            print("training array result: \(selectedResultsToday)")
            update.toggle()
        }
    }
    
    
    
    func saveResults(training: TrainingEntity, goal: GoalEntity) {
        print("selected \(selectedResultsToday)")
        training.repeatCountActual = 0
        for result in resultsToday {
            print("result in for \(result)")
            if result.result != 0 {
                training.repeatCountActual += 1
                print("numbeer count: \(training.repeatCountActual)")
            }
        }
        
        if training.repeatCountActual == training.repeatCountTotal {
            training.isCompleted = true
        }
        if !training.isExcercise, resultsToday[0].result <= goal.targetTime {
            goal.isCompleted = true
        }
        saveResult()
        getTodayGoals()
        allGoals.removeAll()
        self.getGoals()
    }
    
    private func saveGoal() {
        allGoals.removeAll()
        todayGoals.removeAll()
        todayTrainingSheet.removeAll()
        
        self.manager.save()
        self.getGoals()
        self.getTodayGoals()
    }
    
    func getTodayGoals() {
        print("getTodayGoals")
        selectedToday = nil
        let request = NSFetchRequest<GoalEntity>(entityName: "GoalEntity")
        
        let sort = NSSortDescriptor(keyPath: \GoalEntity.dueDate, ascending: true)
         request.sortDescriptors = [sort]
        
        let dateFrom = Calendar.current.startOfDay(for: Date())
        if let dateTo = Calendar.current.date(byAdding: .day, value: 1, to: dateFrom) {
            let fromFilter = NSPredicate(format: "trainings.dueDate >= %@", dateFrom as CVarArg) //ANY
            let toFilter = NSPredicate(format: "trainings.dueDate < %@", dateTo as CVarArg)
            let filter = NSCompoundPredicate(andPredicateWithSubpredicates: [fromFilter, toFilter])
            request.predicate = filter
            
            let filterGoal = NSPredicate(format: "isCompleted == false")
            request.predicate = filterGoal
            
            do {
                todayGoals = try manager.context.fetch(request)
                print("todayGoals: \(todayGoals)")
                selectedToday = todayGoals.first
            } catch let error {
                print("Error fetching coredata: \(error.localizedDescription)")
            }
        }
    }
    
    
    /*
     func getTodayGoals() {
         print("getTodayGoals")
         selectedToday = nil
         let request = NSFetchRequest<GoalEntity>(entityName: "GoalEntity")
         
         let sort = NSSortDescriptor(keyPath: \GoalEntity.dueDate, ascending: true)
          request.sortDescriptors = [sort]
         
         let dateFrom = Calendar.current.startOfDay(for: Date())
         if let dateTo = Calendar.current.date(byAdding: .day, value: 1, to: dateFrom) {
             let fromFilter = NSPredicate(format: "trainings.dueDate >= %@", dateFrom as CVarArg) //ANY
             let toFilter = NSPredicate(format: "trainings.dueDate < %@", dateTo as CVarArg)
             let filter = NSCompoundPredicate(andPredicateWithSubpredicates: [fromFilter, toFilter])
             //request.predicate = filter
             
             let filterGoal = NSPredicate(format: "isCompleted == false")
             request.predicate = filterGoal
             
             do {
                 todayGoals = try manager.context.fetch(request)
                 print("todayGoals: \(todayGoals)")
                 selectedToday = todayGoals.first
             } catch let error {
                 print("Error fetching coredata: \(error.localizedDescription)")
             }
         }
     }
     */
    
    private func getTodayTrainingFromTodayGoal(for todayGoal: GoalEntity?) {
        let request = NSFetchRequest<TrainingEntity>(entityName: "TrainingEntity")
        if let goal = todayGoal {
            let dateFrom = Calendar.current.startOfDay(for: Date())
            if let dateTo = Calendar.current.date(byAdding: .day, value: 1, to: dateFrom) {
                let filterGoal = NSPredicate(format: "goal == %@", goal)
                let fromFilter = NSPredicate(format: "ANY dueDate >= %@", dateFrom as CVarArg)
                let toFilter = NSPredicate(format: "ANY dueDate < %@", dateTo as CVarArg)
                let filter = NSCompoundPredicate(andPredicateWithSubpredicates: [filterGoal, fromFilter, toFilter])
                request.predicate = filter
                
                let sort = NSSortDescriptor(keyPath: \TrainingEntity.dueDate, ascending: true)
                request.sortDescriptors = [sort]
                
                do {
                    todayTrainingSheet = try manager.context.fetch(request)
                } catch let error {
                    print("Error fetching coredata: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func filterToday(selectedGoal: GoalEntity?, todayGoals: [GoalEntity]) -> GoalEntity? {
        if let selectedGoal = selectedGoal {
            return todayGoals.first(where: { $0.id == selectedGoal.id })
        }
        return todayGoals.first
    }
    
    func getResultFromTodayTraining(for training: TrainingEntity) {
        let request = NSFetchRequest<TrainingResultEntity>(entityName: "TrainingResultEntity")
        let filter = NSPredicate(format: "training == %@", training)
        request.predicate = filter
        
        let sort = NSSortDescriptor(keyPath: \TrainingResultEntity.number, ascending: true)
        request.sortDescriptors = [sort]
        
        
        do {
            resultsToday = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching coredata: \(error.localizedDescription)")
        }
    }
    
    private func filterResultToday(results: [TrainingResultEntity], filter: PresentationDetent, update: Bool) -> [TrainingResultEntity] {
        print("inside filterResultToday")
        if filter == .medium {
            if let result = results.first(where: { $0.result == 0 }) {
                print("filter today medium result: \(result)")
                return [result]
            }
        }
        print("filter today full")
        return results.filter( { $0.result == 0 } )
    }
    
    func getGoalResults() {
        
        let request = NSFetchRequest<GoalEntity>(entityName: "GoalEntity")
        
        let sort = NSSortDescriptor(keyPath: \GoalEntity.dueDate, ascending: true)
        request.sortDescriptors = [sort]
        
        let filter = NSPredicate(format: "isCompleted == true")
        request.predicate = filter
        
        do {
            let allGoals = try manager.context.fetch(request)
            print("allGoals \(allGoals)")
            createGoalsPerYear(goals: allGoals)
        } catch let error {
            print("Error fetching coredata: \(error.localizedDescription)")
        }
    }
    
    private func createGoalsPerYear(goals: [GoalEntity]) {
        results = [:]
        var year: String = ""
        for goal in goals {
            let yearGoal = Calendar.current.component(.year, from: goal.dueDate!)
            if year != String(yearGoal) {
                year = String(yearGoal)
            }
            if results[year] == nil {
                results[year] = []
            }
            results[year]?.append(goal)
            
        }
        print("results: \(results)")
    }
 
    private func saveTraining(goal: GoalEntity) {
        currentTrainingSheet.removeAll()
        newTrainingStep.removeAll()
        deletedTrainings.removeAll()
        self.manager.save()
        self.getTrainingSheet(for: goal)
    }
    
    private func saveResult() {
        self.manager.save()
    }
    
    func resetContext() {
        self.manager.reset()
        getTodayGoals()
        getGoals()
    }
    
    //Progess-Bar
    
    func calculateChallengeProgress(dueDate: Date, createdDate: Date) -> CGFloat{
        let totalDays = Double(Calendar.current.numberOfDaysBetween(dueDate, and: createdDate))
        let daysLeft = Double(Calendar.current.numberOfDaysBetween(dueDate, and: Date()))
        let percentage = 100 - ((daysLeft / totalDays) * 100)
        if percentage < 0.0 {
            return CGFloat(0.0)
        }else {
            return CGFloat(percentage)
        }
        
    }
    
    func getAssesmentsResult(for goal: GoalEntity) -> [AssesmentResult]{
        let request = NSFetchRequest<TrainingEntity>(entityName: "TrainingEntity")
        let filter = NSPredicate(format: "goal == %@", goal)
        request.predicate = filter
        
        let sort = NSSortDescriptor(keyPath: \TrainingEntity.dueDate, ascending: true)
        request.sortDescriptors = [sort]
        
        var allTrainings : [TrainingEntity] = []
       
        do {
            allTrainings = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching coredata: \(error.localizedDescription)")
        }
        
        var performanceChartData : [AssesmentResult] = []
        
        print(allTrainings.count)
        
        for training in allTrainings {
            if training.isExcercise == false {
                guard let results = training.results?.allObjects as? [TrainingResultEntity] else {
                    return []
                }
                if let dueDate = training.dueDate {
                    if results[0].result != 0 {
                        performanceChartData.append(AssesmentResult(date: dueDate, result: results[0].result, goal: goal.targetTime))
                        print(results[0].result.asTimeFormatted())
                    }
                }
                
            }
        }
        
        print(performanceChartData)
        
        return performanceChartData
    }
    
}
