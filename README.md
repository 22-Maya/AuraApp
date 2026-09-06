# AuraApp

A minimalist iOS journaling app that uses on-device sentiment analysis to help users understand their emotional patterns privately and simply.

<p align="center">
  <img alt="Swift" src="https://img.shields.io/badge/Swift-5.9-orange?logo=swift&logoColor=white">
  <img alt="Platform" src="https://img.shields.io/badge/Platform-iOS%2017%2B-blue?logo=apple&logoColor=white">
  <img alt="Xcode" src="https://img.shields.io/badge/Xcode-15%2B-1575F9?logo=xcode&logoColor=white">
  <img alt="License" src="https://img.shields.io/badge/License-MIT-green.svg">
</p>

---

## Features

- **Simple Journaling** — A clean, distraction-free space to log thoughts and emotions with no character limits or friction.
- **On-Device Sentiment Analysis** — Every entry is automatically classified as positive, negative, or neutral using Apple's Natural Language framework, with no network calls or third-party APIs involved.
- **Mood Visualization** *(in progress)* — Upcoming trend charts and summaries to help users identify emotional patterns over time.
- **Privacy by Design** — All journal data is stored locally via SwiftData; nothing leaves the device.
- **Minimalist SwiftUI Interface** — A calm, intuitive UI built entirely in SwiftUI, designed to make daily reflection straightforward.

## Requirements

| Requirement | Version |
|---|---|
| iOS | 17.0+ |
| Xcode | 15.0+ |
| Swift | 5.9+ |

AuraApp relies on SwiftData, which requires iOS 17 and Xcode 15 or later. Supporting earlier OS versions would require replacing the persistence layer with Core Data.

## Installation

AuraApp is distributed as a standalone Xcode project rather than a library, so the primary way to get started is to clone and build it directly.

### Clone the repository

```bash
git clone https://github.com/22-Maya/AuraApp.git
cd AuraApp
open Aura.xcodeproj
```

Select a simulator or device in Xcode and run the project (`⌘R`).

### Swift Package Manager (for reusing components)

To pull individual Aura components, such as the sentiment-analysis logic, into another project as a local package, add it as a package dependency in Xcode:

Select the `AuraApp` directory, then import the relevant module:

```swift
import Aura
```

## Usage

AuraApp is a self-contained app, so usage primarily consists of building and running it. The core app entry point looks like this:

```swift
import SwiftUI
import SwiftData

@main
struct AuraApp: App {
    var body: some Scene {
        WindowGroup {
            JournalListView()
        }
        .modelContainer(for: JournalEntry.self)
    }
}
```

Analyzing a journal entry's sentiment on-device:

```swift
import NaturalLanguage

func analyzeSentiment(for text: String) -> Double {
    let tagger = NLTagger(tagSchemes: [.sentimentScore])
    tagger.string = text

    let (sentiment, _) = tagger.tag(at: text.startIndex, unit: .paragraph, scheme: .sentimentScore)
    return Double(sentiment?.rawValue ?? "0") ?? 0.0
}
```

The returned score ranges from -1.0 (very negative) to 1.0 (very positive), which Aura uses to tag and later visualize each entry.

## Contributing

This project is maintained as a personal and academic effort.

## License

This project is licensed under the MIT License.

---
<p align="center">Designed and developed by Maya Itskovich</p>
