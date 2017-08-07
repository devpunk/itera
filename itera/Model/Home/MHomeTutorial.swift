import Foundation

extension MHome
{
    func tutorialCheck(projects:[DProjectUser])
    {
        if projects.count > 0
        {
            projectsLoaded(projects:projects)
        }
        else
        {
            addTutorial(projects:projects)
        }
    }
    
    //MARK: private
    
    private func addTutorial(projects:[DProjectUser])
    {
        
    }
}
