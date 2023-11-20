import Foundation
import MultipeerConnectivity

// Protocolo pra definir funções que outros objetos podem adotar para lidar com eventos de conexão e da mudança de cor
protocol ColorServiceDelegate {
    func connectedDevicesChanged(manager : ColorService, connectedDevices: [String]) // Notifica quando a lista de dispositivos conectados muda
    func colorChanged(manager : ColorService, colorString: String) // Notifica quando a cor é alterada e compartilhada
}

// Classe que lida com a comunicação entre dispositivos
// Cria objetos para publicar/anunciar e procurar outros dispositivos próximos
class ColorService : NSObject {
    
    // Define o tipo de serviço para identificar os pares
    private let ColorServiceType = "example-color"
    private let myPeerId = MCPeerID(displayName: UIDevice.current.name) // Cria um objeto MCPeerID para representar o dispositivo
    private let serviceAdvertiser : MCNearbyServiceAdvertiser // Inicializa o Advertizer para que outros dispositivos possam se encontrar
    private let serviceBrowser : MCNearbyServiceBrowser // Inicializa o browser para encontrar outros dispositivos
    var delegate : ColorServiceDelegate?
    
    // Inicializa uma sessão MCSession que permite a comunicação entre os dispositivos
    lazy var session : MCSession = {
        let session = MCSession(peer: self.myPeerId, securityIdentity: nil, encryptionPreference: .required)
        session.delegate = self
        return session
    }()
    
    // O init configura o advertiser (para compartilhar informações) e o browser (para encontrar outros dispositivos)
    override init() {
       
        // Inicializa o Advertiser com o id de par e o tipo de serviço
        self.serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerId, discoveryInfo: nil, serviceType: ColorServiceType)
        // Inicializa o browser com o id de par e o tipo de serviço
        self.serviceBrowser = MCNearbyServiceBrowser(peer: myPeerId, serviceType: ColorServiceType)

        super.init()
                
                // Configuração dos delegados do advertiser e do browser
                self.serviceAdvertiser.delegate = self
                self.serviceAdvertiser.startAdvertisingPeer()
                self.serviceBrowser.delegate = self
                self.serviceBrowser.startBrowsingForPeers()
            }
            
            // Encerra o advertiser e o browser quando a instância da classe é liberada
            deinit {
                self.serviceAdvertiser.stopAdvertisingPeer()
                self.serviceBrowser.stopBrowsingForPeers()
            }
            // O send é usado para enviar uma string com o nome da cor para outros dispositivos conectados através da sessão
            func send(colorName : String) {
                NSLog("%@", "sendColor: \(colorName) to \(session.connectedPeers.count) peers,\(session.connectedPeers.self)")
                if session.connectedPeers.count > 0 {
                    do {
                        try self.session.send(colorName.data(using: .utf8)!, toPeers: session.connectedPeers, with: .reliable)
                    }
                    catch let error {
                        NSLog("%@", "Error for sending: \(error)")
                    }
                }
            }
        }



// Extensão para lidar com eventos do advertiser
extension ColorService : MCNearbyServiceAdvertiserDelegate {
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        NSLog("%@", "didNotStartAdvertisingPeer: \(error)")
    }
    // Chamado ao receber um convite de outro par e responde aceitando o convite
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        NSLog("%@", "didReceiveInvitationFromPeer \(peerID)")
        invitationHandler(true, self.session)
    }
}

// Extensão para lidar com eventos do browser
extension ColorService : MCNearbyServiceBrowserDelegate {
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        NSLog("%@", "didNotStartBrowsingForPeers: \(error)")
    }
    
    // Chamado quando um dispositivo próximo é encontrado e convida o dispositivo para a sessão
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        NSLog("%@", "foundPeer: \(peerID)")
        NSLog("%@", "invitePeer: \(peerID)")
        browser.invitePeer(peerID, to: self.session, withContext: nil, timeout: 10)
    }
    
    // Chamado quando um dispositivo próximo é perdido ou desconectado da sessão.
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        NSLog("%@", "lostPeer: \(peerID)")
    }
}


// Extensão para lidar com eventos da sessão
extension ColorService : MCSessionDelegate {
    
    // Chamado quando o estado de um dispositivo na sessão muda (conectado ou desconectado) e notifica o delegado sobre a alteração
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        NSLog("%@", "peer \(peerID) didChangeState: \(state.rawValue)")
        self.delegate?.connectedDevicesChanged(manager: self, connectedDevices:
                                                session.connectedPeers.map{$0.displayName})
    }
    
    // Chamado quando dados são recebidos de um dispositivo na sessão, geralmente para compartilhar informações de cor
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        NSLog("%@", "didReceiveData: \(data)")
        let str = String(data: data, encoding: .utf8)!
        self.delegate?.colorChanged(manager: self, colorString: str)
    }
    
    // Outros métodos da sessão que não são usados (recebem arquivos, audio e video):
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        NSLog("%@", "didReceiveStream")
    }
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        NSLog("%@", "didStartReceivingResourceWithName")
    }
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        NSLog("%@", "didFinishReceivingResourceWithName")
    }
}
