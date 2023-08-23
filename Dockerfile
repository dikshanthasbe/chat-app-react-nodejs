# Use official Node.js image
FROM node:14

# Set the working directory
WORKDIR /app

# Copy package.json and yarn.lock to the working directory
COPY ./public ./public
COPY ./server ./server


# Install dependencies for both frontend and backend using yarn
RUN cd /app/public && yarn install -y
RUN cd /app/server && yarn install -y

# Copy the rest of the project files
COPY . .

# Rename .env.example files to .env
RUN mv /app/public/.env.example /app/public/.env
RUN mv /app/server/.env.example /app/server/.env

# Expose the ports for frontend and backend
EXPOSE 3000

# Start the backend server (in the background) when the container runs
CMD cd /app/server && yarn start & \
    cd /app/public && yarn start
