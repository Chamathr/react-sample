# Use an official Node.js runtime as the base image
FROM node:18-alpine

# Set the working directory within the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Copy the rest of the application code
COPY . .

# Build the React app
RUN npm run build

# Expose the desired port for the application
EXPOSE 3000

# Define the command to start the application
CMD ["npm", "start"]
