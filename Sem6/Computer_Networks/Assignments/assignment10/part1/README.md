# Video Streaming with Custom DNS Resolution

This part implements a custom client-server architecture for video streaming over UDP, where the client first resolves the video server's IP address using a custom TCP-based DNS server. 

## Part 1 Structure

The project is divided into three distinct components:

1. **DNS_Server** (`dns_server.c`, `records.txt`)
   - A TCP server listening on port `8080`.
   - Reads domain-to-IP mappings from `records.txt`.
   - Receives custom DNS requests (Transaction ID, Domain Name) and responds with the resolved IP address (or `NOT_FOUND`).

2. **Video_Server** (`video_server.cpp`)
   - A UDP server listening on port `9000`.
   - Captures frames from the default webcam using OpenCV.
   - Waits for a client `KEEP_ALIVE` message to start the stream.
   - Streams JPEG-compressed frames. The stream stops if no `KEEP_ALIVE` is received for more than 200ms.

3. **Client** (`client.cpp`)
   - **Phase 1 (TCP):** Connects to the DNS Server to resolve the IP address for `video.server.com`.
   - **Phase 2 (UDP):** Connects to the Video Server using the resolved IP.
   - Spawns a background thread to send `KEEP_ALIVE` messages every 150ms.
   - Receives UDP packets, decodes the JPEG frames, and displays the video stream using OpenCV.

## Prerequisites

- **C/C++ Compiler:** `gcc` and `g++`
- **OpenCV:** Required for the Client and Video Server to capture, encode, decode, and display video streams.
  - Install on Ubuntu/Debian: `sudo apt install libopencv-dev`

## Compilation Instructions

Open a terminal and compile each component separately:

### 1. DNS Server
```bash
cd DNS_Server
gcc dns_server.c -o dns_server
```

### 2. Video Server
```bash
cd Video_Server
g++ video_server.cpp -o video_server `pkg-config --cflags --libs opencv4`
```
*(Note: If you have an older version of OpenCV, replace `opencv4` with `opencv`)*

### 3. Client
```bash
cd Client
g++ client.cpp -o client `pkg-config --cflags --libs opencv4`
```

## How to Run

For the system to work correctly, you need to run the components in three separate terminal windows.

1. **Start the DNS Server:**
   ```bash
   cd DNS_Server
   ./dns_server
   ```

2. **Start the Video Server:**
   ```bash
   cd Video_Server
   ./video_server
   ```
   *(Ensure your webcam is enabled and accessible)*

3. **Start the Client:**
   ```bash
   cd Client
   ./client
   ```

## Workflow & System Mechanics

1. **DNS Query:** The Client initiates a TCP connection to the DNS Server (`127.0.0.1:8080`) and requests the IP for `video.server.com`.
2. **DNS Response:** The DNS server looks up `records.txt`, finds the corresponding IP (`127.0.0.1`), and responds to the Client, immediately closing the connection.
3. **Stream Handshake:** The Client connects via UDP to the resolved IP on port `9000` and continuously sends `KEEP_ALIVE` messages.
4. **Video Streaming:** Upon receiving the first heartbeat, the Video Server captures webcam footage, compresses frames to JPEG to fit within a single UDP packet (max ~65KB), and sends them to the Client.
5. **Termination:** If the Client is closed (by pressing `ESC`), it stops sending `KEEP_ALIVE`. The Video Server detects the timeout (>200ms) and halts the stream gracefully.
