# Step 1: Choose the Node.js version as the base image
FROM node:18 AS builder

# Step 2: Set the working directory in the container
WORKDIR /app

# Step 3: Copy package.json and package-lock.json to the container
COPY package*.json ./

# Step 4: Install project dependencies
RUN npm install -f

# Step 5: Copy the source code to the container
COPY . .

# Step 6: Build the TypeScript project
RUN npm run build

# Step 7: Use a smaller base image for serving the built app
FROM node:18-alpine

# Step 8: Install a lightweight web server, e.g., serve
RUN npm install -g serve

# Step 9: Set the working directory in the container
WORKDIR /app

# Step 10: Copy the built app from the builder stage to the final image
COPY --from=builder /app/build .

# Step 11: Expose the port that `serve` will use
EXPOSE 3000

# Step 12: Start the web server to serve the built app
CMD ["serve", "-s", ".", "-l", "3000"]
