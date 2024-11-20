FROM node:latest

# Set working directory
WORKDIR /app

# Copy only package.json and yarn.lock first for caching
COPY package.json yarn.lock ./

# Copy the rest of the application files
COPY . .

# Install Medusa CLI globally (optional, for CLI usage within the container)
RUN yarn global add @medusajs/medusa-cli

RUN npm ci

# Build the Medusa application
RUN npx medusa build --admin-only

WORKDIR /app/.medusa/admin

# Expose the application's default port
EXPOSE 9000

# Run migrations and start the server at runtime
CMD ["sh", "-c", "yarn start"]
