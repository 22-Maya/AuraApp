//
//  Scorer.swift
//  Aura
//

import Foundation
import NaturalLanguage

class Scorer {
    private let tagger = NLTagger(tagSchemes: [.sentimentScore])
    private let optimalChunkSize = 150
    
    func score(_ text: String) -> Double {
        guard !text.isEmpty else { return 0 }
        
        // Split long text into manageable chunks
        let chunks = splitTextIntoChunks(text, chunkSize: optimalChunkSize)
        var totalScore = 0.0
        
        // Analyze each chunk separately
        for chunk in chunks {
            let chunkScore = analyzeChunk(chunk)
            totalScore += chunkScore
        }
        
        // Return average score weighted by chunk length
        return (totalScore / Double(chunks.count)).clamped(to: -1.0...1.0)
    }
    
    private func analyzeChunk(_ text: String) -> Double {
        tagger.string = text
        var sentimentScore = 0.0
        
        // Use sentence-level analysis for better accuracy
        tagger.enumerateTags(
            in: text.startIndex..<text.endIndex,
            unit: .sentence,
            scheme: .sentimentScore
        ) { sentimentTag, _ in
            if let sentimentString = sentimentTag?.rawValue {
                sentimentScore += Double(sentimentString) ?? 0
            }
            return true
        }
        
        return sentimentScore.clamped(to: -1.0...1.0)
    }
    
    private func splitTextIntoChunks(_ text: String, chunkSize: Int) -> [String] {
        var chunks: [String] = []
        var currentChunk = ""
        
        // Split by paragraphs first for natural breaks
        let paragraphs = text.components(separatedBy: .newlines)
        
        for paragraph in paragraphs {
            if currentChunk.count + paragraph.count > chunkSize && !currentChunk.isEmpty {
                chunks.append(currentChunk)
                currentChunk = ""
            }
            currentChunk += paragraph + "\n"
        }
        
        if !currentChunk.isEmpty {
            chunks.append(currentChunk)
        }
        
        // If we still have chunks that are too large, force split
        return chunks.flatMap { chunk in
            chunk.count <= chunkSize ? [chunk] : chunk.chunks(ofCount: chunkSize)
        }
    }
}

extension String {
    func chunks(ofCount chunkSize: Int) -> [String] {
        stride(from: 0, to: self.count, by: chunkSize).map {
            let start = self.index(self.startIndex, offsetBy: $0)
            let end = self.index(start, offsetBy: chunkSize, limitedBy: self.endIndex) ?? self.endIndex
            return String(self[start..<end])
        }
    }
}

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        min(max(self, limits.lowerBound), limits.upperBound)
    }
}
