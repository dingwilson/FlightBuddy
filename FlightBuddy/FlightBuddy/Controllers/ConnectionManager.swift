//
//  ConnectionManager.swift
//  FlightBuddy
//
//  Created by Wilson Ding on 1/27/18.
//  Copyright © 2018 Wilson Ding. All rights reserved.
//

import Foundation
import PeerKit
import MultipeerConnectivity

protocol MPCSerializable {
    var mpcSerialized: Data { get }
    init(mpcSerialized: Data)
}

enum Event: String {
    case order, ping
}

struct ConnectionManager {

    // MARK: Properties
    fileprivate static var peers: [MCPeerID] {
        return PeerKit.session?.connectedPeers as [MCPeerID]? ?? []
    }

    static var otherUsers: [User] {
        return peers.map { User(peer: $0) }
    }

    static var allUsers: [User] { return [User.getMe()] + otherUsers }

    // MARK: Start
    static func start(flightNumber: String) {
        PeerKit.transceive(serviceType: flightNumber)
    }

    // MARK: Event Handling
    static func onConnect(_ run: PeerBlock?) {
        PeerKit.onConnect = run
    }

    static func onDisconnect(_ run: PeerBlock?) {
        PeerKit.onDisconnect = run
    }

    static func onEvent(_ event: Event, run: ObjectBlock?) {
        if let run = run {
            PeerKit.eventBlocks[event.rawValue] = run
        } else {
            PeerKit.eventBlocks.removeValue(forKey: event.rawValue)
        }
    }

    // MARK: Sending
    static func sendEvent(_ event: Event, object: [String: MPCSerializable]? = nil,
                          toPeers peers: [MCPeerID]? = PeerKit.session?.connectedPeers) {
        var anyObject: [String: Data]?
        if let object = object {
            anyObject = [String: Data]()
            for (key, value) in object {
                anyObject![key] = value.mpcSerialized
            }
        }
        PeerKit.sendEvent(event.rawValue, object: anyObject as AnyObject, toPeers: peers)
    }

    static func sendEventForEach(_ event: Event, objectBlock: () -> ([String: MPCSerializable])) {
        for peer in ConnectionManager.peers {
            ConnectionManager.sendEvent(event, object: objectBlock(), toPeers: [peer])
        }
    }
}
