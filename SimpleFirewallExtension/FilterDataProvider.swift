/*
See LICENSE folder for this sample’s licensing information.

Abstract:
This file contains the implementation of the NEFilterDataProvider sub-class.
*/

import NetworkExtension
import os.log

/**
    The FilterDataProvider class handles connections that match the installed rules by prompting
    the user to allow or deny the connections.
 */
class FilterDataProvider: NEFilterDataProvider {


    // MARK: NEFilterDataProvider

    override func startFilter(completionHandler: @escaping (Error?) -> Void) {
           let filterSettings = NEFilterSettings(rules: [NEFilterRule(networkRule: NENetworkRule(
               remoteNetwork: nil,
               remotePrefix: 0,
               localNetwork: nil,
               localPrefix: 0,
               protocol: .any,
               direction: .outbound
           ), action: .filterData)], defaultAction: .allow)
           apply(filterSettings) { error in
               if let applyError = error {
                   os_log("Failed to apply filter settings: %@", applyError.localizedDescription)
               }
               completionHandler(error)
           }
       }
    
    override func stopFilter(with reason: NEProviderStopReason, completionHandler: @escaping () -> Void) {

        completionHandler()
    }
    
    override func handleNewFlow(_ flow: NEFilterFlow) -> NEFilterNewFlowVerdict {
   
        guard let socketFlow = flow as? NEFilterSocketFlow,
              let remoteEndpoint = socketFlow.remoteEndpoint,
              let url = socketFlow.url
                else {
                    return .allow()
                }
        
        NSLog("socket url \(url)")
        NSLog("socket remote \(remoteEndpoint)")

        

        
        return .allow()
    }
}
