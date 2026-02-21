# Sanity Chat – Encrypted Messaging App

**🗓 Duration:** Mar 2025 – Jun 2025  
**🛠 Tech Stack:** Flutter, Socket.IO, Provider, AES Encryption

---

## Overview
Sanity Chat is a secure, real-time messaging application designed to prioritize user privacy and message integrity. Messages are end-to-end encrypted using AES, ensuring that sensitive content remains confidential and resistant to interception. The app provides a responsive and user-friendly interface with on-demand message decryption, giving users full control over their private communications.

---

## Key Features
- **End-to-End AES Encryption:** Ensures all messages are encrypted on the sender side and decrypted only by the intended recipient.
- **On-Demand Message Decryption:** Users can decrypt messages only when needed, increasing control over sensitive content.
- **Real-Time Communication:** Built using Socket.IO for low-latency, encrypted message transport.
- **Secure Key Handling:** All encryption keys are managed securely to prevent unauthorized access.
- **Responsive UI:** Flutter with Provider ensures smooth UI updates and state management.
- **Privacy & Security Focused:** Strong emphasis on message authenticity, confidentiality, and resistance to tampering.

---

## Screenshots
<img width="579" height="1020" alt="LDPlayer 20_05_2025 20_15_38" src="https://github.com/user-attachments/assets/bec851f7-a1a0-4461-939e-c42d2702c4c9" />
<img width="579" height="1020" alt="LDPlayer 20_05_2025 20_17_55" src="https://github.com/user-attachments/assets/c9df8ac1-3ec6-44e7-8157-9788a6488b3f" />
<img width="579" height="1020" alt="LDPlayer 20_05_2025 20_18_37" src="https://github.com/user-attachments/assets/333ae7e6-1680-4f18-9439-2aaf66973299" />
<img width="579" height="1020" alt="LDPlayer 20_05_2025 20_22_16" src="https://github.com/user-attachments/assets/3f073930-7238-43a4-ab7d-538928962a48" />
<img width="579" height="1020" alt="LDPlayer 20_05_2025 20_22_29" src="https://github.com/user-attachments/assets/6a42dd6e-ddb1-4ef3-af24-eff7f2b83d7e" />
<img width="579" height="1020" alt="LDPlayer 20_05_2025 20_22_38" src="https://github.com/user-attachments/assets/0c97d51a-8ce0-493e-8ee5-5880e838249d" />




## Tech Stack
- **Flutter** – Cross-platform mobile development.
- **Provider** – State management for responsive UI.
- **Socket.IO** – Real-time communication between clients.
- **AES Encryption** – Secure end-to-end message encryption.

---

## Getting Started

1. **Clone the repository:**
```bash
git clone https://github.com/tareqkh02/sanity-chat.git
cd sanity-chat
flutter pub get
flutter run
```
2. **Server Setup (Socket.IO):**
Ensure a Socket.IO server is running and configured for encrypted communication.
