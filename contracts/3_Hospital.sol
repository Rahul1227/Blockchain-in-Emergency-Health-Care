// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import PatientContract
import "./2_Patient.sol";

contract HospitalContract {
    // Struct to store hospital information
    struct Hospital {
        string name;
        string location;
        string contactDetails;
        string facilitiesAvailable;
    }

    // Struct to store patient information
    struct Patient {
        string name;
        uint256 age;
        string location;
        uint256 contractNumber;
        string bloodGroup;
        string diabeticHistory;
        string fractureHistory;
        string allergies;
        string medications;
        string surgeries;
        string emergencyContact;
    }

    // Hospital information
    Hospital internal hospitalInfo;

    // PatientContract instance
    PatientContract internal patientContract;

    // Mapping to store patient records
    mapping(address => Patient) public patients;

    // Constructor to initialize hospital information
    constructor() {
        hospitalInfo = Hospital(
            "KIMS",                     // Name
            "Bhubaneswar",              // Location
            "Contact: 123-456-789",     // Contact details
            "Facilities: ICU, MRI"      // Facilities available
        );

        // Initialize PatientContract instance
        patientContract = new PatientContract();
    }

    // Function to get hospital information
    function getHospitalInfo() public view returns (Hospital memory) {
        return hospitalInfo;
    }

    // Function to access non-sensitive patient information
    function getPatientInfo(address patientContractAddress) public view returns (string memory, uint256, string memory, uint256, string memory) {
        PatientContract patient = PatientContract(patientContractAddress);
        return patient.getGeneralInformation();
    }

    // Function to access sensitive patient information using passkey
    function getSensitivePatientInfo(address patientContractAddress, string memory passkey) public view returns (string memory, string memory, string memory, string memory, string memory) {
        PatientContract patient = PatientContract(patientContractAddress);
        return patient.getSensitiveInformation(passkey);
    }

    // Function to add new patient to the hospital contract
    function addNewPatient(
        string memory _name,
        uint256 _age,
        string memory _location,
        uint256 _contractNumber,
        string memory _bloodGroup,
        string memory _diabeticHistory,
        string memory _fractureHistory,
        string memory _allergies,
        string memory _medications,
        string memory _surgeries,
        string memory _emergencyContact
    ) public {
        // Add the new patient to the hospital contract
        patients[msg.sender] = Patient(
            _name,
            _age,
            _location,
            _contractNumber,
            _bloodGroup,
            _diabeticHistory,
            _fractureHistory,
            _allergies,
            _medications,
            _surgeries,
            _emergencyContact
        );
    }
}
