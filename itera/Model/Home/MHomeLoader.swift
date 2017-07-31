import UIKit
import CoreData

extension MHome
{
    func load()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncLoad()
        }
    }
    
    //MARK: private
    
    private func asyncLoad()
    {
        DManager.sharedInstance?.fetch(entity:DProject.self)
        { [weak self] (data:[NSManagedObject]?) in
        
            guard
            
                var projects:[DProject] = data as? [DProject]
            
            else
            {
                return
            }
            
            projects.sort
            { (projectA:DProject, projectB:DProject) in
                
                return projectA.created < projectB.created
            }
            
            self?.projectsLoaded(projects:projects)
        }
    }
    
    private func projectsLoaded(projects:[DProject])
    {
        let shouldUpdate:Bool = shouldUpdateProjects(
            projects:projects)
        
        if shouldUpdate
        {
            updateProjects(projects:projects)
        }
    }
    
    private func updateProjects(projects:[DProject])
    {
        guard
            
            let directory:URL = MSave.projectsDirectory()
            
        else
        {
            return
        }
        
        let dispatchGroup:DispatchGroup = DispatchGroup()
        dispatchGroup.setTarget(
            queue:DispatchQueue.global(
                qos:DispatchQoS.QoSClass.background))
        
        updateProjects(
            projects:projects,
            directory:directory,
            dispatchGroup:dispatchGroup)
    }
    
    private func updateProjects(
        projects:[DProject],
        directory:URL,
        dispatchGroup:DispatchGroup)
    {
        var items:[MHomeItem] = []
        
        for project:DProject in projects
        {
            dispatchGroup.enter()
            
            guard
                
                let item:MHomeItem = loadProject(
                    project:project,
                    directory:directory,
                    dispatchGroup:dispatchGroup)
            
            else
            {
                continue
            }
            
            items.append(item)
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(
            queue:DispatchQueue.global(qos:DispatchQoS.QoSClass.background))
        { [weak self] in
            
            self?.itemsLoaded(items:items)
        }
    }
    
    private func loadProject(
        project:DProject,
        directory:URL,
        dispatchGroup:DispatchGroup) -> MHomeItem?
    {
        guard
            
            let name:String = project.name
            
        else
        {
            dispatchGroup.leave()
            
            return nil
        }
        
        let path:URL = directory.appendingPathComponent(name)
        
        guard
            
            let image:UIImage = loadImage(path:path)
        
        else
        {
            dispatchGroup.leave()
            
            return nil
        }
        
        let item:MHomeItem = MHomeItem(
            project:project,
            path:path,
            image:image)
        
        return item
    }
    
    private func loadImage(path:URL) -> UIImage?
    {
        let data:Data
        
        do
        {
            try data = Data(
                contentsOf:path,
                options:Data.ReadingOptions.uncached)
        }
        catch
        {
            return nil
        }
        
        print("data size: \(data.count)")
        
        guard
            
            let image:UIImage = UIImage(data:data)
            
        else
        {
            return nil
        }
        
        return image
    }
    
    private func shouldUpdateProjects(projects:[DProject]) -> Bool
    {
        let currentMap:[NSManagedObjectID:Int] = currentProjectsMap()
        let map:[NSManagedObjectID:Int] = projectsMap(projects:projects)
        
        for project in projects
        {
            let objectId:NSManagedObjectID = project.objectID
            
            if currentMap[objectId] == nil
            {
                return true
            }
        }
        
        for item in items
        {
            let objectId:NSManagedObjectID = item.project.objectID
            
            if map[objectId] == nil
            {
                return true
            }
        }
        
        return false
    }
    
    private func currentProjectsMap() -> [NSManagedObjectID:Int]
    {
        var map:[NSManagedObjectID:Int] = [:]
        
        for item in items
        {
            let objectId:NSManagedObjectID = item.project.objectID
            map[objectId] = 0
        }
        
        return map
    }
    
    private func projectsMap(projects:[DProject]) -> [NSManagedObjectID:Int]
    {
        var map:[NSManagedObjectID:Int] = [:]
        
        for project in projects
        {
            let objectId:NSManagedObjectID = project.objectID
            map[objectId] = 0
        }
        
        return map
    }
}
