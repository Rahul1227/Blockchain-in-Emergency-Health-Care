// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ControlCenter {
    struct Ambulance {
        string numberPlate;
        string currentLocation;
        bool isBusy;
    }

    mapping(string => Ambulance) internal ambulanceByNumberPlate;
    mapping(string => Ambulance) internal ambulanceByLocation;
    Ambulance[] public ambulanceDatabase;

    event AmbulanceAdded(string numberPlate, string currentLocation, bool isBusy);
    event AccidentVerified(bool accidentConfirmed, string location);
    event NearestAmbulancesFound(address[] nearestAmbulances);

    function addAmbulance(string memory _numberPlate, string memory _currentLocation, bool _isBusy) public {
        Ambulance memory newAmbulance = Ambulance(_numberPlate, _currentLocation, _isBusy);
        ambulanceByNumberPlate[_numberPlate] = newAmbulance;
        ambulanceByLocation[_currentLocation] = newAmbulance;
        ambulanceDatabase.push(newAmbulance);
        
        emit AmbulanceAdded(_numberPlate, _currentLocation, _isBusy);
    }

    function displayAmbulanceDatabase() public view returns (Ambulance[] memory) {
        return ambulanceDatabase;
    }

    function searchAmbulanceByNumberPlate(string memory _numberPlate) public view returns (Ambulance memory) {
        return ambulanceByNumberPlate[_numberPlate];
    }

    function searchAmbulanceByLocation(string memory _location) public view returns (Ambulance memory) {
        return ambulanceByLocation[_location];
    }

    function getLocationAddress(string memory _location) public pure returns (address) {
        // Simulated logic to convert location to address
        return address(uint160(uint256(keccak256(abi.encodePacked(_location)))));
    }

    function verifyAccidentInformation(bool _largeCrowd, bool _trafficJam) public returns (bool) {
        // If large number of people gathered and traffic jam situation, then conclude accident has taken place
        if (_largeCrowd && _trafficJam) {
            emit AccidentVerified(true, "Accident confirmed");
            return true;
        } else {
            emit AccidentVerified(false, "No accident confirmed");
            return false;
        }
    }

    function findNearestAmbulances(string memory _accidentLocation) public view returns (address[] memory) {
        address[] memory nearestAmbulances = new address[](5); // Assuming we want to find 5 nearest ambulances

        uint256[] memory distances = new uint256[](ambulanceDatabase.length);

        address accidentLocationAddress = getLocationAddress(_accidentLocation);

        // Calculate distances from the accident location to each ambulance
        for (uint256 i = 0; i < ambulanceDatabase.length; i++) {
            // Dummy distance calculation, replace with actual logic based on coordinates
            distances[i] = i * 100; // Replace this line with actual distance calculation logic
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

        return nearestAmbulances;
    }
}
