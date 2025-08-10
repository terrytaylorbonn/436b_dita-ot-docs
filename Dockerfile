# Use an official lightweight Java image
FROM openjdk:17-slim

# Install wget and unzip
RUN apt-get update && apt-get install -y wget unzip python3 && rm -rf /var/lib/apt/lists/*

# Download and install DITA-OT
WORKDIR /opt
RUN wget https://github.com/dita-ot/dita-ot/releases/download/4.1/dita-ot-4.1.zip \
    && unzip dita-ot-4.1.zip \
    && rm dita-ot-4.1.zip

# Copy project files
WORKDIR /app
COPY . /app

# Build docs on container build
EXPOSE 8080
CMD /opt/dita-ot-4.1/bin/dita --input=a12-3/a12-3.ditamap --format=xhtml --output=public && python3 -m http.server 8080 --directory /app/public
