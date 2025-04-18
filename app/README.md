# SimpleTimeService
SimpleTimeService
SimpleTimeService is a lightweight web application that returns the current date and time along with the IP address of the visitor in JSON format. This microservice is built using Python and Dockerized for easy deployment. It’s designed to be a minimal yet effective demonstration of how to build and containerize a simple microservice.

Table of Contents
Overview

Getting Started

Prerequisites

Clone the Repository

Build the Docker Image

Run the Application

Docker Commands

Project Structure

Usage

License

Overview
The SimpleTimeService application provides a simple API endpoint (/) that returns the following JSON structure:

json
Copy
Edit
{
  "timestamp": "<current date and time>",
  "ip": "<visitor's IP address>"
}
This application is intended to showcase:

Dockerizing a Python-based microservice.

Creating a minimal, efficient container.

Deploying and running the service as a non-root user inside the container.

Getting Started
Prerequisites
Before you begin, ensure you have the following tools installed on your system:

Docker - To build and run the container.

Python 3.x - For running the application locally without Docker (optional).

A Git client to clone the repository.

Clone the Repository
Clone the repository to your local machine using the following command:

bash
Copy
Edit
git clone https://github.com/nikhilnamaji/SimpleTimeService.git
Change to the project directory:

bash
Copy
Edit
cd SimpleTimeService
Build the Docker Image
Once you have the repository cloned, you can build the Docker image for the application using the following command:

bash
Copy
Edit
docker build -t simpletimeservice .
This command will use the Dockerfile in the root directory to build the image. The -t flag is used to tag the image as simpletimeservice.

Run the Application
After building the Docker image, you can run the application in a Docker container:

bash
Copy
Edit
docker run -p 5000:5000 simpletimeservice
This command maps port 5000 on your local machine to port 5000 on the container, so you can access the application at http://localhost:5000.

You should see the application running, and visiting http://localhost:5000 will return a JSON response similar to this:

json
Copy
Edit
{
  "timestamp": "2025-04-18T15:45:00",
  "ip": "127.0.0.1"
}
Docker Commands
Build the Docker Image:
docker build -t simpletimeservice .

Run the Docker Container:
docker run -p 5000:5000 simpletimeservice

List Docker Images:
docker images

Stop a Docker Container:
docker stop <container_id>

Project Structure
Here’s an overview of the project structure:

bash
Copy
Edit
SimpleTimeService/
├── Dockerfile          # Docker configuration for building the image
├── README.md           # Project documentation (you are reading this!)
├── app.py              # Python application serving the time and IP address
├── requirements.txt    # Python dependencies for the app
└── .gitignore          # To avoid pushing sensitive or unnecessary files
Dockerfile: Contains the instructions to build the Docker image. It ensures that the app is run as a non-root user within the container.

app.py: The Python web server application that serves the current timestamp and visitor's IP.

requirements.txt: Lists the dependencies required to run the Python application (e.g., Flask).

.gitignore: Specifies files and directories that Git should ignore (e.g., local development environments, secrets).

Usage
You can build and run the application in Docker with just the two commands mentioned above (docker build and docker run).

The service listens on port 5000 by default, as specified in both the Dockerfile and app.py.

Once running, the service can be accessed through your browser or an HTTP client like Postman.

License
This project is licensed under the MIT License - see the LICENSE file for details.

