import SwiftUI
import MultipeerConnectivity
import AVFoundation
import TipKit
import EventKit
struct ContentView: View {
    
    private let favoriteTip = FavoriteTip()
    
    
    
    var body: some View {
        NavigationStack{
            Text("Tecnologias e Kits")
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .padding()
                .popoverTip(favoriteTip, arrowEdge: .top)
            
            HStack{
                
                
                VStack {
                    NavigationLink {
                        // destination view to navigation to
                        CameraView()
                    } label: {
                        ButtonView(text:"Upload img").foregroundColor(.white)
                        
                    }
                    
                    VStack {
                        NavigationLink {
                            // destination view to navigation to
                            ConnectivityView(connectionsLabel:" \(MCPeerID(displayName: UIDevice.current.name))", backgroundColor: .blue)
                        } label: {
                            ButtonView(text:"Connectivity").foregroundColor(.white)
                            
                        }
                    }
                }
                    
                    VStack {
                        NavigationLink {
                            // destination view to navigation to
                            MapsView()
                        } label: {
                            ButtonView(text:"Mapas").foregroundColor(.white)
                            
                        }
                        
                        
                        
                        
                        VStack {
                            NavigationLink {
                                // destination view to navigation to
                                NotificationView()
                            } label: {
                                ButtonView(text:"Notification").foregroundColor(.white)
                                
                            }
                            
                        }
                        
                        VStack {
                            NavigationLink {
                                // destination view to navigation to
                                EventKitView()
                            } label: {
                                ButtonView(text:"EventKitView").foregroundColor(.white)
                                
                            }
                            
                        }
                    }
                }
            }
        }
    }

    
    
    struct FavoriteTip: Tip {
        var title: Text {
            Text("O que é?")
        }
        
        var message: Text? {
            Text("Aqui temos uma serie de pequenas tecnologias e kits, no qual eu utilizei para aprender, essa propria mensagem já é uma Tecnologia kkk")
        }
        
        var image: Image? {
            Image(systemName: "gear")
        }
    }
    
struct ButtonView: View {
    var text:String
    var body: some View {
       
        ZStack{
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 100 , height: 100 )
                .foregroundColor(.blue)
                
            Text("\(text)")
            
            
        }
    }
}
