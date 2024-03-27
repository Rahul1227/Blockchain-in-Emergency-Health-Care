// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./4_Ambulance.sol";
import "./3_Hospital.sol";
import "./1_Traffic.sol";

contract ControlCenter {
    // Struct to store ambulance details
    struct Ambulance {
        string numberPlate;
        string currentLocation;
        bool isBusy;
    }

    // Struct to store hospital details
    struct Hospital {
        string name;
        string location;
        string contactDetails;
        string facilitiesAvailable;
    }

    // Instance of the AmbulanceContract, HospitalContract, and TrafficManagement contracts
    AmbulanceContract public ambulanceContract;
    HospitalContract public hospitalContract;
    TrafficManagement public trafficContract;

    // Mapping to store ambulance details by its number plate
    mapping(string => Ambulance) internal ambulanceByNumberPlate;
    // Mapping to store ambulance details by its current location
    mapping(string => Ambulance) internal ambulanceByLocation;
    // Array to store all ambulances
    Ambulance[] public ambulanceDatabase;

    // Array to store all hospitals
    Hospital[] public hospitalDatabase;

    // Events
    event AccidentVerified(bool accidentConfirmed, string location);
    event AmbulanceAdded(string numberPlate, string currentLocation, bool isBusy);
    event AmbulanceCalled(string numberPlate, string location);
    event NearestAmbulancesFound(address[] nearestAmbulances);
    event HospitalAdded(string name, string location, string contactDetails, string facilitiesAvailable);

    // Constructor to initialize the contracts
    constructor(address _ambulanceContract, address _hospitalContract, address _trafficContract) {
        ambulanceContract = AmbulanceContract(_ambulanceContract);
        hospitalContract = HospitalContract(_hospitalContract);
        trafficContract = TrafficManagement(_trafficContract);
    }

    // Function to verify accident by taking location as parameter
    function verifyAccident(string memory _location) public returns (bool) {
        // Get traffic details from the Traffic contract
        (bool trafficJam, bool largeCrowd, ) = trafficContract.getTrafficDetails(_location);

        // Verify accident based on traffic conditions
        if (largeCrowd && trafficJam) {
            emit AccidentVerified(true, _location);
            return true;
        } else {
            emit AccidentVerified(false, _location);
            return false;
        }
    }

    // Function to add a new ambulance
    function addAmbulance(string memory _numberPlate, string memory _currentLocation, bool _isBusy) public {
        Ambulance memory newAmbulance = Ambulance(_numberPlate, _currentLocation, _isBusy);
        ambulanceByNumberPlate[_numberPlate] = newAmbulance;
        ambulanceByLocation[_currentLocation] = newAmbulance;
        ambulanceDatabase.push(newAmbulance);
        emit AmbulanceAdded(_numberPlate, _currentLocation, _isBusy);
    }

    // Function to find ambulance by location
    function findAmbulanceByLocation(string memory _location) public view returns (Ambulance[] memory) {
    Ambulance[] memory ambulancesAtLocation = new Ambulance[](ambulanceDatabase.length);
    uint256 count = 0;
    for (uint256 i = 0; i < ambulanceDatabase.length; i++) {
        if (keccak256(abi.encodePacked((ambulanceDatabase[i].currentLocation))) == keccak256(abi.encodePacked((_location)))) {
            ambulancesAtLocation[count] = ambulanceDatabase[i];
            count++;
        }
    }
    // Resize the array to remove unused slots
    assembly { mstore(ambulancesAtLocation, count) }
    return ambulancesAtLocation;
}

    // Function to find ambulance by plate number
    function findAmbulanceByPlateNumber(string memory _plateNumber) public view returns (Ambulance memory) {
        return ambulanceByNumberPlate[_plateNumber];
    }

    // Function to find nearest ambulances within a given radius
    function findNearestAmbulances(string memory _location, uint256 _radius) public returns (address[] memory) {
        // Implement logic to find nearest ambulances within the given radius
        address[] memory nearestAmbulances;
        emit NearestAmbulancesFound(nearestAmbulances);
        return nearestAmbulances;
    }

    // Function to contract all the nearest ambulances
    function contractNearestAmbulances(string memory _location, uint256 _radius) public {
        address[] memory nearestAmbulances = findNearestAmbulances(_location, _radius);
        // Implement logic to contract all the nearest ambulances
    }

    // Function to display ambulance database
    function getAmbulanceDatabase() public view returns (Ambulance[] memory) {
        return ambulanceDatabase;
    }

    // Function to add a new hospital
    function addHospital(string memory _name, string memory _location, string memory _contactDetails, string memory _facilitiesAvailable) public {
        Hospital memory newHospital = Hospital(_name, _location, _contactDetails, _facilitiesAvailable);
        hospitalDatabase.push(newHospital);
        emit HospitalAdded(_name, _location, _contactDetails, _facilitiesAvailable);
    }

    // Function to display hospital database
    function getHospitalDatabase() public view returns (Hospital[] memory) {
        return hospitalDatabase;
    }

    // Function to find hospital by name
    function findHospitalByName(string memory _name) public view returns (Hospital memory) {
        for (uint256 i = 0; i < hospitalDatabase.length; i++) {
            if (keccak256(abi.encodePacked(hospitalDatabase[i].name)) == keccak256(abi.encodePacked(_name))) {
                return hospitalDatabase[i];
            }
        }
    }
}
