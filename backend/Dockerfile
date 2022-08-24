# docker build . --tag=franc-partner-integration-refereance-app-backend:2022-08-24
FROM --platform=linux/amd64 python:3.10-bullseye

# System dependencies
RUN apt-get update
RUN apt-get install -y python3-dev

# Create web user / add web user to web group
RUN adduser web  && adduser web web

# Set the working directory to /app
WORKDIR /app

# This is done so we don't need to re-install the requirements every build
ADD ./requirements.txt /app/requirements.txt

# Install the latest pip for better installing
RUN pip install --upgrade pip

# Install any needed packages specified in requirements.txt
RUN pip install --trusted-host pypi.python.org -r requirements.txt


# Copy the current directory contents into the container at /app
COPY . /app

# Make config directory if no excists
RUN mkdir -p config

# Make script executable
RUN chmod +x /app/docker_run.sh

# Make port 5051 available to the world outside this container
EXPOSE 5051

# Run the start up script
CMD ["/app/docker_run.sh"]
