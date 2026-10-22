# 1. Specify the base image
FROM node:20-alpine

# 2. Set the working directory inside the container
WORKDIR /app

# 3. Copy dependency files first (brings caching benefits)
COPY package*.json ./

# 4. Install production dependencies
RUN npm ci --only=production

# 5. Copy the rest of your application code
COPY . .

# 6. Expose the port your app listens on
EXPOSE 3000

# 7. Define the command to run your app
CMD ["node", "server.js"]