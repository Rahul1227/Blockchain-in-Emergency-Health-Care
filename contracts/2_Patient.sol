// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PatientContract {
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

    Patient internal patient;
    string private passkey = "blockchain";

    constructor () {
        patient = Patient(
            "Rahul Yadav",
            21,
            "Nepal",
            123456789,
            "O+",
            "No diabetic history",
            "No fracture history",
            "No allergies",
            "None",
            "No surgeries",
            "Emergency Contact: 123-456-789"
        );
    }

    modifier onlyWithPasskey(string memory _providedPasskey) {
        require(keccak256(abi.encodePacked(_providedPasskey)) == keccak256(abi.encodePacked(passkey)), "Incorrect passkey");
        _;
    }

    function getGeneralInformation() public view returns (string memory, uint256, string memory, uint256, string memory) {
        return (patient.name, patient.age, patient.location, patient.contractNumber, patient.bloodGroup);
    }

    function getSensitiveInformation(string memory _providedPasskey) public view onlyWithPasskey(_providedPasskey) returns (string memory, string memory, string memory, string memory, string memory) {
        return (patient.diabeticHistory, patient.fractureHistory, patient.allergies, patient.medications, patient.surgeries);
    }
}
