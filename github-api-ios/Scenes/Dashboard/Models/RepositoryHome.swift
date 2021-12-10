import Foundation

struct RepositoryHome {
    let repositoryName: String
    let ownerName: String
    let stargazersCount: Int
    let watchersCount: Int
    let updatedAt: String
    let forksCount: Int

    func getLastUpdatedDay() -> Int {
        let dateFormatter = DateFormatter()
        let calendar = Calendar.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date1 = calendar.startOfDay(for: Date())
        let date2 = dateFormatter.date(from: updatedAt)!
        let components = Calendar.current.dateComponents([.day], from: date2, to: date1).day
        return components!
    }
}
