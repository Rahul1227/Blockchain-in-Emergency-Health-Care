// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import the AmbulanceContract, HospitalContract, and TrafficManagement contracts
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

    // Events
    event AmbulanceAdded(string numberPlate, string currentLocation, bool isBusy);
    event AccidentVerified(bool accidentConfirmed, string location);
    event NearestAmbulancesFound(address[] nearestAmbulances);

    // Constructor to initialize the contracts
    constructor(AmbulanceContract _ambulanceContract, HospitalContract _hospitalContract, TrafficManagement _trafficContract) {
        ambulanceContract = _ambulanceContract;
        hospitalContract = _hospitalContract;
        trafficContract = _trafficContract;
    }

    // Function to add a new ambulance
    function addAmbulance(string memory _numberPlate, string memory _currentLocation, bool _isBusy) public {
        Ambulance memory newAmbulance = Ambulance(_numberPlate, _currentLocation, _isBusy);
        ambulanceByNumberPlate[_numberPlate] = newAmbulance;
        ambulanceByLocation[_currentLocation] = newAmbulance;
        ambulanceDatabase.push(newAmbulance);
        
        emit AmbulanceAdded(_numberPlate, _currentLocation, _isBusy);
    }

    // Function to display all ambulances
    function displayAmbulanceDatabase() public view returns (Ambulance[] memory) {
        return ambulanceDatabase;
    }

    // Function to search an ambulance by its number plate
    function searchAmbulanceByNumberPlate(string memory _numberPlate) public view returns (Ambulance memory) {
        return ambulanceByNumberPlate[_numberPlate];
    }

    // Function to search an ambulance by its location
    function searchAmbulanceByLocation(string memory _location) public view returns (Ambulance memory) {
        return ambulanceByLocation[_location];
    }

    // Function to verify accident information
    function verifyAccidentInformation(string memory _accidentLocation) public returns (bool) {
        // Get traffic details from the Traffic contract
        (bool trafficJam, bool largeCrowd, ) = trafficContract.getTrafficDetails(_accidentLocation);

        // Verify accident based on traffic conditions
        if (largeCrowd && trafficJam) {
            emit AccidentVerified(true, "Accident confirmed");
            return true;
        } else {
            emit AccidentVerified(false, "No accident confirmed");
            return false;
        }
    }

    // Function to find the nearest ambulances
    function findNearestAmbulances(string memory _accidentLocation) public returns (address[] memory) {
        address[] memory nearestAmbulances = new address[](5); // Assuming we want to find 5 nearest ambulances

        uint256[] memory distances = new uint256[](ambulanceDatabase.length);

        // Get accident location address
        string memory accidentLocation = ambulanceContract.getCurrentLocation(_accidentLocation);

        // Calculate distances from the accident location to each ambulance
        for (uint256 i = 0; i < ambulanceDatabase.length; i++) {
            // Get current location address of the ambulance
            string memory ambulanceLocation = ambulanceByNumberPlate[ambulanceDatabase[i].numberPlate].currentLocation;

            // Dummy distance calculation, replace with actual logic based on coordinates
            uint256 distance = 100; // Replace this line with actual distance calculation logic

            distances[i] = distance;
        }

        // Sort distances and find the 5 nearest ambulances
        for (uint256 i = 0; i < 5; i++) {
            uint256 minDistance = type(uint256).max;
            uint256 minIndex = 0;

            for (uint256 j = 0; j < ambulanceDatabase.length; j++) {
                if (distances[j] < minDistance) {
                    bool alreadySelected = false;
                    // Check if this ambulance is already selected
                    for (uint256 k = 0; k < i; k++) {
                        if (nearestAmbulances[k] == address(uint160(j + 1))) {
                            alreadySelected = true;
                            break;
                        }
                    }

                    if (!alreadySelected) {
                        minDistance = distances[j];
                        minIndex = j;
                    }
                }
            }

            nearestAmbulances[i] = address(uint160(minIndex + 1)); // Convert index to address (1-indexed)
        }

        emit NearestAmbulancesFound(nearestAmbulances);
        return nearestAmbulances;
    }
}
