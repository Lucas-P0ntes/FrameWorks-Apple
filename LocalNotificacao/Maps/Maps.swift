// Importa os módulos necessários do SwiftUI e do MapKit
import SwiftUI
import MapKit
import CoreLocation

// Define a struct "Location" que conforma ao protocolo Identifiable
struct Location: Identifiable {
    let id = UUID() // Cria um identificador único para cada instância de Location
    let name: String // Nome da localização
    let coordinate: CLLocationCoordinate2D // Coordenadas (latitude e longitude)
}

struct Maps: View {
    @StateObject var locationDataManager = LocationDataManager()
    @State private var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
    )

    var body: some View {
        ZStack {
            NavigationView {
                Map(coordinateRegion: $mapRegion, showsUserLocation: true, userTrackingMode: .constant(.follow), annotationItems: locations) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        NavigationLink {
                            Text(location.name)
                        } label: {
                            Circle()
                                .stroke(.red, lineWidth: 3)
                                .frame(width: 44, height: 44)
                        }
                    }
                }
                .navigationTitle("London Explorer")
                .onAppear {
                    if let latitude = locationDataManager.locationManager.location?.coordinate.latitude,
                       let longitude = locationDataManager.locationManager.location?.coordinate.longitude {
                        mapRegion.center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    }
                }
            }
        }
    }

    let locations = [
        Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
        Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    ]
}


// Define uma pré-visualização da View "Maps"
#Preview {
    Maps()
}


