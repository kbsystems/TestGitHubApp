//
//  ErrorMessages.swift
//  GitHubApp
//
//  Created by Jan Binkiewicz on 30/07/2022.
//

import Foundation

class ErrorMessages {
    
    static let shared = ErrorMessages()
    
    var alertTitle = ""
    var alertBody  = ""
    
    enum ErrorTypes {
        case unknownError
        case connectionError
        case invalidCredentials
        case invalidRequest
        case notFound
        case invalidResponse
        case serverError
        case paramNotFound
     }
    
    func checkErrorCode(_ errorType: ErrorTypes) {
            switch errorType {
            case .unknownError:
                self.alertTitle = "Nieznamy błąd"
                self.alertBody  = "Spróbuj połączyć się jeszcze raz"
            case .connectionError:
                self.alertTitle = "Błąd połączenia z internetem"
                self.alertBody  = "Włącz proszę WiFi lub sprawdź zasięg telefonu"
            case .invalidCredentials:
                self.alertTitle = "Błędne dane logowania"
                self.alertBody  = "Sprawdź proszę czy podane dane są poprawne"
            case .invalidRequest:
                self.alertTitle = "Błędny URL API"
                self.alertBody  = "Sprawdź proszę czy podany adres API jest poprawny"
            case .notFound:
                self.alertTitle = "Zasobu nie znaleziono"
                self.alertBody  = "Próba wczytania zasobu nie powiodła się."
            case .invalidResponse:
                self.alertTitle = "Błędna odpowiedź API"
                self.alertBody  = "Sprawdź czy wszystkko jest ok po tronie API"
            case .serverError:
                self.alertTitle = "Błąd serwera"
                self.alertBody  = "Sprawdź czy serwer jest dotępny"
            case .paramNotFound:
                self.alertTitle = "Brak parametru"
                self.alertBody  = "Podaj wymagany parametr"
            }
        
    }
    
    
    private init() {
        
    }
    
}
