
# Blockchain in Healthcare Emergency Services

This project implements a comprehensive system for emergency services in the healthcare sector using blockchain technology. It leverages multiple smart contracts to manage hospitals, ambulances, patients, traffic, and control centers, ensuring efficient and coordinated response during emergencies.

## Project Overview

The project involves the development and deployment of the following smart contracts:

1. **Hospital Smart Contract**: Registers patients and doctors, manages patient medical records, and interacts with the control center for emergency response.
2. **Ambulance Smart Contract**: Tracks ambulance status, location, and availability. It responds to emergency calls from the control center and navigates to accident locations efficiently.
3. **Patient Smart Contract**: Stores patient information, including general and sensitive data. It ensures privacy and security by allowing access only with a passkey.
4. **Control Center Smart Contract**: Orchestrates emergency response by verifying accidents, contracting ambulances, and coordinating with hospitals and traffic police.
5. **Traffic Police Smart Contract**: Monitors traffic conditions, provides real-time traffic details, and optimizes ambulance routes to reduce travel time.

## Workflow
![Alt Text](https://github.com/Rahul1227/Blockchain-in-Emergency-Health-Care/blob/master/model1.png)

1. **Accident Reporting**: The observer reports an accident to the control center, providing necessary details.
2. **Accident Verification**: The control center verifies the accident using traffic police video feedback.
3. **Emergency Response**: Upon verification, the control center contracts the nearest ambulances and directs one to the accident location.
4. **Ambulance Dispatch**: The selected ambulance navigates to the accident location, guided by the traffic police for optimized routes.
5. **Hospital Allocation**: After reaching the accident site, the ambulance selects the nearest hospital for patient treatment.

## Smart Contracts Implementation

### Hospital Smart Contract
- Registers patients and doctors.
- Manages patient medical records.
- Interacts with the control center for emergency response.

### Ambulance Smart Contract
- Tracks ambulance status, location, and availability.
- Responds to emergency calls from the control center.
- Navigates efficiently to accident locations.

### Patient Smart Contract
- Stores patient information securely.
- Provides access to general and sensitive data with passkey protection.

### Control Center Smart Contract
- Verifies accidents using traffic police video feedback.
- Contracts ambulances and coordinates emergency response.
- Manages ambulance database and communicates with other contracts.

### Traffic Police Smart Contract
- Monitors traffic conditions and provides real-time details.
- Optimizes ambulance routes to reduce travel time.

## Deployment and Usage

Deploy the smart contracts on a compatible blockchain network. Interact with the contracts using compatible Ethereum wallets or development environments.

## Contributors

- Rahul Yadav
- rahulydv1227@gmail.com

## License

This project is licensed under the [MIT License](LICENSE).


