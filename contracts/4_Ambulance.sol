// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import the HospitalContract and TrafficManagement contracts
import "./3_Hospital.sol";
import "./1_Traffic.sol";

contract AmbulanceContract {
    enum AmbulanceStatus { Free, Busy }

    struct Ambulance {
        string numberPlate;
        string currentLocation;
        AmbulanceStatus status;
    }

    // Instance of the HospitalContract and TrafficManagement contracts
    HospitalContract public hospitalContract;
    TrafficManagement public trafficContract;

    // Mapping to store ambulance details by its number plate
    mapping(string => Ambulance) internal ambulances;

    // Constructor to initialize the contracts and ambulances
    constructor(address _hospitalContractAddress, address _trafficContractAddress) {
        hospitalContract = HospitalContract(_hospitalContractAddress);
        trafficContract = TrafficManagement(_trafficContractAddress);
    }

    // Function to show the status of the ambulance (Free or Busy)
    function getStatus(string memory _numberPlate) public view returns (AmbulanceStatus) {
        return ambulances[_numberPlate].status;
    }

    // Function to share the current location of the ambulance
    function getCurrentLocation(string memory _numberPlate) public view returns (string memory) {
        return ambulances[_numberPlate].currentLocation;
    }

    // Function to respond to the command received by the control center smart contract
    function respondToCommand(string memory _numberPlate, string memory _command) public {
        // Implement response logic here
    }

    // Function to access information about the hospital
    function getHospitalInfo() public view returns (HospitalContract.Hospital memory) {
        return hospitalContract.getHospitalInfo();
    }

    // Function to know the expected time with the help of the traffic smart contract
    function getExpectedTime(string memory _locationFrom, string memory _locationTo) public view returns (uint256) {
        return trafficContract.getEstimatedTravelTime(_locationFrom, _locationTo);
    }

    // Function to find the optimized path based on the traffic smart contract
    function findOptimizedPath(string memory _locationFrom, string memory _locationTo) public view returns (string[] memory) {
        return trafficContract.optimizeTravelTime(_locationFrom, _locationTo);
    }
}
