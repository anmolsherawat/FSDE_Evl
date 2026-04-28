FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files first (better caching)
COPY app/package*.json ./

# Install dependencies
RUN npm install --production

# Copy application code
COPY app/ .

# Expose the port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -qO- http://localhost:3000/ || exit 1

# Start the application
CMD ["node", "index.js"]
