# Class Students Add App 

Made it in Swift and SwiftUI, this is a training applications where I learned the basic concepts about Data Persistence in iOS development using Plist.
<br>
<br>
º Data Persistence with Plist
<br>
º MVVM
<br>
<br>
![Untitled](https://user-images.githubusercontent.com/92945868/215280205-aacabb6c-213e-4f76-bc2e-e3d44b5cf962.gif)

### About the Plist storage
<br>

1. I created a class to create a Plist file

```Swift
class StorageHandler {
    static private var plistURL: URL {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        return documents.appendingPathComponent("students.plist")
    }
}
```
<br>

In this class there's this computed property ULR type, with this procolo its can be change in execution time

```Swift
static private var plistURL: URL {}
```
<br>

This is to find the documents directory inside of the App, the sand box, everything that is added to this sand box, the iOS allow us to change it any time.
```Swift
let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
```
<br>

Here I'm adding a Plist file in the documents directory
```Swift
return documents.appendingPathComponent("students.plist")
```
<br>

2. Now I'm writing in the Plist file
```Swift
static func write(item: Student) {
    if !FileManager.default.fileExists(atPath: plistURL.path) {
        FileManager.default.createFile(atPath: plistURL.path, contents: prepareData([item]), attributes: nil)
        
        print(plistURL.path)
    } else {
        var currentItens = StorageHandler.load()
        currentItens.append(item)
        try? prepareData(currentItens).write(to: plistURL)
    }
}
```
<br>

3. To consulting
```Swift
static func load() -> [Student] {
    let decoder = PropertyListDecoder()
    
    guard let data = try? Data.init(contentsOf: plistURL), let preferences = try? decoder.decode([Student].self, from: data)
        else { return [] }
            
    return preferences
}
```

<br>

4. To delete the Plist file from documents directory   
```Swift
static func deleteAll() {
        
    if FileManager.default.fileExists(atPath: plistURL.path) {
        
        try? FileManager.default.removeItem(at: plistURL)
        
    }
}
```

<br>

5. This method packages data to easely be required and used in a simple way
```Swift
static func prepareData(_ value: [Student]) -> Data {
        
        let encoder = PropertyListEncoder()
        
        guard let data = try? encoder.encode(value) else {
            return Data()
        }
        
        return data
    }
}
```

