import Foundation
import Observation

@MainActor
@Observable
class CurrentDateListViewModel {
    var currentDates: [CurrentDateViewViewModel] = []
    
    func populateDates() async {
        do {
            let currentDate = try await Webservice().getDate()
            if let currentDate  {
                let currentDateViewModel = CurrentDateViewViewModel(currentDate: currentDate)
                self.currentDates.append(currentDateViewModel)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

