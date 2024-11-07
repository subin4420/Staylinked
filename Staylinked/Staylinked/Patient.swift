//
//  Patient.swift
//  Staylinked
//
//  Created by 박수빈 on 2023/05/31.
//
import Foundation

struct Patient: Codable {
    let patientId: Int
    let name: String
    let medicalProcedure: String
    let notes: String
    let appointmentDate: String
    let guardianId: Int
    let patientDiseaseInfo: PatientDiseaseInfo
    
    enum CodingKeys: String, CodingKey {
        case patientId = "patientId"
        case name = "name"
        case medicalProcedure = "medicalProcedure"
        case notes = "notes"
        case appointmentDate = "appointmentDate"
        case guardianId = "guardianId"
        case patientDiseaseInfo = "patientDiseaseInfo"
    }
}

struct PatientDiseaseInfo: Codable {
    let underlyingCondition: String
    let diseaseId: Int
    let allergy: String
    
    enum CodingKeys: String, CodingKey {
        case underlyingCondition = "underlyingCondition"
        case diseaseId = "diseaseId"
        case allergy = "allergy"
    }
}


