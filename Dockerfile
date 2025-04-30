git # Dockerfile
FROM node:18

# Set working directory
WORKDIR /app/

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the Vue app
RUN npm run build

# Use Nginx to serve the built app
FROM nginx:alpine
COPY --from=0 /app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
